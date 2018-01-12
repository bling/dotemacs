(after 'company
  (define-key company-active-map (kbd "<backtab>") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-select-next)
  (after "yasnippet-autoloads"
    (define-key company-active-map (kbd "<tab>")
      (bind (when (null (yas-expand))
              (company-select-next)))))

  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(provide 'config-bindings-company)
