(require-package 'guide-key)
(setq guide-key/guide-key-sequence
      '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(require-package 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-c C-m") 'smex)
(global-set-key (kbd "C-c h") 'helm-mini)

(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'eval-last-sexp
  "b d" 'kill-this-buffer
  "v" (kbd "C-w v C-w l")
  "s" (kbd "C-w s C-w j")
  "g s" 'magit-status
  "h" help-map
  "h h" 'help-for-help-internal)

(define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
(define-key evil-normal-state-map (kbd "] b") 'next-buffer)
(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
(define-key evil-normal-state-map (kbd "C-q") 'universal-argument)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)

(define-key evil-normal-state-map (kbd "Q") 'my-window-killer)
(define-key evil-normal-state-map (kbd "Y") (kbd "y$"))

(define-key evil-visual-state-map (kbd "*") 'my-visualstar-forward)
(define-key evil-visual-state-map (kbd "#") 'my-visualstar-backward)

(provide 'init-bindings)
