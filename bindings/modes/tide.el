(after [evil tide hydra]
  (defhydra /bindings/tide/hydra (:exit t)
    ("a" tide-nav "navigate" :column "nav")
    ("r" tide-references "find references")
    ("d" tide-jump-to-definition "jump to def")

    ("e" tide-project-errors "project errors" :column "info")
    ("h" tide-documentation-at-point "doc at point")

    ("R" tide-refactor "refactor" :column "refactor")
    ("n" tide-rename-symbol "rename symbol")
    ("N" tide-rename-file "rename file")
    ("o" tide-organize-imports "organize imports")
    ("f" tide-fix "fix")
    ("=" tide-format "format")

    ("j" tide-jsdoc-template "insert jsdoc" :column "insert")
    ("l" tide-add-tslint-disable-next-line "tslint disable next line")

    ("v" tide-verify-setup "verify setup" :column "setup")
    ("S" tide-restart-server "restart server"))

  (evil-define-key 'normal tide-mode-map (kbd "RET") #'/bindings/tide/hydra/body)
  (evil-define-key 'normal tide-mode-map (kbd "g r") #'tide-rename-symbol)
  (evil-define-key 'normal tide-mode-map (kbd "K") #'tide-documentation-at-point)

  (evil-define-key 'normal tide-references-mode-map
    (kbd "j") #'tide-find-next-reference
    (kbd "k") #'tide-find-previous-reference)

  (evil-define-key 'normal tide-project-errors-mode-map
    (kbd "j") #'tide-find-next-error
    (kbd "k") #'tide-find-previous-error))

(provide 'config-bindings-tide)
