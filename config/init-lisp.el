(require-package 'elisp-slime-nav)
(after 'elisp-slime-nav
  (defadvice elisp-slime-nav-find-elisp-thing-at-point (after dotemacs activate)
    (recenter)))

(defun my-lisp-hook ()
  (progn
    (elisp-slime-nav-mode)
    (eldoc-mode)))

(add-hook 'emacs-lisp-mode-hook #'my-lisp-hook)
(add-hook 'lisp-interaction-mode-hook #'my-lisp-hook)
(add-hook 'ielm-mode-hook #'my-lisp-hook)

(provide 'init-lisp)
