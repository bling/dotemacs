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
(setq helm-completion-in-region-fuzzy-match t)
(setq helm-mode-fuzzy-match t)

(setq helm-input-idle-delay 0.02)
(setq helm-candidate-number-limit 10)

(require-package 'helm)
(require-package 'helm-descbinds)

(setq helm-swoop-pre-input-function #'ignore)
(setq helm-swoop-use-line-number-face t)
(setq helm-swoop-split-with-multiple-windows t)
(require-package 'helm-swoop)
(after 'helm-swoop
  (after 'evil
    (defadvice helm-swoop--edit (after helm-swoop--edit-advice activate)
       (turn-on-evil-mode))))

(after "projectile-autoloads"
  (require-package 'helm-projectile))

(after "company-autoloads"
  (require-package 'helm-company))

(after 'helm
  ;; take between 10-30% of screen space
  (setq helm-autoresize-min-height 10)
  (setq helm-autoresize-max-height 30)
  (helm-autoresize-mode t))

(when (eq dotemacs-switch-engine 'helm)
  (delayed-init
   (helm-mode t)
   (global-set-key [remap execute-extended-command] #'helm-M-x)
   (global-set-key [remap find-file] #'helm-find-files)))


(provide 'init-helm)
