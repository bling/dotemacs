(defun /typescript/setup ()
  (tide-setup)
  (tide-hl-identifier-mode t)
  (add-hook 'before-save-hook #'tide-format-before-save))

(defun /typescript/typescript-mode-hook ()
  (require-package 'tide)
  (/typescript/setup))

(defun /typescript/web-mode-hook ()
  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (/typescript/setup)))

(lazy-major-mode "\\.ts$" typescript-mode)
(add-hook 'typescript-mode-hook #'/typescript/typescript-mode-hook)

(lazy-major-mode "\\.tsx$" web-mode)
(add-hook 'web-mode-hook #'/typescript/web-mode-hook)

(provide 'init-typescript)
