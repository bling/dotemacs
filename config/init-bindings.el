(defmacro bind (&rest commands)
  "Convenience macro which creates a lambda interactive command."
  `(lambda (arg)
     (interactive "P")
     ,@commands))

(require-package 'which-key)
(setq which-key-idle-delay 0.2)
(setq which-key-min-display-lines 3)
(which-key-mode)

(defmacro -define-key (keymap sequence binding &optional description)
  (declare (indent defun))
  `(progn
     (define-key ,keymap (kbd ,sequence) ,binding)
     (when ,description
       (which-key-add-key-based-replacements ,sequence ,description))))

(defmacro -define-keys (keymap &rest body)
  (declare (indent defun))
  `(progn
     ,@(cl-loop for binding in body
                collect `(let ((seq ,(car binding))
                               (func ,(cadr binding))
                               (desc ,(caddr binding)))
                           (-define-key ,keymap seq func desc)))))



(after 'evil
  (require-package 'key-chord)
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)

  (-define-keys evil-normal-state-map
    (", w" #'save-buffer)
    (", e" #'eval-last-sexp)
    (", , e" #'eval-defun)
    (", E" #'eval-defun)
    (", f" ctl-x-5-map "frames")
    (", c" #'my-new-eshell-split "eshell")
    (", C" #'customize-group)
    (", v" (kbd "C-w v C-w l") "vsplit")
    (", s" (kbd "C-w s C-w j") "split")
    (", P" #'package-list-packages "packages")
    (", h" help-map "help"))

  (-define-keys evil-visual-state-map
    (", e" #'eval-region))

  (after "paradox-autoloads"
    (-define-key evil-normal-state-map ", P" #'paradox-list-packages))

  (-define-key evil-visual-state-map "SPC SPC" #'execute-extended-command "M-x")
  (-define-keys evil-normal-state-map
    ("SPC SPC" #'execute-extended-command "M-x")
    ("SPC t" #'my-toggle-hydra/body "toggle...")
    ("SPC q" #'my-quit-hydra/body "quit...")
    ("SPC e" #'my-errors-hydra/body "errors...")
    ("SPC b" #'my-buffer-hydra/body "buffers...")
    ("SPC j" #'my-jump-hydra/body "jump...")
    ("SPC f" #'my-file-hydra/body "files...")
    ("SPC s" #'my-search-hydra/body "search...")
    ("SPC l" #'my-jump-hydra/lambda-l-and-exit "lines(current)")
    ("SPC L" #'my-jump-hydra/lambda-L-and-exit "lines(all)")
    ("SPC o" #'my-jump-hydra/lambda-i-and-exit "outline")
    ("SPC '" #'my-new-eshell-split "shell")
    ("SPC y" (bind
              (cond ((eq dotemacs-switch-engine 'ivy)
                     (call-interactively #'counsel-yank-pop))
                    ((eq dotemacs-switch-engine 'helm)
                     (call-interactively #'helm-show-kill-ring)))) "kill-ring"))

  (after "magit-autoloads"
    (-define-key evil-normal-state-map "SPC g" #'my-git-hydra/body "git..."))

  (after "counsel-autoloads"
    (-define-key evil-normal-state-map "SPC i" #'my-ivy-hydra/body "ivy..."))

  (after "helm-autoloads"
    (-define-key evil-normal-state-map "SPC h" #'my-helm-hydra/body "helm..."))

  (after "fzf-autoloads"
    (define-key evil-normal-state-map (kbd "SPC F") 'fzf))

  (after "evil-numbers-autoloads"
    (-define-key evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt)
    (-define-key evil-normal-state-map "C-S-a" #'evil-numbers/dec-at-pt))

  (after "git-gutter+-autoloads"
    (-define-keys evil-normal-state-map
      ("[ h" #'git-gutter+-next-hunk)
      ("] h" #'git-gutter+-previous-hunk))
    (-define-keys evil-visual-state-map
      ("SPC g a" #'git-gutter+-stage-hunks)
      ("SPC g r" #'git-gutter+-revert-hunks))
    (evil-ex-define-cmd "Gw" (bind (git-gutter+-stage-whole-buffer))))

  (-define-keys evil-normal-state-map
    ("g p" "`[v`]")
    ("g b" #'my-buffer-hydra/lambda-b-and-exit))

  (-define-keys evil-normal-state-map
    ("C-b" #'evil-scroll-up)
    ("C-f" #'evil-scroll-down))

  (-define-keys evil-normal-state-map
    ("[ SPC" (bind (evil-insert-newline-above) (forward-line)))
    ("] SPC" (bind (evil-insert-newline-below) (forward-line -1)))
    ("[ e" "ddkP")
    ("] e" "ddp")
    ("[ b" 'previous-buffer)
    ("] b" 'next-buffer)
    ("[ q" 'previous-error)
    ("] q" 'next-error))

  (global-set-key (kbd "C-w") 'evil-window-map)
  (after 'evil-evilified-state
    (-define-keys evil-evilified-state-map
      ("C-h" #'evil-window-left)
      ("C-j" #'evil-window-down)
      ("C-k" #'evil-window-up)
      ("C-l" #'evil-window-right)))
  (-define-keys evil-normal-state-map
    ("C-h" #'evil-window-left)
    ("C-j" #'evil-window-down)
    ("C-k" #'evil-window-up)
    ("C-l" #'evil-window-right)
    ("C-w C-h" #'evil-window-left)
    ("C-w C-j" #'evil-window-down)
    ("C-w C-k" #'evil-window-up)
    ("C-w C-l" #'evil-window-right))

  (-define-keys evil-motion-state-map
    ("j" #'evil-next-visual-line)
    ("k" #'evil-previous-visual-line))

  (-define-keys evil-normal-state-map
    ("p" #'my-paste-hydra/evil-paste-after)
    ("P" #'my-paste-hydra/evil-paste-before)
    ("Q" #'my-window-killer)
    ("Y" "y$"))

  ;; emacs lisp
  (evil-define-key 'normal emacs-lisp-mode-map "K" (bind (help-xref-interned (symbol-at-point))))
  (after "elisp-slime-nav-autoloads"
    (evil-define-key 'normal emacs-lisp-mode-map (kbd "g d") 'elisp-slime-nav-find-elisp-thing-at-point))

  (after 'coffee-mode
    (evil-define-key 'visual coffee-mode-map (kbd ", p") 'coffee-compile-region)
    (evil-define-key 'normal coffee-mode-map (kbd ", p") 'coffee-compile-buffer))

  (after 'stylus-mode
    (define-key stylus-mode-map [remap eval-last-sexp] 'my-stylus-compile-and-eval-buffer)
    (evil-define-key 'visual stylus-mode-map (kbd ", p") 'my-stylus-compile-and-show-region)
    (evil-define-key 'normal stylus-mode-map (kbd ", p") 'my-stylus-compile-and-show-buffer))

  (after "projectile-autoloads"
    (-define-keys evil-normal-state-map
      ("SPC p" #'projectile-command-map "projectile...")
      ("SPC /"
       (bind
        (if current-prefix-arg
            (cond
             ((executable-find "ag")  (call-interactively #'projectile-ag))
             ((executable-find "pt")  (call-interactively #'projectile-pt))
             ((executable-find "ack") (call-interactively #'projectile-ack))
             (t                       (call-interactively #'projectile-grep)))
          (cond
           ((eq dotemacs-switch-engine 'ivy)
            (cond
             ((executable-find "ag") (counsel-ag nil (projectile-project-root)))
             ((executable-find "pt") (counsel-pt nil (projectile-project-root)))))
           ((eq dotemacs-switch-engine 'helm)
            (helm-do-ag (projectile-project-root))))))
       "search..."))
    (-define-keys evil-normal-state-map
      ("C-p" (bind (cond ((and (fboundp #'helm-projectile)
                               (eq dotemacs-switch-engine 'helm))
                          (call-interactively #'helm-projectile))
                         (t
                          (call-interactively #'projectile-find-file)))))))

  (after "multiple-cursors-autoloads"
    (define-key evil-normal-state-map (kbd "g r") 'mc/mark-all-like-this-dwim))

  (after 'js2-mode
    (evil-define-key 'normal js2-mode-map (kbd "g r") #'js2r-rename-var)
    (evil-define-key 'normal js2-mode-map (kbd "g d") #'js2-jump-to-definition))

  (after "avy-autoloads"
    (define-key evil-operator-state-map (kbd "z") 'avy-goto-char-2)
    (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)
    (define-key evil-motion-state-map (kbd "S-SPC") 'avy-goto-line))

  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-h") #'evil-window-left)
              (local-set-key (kbd "C-j") #'evil-window-down)
              (local-set-key (kbd "C-k") #'evil-window-up)
              (local-set-key (kbd "C-l") #'evil-window-right))))

;; escape minibuffer
(define-key minibuffer-local-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'my-minibuffer-keyboard-quit)

(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)


(after 'ivy
  (define-key ivy-mode-map [escape] (kbd "C-g")))


(after "magit-autoloads"
  (global-set-key (kbd "C-x g") #'my-git-hydra/body))


(after "project-explorer-autoloads"
  (global-set-key [f2] 'project-explorer-open)
  (autoload 'pe/show-file "project-explorer")
  (global-set-key [f3] 'pe/show-file)
  (after 'project-explorer
    (define-key project-explorer-mode-map (kbd "C-l") 'evil-window-right)))


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


(after 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'my-company-tab)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous))


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
  (-define-key (current-global-map) "C-c h" #'my-helm-hydra/body "helm..."))


(after "counsel-autoloads"
  (-define-key (current-global-map) "C-c i" #'my-ivy-hydra/body "ivy..."))


(global-set-key [prior] 'previous-buffer)
(global-set-key [next] 'next-buffer)

(-define-keys (current-global-map)
  ("C-c c" #'org-capture)
  ("C-c a" #'org-agenda)
  ("C-c l" #'org-store-link)
  ("C-c s" #'my-goto-scratch-buffer)
  ("C-c e" #'my-eval-and-replace)
  ("C-c t" #'my-new-eshell-split))

(-define-keys (current-global-map)
  ("C-x c" #'calculator)
  ("C-x C" #'calendar)
  ("C-x C-b" #'ibuffer)
  ("C-x C-k" #'kill-this-buffer)
  ("C-x n" #'my-narrow-hydra/body)
  ("C-x p" #'proced))

(after "vkill-autoloads"
  (autoload 'vkill "vkill" nil t)
  (global-set-key (kbd "C-x p") 'vkill))

(-define-keys (current-global-map)
  ("C-s"   #'isearch-forward-regexp)
  ("C-M-s" #'isearch-forward)
  ("C-r"   #'isearch-backward-regexp)
  ("C-M-r" #'isearch-backward))


;; have no use for these default bindings
(global-unset-key (kbd "C-x m"))


(global-set-key (kbd "C-x C-c") (bind (message "Thou shall not quit!")))
(after 'evil
  (defadvice evil-quit (around dotemacs activate)
    (message "Thou shall not quit!"))
  (defadvice evil-quit-all (around dotemacs activate)
    (message "Thou shall not quit!")))


(provide 'init-bindings)
