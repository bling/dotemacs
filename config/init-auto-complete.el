(require-package 'auto-complete)
(require 'auto-complete)
(require 'auto-complete-config)

(setq ac-auto-show-menu t)
(setq ac-auto-start t)
(setq ac-comphist-file (concat user-emacs-directory ".cache/ac-comphist.dat"))
(setq ac-quick-help-delay 0.3)
(setq ac-quick-help-height 30)
(setq ac-show-menu-immediately-on-auto-complete t)

(dolist (mode '(vimrc-mode
                html-mode stylus-mode))
  (add-to-list 'ac-modes mode))

(ac-config-default)

(after 'linum
  (ac-linum-workaround))

(defadvice ac-expand (before advice-for-ac-expand activate)
  (when (yas-expand)
    (ac-stop)))

(provide 'init-auto-complete)
