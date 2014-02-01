(require-package 'wgrep)
(require 'wgrep)


(when (executable-find "ag")
  (require-package 'ag)
  (require 'ag)
  (require-package 'wgrep-ag)
  (require 'wgrep-ag)
  (setq ag-highlight-search t)
  (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t))))


(when (executable-find "ack")
  (require-package 'ack-and-a-half)
  (require 'ack-and-a-half)
  (require-package 'wgrep-ack)
  (require 'wgrep-ack))


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


(require-package 'framemove)
(require 'framemove)
(setq framemove-hook-into-windmove t)


(require-package 'discover)
(global-discover-mode)


(provide 'init-misc)
