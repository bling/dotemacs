(after 'evil-evilified-state
  (/bindings/define-keys evil-evilified-state-map
    ("g b" #'/hydras/buffers/lambda-b-and-exit)
    ("," /bindings/normal-comma-leader-map)
    ("SPC" /bindings/normal-space-leader-map)))



(after 'evil
  (after "multiple-cursors-autoloads"
    (define-key evil-normal-state-map (kbd "g r") 'mc/mark-all-like-this-dwim))

  (/bindings/define-keys evil-normal-state-map ("g d" #'dumb-jump-go))

  (require-package 'key-chord)
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)

  (define-key evil-normal-state-map (kbd "SPC") /bindings/normal-space-leader-map)
  (define-key evil-normal-state-map (kbd ",") /bindings/normal-comma-leader-map)

  (/bindings/define-keys evil-visual-state-map
    (", e" #'eval-region))

  (/bindings/define-key evil-visual-state-map "SPC SPC" #'execute-extended-command "M-x")

  (after "evil-numbers-autoloads"
    (/bindings/define-key evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt)
    (/bindings/define-key evil-normal-state-map "C-S-a" #'evil-numbers/dec-at-pt))

  (after "git-gutter+-autoloads"
    (/bindings/define-keys evil-normal-state-map
      ("[ h" #'git-gutter+-previous-hunk)
      ("] h" #'git-gutter+-next-hunk))
    (/bindings/define-keys evil-visual-state-map
      ("SPC g a" #'git-gutter+-stage-hunks)
      ("SPC g r" #'git-gutter+-revert-hunks))
    (evil-ex-define-cmd "Gw" (bind (git-gutter+-stage-whole-buffer))))

  (/bindings/define-keys evil-normal-state-map
    ("g p" "`[v`]")
    ("g b" #'/hydras/buffers/lambda-b-and-exit))

  (/bindings/define-keys evil-normal-state-map
    ("C-b" #'evil-scroll-up)
    ("C-f" #'evil-scroll-down))

  (/bindings/define-keys evil-normal-state-map
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
    (/bindings/define-keys evil-evilified-state-map
      ("C-h" #'evil-window-left)
      ("C-j" #'evil-window-down)
      ("C-k" #'evil-window-up)
      ("C-l" #'evil-window-right)))
  (/bindings/define-keys evil-normal-state-map
    ("C-h" #'evil-window-left)
    ("C-j" #'evil-window-down)
    ("C-k" #'evil-window-up)
    ("C-l" #'evil-window-right)
    ("C-w C-h" #'evil-window-left)
    ("C-w C-j" #'evil-window-down)
    ("C-w C-k" #'evil-window-up)
    ("C-w C-l" #'evil-window-right))

  (/bindings/define-keys evil-motion-state-map
    ("j" #'evil-next-visual-line)
    ("k" #'evil-previous-visual-line))

  (/bindings/define-keys evil-normal-state-map
    ("p" #'/hydras/paste/evil-paste-after)
    ("P" #'/hydras/paste/evil-paste-before)
    ("Q" #'/utils/window-killer)
    ("Y" "y$"))

  ;; emacs lisp
  (evil-define-key 'normal emacs-lisp-mode-map "K" (bind (help-xref-interned (symbol-at-point))))
  (after "elisp-slime-nav-autoloads"
    (evil-define-key 'normal emacs-lisp-mode-map (kbd "g d") 'elisp-slime-nav-find-elisp-thing-at-point))

  (after 'coffee-mode
    (evil-define-key 'visual coffee-mode-map (kbd ", p") 'coffee-compile-region)
    (evil-define-key 'normal coffee-mode-map (kbd ", p") 'coffee-compile-buffer))

  (after 'css-mode
    (evil-define-key 'normal css-mode-map (kbd "RET") #'/hydras/modes/css-mode/body))

  (after 'stylus-mode
    (define-key stylus-mode-map [remap eval-last-sexp] '/stylus/compile-and-eval-buffer)
    (evil-define-key 'visual stylus-mode-map (kbd ", p") '/stylus/compile-and-show-region)
    (evil-define-key 'normal stylus-mode-map (kbd ", p") '/stylus/compile-and-show-buffer))

  (after 'js2-mode
    (evil-define-key 'normal js2-mode-map (kbd "g r") #'js2r-rename-var))

  (after "avy-autoloads"
    (define-key evil-operator-state-map (kbd "z") 'avy-goto-char-2)
    (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)
    (define-key evil-motion-state-map (kbd "S-SPC") 'avy-goto-line))

  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-h") #'evil-window-left)
              (local-set-key (kbd "C-j") #'evil-window-down)
              (local-set-key (kbd "C-k") #'evil-window-up)
              (local-set-key (kbd "C-l") #'evil-window-right)))

  (require-package 'evil-collection)
  (setq evil-collection-company-use-tng nil)
  (add-hook 'evil-collection-setup-hook
            (defun /bindings/evil/evil-collection-setup-hook (_mode mode-keymaps)
              ;; removes any bindings to SPC and , since they are global prefix keys
              ;; [ and ] are rebound to [[ and ]] respectively so global style vim-unimpaired mappings remain
              (evil-collection-translate-key 'normal mode-keymaps
                (kbd "SPC") nil
                "," nil
                "[" nil
                "]" nil
                "[[" "["
                "]]" "]"
                )))
  (evil-collection-init))

(provide 'config-bindings-evil)
