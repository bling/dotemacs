(require-package 'yasnippet)
(require 'yasnippet)

(setq yas-fallback-behavior 'return-nil)
(setq yas-also-auto-indent-first-line t)
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

(yas-reload-all)

(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'html-mode-hook 'yas-minor-mode)

(provide 'init-yasnippet)
