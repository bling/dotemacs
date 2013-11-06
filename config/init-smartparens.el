(require-package 'smartparens)
(require 'smartparens-config)

(setq sp-autoskip-closing-pair t
      sp-autoescape-string-quote nil
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

(sp-local-pair '(js-mode js2-mode) "{" nil :post-handlers '(:add (my-open-block-c-mode "C-j")))

(provide 'init-smartparens)
