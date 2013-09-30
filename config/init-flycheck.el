(require-package 'flycheck)

(after-load 'flycheck
  (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

(global-flycheck-mode t)

(provide 'init-flycheck)
