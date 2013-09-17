(require-package 'evil)
(require-package 'evil-leader)
(require-package 'surround)

(setq evil-magic 'very-magic)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-w-in-emacs-state t)
(setq evil-search-module 'evil-search)

(require 'evil)
(require 'evil-leader)
(require 'surround)

(global-evil-leader-mode)
(evil-mode t)
(global-surround-mode 1)

(unless (display-graphic-p)
  (if (string= (getenv "TERM_PROGRAM") "iTerm.app")
      (progn
        (add-hook 'evil-insert-state-entry-hook
                  (lambda () (send-string-to-terminal "\e]50;CursorShape=1\x7")))
        (add-hook 'evil-insert-state-exit-hook
                  (lambda () (send-string-to-terminal "\e]50;CursorShape=0\x7")))))
  (if (and (getenv "TMUX") (string= (getenv "TERM_PROGRAM") "iTerm.app"))
      (progn
        (add-hook 'evil-insert-state-entry-hook
                  (lambda () (send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
        (add-hook 'evil-insert-state-exit-hook
                  (lambda () (send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\"))))))

(provide 'init-evil)
