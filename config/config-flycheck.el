(require-package 'flycheck)

(setq flycheck-standard-error-navigation t)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc html-tidy))

(after 'web-mode
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)

(when (display-graphic-p)
  (require-package 'flycheck-pos-tip)
  (setq flycheck-pos-tip-timeout -1)
  (flycheck-pos-tip-mode))

(after [evil flycheck]
  (evil-define-key 'normal flycheck-error-list-mode-map
    "j" #'flycheck-error-list-next-error
    "k" #'flycheck-error-list-previous-error))

(provide 'config-flycheck)
