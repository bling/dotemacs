(setq lv-use-separator t)
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
(defun my-errors-hydra/target-list ()
  (if my-errors-hydra/flycheck
      'flycheck
    'emacs))
(defhydra my-errors-hydra (:hint nil :post (quit-windows-on "*Flycheck errors*"))
  "
   errors:  navigation                 flycheck
            -----------------------    ---------------
            _j_ → next error             _l_ → list errors
            _k_ → previous error         _?_ → describe checker
            _t_ → toggle list (%(my-errors-hydra/target-list))
"
  ("j" (if my-errors-hydra/flycheck
           (call-interactively #'flycheck-next-error)
         (call-interactively #'next-error)))
  ("k" (if my-errors-hydra/flycheck
           (call-interactively #'flycheck-previous-error)
         (call-interactively #'previous-error)))
  ("t" (setq my-errors-hydra/flycheck (not my-errors-hydra/flycheck)))
  ("?" flycheck-describe-checker)
  ("l" flycheck-list-errors))



(defhydra my-quit-hydra (:hint nil :exit t)
  "
   quit:  _q_ → quit    _r_ → restart
"
  ("q" save-buffers-kill-emacs)
  ("r" (restart-emacs '("--debug-init"))))



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
  ("L" (my-switch-action nil     :ivy #'swiper-all    :helm #'helm-multi-swoop-all))
  ("b" bookmark-jump))



(defhydra my-search-hydra (:hint nil :exit t)
  "
    search     project      ^^directory    ^^buffer       ^^buffers      ^^web
               -------      ^^---------    ^^------       ^^-------      ^^---
               _a_ → ag       _A_ → ag       _l_ → lines    _L_ → lines    _g_ → google
               _p_ → pt       _P_ → pt
"
  ("a" projectile-ag)
  ("p" projectile-pt)
  ("A" ag)
  ("P" pt-regexp)
  ("l" my-jump-hydra/lambda-l-and-exit)
  ("L" my-jump-hydra/lambda-L-and-exit)
  ("g" my-google))



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
  ("r" (my-switch-action #'recentf   :ivy #'ivy-recentf       :helm #'helm-recentf))
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
        ((eq dotemacs-switch-engine 'ivy)  (my-activate-switch-engine 'helm))
        ((eq dotemacs-switch-engine 'helm) (my-activate-switch-engine 'ido))
        ((eq dotemacs-switch-engine 'ido) (my-activate-switch-engine 'ivy)))
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
  ("L" helm-multi-swoop-all)
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



(autoload 'magit-log-popup "magit-log" nil t)
(autoload 'magit-diff-popup "magit-diff" nil t)
(autoload 'magit-commit-popup "magit-commit" nil t)
(autoload 'magit-file-popup "magit" nil t)

(defhydra my-git-hydra (:hint nil :exit t)
  "
   magit:  _s_ → status  _l_ → log    _f_ → file      staging:  _a_ → +hunk  _A_ → +buffer
           _c_ → commit  _d_ → diff   _z_ → stash               _r_ → -hunk  _R_ → -buffer
           _p_ → push    _b_ → blame  _m_ → merge
"
  ("s" magit-status)
  ("b" magit-blame-popup)
  ("f" magit-file-popup)
  ("z" magit-status-popup)
  ("l" magit-log-popup)
  ("d" magit-diff-popup)
  ("c" magit-commit-popup)
  ("m" magit-merge-popup)
  ("p" magit-push-popup)
  ("a" git-gutter+-stage-hunks)
  ("r" git-gutter+-revert-hunk)
  ("A" git-gutter+-stage-whole-buffer)
  ("R" git-gutter+-unstage-whole-buffer))



(defhydra my-paste-hydra (:hint nil)
  "
   Paste transient state: [%s(length kill-ring-yank-pointer)/%s(length kill-ring)]
         _C-j_ → cycle next          _p_ → paste before
         _C-k_ → cycle previous      _P_ → paste after
"
  ("C-j" evil-paste-pop-next)
  ("C-k" evil-paste-pop)
  ("p" evil-paste-after)
  ("P" evil-paste-before))



(when (> (length narrow-map) 8)
  (error "`narrow-map' has more than 7 bindings!"))
(defhydra my-narrow-hydra (:hint nil :exit t)
  "
   narrow  _d_ → defun   _b_ → org-block    _w_ → widen
           _n_ → region  _e_ → org-element
           _p_ → page    _s_ → org-subtree
"
  ("b" org-narrow-to-block)
  ("e" org-narrow-to-element)
  ("s" org-narrow-to-subtree)
  ("d" narrow-to-defun)
  ("n" narrow-to-region)
  ("p" narrow-to-page)
  ("w" widen))

(provide 'init-hydras)
