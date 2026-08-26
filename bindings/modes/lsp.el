;; -*- lexical-binding: t -*-

(after 'lsp-mode
  (transient-define-prefix /bindings/lsp/workspace/transient ()
    ["workspace"
     ("a" "add folder" lsp-workspace-folders-add)
     ("r" "remove folder" lsp-workspace-folders-remove)
     ("s" "switch folder" lsp-workspace-folders-switch)])

  (transient-define-prefix /bindings/lsp/transient ()
    [["nav"
      ("d" "peek definition" lsp-ui-peek-find-definitions)
      ("D" "xref definition" xref-find-definitions)
      ("r" "peek references" lsp-ui-peek-find-references)
      ("R" "xref references" xref-find-references)
      ("c" "call hierarchy" lsp-treemacs-call-hierarchy)
      ("T" "type hierarchy" lsp-treemacs-type-hierarchy)
      ("i" "implementation" lsp-find-implementation)
      ("t" "type definition" lsp-find-type-definition)]
     ["refactor"
      ("n" "rename" lsp-rename)
      ("o" "organize imports" lsp-organize-imports)
      ("f" "quick fix" lsp-ui-sideline-apply-code-actions)
      ("a" "code action" lsp-execute-code-action)
      ("=" "format buffer" lsp-format-buffer)
      ("F" "format region" lsp-format-region)]
     ["info / errors"
      ("h" "doc at point" lsp-describe-thing-at-point)
      ("g" "doc glance" lsp-ui-doc-glance)
      ("s" "symbols" (lambda () (interactive)
                       (if (eq dotemacs-switch-engine 'consult)
                           (call-interactively #'consult-lsp-symbols)
                         (call-interactively #'lsp-treemacs-symbols))))
      ("e" "errors list" lsp-treemacs-errors-list)]
     ["server & toggles"
      ("S" "restart workspace" lsp-restart-workspace)
      ("Q" "shutdown" lsp-shutdown-workspace)
      ("w" "folders" /bindings/lsp/workspace/transient)
      ("H" (lambda () (/transients/toggle-fmt "inlay hints" 'lsp-inlay-hints-mode)) lsp-inlay-hints-mode)
      ("L" (lambda () (/transients/toggle-fmt "code lenses" 'lsp-lens-mode)) lsp-lens-mode)
      ("I" "session info" lsp-describe-session)]])

  (after 'lsp-ui
    (evil-define-key 'normal lsp-ui-mode-map (kbd "RET") #'/bindings/lsp/transient)
    (evil-define-key 'normal lsp-ui-mode-map (kbd "g r") #'lsp-rename)
    (evil-define-key 'normal lsp-ui-mode-map (kbd "g d") #'lsp-ui-peek-find-definitions)
    (evil-define-key 'normal lsp-ui-mode-map (kbd "K") #'lsp-describe-thing-at-point)

    (define-key lsp-ui-peek-mode-map (kbd "k") #'lsp-ui-peek--select-prev)
    (define-key lsp-ui-peek-mode-map (kbd "j") #'lsp-ui-peek--select-next)
    (define-key lsp-ui-peek-mode-map (kbd "C-k") #'lsp-ui-peek--select-prev-file)
    (define-key lsp-ui-peek-mode-map (kbd "C-j") #'lsp-ui-peek--select-next-file))

  (evil-define-key 'normal lsp-mode-map (kbd "RET") #'/bindings/lsp/transient)
  (evil-define-key 'normal lsp-mode-map (kbd "g r") #'lsp-rename)
  (evil-define-key 'normal lsp-mode-map (kbd "g d") #'lsp-find-definition)
  (evil-define-key 'normal lsp-mode-map (kbd "K") #'lsp-describe-thing-at-point))

(provide 'config-bindings-lsp)
