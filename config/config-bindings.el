(require-package 'which-key)
(setq which-key-idle-delay 0.2)
(setq which-key-min-display-lines 3)
(which-key-mode)

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
  ("t" #'/hydras/toggles/body "toggle...")
  ("q" #'/hydras/quit/body "quit...")
  ("e" #'/hydras/errors/body "errors...")
  ("b" #'/hydras/buffers/body "buffers...")
  ("j" #'/hydras/jumps/body "jump...")
  ("f" #'/hydras/files/body "files...")
  ("s" #'/hydras/search/body "search...")
  ("l" #'/hydras/jumps/lambda-l-and-exit "lines(current)")
  ("L" #'/hydras/jumps/lambda-L-and-exit "lines(all)")
  ("o" #'/hydras/jumps/lambda-i-and-exit "outline")
  ("'" #'/eshell/new-split "shell")
  ("y" (bind
        (cond ((eq dotemacs-switch-engine 'ivy)
               (call-interactively #'counsel-yank-pop))
              ((eq dotemacs-switch-engine 'helm)
               (call-interactively #'helm-show-kill-ring)))) "kill-ring"))

(after "magit-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("g" #'/hydras/git/body "git...")))

(after "counsel-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("i" #'/hydras/ivy/body "ivy...")))

(after "helm-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("h" #'/hydras/helm/body "helm...")))

(after "helm-dash-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("d" #'helm-dash "dash")))

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

(after "paradox-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-comma-leader-map ","
    ("P" #'paradox-list-packages)))



;; escape minibuffer
(define-key minibuffer-local-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] '/utils/minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] '/utils/minibuffer-keyboard-quit)

(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)


(after 'ivy
  (define-key ivy-mode-map [escape] (kbd "C-g")))


(after "magit-autoloads"
  (global-set-key (kbd "C-x g") #'/hydras/git/body))


(global-set-key [f2] #'/explorer/toggle)
(global-set-key [f3] #'/explorer/find-file)


(after "multiple-cursors-autoloads"
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-unset-key (kbd "M-<down-mouse-1>"))
  (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click))


(after 'comint
  (define-key comint-mode-map [up] 'comint-previous-input)
  (define-key comint-mode-map [down] 'comint-next-input))


(after 'auto-complete
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous))


(after "expand-region-autoloads"
  (global-set-key (kbd "C-=") 'er/expand-region))


;; mouse scrolling in terminal
(unless (display-graphic-p)
  (global-set-key [mouse-4] (bind (scroll-down 1)))
  (global-set-key [mouse-5] (bind (scroll-up 1))))


(after 'compile
  (define-key compilation-mode-map (kbd "j") 'compilation-next-error)
  (define-key compilation-mode-map (kbd "k") 'compilation-previous-error))


(after "helm-autoloads"
  (/bindings/define-key (current-global-map) "C-c h" #'/hydras/helm/body "helm..."))


(after "counsel-autoloads"
  (/bindings/define-key (current-global-map) "C-c i" #'/hydras/ivy/body "ivy..."))


(global-set-key [prior] 'previous-buffer)
(global-set-key [next] 'next-buffer)

(/bindings/define-keys (current-global-map)
  ("C-c c" #'org-capture)
  ("C-c a" #'org-agenda)
  ("C-c l" #'org-store-link)
  ("C-c s" #'/utils/goto-scratch-buffer)
  ("C-c e" #'/utils/eval-and-replace)
  ("C-c t" #'/eshell/new-split))

(/bindings/define-keys (current-global-map)
  ("C-x c" #'calculator)
  ("C-x C" #'calendar)
  ("C-x C-b" #'ibuffer)
  ("C-x C-k" #'kill-this-buffer)
  ("C-x n" #'/hydras/narrow/body)
  ("C-x p" #'proced))

(after "vkill-autoloads"
  (autoload 'vkill "vkill" nil t)
  (global-set-key (kbd "C-x p") 'vkill))

(/bindings/define-keys (current-global-map)
  ("C-s"   #'isearch-forward-regexp)
  ("C-M-s" #'isearch-forward)
  ("C-r"   #'isearch-backward-regexp)
  ("C-M-r" #'isearch-backward))


(global-set-key (kbd "<f5>") (bind (profiler-start 'cpu+mem)))
(global-set-key (kbd "<f6>") (bind (profiler-report) (profiler-stop)))


;; have no use for these default bindings
(global-unset-key (kbd "C-x m"))


(global-set-key (kbd "C-x C-c") (bind (message "Thou shall not quit!")))
(after 'evil
  (defadvice evil-quit (around dotemacs activate)
    (message "Thou shall not quit!"))
  (defadvice evil-quit-all (around dotemacs activate)
    (message "Thou shall not quit!")))


(provide 'config-bindings)
