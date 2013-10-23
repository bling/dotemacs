(defmacro bind (&rest commands)
  "Convience macro which creates a lambda interactive command."
  `(lambda ()
     (interactive)
     ,@commands))


(require-package 'guide-key)
(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)


(after 'smex
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "C-x C-m") 'smex)
  (global-set-key (kbd "C-c C-m") 'smex))


(after 'evil-leader
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "e" (kbd "C-x C-e")
    "E" (kbd "C-M-x")
    "c" (bind
          (evil-window-split)
          (eshell))
    "C" 'customize-group
    "b d" 'kill-this-buffer
    "v" (kbd "C-w v C-w l")
    "s" (kbd "C-w s C-w j")
    "g s" 'magit-status
    "g l" 'magit-log
    "g d" 'vc-diff
    "P" 'package-list-packages
    "V" (bind (term "vim"))
    "h" help-map
    "h h" 'help-for-help-internal))


(after 'evil
  (require-package 'key-chord)
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)

  (after 'git-gutter+-autoloads
    (define-key evil-normal-state-map (kbd "[ h") 'git-gutter+-previous-hunk)
    (define-key evil-normal-state-map (kbd "] h") 'git-gutter+-next-hunk)
    (define-key evil-normal-state-map (kbd ", g a") 'git-gutter+-stage-hunks)
    (define-key evil-normal-state-map (kbd ", g r") 'git-gutter+-revert-hunks)
    (evil-ex-define-cmd "Gw" (bind (git-gutter+-stage-whole-buffer))))

  (after 'smex
    (define-key evil-visual-state-map (kbd "SPC SPC") 'smex)
    (define-key evil-normal-state-map (kbd "SPC SPC") 'smex))
  (define-key evil-normal-state-map (kbd "SPC o") 'imenu)
  (define-key evil-normal-state-map (kbd "SPC b") 'switch-to-buffer)
  (define-key evil-normal-state-map (kbd "SPC k") 'ido-kill-buffer)
  (define-key evil-normal-state-map (kbd "SPC t") 'helm-etags-select)
  (define-key evil-normal-state-map (kbd "SPC y") 'helm-show-kill-ring)
  (define-key evil-normal-state-map (kbd "SPC f") 'ido-find-file)

  (define-key evil-normal-state-map (kbd "[ SPC") (bind (evil-insert-newline-above) (forward-line)))
  (define-key evil-normal-state-map (kbd "] SPC") (bind (evil-insert-newline-below) (forward-line -1)))
  (define-key evil-normal-state-map (kbd "[ e") (kbd "ddkP"))
  (define-key evil-normal-state-map (kbd "] e") (kbd "ddp"))
  (define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "] b") 'next-buffer)

  (define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-q") 'universal-argument)

  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)

  (define-key evil-normal-state-map (kbd "Q") 'my-window-killer)
  (define-key evil-normal-state-map (kbd "Y") (kbd "y$"))

  (define-key evil-visual-state-map (kbd ", e") 'eval-region)

  ;; emacs lisp
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "K") (kbd ", h f RET"))

  ;; proper jump lists
  ;; (require-package 'jumpc)
  ;; (jumpc)
  ;; (define-key evil-normal-state-map (kbd "C-o") 'jumpc-jump-backward)
  ;; (define-key evil-normal-state-map (kbd "C-i") 'jumpc-jump-forward)

  (after 'coffee-mode
    (evil-define-key 'visual coffee-mode-map (kbd ", p") 'coffee-compile-region)
    (evil-define-key 'insert coffee-mode-map (kbd "RET") 'coffee-newline-and-indent))

  (after 'ag-autoloads
    (define-key evil-normal-state-map (kbd "SPC /") 'ag-regexp-project-at-point))

  (after 'company
    (define-key evil-insert-state-map (kbd "TAB") 'my-company-tab)
    (define-key evil-insert-state-map [tab] 'my-company-tab))

  (after 'multiple-cursors
    (define-key evil-emacs-state-map (kbd "C->") 'mc/mark-next-like-this)
    (define-key evil-emacs-state-map (kbd "C-<") 'mc/mark-previous-like-this)
    (define-key evil-visual-state-map (kbd "C->") 'mc/mark-all-like-this)
    (define-key evil-normal-state-map (kbd "C->") 'mc/mark-next-like-this)
    (define-key evil-normal-state-map (kbd "C-<") 'mc/mark-previous-like-this))

  (after 'magit
    (evil-add-hjkl-bindings magit-status-mode-map 'emacs
      "K" 'magit-discard-item
      "l" 'magit-key-mode-popup-logging
      "h" 'magit-toggle-diff-refine-hunk))

  ;; butter fingers
  (evil-ex-define-cmd "Q" 'evil-quit)
  (evil-ex-define-cmd "Qa" 'evil-quit-all)
  (evil-ex-define-cmd "QA" 'evil-quit-all))

;; escape minibuffer
(define-key minibuffer-local-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'my-minibuffer-keyboard-quit)

(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)


(after 'package
  (define-key package-menu-mode-map "j" 'next-line)
  (define-key package-menu-mode-map "k" 'previous-line))


(after 'project-explorer-autoloads
  (global-set-key [f2] 'project-explorer-open)
  (global-set-key [f3] 'pe/show-file))


(after 'comint
  (define-key comint-mode-map [up] 'comint-previous-input)
  (define-key comint-mode-map [down] 'comint-next-input))


(after 'auto-complete
  (define-key ac-completing-map "\t" 'ac-expand)
  (define-key ac-completing-map [tab] 'ac-expand)
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous))


(after 'company
  (define-key company-active-map "\t" 'my-company-tab)
  (define-key company-active-map [tab] 'my-company-tab)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


;; mouse scrolling in terminal
(unless (display-graphic-p)
  (global-set-key [mouse-4] (bind (scroll-down 1)))
  (global-set-key [mouse-5] (bind (scroll-up 1))))


(global-set-key [prior] 'previous-buffer)
(global-set-key [next] 'next-buffer)


;; have no use for these default bindings
(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x C-c") (bind (message "Thou shall not quit!")))
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)


(provide 'init-bindings)
