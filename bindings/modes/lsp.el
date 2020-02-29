(after 'lsp-ui
  (defhydra /bindings/lsp/workspace/hydra (:exit t)
    ("a" lsp-workspace-folders-add "add folder" :column "workspace")
    ("r" lsp-workspace-folders-remove "remove folder")
    ("s" lsp-workspace-folders-switch "switch folder"))

  (defhydra /bindings/lsp/hydra (:exit t)
    ("d" lsp-ui-peek-find-definitions "peek definition" :column "definitions")
    ("D" xref-find-definitions "xref definitions")

    ("r" lsp-ui-peek-find-references "peek references" :column "references")
    ("R" xref-find-references "xref references")
    ("u" lsp-treemacs-references "usages")

    ("n" lsp-rename "rename" :column "refactor")
    ("=" lsp-format-buffer "format")
    ("a" lsp-ui-sideline-apply-code-actions "apply code action")

    ;; ("o" lsp-ui-imenu "outline" :column "info")
    ("o" lsp-treemacs-symbols "outline" :column "info")

    ("e" lsp-treemacs-errors-list "list" :column "errors")

    ("S" lsp-restart-workspace "restart workspace" :column "workspace")
    ("w" /bindings/lsp/workspace/hydra/body "folders")
    ("i" lsp-describe-session "session info"))

  (evil-define-key 'normal lsp-ui-mode-map (kbd "RET") #'/bindings/lsp/hydra/body)
  (evil-define-key 'normal lsp-ui-mode-map (kbd "g r") #'lsp-rename)
  (evil-define-key 'normal lsp-ui-mode-map (kbd "g d") #'lsp-ui-peek-find-definitions)
  (evil-define-key 'normal lsp-ui-mode-map (kbd "K") #'lsp-describe-thing-at-point)

  (define-key lsp-ui-peek-mode-map (kbd "k") #'lsp-ui-peek--select-prev)
  (define-key lsp-ui-peek-mode-map (kbd "j") #'lsp-ui-peek--select-next)
  (define-key lsp-ui-peek-mode-map (kbd "C-k") #'lsp-ui-peek--select-prev-file)
  (define-key lsp-ui-peek-mode-map (kbd "C-j") #'lsp-ui-peek--select-next-file))

(provide 'config-bindings-lsp)
