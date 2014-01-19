(setq eshell-directory-name (concat user-emacs-directory ".cache/eshell"))
(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))
(setq eshell-scroll-to-bottom-on-input 'all)
(setq eshell-glob-case-insensitive t)
(setq eshell-buffer-shorthand t)
(setq eshell-error-if-no-glob t)

(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))
