;; -*- lexical-binding: t -*-

(require-package 'yasnippet)
(require 'yasnippet)

(setq yas-fallback-behavior 'return-nil)
(setq yas-also-auto-indent-first-line t)
(setq yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))

(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'html-mode-hook #'yas-minor-mode)

(/boot/delayed-init
 (yas-load-directory (concat user-emacs-directory "snippets")))

(when (eq dotemacs-completion-engine 'corfu)
  (require-package 'yasnippet-capf)
  (defun /yasnippet/add-capf ()
    (add-to-list 'completion-at-point-functions #'yasnippet-capf))
  (add-hook 'prog-mode-hook #'/yasnippet/add-capf)
  (add-hook 'text-mode-hook #'/yasnippet/add-capf))

(provide 'config-yasnippet)
