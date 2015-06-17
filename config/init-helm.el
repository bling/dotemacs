(setq helm-command-prefix-key "C-c h")
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)
(setq helm-M-x-fuzzy-match t)
(setq helm-apropos-fuzzy-match t)
(setq helm-recentf-fuzzy-match t)
(setq helm-locate-fuzzy-match t)
(setq helm-file-cache-fuzzy-match t)
(setq helm-semantic-fuzzy-match t)
(setq helm-imenu-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)

(require-package 'helm)
(require-package 'helm-descbinds)

(setq helm-swoop-pre-input-function #'ignore)
(setq helm-swoop-use-line-number-face t)
(setq helm-swoop-split-with-multiple-windows t)
(require-package 'helm-swoop)

(after "projectile-autoloads"
  (require-package 'helm-projectile))

(after "company-autoloads"
  (require-package 'helm-company))

(after 'helm
  (helm-autoresize-mode t))

(provide 'init-helm)
