(require-package 'auto-complete)

(setq
 ac-auto-show-menu 0.01
 ac-auto-start 2
 ac-comphist-file (concat user-emacs-directory ".cache/ac-comphist.dat")
 ac-delay 0.01
 ac-quick-help-delay 0.5
 ac-use-fuzzy t
 ac-show-menu-immediately-on-auto-complete t)

(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-modes 'vimrc-mode)

(provide 'init-auto-complete)
