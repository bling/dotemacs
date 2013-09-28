(defvar ac-auto-show-menu 0.01)
(defvar ac-auto-start 1)
(defvar ac-comphist-file (concat user-emacs-directory ".cache/ac-comphist.dat"))
(defvar ac-delay 0.01)
(defvar ac-quick-help-delay 0.5)
(defvar ac-show-menu-immediately-on-auto-complete t)

(require-package 'auto-complete)

(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)

(add-to-list 'ac-modes 'vimrc-mode)

(defun my-auto-complete-tab ()
  (interactive)
  (when (null (yas/expand))
    (ac-expand)))

(provide 'init-auto-complete)
