(require-package 'elisp-slime-nav)
(after "elisp-slime-nav-autoloads"
  (defadvice elisp-slime-nav-find-elisp-thing-at-point (after advice-for-elisp-slime-nav-find-elisp-thing-at-point activate)
    (recenter)))

(defun my-lisp-hook ()
  (progn
    (elisp-slime-nav-mode)
    (eldoc-mode)))

(defun my-lisp-after-save-hook ()
  (when (or (string-prefix-p (file-truename (concat user-emacs-directory "/config"))
                             (file-truename buffer-file-name))
            (equal (file-truename buffer-file-name)
                   (file-truename custom-file)))
    (emacs-lisp-byte-compile)))

(add-hook 'emacs-lisp-mode-hook #'my-lisp-hook)
(add-hook 'lisp-interaction-mode-hook #'my-lisp-hook)
(add-hook 'ielm-mode-hook #'my-lisp-hook)
(add-hook 'after-save-hook #'my-lisp-after-save-hook)

(provide 'init-lisp)
