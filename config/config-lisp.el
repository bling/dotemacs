;; -*- lexical-binding: t -*-

(defun /lisp/major-mode-hook ()
  (setq-local dash-docs-common-docsets '("Emacs Lisp"))
  (eldoc-mode)
  (when (fboundp #'cape-elisp-symbol)
    (add-hook 'completion-at-point-functions #'cape-elisp-symbol nil t)))

(add-hook 'emacs-lisp-mode-hook #'/lisp/major-mode-hook)
(add-hook 'lisp-interaction-mode-hook #'/lisp/major-mode-hook)
(add-hook 'ielm-mode-hook #'/lisp/major-mode-hook)

(defun /lisp/recompile-elpa ()
  "Byte-recompile installed packages in elpa/."
  (interactive)
  (byte-recompile-directory (concat user-emacs-directory "elpa/") 0 t))

(use-package helpful)

(provide 'config-lisp)
