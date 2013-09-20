(require-package 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)
(smartparens-global-strict-mode t)
(setq sp-autoescape-string-quote nil
      sp-autoskip-closing-pair 'always)

(require-package 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq-default undo-tree-history-directory-alist
              `(("." . ,(expand-file-name ".cache/undo" my-user-emacs-directory))))

(require-package 'monokai-theme)
(load-theme 'monokai t)

(require-package 'multiple-cursors)

(provide 'init-editor)
