(require-package 'smartparens)
(require 'smartparens-config)

(setq sp-autoinsert-quote-if-followed-by-closing-pair nil)

(when (eq dotemacs-pair-engine 'smartparens)
  (setq sp-autoinsert-pair t)

  (setq sp-show-pair-delay 0)
  (setq sp-show-pair-from-inside t)
  (show-smartparens-global-mode t))

(sp-use-smartparens-bindings)
(smartparens-global-mode t)

;; fix conflict where smartparens clobbers yas' key bindings
(after 'yasnippet
  (defadvice yas-expand (before advice-for-yas-expand activate)
    (sp-remove-active-pair-overlay)))

(provide 'init-smartparens)
