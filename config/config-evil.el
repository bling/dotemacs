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
    makey-key-mode)
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



(setq evil-search-module 'evil-search)
(setq evil-magic 'very-magic)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-motion-state-cursor '("orange" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(add-hook 'evil-jumps-post-jump-hook #'recenter)

(setq evil-want-keybinding nil) ;; evil-collection will provide instead

(require-package 'evil)
(require 'evil)
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

(after 'evil-common
  (evil-put-property 'evil-state-properties 'normal   :tag " NORMAL ")
  (evil-put-property 'evil-state-properties 'insert   :tag " INSERT ")
  (evil-put-property 'evil-state-properties 'visual   :tag " VISUAL ")
  (evil-put-property 'evil-state-properties 'motion   :tag " MOTION ")
  (evil-put-property 'evil-state-properties 'emacs    :tag " EMACS ")
  (evil-put-property 'evil-state-properties 'replace  :tag " REPLACE ")
  (evil-put-property 'evil-state-properties 'operator :tag " OPERATOR "))



(when dotemacs-evil/emacs-insert-mode
  (defalias 'evil-insert-state 'evil-emacs-state)
  (define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state))


(unless (display-graphic-p)
  (evil-esc-mode 1))


(cond
 ((eq dotemacs-evil/comments 'evil-commentary)
  (require-package 'evil-commentary)
  (evil-commentary-mode t))
 ((eq dotemacs-evil/comments 'evil-nerd-commenter)
  (require-package 'evil-nerd-commenter)
  (require 'evil-nerd-commenter)
  (require 'evil-nerd-commenter-operator)
  (define-key evil-inner-text-objects-map evilnc-comment-text-object 'evilnc-inner-comment)
  (define-key evil-outer-text-objects-map evilnc-comment-text-object 'evilnc-outer-commenter)
  (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
  (define-key evil-normal-state-map "gy" 'evilnc-copy-and-comment-operator)))


(require-package 'evil-surround)
(global-evil-surround-mode t)


(require-package 'evil-exchange)
(evil-exchange-install)


(require-package 'evil-anzu)
(require 'evil-anzu)


(after 'magit
  (require-package 'evil-magit)
  (require 'evil-magit))


(require-package 'evil-avy)
(evil-avy-mode)


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


(require-package 'evil-terminal-cursor-changer)
(evil-terminal-cursor-changer-activate)



(defadvice evil-ex-search-next (after dotemacs activate)
  (recenter))

(defadvice evil-ex-search-previous (after dotemacs activate)
  (recenter))

(provide 'config-evil)
