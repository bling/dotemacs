(require-package 'flycheck)

(after 'flycheck
  (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

(global-flycheck-mode t)

(provide 'init-flycheck)
