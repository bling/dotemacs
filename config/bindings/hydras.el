(setq lv-use-separator t)
(require-package 'hydra)
(autoload 'hydra-default-pre "hydra")

(defun /hydras/switch-action (fallback &rest props)
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



(defvar /hydras/errors/flycheck nil)
(defun /hydras/errors/target-list ()
  (if /hydras/errors/flycheck
      'flycheck
    'emacs))
(defhydra /hydras/errors (:hint nil)
  "
   errors:  navigation                 flycheck
            -----------------------    ---------------
            _j_ → next error             _l_ → list errors
            _k_ → previous error         _?_ → describe checker
            _t_ → toggle list (%(/hydras/errors/target-list))
"
  ("j" (if /hydras/errors/flycheck
           (call-interactively #'flycheck-next-error)
         (call-interactively #'next-error)))
  ("k" (if /hydras/errors/flycheck
           (call-interactively #'flycheck-previous-error)
         (call-interactively #'previous-error)))
  ("t" (setq /hydras/errors/flycheck (not /hydras/errors/flycheck)))
  ("?" flycheck-describe-checker)
  ("l" flycheck-list-errors :exit t))



(defhydra /hydras/quit (:hint nil :exit t)
  "
   quit:  _q_ → quit    _r_ → restart
"
  ("q" save-buffers-kill-emacs)
  ("r" (restart-emacs '("--debug-init"))))



(defhydra /hydras/buffers (:hint nil :exit t)
  "
   buffers:   _b_ → buffers          _k_ → kill buffer             _f_ → reveal in os
              _m_ → goto messages    _e_ → erase buffer            ^ ^
              _s_ → goto scratch     _E_ → erase buffer (force)    ^ ^
"
  ("s" /utils/goto-scratch-buffer)
  ("k" kill-this-buffer)
  ("f" /os/reveal-in-os)
  ("m" (switch-to-buffer "*Messages*"))
  ("b" (/hydras/switch-action #'switch-to-buffer :ivy #'/ivy/mini :helm #'helm-mini))
  ("e" erase-buffer)
  ("E" (let ((inhibit-read-only t)) (erase-buffer))))



(defhydra /hydras/jumps (:hint nil :exit t)
  "
   jump   _i_ → outline in current buffer   _l_ → lines in current buffer
          _b_ → bookmarks                   _L_ → lines in all buffers
"
  ("i" (/hydras/switch-action #'imenu :ivy #'counsel-imenu :helm #'helm-semantic-or-imenu))
  ("l" (/hydras/switch-action nil     :ivy #'swiper        :helm #'helm-swoop))
  ("L" (/hydras/switch-action nil     :ivy #'swiper-all    :helm #'helm-multi-swoop-all))
  ("b" bookmark-jump))



(defhydra /hydras/search (:hint nil :exit t)
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
  ("l" /hydras/jumps/lambda-l-and-exit)
  ("L" /hydras/jumps/lambda-L-and-exit)
  ("g" /utils/google))



(defhydra /hydras/files/convert (:hint nil :exit t)
  "
   convert to _d_ → dos
              _u_ → unix
"
  ("d" /utils/set-buffer-to-dos-format)
  ("u" /utils/set-buffer-to-unix-format))

(defhydra /hydras/files (:hint nil :exit t)
  "
   files:    _f_ → find files      _D_ → delete    _y_ → copy filename   _E_ → edit as root   _z_ → fzf
             _r_ → recent files    _R_ → rename    _c_ → copy file       _C_ → convert
"
  ("D" /utils/delete-current-buffer-file)
  ("R" /utils/rename-current-buffer-file)
  ("f" (/hydras/switch-action #'find-file :ivy #'counsel-find-file :helm #'helm-find-files))
  ("r" (/hydras/switch-action #'recentf   :ivy #'counsel-recentf   :helm #'helm-recentf))
  ("y" /utils/copy-file-name-to-clipboard)
  ("E" /utils/find-file-as-root)
  ("c" copy-file)
  ("C" /hydras/files/convert/body)
  ("z" fzf))



(defun /hydras/toggles/activate-switch-engine (engine)
  (let ((func (intern (concat "/" (symbol-name dotemacs-switch-engine) "/activate-as-switch-engine"))))
    (apply func '(nil)))
  (let ((func (intern (concat "/" (symbol-name engine) "/activate-as-switch-engine"))))
    (apply func '(t)))
  (setq dotemacs-switch-engine engine)
  (setq projectile-completion-system dotemacs-switch-engine))

(defhydra /hydras/toggles/switch-engine (:hint nil :exit t)
  "
   engine:  _h_ → helm
            _i_ → ivy
            _o_ → ido
"
  ("h" (/hydras/toggles/activate-switch-engine 'helm))
  ("i" (/hydras/toggles/activate-switch-engine 'ivy))
  ("o" (/hydras/toggles/activate-switch-engine 'ido)))

(defhydra /hydras/toggles (:hint nil :exit t)
  "
   toggle:  _a_ → aggressive indent   _s_ → flycheck   _r_ → read only      _t_ → truncate lines   _e_ → debug on error   ' → switch-engine
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
  ("p" /pairs/toggle)
  ("'" /hydras/toggles/switch-engine/body))



(defhydra /hydras/helm (:hint nil :exit t)
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



(defhydra /hydras/ivy (:hint nil :exit t)
  "
   ivy:   _b_ → mini       _y_ → kill-ring   _l_ → swiper
          _e_ → recentf    _x_ → M-x         _L_ → swiper (multi)
          _f_ → files
"
  ("b" /ivy/mini)
  ("e" counsel-recentf)
  ("f" counsel-find-file)
  ("y" counsel-yank-pop)
  ("x" counsel-M-x)
  ("l" swiper)
  ("L" swiper-all))



(autoload 'magit-log-popup "magit-log" nil t)
(autoload 'magit-commit-popup "magit-commit" nil t)

(defhydra /hydras/git (:hint nil :exit t)
  "
  magit: _s_ → status  _l_ → log    _f_ → file       staging: _a_ → +hunk  _A_ → +buffer      history: _t_ → time machine
         _c_ → commit  _d_ → diff   _z_ → stash               _r_ → -hunk  _R_ → -buffer
         _p_ → push    _b_ → blame  _m_ → merge

"
  ("s" magit-status)
  ("b" magit-blame-popup)
  ("f" magit-file-popup)
  ("z" magit-stash-popup)
  ("l" magit-log-popup)
  ("d" magit-diff-popup)
  ("c" magit-commit-popup)
  ("m" magit-merge-popup)
  ("p" magit-push-popup)
  ("a" git-gutter+-stage-hunks)
  ("r" git-gutter+-revert-hunk)
  ("A" git-gutter+-stage-whole-buffer)
  ("R" git-gutter+-unstage-whole-buffer)
  ("t" git-timemachine))



(defhydra /hydras/paste (:hint nil)
  "
   paste:  _C-j_ → cycle next          _p_ → paste before       pos: %(length kill-ring-yank-pointer)
           _C-k_ → cycle previous      _P_ → paste after        len: %(length kill-ring)
"
  ("C-j" evil-paste-pop-next)
  ("C-k" evil-paste-pop)
  ("p" evil-paste-after)
  ("P" evil-paste-before))



(when (> (length narrow-map) 8)
  (error "`narrow-map' has more than 7 bindings!"))
(defhydra /hydras/narrow (:hint nil :exit t)
  "
   narrow:  _d_ → defun   _b_ → org-block    _w_ → widen
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



(defhydra /hydras/modes/css-mode (:hint nil :exit t)
  "
   css:  _t_ generate type definition for CSS
"
  ("t" /typescript/generate-typings-for-css))


(provide 'config-bindings-hydras)
