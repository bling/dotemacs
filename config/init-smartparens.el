(require-package 'smartparens)
(require 'smartparens-config)


(setq sp-autoescape-string-quote nil)
(setq sp-autoinsert-quote-if-followed-by-closing-pair nil)

(sp-use-smartparens-bindings)
(electric-pair-mode -1)
(smartparens-global-mode t)


(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside t)
(show-paren-mode -1)
(show-smartparens-global-mode t)


(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode)))

(sp-pair "{" nil :post-handlers '(:add (my-open-block-c-mode "RET")))
(sp-pair "[" nil :post-handlers '(:add (my-open-block-c-mode "RET")))

;; fix conflict where smartparens clobbers yas' key bindings
(after 'yasnippet
  (defadvice yas-expand (before advice-for-yas-expand activate)
    (sp-remove-active-pair-overlay)))

(provide 'init-smartparens)
