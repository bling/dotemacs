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
                ;; shell-mode term-mode terminal-mode eshell-mode comint-mode skewer-repl-mode
                html-mode stylus-mode))
  (add-to-list 'ac-modes mode))

(ac-config-default)

(after 'linum
  (ac-linum-workaround))

(after 'yasnippet
  (add-hook 'yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
  (add-hook 'yas-after-exit-snippet-hook (lambda () (auto-complete-mode t)))
  (defadvice ac-expand (before advice-for-ac-expand activate)
    (when (yas-expand)
      (ac-stop))))

(require-package 'ac-etags)
(setq ac-etags-requires 1)
(after 'etags
  (ac-etags-setup))

(provide 'init-auto-complete)
