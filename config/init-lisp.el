(require-package 'rainbow-delimiters)
(require-package 'elisp-slime-nav)

(defun my-lisp-hook ()
  (progn
    (elisp-slime-nav-mode)
    (turn-on-eldoc-mode)
    (rainbow-delimiters-mode t)))

(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
(add-hook 'lisp-interaction-mode-hook 'my-lisp-hook)
(add-hook 'ielm-mode-hook 'my-lisp-hook)

(provide 'init-lisp)
