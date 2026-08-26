;; -*- lexical-binding: t -*-

(after 'evil
  (defun /bindings/evil/window-or-frame (dir)
    "Move to window in DIR, or cycle to next frame if no window exists there."
    (condition-case nil
        (pcase dir
          ('left  (evil-window-left  1))
          ('right (evil-window-right 1))
          ('up    (evil-window-up    1))
          ('down  (evil-window-down  1)))
      (error (select-frame-set-input-focus (next-frame nil 'visible)))))

  (defun /bindings/evil/window-or-frame-left  () (interactive) (/bindings/evil/window-or-frame 'left))
  (defun /bindings/evil/window-or-frame-right () (interactive) (/bindings/evil/window-or-frame 'right))
  (defun /bindings/evil/window-or-frame-up    () (interactive) (/bindings/evil/window-or-frame 'up))
  (defun /bindings/evil/window-or-frame-down  () (interactive) (/bindings/evil/window-or-frame 'down))

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
    ("Y" "y$")
    ("g p" (bind (evil-visual-select (evil-get-marker ?\[) (evil-get-marker ?\]))))
    ("g b" #'/transients/switch-to-buffer))

  (/bindings/define-keys evil-normal-state-map
    ("C-b" #'evil-scroll-up)
    ("C-f" #'evil-scroll-down))

  (global-set-key (kbd "C-w") 'evil-window-map)
  (after 'evil-evilified-state
    (/bindings/define-keys evil-evilified-state-map
      ("C-h" #'/bindings/evil/window-or-frame-left)
      ("C-j" #'/bindings/evil/window-or-frame-down)
      ("C-k" #'/bindings/evil/window-or-frame-up)
      ("C-l" #'/bindings/evil/window-or-frame-right)))
  (/bindings/define-keys evil-normal-state-map
    ("C-h" #'/bindings/evil/window-or-frame-left)
    ("C-j" #'/bindings/evil/window-or-frame-down)
    ("C-k" #'/bindings/evil/window-or-frame-up)
    ("C-l" #'/bindings/evil/window-or-frame-right)
    ("C-w C-h" #'/bindings/evil/window-or-frame-left)
    ("C-w   h" #'/bindings/evil/window-or-frame-left)
    ("C-w C-j" #'/bindings/evil/window-or-frame-down)
    ("C-w   j" #'/bindings/evil/window-or-frame-down)
    ("C-w C-k" #'/bindings/evil/window-or-frame-up)
    ("C-w   k" #'/bindings/evil/window-or-frame-up)
    ("C-w C-l" #'/bindings/evil/window-or-frame-right)
    ("C-w   l" #'/bindings/evil/window-or-frame-right))

  (/bindings/define-keys evil-motion-state-map
    ("j" #'evil-next-visual-line)
    ("k" #'evil-previous-visual-line))

  (/bindings/define-keys evil-normal-state-map
    ("Q" #'/utils/window-killer)
    ("Y" "y$"))

  ;; emacs lisp
  (evil-define-key 'normal emacs-lisp-mode-map "K" #'helpful-at-point)
  (evil-define-key 'normal lisp-interaction-mode-map "K" #'helpful-at-point)

  (after 'css-mode
    (evil-define-key 'normal css-mode-map (kbd "RET") #'/transients/modes/css-mode))

  (after 'css-ts-mode
    (evil-define-key 'normal css-ts-mode-map (kbd "RET") #'/transients/modes/css-mode))

  (after 'flymake
    (evil-define-key 'normal flymake-diagnostics-buffer-mode-map
      "j" #'evil-next-line
      "k" #'evil-previous-line)
    (evil-define-key 'normal flymake-project-diagnostics-mode-map
      "j" #'evil-next-line
      "k" #'evil-previous-line))

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
              (local-set-key (kbd "C-h") #'/bindings/evil/window-or-frame-left)
              (local-set-key (kbd "C-j") #'/bindings/evil/window-or-frame-down)
              (local-set-key (kbd "C-k") #'/bindings/evil/window-or-frame-up)
              (local-set-key (kbd "C-l") #'/bindings/evil/window-or-frame-right)))

  (use-package evil-collection :demand t
    :init
    (add-hook 'evil-collection-setup-hook
              (defun /bindings/evil/evil-collection-setup-hook (_mode mode-keymaps)
                ;; removes any bindings to SPC and , since they are global prefix keys
                (evil-collection-translate-key 'normal mode-keymaps
                  (kbd "SPC") nil
                  "," nil)))
    :config
    (evil-collection-init)

    ;; fix compilation-mode integration
    (advice-add #'evil-collection-unimpaired-next-error :override #'next-error)
    (advice-add #'evil-collection-unimpaired-previous-error :override #'previous-error)))

(provide 'config-bindings-evil)
