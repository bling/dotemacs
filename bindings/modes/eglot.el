;; -*- lexical-binding: t -*-

(after 'eglot
  (defhydra /bindings/eglot/hydra (:exit t)
    ("d" xref-find-definitions "definition" :column "nav")
    ("r" xref-find-references "references")
    ("s" (if (eq dotemacs-switch-engine 'consult)
             (call-interactively #'consult-eglot-symbols)
           (call-interactively #'xref-find-apropos)) "symbol search")
    ("i" eglot-find-implementation "implementation")
    ("t" eglot-find-typeDefinition "type definition")

    ("n" eglot-rename "rename" :column "refactor")
    ("o" eglot-code-action-organize-imports "organize imports")
    ("f" eglot-code-action-quickfix "quick fix")
    ("x" eglot-code-action-extract "extract")
    ("l" eglot-code-action-inline "inline")
    ("a" eglot-code-actions "code actions")
    ("=" eglot-format-buffer "format buffer")
    ("F" eglot-format "format region")

    ("h" eldoc-doc-buffer "doc at point" :column "info / errors")
    ("g" eldoc-print-current-symbol-info "doc glance")
    ("e" flymake-show-buffer-diagnostics "buffer errors")
    ("E" flymake-show-project-diagnostics "project errors")

    ("S" eglot-reconnect "restart server" :column "server & toggles")
    ("Q" eglot-shutdown "shutdown")
    ("H" eglot-inlay-hints-mode "inlay hints"))

  (evil-define-key 'normal eglot-mode-map (kbd "RET") #'/bindings/eglot/hydra/body)
  (evil-define-key 'normal eglot-mode-map (kbd "g r") #'eglot-rename)
  (evil-define-key 'normal eglot-mode-map (kbd "g d") #'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "K") #'eldoc))

(provide 'config-bindings-eglot)
