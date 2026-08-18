;; -*- lexical-binding: t -*-

(after 'evil
  (after "multiple-cursors-autoloads"
    (define-key evil-normal-state-map (kbd "g r") 'mc/mark-all-like-this-dwim))

  (/bindings/define-keys evil-normal-state-map ("g d" #'xref-find-definitions))

  (define-key evil-normal-state-map (kbd "SPC") /bindings/normal-space-leader-map)
  (define-key evil-normal-state-map (kbd ",") /bindings/normal-comma-leader-map)

  (define-key evil-normal-state-map (kbd ", h f") #'helpful-function)
  (define-key evil-normal-state-map (kbd ", h k") #'helpful-key)
  (define-key evil-normal-state-map (kbd ", h v") #'helpful-variable)
  (define-key evil-normal-state-map (kbd ", h x") #'helpful-command)

  (/bindings/define-keys evil-visual-state-map
    (", e" #'eval-region))

  (/bindings/define-key evil-visual-state-map "SPC SPC" #'execute-extended-command "M-x")
  (/bindings/define-key evil-visual-state-map "SPC /" #'/transients/project/search "search...")

  (after "evil-numbers-autoloads"
    (/bindings/define-key evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt)
    (/bindings/define-key evil-normal-state-map "C-S-a" #'evil-numbers/dec-at-pt))

  (after 'diff-hl
    (/bindings/define-keys evil-normal-state-map
      ("[ h" #'diff-hl-previous-hunk)
      ("] h" #'diff-hl-next-hunk))
    (/bindings/define-keys evil-visual-state-map
      ("SPC g a" #'diff-hl-stage-current-hunk)
      ("SPC g r" #'diff-hl-revert-hunk)))

  (/bindings/define-keys evil-normal-state-map
    ("g p" "`[v`]")
    ("g b" #'/hydras/buffers/lambda-b-and-exit))

  (/bindings/define-keys evil-normal-state-map
    ("C-b" #'evil-scroll-up)
    ("C-f" #'evil-scroll-down))

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
  (evil-define-key 'normal emacs-lisp-mode-map "K" #'helpful-at-point)
  (evil-define-key 'normal lisp-interaction-mode-map "K" #'helpful-at-point)

  (after 'css-mode
    (evil-define-key 'normal css-mode-map (kbd "RET") #'/hydras/modes/css-mode/body))

  (after 'css-ts-mode
    (evil-define-key 'normal css-ts-mode-map (kbd "RET") #'/hydras/modes/css-mode/body))

  (after 'flycheck
    (evil-define-key 'normal flycheck-error-list-mode-map
      "j" #'flycheck-error-list-next-error
      "k" #'flycheck-error-list-previous-error))

  (after 'diff-mode
    (evil-define-key 'normal diff-mode-map
      "j" #'diff-hunk-next
      "k" #'diff-hunk-prev))

  (after 'vc-annotate
    (evil-define-key 'normal vc-annotate-mode-map
      (kbd "M-p") #'vc-annotate-prev-revision
      (kbd "M-n") #'vc-annotate-next-revision
      "l" #'vc-annotate-show-log-revision-at-line))

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
  (add-hook 'evil-collection-setup-hook
            (defun /bindings/evil/evil-collection-setup-hook (_mode mode-keymaps)
              ;; removes any bindings to SPC and , since they are global prefix keys
              (evil-collection-translate-key 'normal mode-keymaps
                (kbd "SPC") nil
                "," nil
                )))
  (evil-collection-init))

(provide 'config-bindings-evil)
