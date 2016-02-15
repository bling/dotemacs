(require-package 'hydra)

(defun my-switch-action (fallback &rest props)
  "Performs an action based on the value of `dotemacs-switch-engine'."
  (cond
   ((and (eq dotemacs-switch-engine 'ivy) (plist-get props :ivy))
    (call-interactively (plist-get props :ivy)))
   ((and (eq dotemacs-switch-engine 'helm) (plist-get props :helm))
    (call-interactively (plist-get props :helm)))
   (t
    (if fallback
        (call-interactively fallback)
      (message "unsupported action")))))



(setq my-errors-hydra/flycheck nil)
(defhydra my-errors-hydra (:hint nil)
  "
   errors:  _n_ → next error       _t_ → toggle flycheck (%`my-errors-hydra/flycheck)
            _p_ → previous error
"
  ("n" (if my-errors-hydra/flycheck
           (call-interactively #'flycheck-next-error)
         (call-interactively #'next-error)))
  ("p" (if my-errors-hydra/flycheck
           (call-interactively #'flycheck-previous-error)
         (call-interactively #'previous-error)))
  ("t" (setq my-errors-hydra/flycheck (not my-errors-hydra/flycheck))))



(defhydra my-quit-hydra (:hint nil :exit t)
  "
   quit:  _q_ → quit    _r_ → restart
"
  ("q" save-buffers-kill-emacs)
  ("r" restart-emacs))



(defhydra my-buffer-hydra (:hint nil :exit t)
  "
   buffers:   _b_ → buffers          _k_ → kill buffer             _f_ → reveal in finder
              _m_ → goto messages    _e_ → erase buffer            ^ ^
              _s_ → goto scratch     _E_ → erase buffer (force)    ^ ^
"
  ("s" my-goto-scratch-buffer)
  ("k" kill-this-buffer)
  ("f" reveal-in-osx-finder)
  ("m" (switch-to-buffer "*Messages*"))
  ("b" (my-switch-action #'switch-to-buffer :ivy #'my-ivy-mini :helm #'helm-mini))
  ("e" erase-buffer)
  ("E" (let ((inhibit-read-only t)) (erase-buffer))))



(defhydra my-jump-hydra (:hint nil :exit t)
  "
   jump   _i_ → outline in current buffer   _l_ → lines in current buffer
          _b_ → bookmarks                   _L_ → lines in all buffers
"
  ("i" (my-switch-action #'imenu :ivy #'counsel-imenu :helm #'helm-semantic-or-imenu))
  ("l" (my-switch-action nil     :ivy #'swiper        :helm #'helm-swoop))
  ("L" (my-switch-action nil     :ivy #'swiper-all    :helm #'helm-multi-swoop))
  ("b" bookmark-jump))



(defhydra my-file-convert-hydra (:hint nil :exit t)
  "
   convert to _d_ → dos
              _u_ → unix
"
  ("d" my-buffer-to-dos-format)
  ("u" my-buffer-to-unix-format))

(defhydra my-file-hydra (:hint nil :exit t)
  "
   files:    _f_ → find files      _D_ → delete    _y_ → copy filename   _E_ → edit as root   _z_ → fzf
             _r_ → recent files    _R_ → rename    _c_ → copy file       _C_ → convert
"
  ("D" my-delete-current-buffer-file)
  ("R" my-rename-current-buffer-file)
  ("f" (my-switch-action #'find-file :ivy #'counsel-find-file :helm #'helm-find-files))
  ("r" (my-switch-action #'recentf   :ivy #'ivy-recentf        :helm #'helm-recentf))
  ("y" my-copy-file-name-to-clipboard)
  ("E" my-find-file-as-root)
  ("c" copy-file)
  ("C" my-file-convert-hydra/body)
  ("z" fzf))



(defhydra my-toggle-hydra (:hint nil :exit t)
  "
   toggle:  _a_ → aggressive indent   _s_ → flycheck   _r_ → read only      _t_ → truncate lines   _e_ → debug on error   ' → switch (%`dotemacs-switch-engine)
            _f_ → auto-fill           _S_ → flyspell   _c_ → completion     _W_ → word wrap        _g_ → debug on quit
            _w_ → whitespace          ^ ^              _p_ → auto-pairing   _b_ → page break
"
  ("a" aggressive-indent-mode)
  ("c" (if (eq dotemacs-completion-engine 'company)
           (call-interactively 'company-mode)
         (call-interactively 'auto-complete-mode)))
  ("t" toggle-truncate-lines)
  ("e" toggle-debug-on-error)
  ("g" toggle-debug-on-quit)
  ("b" page-break-lines-mode)
  ("s" flycheck-mode)
  ("S" flyspell-mode)
  ("w" whitespace-mode)
  ("W" toggle-word-wrap)
  ("r" read-only-mode)
  ("f" auto-fill-mode)
  ("p" (cond
        ((eq dotemacs-pair-engine 'emacs)
         (call-interactively #'electric-pair-mode))
        ((eq dotemacs-pair-engine 'smartparens)
         (call-interactively #'smartparens-global-mode))))
  ("'" (cond
        ((eq dotemacs-switch-engine 'ivy)
         (setq dotemacs-switch-engine 'helm))
        ((eq dotemacs-switch-engine 'helm)
         (setq dotemacs-switch-engine 'ido))
        ((eq dotemacs-switch-engine 'ido)
         (setq dotemacs-switch-engine 'ivy)))
   :exit nil))



(defhydra my-helm-hydra (:hint nil :exit t)
  "
   helm:   _a_ → apropos   _m_ → bookmarks   _y_ → kill-ring  _l_ → swoop
           _b_ → mini      _p_ → projectile  _d_ → dash       _L_ → swoop (multi)
           _e_ → recentf   _r_ → register    _x_ → M-x
           _f_ → files     _t_ → tags
"
  ("a" helm-apropos)
  ("b" helm-mini)
  ("d" helm-dash)
  ("e" helm-recentf)
  ("f" helm-find-files)
  ("m" helm-bookmarks)
  ("p" helm-projectile)
  ("r" helm-register)
  ("t" helm-etags-select)
  ("x" helm-M-x)
  ("l" helm-swoop)
  ("L" helm-multi-swoop)
  ("y" helm-show-kill-ring))



(defhydra my-ivy-hydra (:hint nil :exit t)
  "
   ivy:   _b_ → mini       _y_ → kill-ring   _l_ → swiper
          _e_ → recentf    _x_ → M-x         _L_ → swiper (multi)
          _f_ → files
"
  ("b" my-ivy-mini)
  ("e" ivy-recentf)
  ("f" counsel-find-file)
  ("y" counsel-yank-pop)
  ("x" counsel-M-x)
  ("l" swiper)
  ("L" swiper-all))



(autoload 'magit-log-popup "magit-log")
(autoload 'magit-diff-popup "magit-diff")
(autoload 'magit-commit-popup "magit-commit")

(defhydra my-git-hydra (:hint nil :exit t)
  "
   magit         ^ ^           ^ ^          ^ ^         ^^stage/unstage
   ^-^-----------^-^-----------^-^----------^-^-------    ^-^----------^-^----------------
   _s_ → status  _b_ → blame   _l_ → log    _f_ → file    _a_ → +hunk  _A_ → +buffer
   _d_ → diff    _c_ → commit  _z_ → stash  ^ ^           _r_ → -hunk  _R_ → -buffer
"
  ("s" magit-status)
  ("b" magit-blame-popup)
  ("f" magit-file-popup)
  ("z" magit-status-popup)
  ("l" magit-log-popup)
  ("d" magit-diff-popup)
  ("c" magit-commit-popup)
  ("a" git-gutter+-stage-hunks)
  ("r" git-gutter+-revert-hunk)
  ("A" git-gutter+-stage-whole-buffer)
  ("R" git-gutter+-unstage-whole-buffer))



(defhydra my-paste-hydra (:hint nil)
  "
   Paste transient state: [%s(length kill-ring-yank-pointer)/%s(length kill-ring)]
         _J_ → cycle next          _p_ → paste before
         _K_ → cycle previous      _P_ → paste after
"
  ("J" evil-paste-pop)
  ("K" evil-paste-pop-next)
  ("p" evil-paste-after)
  ("P" evil-paste-before))
