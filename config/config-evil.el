;; -*- lexical-binding: t -*-

(defgroup dotemacs-evil nil
  "Configuration options for evil-mode."
  :group 'dotemacs
  :prefix 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-state-hooks
  '(org-log-buffer-setup-hook org-capture-mode-hook)
  "List of hooks to automatically start up in Evil Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-state-major-modes
  '(calculator-mode
    eshell-mode
    shell-mode
    ghostel-mode
    eat-mode
    vterm-mode
    term-mode)
  "List of major modes that should default to Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-state-minor-modes
  '(git-commit-mode
    magit-blame-mode)
  "List of minor modes that when active should switch to Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-insert-mode
  nil
  "If non-nil, insert mode will act as Emacs state."
  :type 'boolean
  :group 'dotemacs-evil)

(defcustom dotemacs-evil/comments
  'evil-nerd-commenter
  "The library to use for comments."
  :type '(radio
          (const :tag "evil-nerd-commenter" evil-nerd-commenter)
          (const :tag "evil-commentary" evil-commentary))
  :group 'dotemacs-evil)



(use-package evil :demand t
  :init
  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-motion-state-cursor '("orange" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" bar))
  (setq evil-operator-state-cursor '("red" hollow))
  (setq evil-search-module 'evil-search)
  (setq evil-magic 'very-magic)
  (setq evil-want-keybinding nil) ;; evil-collection will provide instead
  (setq evil-undo-system 'undo-fu)
  :config
  (add-hook 'evil-jumps-post-jump-hook #'recenter)
  (evil-mode)

  (cl-loop for mode in dotemacs-evil/emacs-state-minor-modes
           do (let ((hook (concat (symbol-name mode) "-hook")))
                (add-hook (intern hook) `(lambda ()
                                           (if ,mode
                                               (evil-emacs-state)
                                             (evil-normal-state))))))

  (cl-loop for hook in dotemacs-evil/emacs-state-hooks
           do (add-hook hook #'evil-emacs-state))

  (cl-loop for mode in dotemacs-evil/emacs-state-major-modes
           do (evil-set-initial-state mode 'emacs))

  (evil-put-property 'evil-state-properties 'normal   :tag " NORMAL ")
  (evil-put-property 'evil-state-properties 'insert   :tag " INSERT ")
  (evil-put-property 'evil-state-properties 'visual   :tag " VISUAL ")
  (evil-put-property 'evil-state-properties 'motion   :tag " MOTION ")
  (evil-put-property 'evil-state-properties 'emacs    :tag " EMACS ")
  (evil-put-property 'evil-state-properties 'replace  :tag " REPLACE ")
  (evil-put-property 'evil-state-properties 'operator :tag " OPERATOR ")

  (defvar-local /evil/emacs-state-modeline-tag nil)
  (add-to-list 'global-mode-string '(:eval /evil/emacs-state-modeline-tag) t)
  (add-hook 'evil-emacs-state-entry-hook
            (defun /evil/turn-emacs-modeline-tag-on ()
              (setq /evil/emacs-state-modeline-tag (propertize "   EMACS STATE   " 'face 'isearch))))
  (add-hook 'evil-emacs-state-exit-hook
            (defun /evil/turn-emacs-modeline-tag-off ()
              (setq /evil/emacs-state-modeline-tag nil))))



(when dotemacs-evil/emacs-insert-mode
  (defalias 'evil-insert-state 'evil-emacs-state)
  (define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state))


(pcase dotemacs-evil/comments
  ('evil-commentary
   (use-package evil-commentary :demand t
     :config
     (evil-commentary-mode t)))
  ('evil-nerd-commenter
   (use-package evil-nerd-commenter :demand t
     :config
     (require 'evil-nerd-commenter-operator)
     (define-key evil-inner-text-objects-map evilnc-comment-text-object 'evilnc-inner-comment)
     (define-key evil-outer-text-objects-map evilnc-comment-text-object 'evilnc-outer-commenter)
     (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
     (define-key evil-normal-state-map "gy" 'evilnc-copy-and-comment-operator))))


(use-package evil-surround :demand t
  :config
  (global-evil-surround-mode t))


(use-package evil-exchange :demand t
  :config
  (evil-exchange-install))


(use-package evil-anzu :demand t)


(use-package evil-avy :demand t
  :config
  (evil-avy-mode)
  (add-hook 'magit-status-mode-hook (lambda () (evil-avy-mode -1))))


(use-package evil-matchit :demand t
  :config
  (global-evil-matchit-mode t))


(use-package evil-indent-textobject :demand t)


(use-package evil-visualstar :demand t
  :config
  (global-evil-visualstar-mode t))


(use-package evil-numbers)


(use-package evil-terminal-cursor-changer :demand t
  :if (not (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate))



(advice-add 'evil-ex-search-next :after (lambda (&rest _) (recenter)))
(advice-add 'evil-ex-search-previous :after (lambda (&rest _) (recenter)))

(provide 'config-evil)
