(require-package 'smartparens)
(require 'smartparens-config)

(setq sp-autoskip-closing-pair 'always
      sp-show-pair-delay 0
      sp-show-pair-from-inside t)

(smartparens-global-mode t)
(show-smartparens-global-mode)

(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))

(sp-local-pair '(js2-mode) "{" nil :post-handlers '((my-open-block-c-mode "RET")))

(provide 'init-smartparens)
