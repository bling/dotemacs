(require-package 'undo-tree)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `(("." . ,(concat dotemacs-cache-directory "undo"))))
(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)
(global-undo-tree-mode)


(require-package 'multiple-cursors)
(setq mc/unsupported-minor-modes '(company-mode auto-complete-mode flyspell-mode jedi-mode))
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state))


(require-package 'wgrep)


(when (executable-find "pt")
  (require-package 'pt)
  (require-package 'wgrep-pt))


(when (executable-find "ag")
  (require-package 'ag)
  (setq ag-highlight-search t)
  (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))
  (require-package 'wgrep-ag))


(when (executable-find "ack")
  (require-package 'ack-and-a-half)
  (require-package 'wgrep-ack))


(require-package 'project-explorer)
(after 'project-explorer
  (setq pe/cache-directory (concat dotemacs-cache-directory "project-explorer"))
  (setq pe/omit-regex (concat pe/omit-regex "\\|^node_modules$")))


(require-package 'ace-jump-mode)


(require-package 'expand-region)


(require-package 'editorconfig)
(require 'editorconfig)


(require-package 'etags-select)
(setq etags-select-go-if-unambiguous t)


(require-package 'windsize)
(require 'windsize)
(setq windsize-cols 16)
(setq windsize-rows 8)
(windsize-default-keybindings)


(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


(require-package 'framemove)
(require 'framemove)
(setq framemove-hook-into-windmove t)


(require-package 'discover-my-major)


(provide 'init-misc)
