(require-package 'auto-complete)

(after 'auto-complete-autoloads
  (setq ac-auto-show-menu t
        ac-auto-start 1
        ac-comphist-file (concat user-emacs-directory ".cache/ac-comphist.dat")
        ac-delay 0
        ac-quick-help-delay 0.3
        ac-quick-help-height 30
        ac-show-menu-immediately-on-auto-complete t))

(require 'auto-complete-config)

(ac-config-default)

(after 'linum
  (ac-linum-workaround))

(add-to-list 'ac-modes 'vimrc-mode)

(defadvice ac-expand (before advice-for-ac-expand activate)
  (when (yas-expand)
    (ac-stop)))

(provide 'init-auto-complete)
