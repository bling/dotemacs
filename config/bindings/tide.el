(after [evil tide hydra]
  (defhydra /bindings/tide/hydra (:hint nil :exit t)
    "
   typescript:  _d_ jump to definition   _R_ refactor             _e_ project errors
                _h_ documentation        _j_ insert jsdoc         _o_ organize imports
                _r_ find references      _f_ fix error at point   _v_ verify setup
                _n_ rename               _F_ format               _S_ restart server
"
    ("e" tide-project-errors)
    ("j" tide-jsdoc-template)
    ("d" tide-jump-to-definition)
    ("R" tide-refactor)
    ("n" tide-rename-symbol)
    ("o" tide-organize-imports)
    ("r" tide-references)
    ("S" tide-restart-server)
    ("f" tide-fix)
    ("F" tide-format)
    ("v" tide-verify-setup)
    ("h" tide-documentation-at-point))

  (evil-define-key 'normal tide-mode-map (kbd "RET") #'/bindings/tide/hydra/body)
  (evil-define-key 'normal tide-mode-map (kbd "g r") #'tide-rename-symbol)

  (evil-define-key 'normal tide-references-mode-map
    (kbd "j") #'tide-find-next-reference
    (kbd "k") #'tide-find-previous-reference)

  (evil-define-key 'normal tide-project-errors-mode-map
    (kbd "j") #'tide-find-next-error
    (kbd "k") #'tide-find-previous-error))

(provide 'config-bindings-tide)
