(require-package 'guide-key)
(setq guide-key/guide-key-sequence
      '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c h") 'helm-projectile)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-c C-m") 'smex)

(evil-leader/set-leader ",")
(evil-leader/set-key
  "v" 'split-window-horizontally
  "s" 'split-window-vertically
  "h" help-map)

(define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
(define-key evil-normal-state-map (kbd "] b") 'next-buffer)
(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)

(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)

(define-key evil-normal-state-map (kbd "Q") 'kill-this-buffer)

(provide 'init-bindings)
