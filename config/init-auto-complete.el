(defvar ac-auto-show-menu t)
(defvar ac-auto-start 1)
(defvar ac-comphist-file (concat user-emacs-directory ".cache/ac-comphist.dat"))
(defvar ac-quick-help-delay 0.3)
(defvar ac-quick-help-height 30)
(defvar ac-show-menu-immediately-on-auto-complete t)

(require-package 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(after 'linum
  (ac-linum-workaround))

(add-to-list 'ac-modes 'vimrc-mode)

(defadvice ac-expand (before advice-for-ac-expand activate)
  (when (yas-expand)
    (ac-stop)))

(provide 'init-auto-complete)
