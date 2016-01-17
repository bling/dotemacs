(require-package 'flycheck)

(setq flycheck-check-syntax-automatically '(save mode-enabled))
(setq flycheck-standard-error-navigation nil)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc html-tidy))

(global-flycheck-mode)


(require-package 'flycheck-pos-tip)
(flycheck-pos-tip-mode)


(provide 'init-flycheck)
