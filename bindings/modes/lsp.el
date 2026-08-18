;; -*- lexical-binding: t -*-

(after 'lsp-mode
  (defhydra /bindings/lsp/workspace/hydra (:exit t)
    ("a" lsp-workspace-folders-add "add folder" :column "workspace")
    ("r" lsp-workspace-folders-remove "remove folder")
    ("s" lsp-workspace-folders-switch "switch folder"))

  (defhydra /bindings/lsp/hydra (:exit t)
    ("d" lsp-ui-peek-find-definitions "peek definition" :column "nav")
    ("D" xref-find-definitions "xref definition")
    ("r" lsp-ui-peek-find-references "peek references")
    ("R" xref-find-references "xref references")
    ("c" lsp-treemacs-call-hierarchy "call hierarchy")
    ("T" lsp-treemacs-type-hierarchy "type hierarchy")
    ("i" lsp-find-implementation "implementation")
    ("t" lsp-find-type-definition "type definition")

    ("n" lsp-rename "rename" :column "refactor")
    ("o" lsp-organize-imports "organize imports")
    ("f" lsp-ui-sideline-apply-code-actions "quick fix")
    ("a" lsp-execute-code-action "code action")
    ("=" lsp-format-buffer "format buffer")
    ("F" lsp-format-region "format region")

    ("h" lsp-describe-thing-at-point "doc at point" :column "info / errors")
    ("g" lsp-ui-doc-glance "doc glance")
    ("s" (if (eq dotemacs-switch-engine 'consult)
             (call-interactively #'consult-lsp-symbols)
           (call-interactively #'lsp-treemacs-symbols)) "symbols")
    ("e" lsp-treemacs-errors-list "errors list")

    ("S" lsp-restart-workspace "restart workspace" :column "server & toggles")
    ("Q" lsp-shutdown-workspace "shutdown")
    ("w" /bindings/lsp/workspace/hydra/body "folders")
    ("H" lsp-inlay-hints-mode "inlay hints")
    ("L" lsp-lens-mode "code lenses")
    ("I" lsp-describe-session "session info"))

  (after 'lsp-ui
    (evil-define-key 'normal lsp-ui-mode-map (kbd "RET") #'/bindings/lsp/hydra/body)
    (evil-define-key 'normal lsp-ui-mode-map (kbd "g r") #'lsp-rename)
    (evil-define-key 'normal lsp-ui-mode-map (kbd "g d") #'lsp-ui-peek-find-definitions)
    (evil-define-key 'normal lsp-ui-mode-map (kbd "K") #'lsp-describe-thing-at-point)

    (define-key lsp-ui-peek-mode-map (kbd "k") #'lsp-ui-peek--select-prev)
    (define-key lsp-ui-peek-mode-map (kbd "j") #'lsp-ui-peek--select-next)
    (define-key lsp-ui-peek-mode-map (kbd "C-k") #'lsp-ui-peek--select-prev-file)
    (define-key lsp-ui-peek-mode-map (kbd "C-j") #'lsp-ui-peek--select-next-file))

  (evil-define-key 'normal lsp-mode-map (kbd "RET") #'/bindings/lsp/hydra/body)
  (evil-define-key 'normal lsp-mode-map (kbd "g r") #'lsp-rename)
  (evil-define-key 'normal lsp-mode-map (kbd "g d") #'lsp-find-definition)
  (evil-define-key 'normal lsp-mode-map (kbd "K") #'lsp-describe-thing-at-point))

(provide 'config-bindings-lsp)
