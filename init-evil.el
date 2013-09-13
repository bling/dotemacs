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

(evil-leader/set-leader ",")
(evil-leader/set-key
  "v" 'split-window-horizontally
  "s" 'split-window-vertically)

(define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
(define-key evil-normal-state-map (kbd "] b") 'next-buffer)
(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)

(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)

(provide 'init-evil)
