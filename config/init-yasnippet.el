(defvar yas-fallback-behavior 'return-nil)
(defvar yas-also-auto-indent-first-line t)

(el-get 'sync '(yasnippet))
(require 'yasnippet)
(yas-global-mode t)

(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map [tab] nil)

(provide 'init-yasnippet)
