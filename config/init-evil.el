(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-nerd-commenter)
(require-package 'surround)

(setq evil-magic 'very-magic)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-w-in-emacs-state t)
(setq evil-search-module 'evil-search)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-insert-state-cursor '("orange" bar))

(setq evilnc-hotkey-comment-operator "gc")

(require 'evil)
(require 'evil-leader)
(require 'evil-nerd-commenter)
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

(defun my-visualstar-search (beg end direction)
  (when (evil-visual-state-p)
    (let ((selection (buffer-substring-no-properties beg end)))
      (evil-exit-visual-state)
      (setq isearch-forward direction)
      (evil-search (regexp-quote selection) direction t))))

(defun my-visualstar-forward (beg end)
  "search for selected text in forward direction"
  (interactive "r")
  (my-visualstar-search beg end t))

(defun my-visualstar-backward (beg end)
  "search for selected text in backward direction"
  (interactive "r")
  (my-visualstar-search beg end nil))

(provide 'init-evil)
