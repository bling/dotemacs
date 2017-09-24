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

(provide 'init-lisp)
