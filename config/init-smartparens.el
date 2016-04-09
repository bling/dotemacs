(when (eq dotemacs-pair-engine 'smartparens)
  (require-package 'smartparens)
  (require 'smartparens-config)

  (electric-pair-mode -1)

  (setq sp-autoinsert-quote-if-followed-by-closing-pair nil)
  (setq sp-autoinsert-pair t)

  (setq sp-show-pair-delay 0)
  (setq sp-show-pair-from-inside t)

  (show-smartparens-global-mode t)
  (smartparens-global-mode t)

  (sp-use-smartparens-bindings)

  ;; fix conflict where smartparens clobbers yas' key bindings
  (after 'yasnippet
    (defadvice yas-expand (before dotemacs activate)
      (sp-remove-active-pair-overlay))))

(provide 'init-smartparens)
