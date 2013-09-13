(require-package 'evil)
(require-package 'evil-leader)
(require-package 'surround)

(setq evil-magic 'very-magic)
(setq evil-want-C-u-scroll t)
(setq evil-search-module 'evil-search)

(require 'evil)
(require 'evil-leader)
(require 'surround)

(evil-mode t)
(global-evil-leader-mode)
(global-surround-mode 1)

(provide 'init-evil)
