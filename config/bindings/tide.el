(after [evil tide hydra]
  (defhydra /bindings/tide/hydra (:hint nil :exit t)
    "
   typescript:  _d_ jump to definition   _R_ refactor           _e_ project errors       _v_ verify setup
                _h_ documentation        _j_ insert jsdoc       _o_ organize imports     _S_ restart server
                _r_ find references      _f_ fix at point       _a_ navigate
                _n_ rename symbol        _F_ format
                _N_ rename file          _l_ tslint disable next line
"
    ("a" tide-nav)
    ("e" tide-project-errors)
    ("j" tide-jsdoc-template)
    ("d" tide-jump-to-definition)
    ("R" tide-refactor)
    ("n" tide-rename-symbol)
    ("N" tide-rename-file)
    ("o" tide-organize-imports)
    ("r" tide-references)
    ("f" tide-fix)
    ("F" tide-format)
    ("l" tide-add-tslint-disable-next-line)
    ("h" tide-documentation-at-point)
    ("v" tide-verify-setup)
    ("S" tide-restart-server))

  (evil-define-key 'normal tide-mode-map (kbd "RET") #'/bindings/tide/hydra/body)
  (evil-define-key 'normal tide-mode-map (kbd "g r") #'tide-rename-symbol)

  (evil-define-key 'normal tide-references-mode-map
    (kbd "j") #'tide-find-next-reference
    (kbd "k") #'tide-find-previous-reference)

  (evil-define-key 'normal tide-project-errors-mode-map
    (kbd "j") #'tide-find-next-error
    (kbd "k") #'tide-find-previous-error))

(provide 'config-bindings-tide)
