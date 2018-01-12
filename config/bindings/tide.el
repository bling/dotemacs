(after [evil tide]
  (evil-define-key 'normal tide-mode-map (kbd "g d") #'tide-jump-to-definition)
  (evil-define-key 'normal tide-mode-map (kbd "g r") #'tide-rename-symbol)

  (evilify tide-references-mode tide-references-mode-map
    (kbd "j") #'tide-find-next-reference
    (kbd "k") #'tide-find-previous-reference)

  (evilify tide-project-errors-mode tide-project-errors-mode-map
    (kbd "j") #'tide-find-next-error
    (kbd "k") #'tide-find-previous-error))

(provide 'config-bindings-tide)
