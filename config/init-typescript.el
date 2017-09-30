(defun /typescript/setup ()
  (tide-setup)
  (tide-hl-identifier-mode t)
  (eldoc-mode t)
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

(after 'hydra
  (defhydra /hydras/modes/typescript-mode (:hint nil)
    "
 _d_ jump to definition   _f_ find references
 _r_ rename               _h_ documentation
 _S_ restart server
"
    ("d" tide-jump-to-definition)
    ("r" tide-rename-symbol)
    ("S" tide-restart-server)
    ("f" tide-references)
    ("h" tide-documentation-at-point)))

(provide 'init-typescript)
