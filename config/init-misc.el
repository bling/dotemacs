(defvar ag-highlight-search t)
(require-package 'ag)
(add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))


(require-package 'project-explorer)
(require 'project-explorer)
(setq pe/omit-regex (concat pe/omit-regex "\\|^node_modules$"))


(require-package 'ace-jump-mode)
(require 'ace-jump-mode)


(provide 'init-misc)
