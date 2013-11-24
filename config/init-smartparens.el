(require-package 'smartparens)
(require 'smartparens-config)

(setq sp-autoskip-closing-pair 'always
      sp-autoescape-string-quote nil
      sp-show-pair-delay 0
      sp-show-pair-from-inside t)

(smartparens-global-mode t)
(show-smartparens-global-mode)

(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode)))

(sp-pair "{" nil :post-handlers '(:add (my-open-block-c-mode "RET")))
(sp-pair "[" nil :post-handlers '(:add (my-open-block-c-mode "RET")))

(provide 'init-smartparens)
