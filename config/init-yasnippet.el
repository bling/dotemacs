(require-package 'yasnippet)
(require 'yasnippet)

(setq yas-fallback-behavior 'return-nil)
(setq yas-also-auto-indent-first-line t)
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

;; just use my own
(setq yas-snippet-dirs `(,(concat user-emacs-directory "snippets")))

(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'html-mode-hook 'yas-minor-mode)

(yas-reload-all)

(provide 'init-yasnippet)
