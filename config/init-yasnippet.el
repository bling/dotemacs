(require-package 'yasnippet)

(let* ((yas-install-dir (elt (cadr (assoc 'yasnippet package-alist)) 7))
       (dir (concat yas-install-dir "/snippets/js-mode")))
  (if (file-exists-p dir)
    (delete-directory dir t)))

(require 'yasnippet)

(setq yas-fallback-behavior 'return-nil)
(setq yas-also-auto-indent-first-line t)
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'html-mode-hook 'yas-minor-mode)

(yas-reload-all)

(provide 'init-yasnippet)
