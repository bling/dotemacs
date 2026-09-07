;; -*- lexical-binding: t -*-

(use-package yasnippet
  :hook ((prog-mode text-mode) . yas-minor-mode)
  :init
  (setq yas-fallback-behavior 'return-nil)
  (setq yas-also-auto-indent-first-line t)
  (setq yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))
  :config
  (/boot/delayed-init
   (yas-load-directory (concat user-emacs-directory "snippets"))))

(when (eq dotemacs-completion-engine 'corfu)
  (use-package yasnippet-capf
    :config
    (defun /yasnippet/add-capf ()
      (add-to-list 'completion-at-point-functions #'yasnippet-capf))
    (add-hook 'prog-mode-hook #'/yasnippet/add-capf)
    (add-hook 'text-mode-hook #'/yasnippet/add-capf)))

(provide 'config-yasnippet)
