(require-package 'smartparens)
(require 'smartparens-config)

(setq sp-autoskip-closing-pair 'always
      sp-show-pair-delay 0
      sp-show-pair-from-inside t)

(smartparens-global-mode t)
(show-smartparens-global-mode t)

(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))

(sp-with-modes '(js2-mode)
  (sp-local-pair "{" nil :post-handlers '(:add my-open-block-c-mode)))

(provide 'init-smartparens)
