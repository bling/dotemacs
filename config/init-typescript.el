(defun init-typescript/setup ()
  (tide-setup)
  (tide-hl-identifier-mode t)
  (add-hook 'before-save-hook #'tide-format-before-save))

(defun init-typescript/typescript-mode-hook ()
  (require-package 'tide)
  (init-typescript/setup))

(defun init-typescript/web-mode-hook ()
  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (init-typescript/setup)))

(lazy-major-mode "\\.ts$" typescript-mode)
(add-hook 'typescript-mode-hook #'init-typescript/typescript-mode-hook)

(lazy-major-mode "\\.tsx$" web-mode)
(add-hook 'web-mode-hook #'init-typescript/web-mode-hook)

(provide 'init-typescript)
