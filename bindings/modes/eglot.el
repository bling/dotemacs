;; -*- lexical-binding: t -*-

(after 'eglot
  (transient-define-prefix /bindings/eglot/transient ()
    [["nav"
      ("d" "definition" xref-find-definitions)
      ("r" "references" xref-find-references)
      ("s" "symbol search" (lambda () (interactive)
                             (if (eq dotemacs-switch-engine 'consult)
                                 (call-interactively #'consult-eglot-symbols)
                               (call-interactively #'xref-find-apropos))))
      ("i" "implementation" eglot-find-implementation)
      ("t" "type definition" eglot-find-typeDefinition)]
     ["refactor"
      ("n" "rename" eglot-rename)
      ("o" "organize imports" eglot-code-action-organize-imports)
      ("f" "quick fix" eglot-code-action-quickfix)
      ("x" "extract" eglot-code-action-extract)
      ("l" "inline" eglot-code-action-inline)
      ("a" "code actions" eglot-code-actions)
      ("=" "format buffer" eglot-format-buffer)
      ("F" "format region" eglot-format)]
     ["info / errors"
      ("h" "doc at point" eldoc-doc-buffer)
      ("g" "doc glance" eldoc-print-current-symbol-info)
      ("e" "buffer errors" flymake-show-buffer-diagnostics)
      ("E" "project errors" flymake-show-project-diagnostics)]
     ["server & toggles"
      ("H" (lambda () (/transients/toggle-fmt "inlay hints" 'eglot-inlay-hints-mode)) eglot-inlay-hints-mode)
      ("S" "restart server" eglot-reconnect)
      ("Q" "shutdown" eglot-shutdown)]])

  (evil-define-key 'normal eglot-mode-map (kbd "RET") #'/bindings/eglot/transient)
  (evil-define-key 'normal eglot-mode-map (kbd "g r") #'eglot-rename)
  (evil-define-key 'normal eglot-mode-map (kbd "g d") #'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "K") #'eldoc))

(provide 'config-bindings-eglot)
