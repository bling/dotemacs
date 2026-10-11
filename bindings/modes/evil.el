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
    (keymap-set evil-normal-state-map "g r" #'mc/mark-all-like-this-dwim))

  (/bindings/set-keys evil-normal-state-map ("g d" #'xref-find-definitions))

  (keymap-set evil-normal-state-map "SPC" /bindings/normal-space-leader-map)
  (keymap-set evil-visual-state-map "SPC" /bindings/visual-space-leader-map)
  (keymap-set evil-normal-state-map "," /bindings/normal-comma-leader-map)
  (keymap-set evil-visual-state-map "," /bindings/visual-comma-leader-map)

  (transient-define-prefix /bindings/evil/transients/paste ()
    :transient-non-suffix 'leave
    [["paste"
      ("p" "paste after" evil-paste-after)
      ("P" "paste before" evil-paste-before)]
     ["cycle"
      ("C-k" "cycle previous" evil-paste-pop :transient t)
      ("C-j" "cycle next" evil-paste-pop-next :transient t)]
     ["kill ring"
      (:info (lambda () (format "%s/%s" (length kill-ring-yank-pointer) (length kill-ring))))]])

  (defun /bindings/evil/transients/paste/show (&rest _)
    (/bindings/evil/transients/paste))

  (advice-add 'evil-paste-after :after #'/bindings/evil/transients/paste/show)
  (advice-add 'evil-paste-before :after #'/bindings/evil/transients/paste/show)

  (after "evil-numbers-autoloads"
    (/bindings/set-key evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt)
    (/bindings/set-key evil-normal-state-map "C-S-a" #'evil-numbers/dec-at-pt))

  (after 'diff-hl
    (/bindings/set-keys evil-normal-state-map
      ("[ h" #'diff-hl-previous-hunk)
      ("] h" #'diff-hl-next-hunk)))

  (/bindings/set-keys evil-normal-state-map
    ("Y" "y $")
    ("g p" (bind (evil-visual-select (evil-get-marker ?\[) (evil-get-marker ?\]))))
    ("g b" #'/transients/switch-to-buffer))

  (keymap-global-set "C-w" #'evil-window-map)
  (after 'evil-evilified-state
    (/bindings/set-keys evil-evilified-state-map
      ("C-h" #'/bindings/evil/window-or-frame-left)
      ("C-j" #'/bindings/evil/window-or-frame-down)
      ("C-k" #'/bindings/evil/window-or-frame-up)
      ("C-l" #'/bindings/evil/window-or-frame-right)))
  (/bindings/set-keys evil-normal-state-map
    ("C-h" #'/bindings/evil/window-or-frame-left)
    ("C-j" #'/bindings/evil/window-or-frame-down)
    ("C-k" #'/bindings/evil/window-or-frame-up)
    ("C-l" #'/bindings/evil/window-or-frame-right)
    ("C-w C-h" #'/bindings/evil/window-or-frame-left)
    ("C-w h"   #'/bindings/evil/window-or-frame-left)
    ("C-w C-j" #'/bindings/evil/window-or-frame-down)
    ("C-w j"   #'/bindings/evil/window-or-frame-down)
    ("C-w C-k" #'/bindings/evil/window-or-frame-up)
    ("C-w k"   #'/bindings/evil/window-or-frame-up)
    ("C-w C-l" #'/bindings/evil/window-or-frame-right)
    ("C-w l"   #'/bindings/evil/window-or-frame-right))

  (/bindings/set-keys evil-motion-state-map
    ("j" #'evil-next-visual-line)
    ("k" #'evil-previous-visual-line))

  (/bindings/set-keys evil-normal-state-map
    ("Q" #'/utils/window-killer))

  ;; emacs lisp
  (evil-define-key 'normal emacs-lisp-mode-map "K" #'helpful-at-point)
  (evil-define-key 'normal lisp-interaction-mode-map "K" #'helpful-at-point)

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
    (keymap-set evil-operator-state-map "z" #'avy-goto-char-2)
    (keymap-set evil-normal-state-map "s" #'avy-goto-char-2)
    (keymap-set evil-motion-state-map "S-SPC" #'avy-goto-line))

  (add-hook 'eshell-mode-hook
            (lambda ()
              (keymap-local-set "C-h" #'/bindings/evil/window-or-frame-left)
              (keymap-local-set "C-j" #'/bindings/evil/window-or-frame-down)
              (keymap-local-set "C-k" #'/bindings/evil/window-or-frame-up)
              (keymap-local-set "C-l" #'/bindings/evil/window-or-frame-right)))

  (use-package evil-textobj-tree-sitter
    :config
    (keymap-set evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
    (keymap-set evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
    (keymap-set evil-outer-text-objects-map "c" (evil-textobj-tree-sitter-get-textobj "class.outer"))
    (keymap-set evil-inner-text-objects-map "c" (evil-textobj-tree-sitter-get-textobj "class.inner"))
    (keymap-set evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "parameter.outer"))
    (keymap-set evil-inner-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "parameter.inner"))
    (keymap-set evil-outer-text-objects-map "i" (evil-textobj-tree-sitter-get-textobj "conditional.outer"))
    (keymap-set evil-inner-text-objects-map "i" (evil-textobj-tree-sitter-get-textobj "conditional.inner"))
    (keymap-set evil-outer-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj "loop.outer"))
    (keymap-set evil-inner-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj "loop.inner"))
    (keymap-set evil-outer-text-objects-map "/" (evil-textobj-tree-sitter-get-textobj "comment.outer"))
    (keymap-set evil-inner-text-objects-map "/" (evil-textobj-tree-sitter-get-textobj "comment.inner"))
    (keymap-set evil-normal-state-map "] f" (bind (evil-textobj-tree-sitter-goto-textobj "function.outer")))
    (keymap-set evil-normal-state-map "[ f" (bind (evil-textobj-tree-sitter-goto-textobj "function.outer" t)))
    (keymap-set evil-normal-state-map "] F" (bind (evil-textobj-tree-sitter-goto-textobj "function.outer" nil t)))
    (keymap-set evil-normal-state-map "[ F" (bind (evil-textobj-tree-sitter-goto-textobj "function.outer" t t))))

  (use-package evil-collection
    :init
    (add-hook 'evil-collection-setup-hook
              (defun /bindings/evil/evil-collection-setup-hook (_mode mode-keymaps)
                ;; removes any bindings to SPC and , since they are global prefix keys
                (evil-collection-translate-key 'normal mode-keymaps
                  (kbd "SPC") nil
                  "," nil)))
    :config
    (setq evil-collection-mode-list (delq 'eat evil-collection-mode-list))
    (setq evil-collection-mode-list (delq 'vterm evil-collection-mode-list))
    (setq evil-collection-mode-list (delq 'evil-ghostel evil-collection-mode-list))
    (evil-collection-init)

    ;; replace flymake with compilation-mode integration
    (advice-add #'evil-collection-unimpaired-first-error :override #'first-error)
    (advice-add #'evil-collection-unimpaired-next-error :override #'next-error)
    (advice-add #'evil-collection-unimpaired-previous-error :override #'previous-error)))

(provide 'config-bindings-evil)
