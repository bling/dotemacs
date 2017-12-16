(add-hook 'csharp-mode-hook
          (lambda ()
            (require-package 'omnisharp)
            (omnisharp-mode t)))

(setq omnisharp-company-match-sort-by-flx-score t)
(setq omnisharp-company-match-type 'company-match-flex)

(after [omnisharp company]
  (add-to-list 'company-backends #'company-omnisharp))

(provide 'config-csharp)
