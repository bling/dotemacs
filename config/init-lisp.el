(require-package 'rainbow-delimiters)

(defun my-lisp-hook ()
  (progn
    (turn-on-eldoc-mode)
    (rainbow-delimiters-mode t)))

(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
(add-hook 'lisp-interaction-mode-hook 'my-lisp-hook)
(add-hook 'ielm-mode-hook 'my-lisp-hook)

(provide 'init-lisp)
