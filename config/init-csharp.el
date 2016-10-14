(require-package 'omnisharp)

(setq omnisharp-company-match-sort-by-flx-score t)
(setq omnisharp-company-match-type 'company-match-flex)

(after [omnisharp company]
  (add-to-list 'company-backends #'company-omnisharp))

(add-hook 'csharp-mode-hook #'omnisharp-mode)

(provide 'init-csharp)
