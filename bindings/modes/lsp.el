(after 'lsp-ui
  (defhydra /bindings/lsp/workspace/hydra (:hint nil :exit t)
    "
   workspace:  _a_ → add folder
               _r_ → remove folder
               _s_ → switch folder
"
    ("a" lsp-workspace-folders-add)
    ("r" lsp-workspace-folders-remove)
    ("s" lsp-workspace-folders-switch))

  (defhydra /bindings/lsp/hydra (:hint nil :exit t)
    "
   lsp:  _d_ → peek definitions   _r_ → peek references   _n_ → rename   _o_ → outline   _S_ → restart workspace
         _D_ → xref definitions   _R_ → xref references   _=_ → format   ^ ^             _i_ → describe session
         ^ ^                      ^ ^                     _a_ → apply code action     ^^ _w_ → workspace
"
    ("d" lsp-ui-peek-find-definitions)
    ("D" xref-find-definitions)
    ("r" lsp-ui-peek-find-references)
    ("R" xref-find-references)
    ("n" lsp-rename)
    ("=" lsp-format-buffer)
    ("a" lsp-ui-sideline-apply-code-actions)
    ("o" lsp-ui-imenu)
    ("S" lsp-restart-workspace)
    ("i" lsp-describe-session)
    ("w" /bindings/lsp/workspace/hydra/body))

  (evil-define-key 'normal lsp-ui-mode-map (kbd "RET") #'/bindings/lsp/hydra/body)
  (evil-define-key 'normal lsp-ui-mode-map (kbd "g r") #'lsp-rename)
  (evil-define-key 'normal lsp-ui-mode-map (kbd "g d") #'lsp-ui-peek-find-definitions)
  (evil-define-key 'normal lsp-ui-mode-map (kbd "K") #'lsp-describe-thing-at-point)

  (define-key lsp-ui-peek-mode-map (kbd "k") #'lsp-ui-peek--select-prev)
  (define-key lsp-ui-peek-mode-map (kbd "j") #'lsp-ui-peek--select-next)
  (define-key lsp-ui-peek-mode-map (kbd "C-k") #'lsp-ui-peek--select-prev-file)
  (define-key lsp-ui-peek-mode-map (kbd "C-j") #'lsp-ui-peek--select-next-file))

(provide 'config-bindings-lsp)
