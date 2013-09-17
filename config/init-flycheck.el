(require-package 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

(provide 'init-flycheck)
