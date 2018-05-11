(after [evil tide]
  (evil-define-key 'normal tide-mode-map (kbd "RET") #'/hydras/modes/typescript-mode/body)
  (evil-define-key 'normal tide-mode-map (kbd "g r") #'tide-rename-symbol)

  (evil-define-key 'normal tide-references-mode-map
    (kbd "j") #'tide-find-next-reference
    (kbd "k") #'tide-find-previous-reference)

  (evil-define-key 'normal tide-project-errors-mode-map
    (kbd "j") #'tide-find-next-error
    (kbd "k") #'tide-find-previous-error))

(provide 'config-bindings-tide)
