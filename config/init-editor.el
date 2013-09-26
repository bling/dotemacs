(require-package 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)
;; (smartparens-global-strict-mode t)
(show-smartparens-global-mode t)
(setq sp-autoescape-string-quote nil
      sp-autoskip-closing-pair 'always
      sp-show-pair-delay 0
      sp-show-pair-from-inside t)

(require-package 'undo-tree)
(require 'undo-tree)
(setq undo-tree-auto-save-history t)
(setq-default undo-tree-history-directory-alist
              `(("." . ,(concat user-emacs-directory ".cache/undo"))))
(global-undo-tree-mode)

(require-package 'monokai-theme)
(load-theme 'monokai t)

(require-package 'multiple-cursors)
(require 'multiple-cursors)

(add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
(add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)

(provide 'init-editor)
