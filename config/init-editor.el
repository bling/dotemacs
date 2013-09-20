(require-package 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)
(smartparens-global-strict-mode t)
(show-smartparens-global-mode t)
(setq sp-autoescape-string-quote nil
      sp-autoskip-closing-pair 'always
      sp-show-pair-delay 0
      sp-show-pair-from-inside t)

(require-package 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq-default undo-tree-history-directory-alist
              `(("." . ,(concat my-user-emacs-directory ".cache/undo"))))

(require-package 'monokai-theme)
(load-theme 'monokai t)

(require-package 'multiple-cursors)

(provide 'init-editor)
