(require-package 'undo-tree)
(require 'undo-tree)
(setq undo-tree-auto-save-history t)
(setq-default undo-tree-history-directory-alist
              `(("." . ,(concat user-emacs-directory ".cache/undo"))))
(global-undo-tree-mode)

(require-package 'multiple-cursors)
(require 'multiple-cursors)

(add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
(add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)

(provide 'init-editor)
