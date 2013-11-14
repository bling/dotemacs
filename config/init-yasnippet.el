(setq yas-fallback-behavior 'return-nil)
(setq yas-also-auto-indent-first-line t)

(require-package 'yasnippet)
(require 'yasnippet)
(yas-global-mode t)

(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map [tab] nil)

(provide 'init-yasnippet)
