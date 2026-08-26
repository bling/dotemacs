;; -*- lexical-binding: t -*-

(use-package transient
  :demand t
  :init
  (setq transient-history-file (concat dotemacs-cache-directory "transient/history.el"))
  (setq transient-levels-file (concat dotemacs-cache-directory "transient/levels.el"))
  (setq transient-values-file (concat dotemacs-cache-directory "transient/values.el"))
  (setq transient-enable-menu-navigation nil)
  :config
  (add-hook 'transient-setup-buffer-hook
            (lambda ()
              (setq-local cursor-in-non-selected-windows nil)
              (setq-local cursor-type nil)))
  (keymap-set transient-base-map "q" #'transient-quit-one)
  (keymap-set transient-base-map "<escape>" #'transient-quit-one)
  (keymap-set transient-sticky-map "q" #'transient-quit-seq)
  (keymap-set transient-sticky-map "<escape>" #'transient-quit-seq))

(defmacro /bindings/define-prefix-keys (keymap prefix &rest body)
  (declare (indent defun))
  `(progn
     ,@(cl-loop for binding in body
                collect
                `(let ((seq ,(car binding))
                       (func ,(cadr binding))
                       (desc ,(caddr binding)))
                   (define-key ,keymap (kbd seq) func)
                   (when desc
                     (which-key-add-key-based-replacements
                       (if ,prefix
                           (concat ,prefix " " seq)
                         seq)
                       desc))))))

(defmacro /bindings/define-keys (keymap &rest body)
  (declare (indent defun))
  `(/bindings/define-prefix-keys ,keymap nil ,@body))

(defmacro /bindings/define-key (keymap sequence binding &optional description)
  (declare (indent defun))
  `(/bindings/define-prefix-keys ,keymap nil
     (,sequence ,binding ,description)))



(setq /bindings/normal-space-leader-map (make-sparse-keymap))
(/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
  ("SPC" #'execute-extended-command "M-x")
  ("t" #'/transients/toggles "toggle...")
  ("q" #'/transients/quit "quit...")
  ("e" #'/transients/errors "errors...")
  ("b" #'/transients/buffers "buffers...")
  ("j" #'/transients/jumps "jump...")
  ("f" #'/transients/files "files...")
  ("s" #'/transients/search "search...")
  ("l" #'/transients/occur-current "lines(current)")
  ("L" #'/transients/occur-all "lines(all)")
  ("o" #'/transients/imenu "outline")
  ("v" vc-prefix-map)
  ("4" ctl-x-4-map)
  ("5" ctl-x-5-map "frames...")
  ("'" #'/eshell/new-split "shell")
  ("y" (bind
        (cond
         ((eq dotemacs-switch-engine 'consult)
          (call-interactively #'consult-yank-pop))
         ((eq dotemacs-switch-engine 'helm)
          (call-interactively #'helm-show-kill-ring)))) "kill-ring"))

(after 'lsp-mode
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("RET" lsp-command-map "lsp...")))

(after "magit-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("g" #'/transients/git "git...")))

(after "consult-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("c" #'/transients/consult "consult...")))

(after "helm-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("h" #'/transients/helm "helm...")))

(/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
  ("d" (bind
        (cond
         ((eq dotemacs-switch-engine 'consult)
          (call-interactively #'consult-dash))
         ((eq dotemacs-switch-engine 'helm)
          (call-interactively #'helm-dash)))) "dash"))

(after "fzf-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("F" #'fzf)))



(setq /bindings/normal-comma-leader-map (make-sparse-keymap))
(/bindings/define-prefix-keys /bindings/normal-comma-leader-map ","
  ("w" #'save-buffer)
  ("e" #'eval-last-sexp)
  (", e" #'eval-defun)
  ("E" #'eval-defun)
  ("f" ctl-x-5-map "frames")
  ("c" #'/eshell/new-split "eshell")
  ("C" #'customize-group)
  ("v" (kbd "C-w v C-w l") "vsplit")
  ("s" (kbd "C-w s C-w j") "split")
  ("P" #'package-list-packages "packages")
  ("h" help-map "help"))



;; escape minibuffer
(define-key minibuffer-local-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)
(define-key minibuffer-local-ns-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] '/utils/minibuffer-keyboard-quit)

(after "multiple-cursors-autoloads"
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-unset-key (kbd "M-<down-mouse-1>"))
  (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click))

(after "expand-region-autoloads"
  (global-set-key (kbd "C-=") 'er/expand-region))

(after "magit-autoloads"
  (/bindings/define-key (current-global-map) "C-c g" #'/transients/git "git..."))

(after "helm-autoloads"
  (/bindings/define-key (current-global-map) "C-c h" #'/transients/helm "helm..."))

;; mouse scrolling in terminal
(unless (display-graphic-p)
  (global-set-key [mouse-4] (bind (scroll-down 1)))
  (global-set-key [mouse-5] (bind (scroll-up 1))))

(after 'comint
  (define-key comint-mode-map [up] 'comint-previous-input)
  (define-key comint-mode-map [down] 'comint-next-input))

(after 'compile
  (define-key compilation-mode-map (kbd "j") 'compilation-next-error)
  (define-key compilation-mode-map (kbd "k") 'compilation-previous-error))

(/bindings/define-keys (current-global-map)
  ("C-c c" #'org-capture)
  ("C-c a" #'org-agenda)
  ("C-c l" #'org-store-link))

(/bindings/define-keys (current-global-map)
  ("C-c s" #'/utils/goto-scratch-buffer)
  ("C-c e" #'crux-eval-and-replace)
  ("C-c t" #'/eshell/new-split)
  ("C-x c" #'calculator)
  ("C-x C" #'calendar)
  ("C-x C-b" #'ibuffer)
  ("C-x C-k" #'kill-current-buffer)
  ("C-x n" #'/transients/narrow "narrow...")
  ("C-x p" #'proced))

(/bindings/define-keys (current-global-map)
  ("C-s"   #'isearch-forward-regexp)
  ("C-M-s" #'isearch-forward)
  ("C-r"   #'isearch-backward-regexp)
  ("C-M-r" #'isearch-backward))

(global-set-key [prior] 'previous-buffer)
(global-set-key [next] 'next-buffer)
(global-set-key [f2] #'/explorer/toggle)
(global-set-key [f3] #'/explorer/find-file)
(global-set-key [f5] (bind (profiler-start 'cpu+mem)))
(global-set-key [f6] (bind (profiler-report) (profiler-stop)))

;; have no use for these default bindings
(global-unset-key (kbd "C-x m"))

(defun dotemacs/no-quit (&rest _)
  (message "Thou shall not quit!"))

(global-set-key (kbd "C-x C-c") (bind (dotemacs/no-quit)))
(after 'evil
  (advice-add 'evil-quit :override #'dotemacs/no-quit)
  (advice-add 'evil-quit-all :override #'dotemacs/no-quit))

(provide 'config-bindings)
