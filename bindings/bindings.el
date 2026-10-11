;; -*- lexical-binding: t -*-

(use-package transient
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

(defmacro /bindings/set-prefix-keys (keymap prefix &rest body)
  (declare (indent defun))
  `(progn
     ,@(mapcar
        (lambda (binding)
          `(let ((seq ,(car binding))
                 (func ,(cadr binding))
                 (desc ,(caddr binding)))
             (keymap-set ,keymap seq func)
             (when desc
               (which-key-add-keymap-based-replacements ,keymap seq desc)
               (when ,prefix
                 (which-key-add-key-based-replacements
                   (concat ,prefix " " seq)
                   desc)
                 (when (equal ,prefix "SPC")
                   (which-key-add-key-based-replacements
                     (concat "M-SPC " seq)
                     desc))))))
        body)))

(defmacro /bindings/set-keys (keymap &rest body)
  (declare (indent defun))
  `(/bindings/set-prefix-keys ,keymap nil ,@body))

(defmacro /bindings/set-key (keymap sequence binding &optional description)
  (declare (indent defun))
  `(/bindings/set-prefix-keys ,keymap nil
     (,sequence ,binding ,description)))



(defvar /bindings/normal-space-leader-map (make-sparse-keymap))
(defvar /bindings/visual-space-leader-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map /bindings/normal-space-leader-map) map))

(/bindings/set-prefix-keys /bindings/normal-space-leader-map "SPC"
  ("SPC" #'execute-extended-command "M-x")
  ("M-SPC" #'execute-extended-command "M-x")
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
  ("v" vc-prefix-map "vc...")
  ("4" ctl-x-4-map "windows...")
  ("5" ctl-x-5-map "frames...")
  ("'" #'/eshell/new-split "shell")
  ("d" (bind (/transients/switch-action nil :consult #'consult-dash :helm #'helm-dash)) "dash")
  ("y" (bind (/transients/switch-action #'yank-pop :consult #'consult-yank-pop :helm #'helm-show-kill-ring)) "kill-ring"))

(after 'lsp-mode
  (/bindings/set-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("RET" lsp-command-map "lsp...")))

(after "magit-autoloads"
  (/bindings/set-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("g" #'/transients/git "git...")))

(after "consult-autoloads"
  (/bindings/set-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("c" #'/transients/consult "consult...")))

(after "helm-autoloads"
  (/bindings/set-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("h" #'/transients/helm "helm...")))

(after "fzf-autoloads"
  (/bindings/set-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("F" #'fzf)))



(defvar /bindings/normal-comma-leader-map (make-sparse-keymap))
(defvar /bindings/visual-comma-leader-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map /bindings/normal-comma-leader-map) map))

(/bindings/set-prefix-keys /bindings/normal-comma-leader-map ","
  ("w" #'save-buffer)
  ("e" #'eval-last-sexp)
  (", e" #'eval-defun)
  ("E" #'eval-defun)
  ("f" ctl-x-5-map "frames")
  ("c" #'/eshell/new-split "eshell")
  ("C" #'customize-group)
  ("v" "C-w v C-w l" "vsplit")
  ("s" "C-w s C-w j" "split")
  ("P" #'package-list-packages "packages")
  ("h f" #'helpful-function)
  ("h k" #'helpful-key)
  ("h v" #'helpful-variable)
  ("h x" #'helpful-command))

(/bindings/set-prefix-keys /bindings/visual-comma-leader-map ","
  ("e" #'eval-region))



;; escape minibuffer
(keymap-set minibuffer-local-map "<escape>" #'/utils/minibuffer-keyboard-quit)
(keymap-set minibuffer-local-map "C-w" #'backward-kill-word)
(keymap-set minibuffer-local-ns-map "<escape>" #'/utils/minibuffer-keyboard-quit)
(keymap-set minibuffer-local-completion-map "<escape>" #'/utils/minibuffer-keyboard-quit)
(keymap-set minibuffer-local-must-match-map "<escape>" #'/utils/minibuffer-keyboard-quit)
(keymap-set minibuffer-local-isearch-map "<escape>" #'/utils/minibuffer-keyboard-quit)

(after "multiple-cursors-autoloads"
  (keymap-global-set "C->" #'mc/mark-next-like-this)
  (keymap-global-set "C-<" #'mc/mark-previous-like-this)
  (keymap-global-unset "M-<down-mouse-1>")
  (keymap-global-set "M-<mouse-1>" #'mc/add-cursor-on-click))

(after "expand-region-autoloads"
  (keymap-global-set "C-=" #'er/expand-region))

(after "magit-autoloads"
  (/bindings/set-key (current-global-map) "C-c g" #'/transients/git "git..."))

(after "helm-autoloads"
  (/bindings/set-key (current-global-map) "C-c h" #'/transients/helm "helm..."))

;; mouse scrolling in terminal
(unless (display-graphic-p)
  (keymap-global-set "<mouse-4>" (bind (scroll-down 1)))
  (keymap-global-set "<mouse-5>" (bind (scroll-up 1))))

(/bindings/set-keys (current-global-map)
  ("C-c c" #'org-capture)
  ("C-c a" #'org-agenda)
  ("C-c l" #'org-store-link))

(/bindings/set-keys (current-global-map)
  ("C-c s" #'/utils/goto-scratch-buffer)
  ("C-c e" #'crux-eval-and-replace)
  ("C-c t" #'/eshell/new-split)
  ("C-x c" #'calculator)
  ("C-x C" #'calendar)
  ("C-x C-b" #'ibuffer)
  ("C-x C-k" #'kill-current-buffer)
  ("C-x n" #'/transients/narrow "narrow...")
  ("C-x p" #'proced))

(/bindings/set-keys (current-global-map)
  ("C-s"   #'isearch-forward-regexp)
  ("C-M-s" #'isearch-forward)
  ("C-r"   #'isearch-backward-regexp)
  ("C-M-r" #'isearch-backward))

(/bindings/set-keys (current-global-map)
  ("C-x 4 h" #'windmove-left)
  ("C-x 4 j" #'windmove-down)
  ("C-x 4 k" #'windmove-up)
  ("C-x 4 l" #'windmove-right))

(keymap-global-set "<prior>" #'previous-buffer)
(keymap-global-set "<next>" #'next-buffer)
(keymap-global-set "<f2>" #'/explorer/toggle)
(keymap-global-set "<f3>" #'/explorer/find-file)
(keymap-global-set "<f5>" (bind (profiler-start 'cpu+mem)))
(keymap-global-set "<f6>" (bind (profiler-report) (profiler-stop)))
(keymap-global-set "M-SPC" /bindings/normal-space-leader-map)

;; have no use for these default bindings
(keymap-global-unset "C-x m")

(defun dotemacs/no-quit (&rest _)
  (message "Thou shall not quit!"))

(keymap-global-set "C-x C-c" (bind (dotemacs/no-quit)))
(after 'evil
  (advice-add 'evil-quit :override #'dotemacs/no-quit)
  (advice-add 'evil-quit-all :override #'dotemacs/no-quit))

(provide 'config-bindings)
