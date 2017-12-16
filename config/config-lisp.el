(defgroup dotemacs-lisp nil
  "Configuration options for lisp."
  :group 'dotemacs
  :prefix 'dotemacs-lisp)

(defcustom dotemacs-lisp/compile-config
  nil
  "If non-nil, automatically byte-compile all configuration."
  :type 'boolean
  :group 'dotemacs-lisp)

(require-package 'elisp-slime-nav)
(after 'elisp-slime-nav
  (defadvice elisp-slime-nav-find-elisp-thing-at-point (after dotemacs activate)
    (recenter)))

(defun /lisp/major-mode-hook ()
  (progn
    (elisp-slime-nav-mode)
    (eldoc-mode)))

(add-hook 'emacs-lisp-mode-hook #'/lisp/major-mode-hook)
(add-hook 'lisp-interaction-mode-hook #'/lisp/major-mode-hook)
(add-hook 'ielm-mode-hook #'/lisp/major-mode-hook)

(when dotemacs-lisp/compile-config
  (require-package 'auto-compile)
  (auto-compile-on-save-mode)
  (add-hook 'after-init-hook
            (defun /lisp/after-init-auto-compile-hook ()
              (unless (file-exists-p (concat user-emacs-directory "init.elc"))
                (byte-compile-file (concat user-emacs-directory "init.el"))
                (byte-recompile-directory (concat user-emacs-directory "config/") 0 t)))))

(provide 'config-lisp)
