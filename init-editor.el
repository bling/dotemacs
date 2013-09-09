(when (fboundp 'electric-pair-mode)
  (setq-default electric-pair-mode 1))

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(require-package 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)

(global-set-key (kbd "RET") 'newline-and-indent)

(require-package 'mic-paren)
(paren-activate)

(provide 'init-editor)
