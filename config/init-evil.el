(defcustom dotemacs-evil-state-modes
  '(fundamental-mode
    text-mode
    prog-mode
    sws-mode
    dired-mode
    comint-mode
    log-edit-mode
    compilation-mode)
  "List of modes that should start up in Evil state."
  :type '(repeat (symbol))
  :group 'dotemacs)

(defcustom dotemacs-emacs-state-modes
  '(debugger-mode)
  "List of modes that should start up in Evil Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs)


(setq evil-search-module 'evil-search)
(setq evil-magic 'very-magic)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(require-package 'evil)
(require 'evil)

(unless (display-graphic-p)
  (evil-esc-mode))


(require-package 'evil-leader)
(global-evil-leader-mode t)


(setq evilnc-hotkey-comment-operator "gc")
(require-package 'evil-nerd-commenter)
(require 'evil-nerd-commenter)


(require-package 'evil-surround)
(global-evil-surround-mode t)


(require-package 'evil-exchange)
(evil-exchange-install)


(setq evil-jumper-auto-center t)
(setq evil-jumper-file (concat dotemacs-cache-directory "evil-jumps"))
(setq evil-jumper-auto-save-interval 3600)
(require-package 'evil-jumper)
(global-evil-jumper-mode t)


(require-package 'evil-matchit)
(defun evilmi-customize-keybinding ()
  (evil-define-key 'normal evil-matchit-mode-map
    "%" 'evilmi-jump-items))
(global-evil-matchit-mode t)


(require-package 'evil-indent-textobject)
(require 'evil-indent-textobject)


(require-package 'evil-visualstar)
(global-evil-visualstar-mode t)


(require-package 'evil-numbers)


(defun my-major-mode-evil-state-adjust ()
  (if (apply 'derived-mode-p dotemacs-evil-state-modes)
      (turn-on-evil-mode)
    (set-cursor-color "red"))
  (if (apply 'derived-mode-p dotemacs-emacs-state-modes)
      (turn-off-evil-mode)))
(add-hook 'after-change-major-mode-hook #'my-major-mode-evil-state-adjust)

(defun my-send-string-to-terminal (string)
  (unless (display-graphic-p) (send-string-to-terminal string)))

(defun my-evil-terminal-cursor-change ()
  (when (string= (getenv "TERM_PROGRAM") "iTerm.app")
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\e]50;CursorShape=1\x7")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\e]50;CursorShape=0\x7"))))
  (when (and (getenv "TMUX") (string= (getenv "TERM_PROGRAM") "iTerm.app"))
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\")))))

(add-hook 'after-make-frame-functions (lambda (frame) (my-evil-terminal-cursor-change)))
(my-evil-terminal-cursor-change)

(defun my-evil-modeline-change (default-color)
  "changes the modeline color when the evil mode changes"
  (let ((color (cond ((evil-insert-state-p) '("#002233" . "#ffffff"))
                     ((evil-visual-state-p) '("#330022" . "#ffffff"))
                     ((evil-normal-state-p) default-color)
                     (t '("#440000" . "#ffffff")))))
    (set-face-background 'mode-line (car color))
    (set-face-foreground 'mode-line (cdr color))))

(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook (lambda () (my-evil-modeline-change default-color))))

(defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
  (recenter))

(defadvice evil-ex-search-previous (after advice-for-evil-ex-search-previous activate)
  (recenter))

(after 'edebug
  (add-hook 'edebug-mode-hook (lambda ()
                                (if edebug-mode
                                    (evil-emacs-state)
                                  (evil-normal-state)))))

(when (>= emacs-major-version 25)
  (defadvice elisp--preceding-sexp (around evil activate)
    "In normal-state or motion-state, last sexp ends at point."
    (if (or (evil-normal-state-p) (evil-motion-state-p))
        (save-excursion
          (unless (or (eobp) (eolp)) (forward-char))
          ad-do-it)
      ad-do-it)))

(provide 'init-evil)
