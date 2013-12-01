(require-package 'ag)
(require 'ag)
(setq ag-highlight-search t)
(add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))


(require-package 'project-explorer)
(require 'project-explorer)
(setq pe/omit-regex (concat pe/omit-regex "\\|^node_modules$"))


(require-package 'ace-jump-mode)
(require 'ace-jump-mode)


(require-package 'expand-region)
(require 'expand-region)


(require-package 'editorconfig)
(require 'editorconfig)


(require-package 'etags-select)
(require 'etags-select)
(setq etags-select-go-if-unambiguous t)


(require-package 'windsize)
(require 'windsize)
(setq windsize-cols 16)
(setq windsize-rows 8)
(windsize-default-keybindings)


(require-package 'rainbow-delimiters)
(global-rainbow-delimiters-mode)


(provide 'init-misc)
