(defun /lsp/setup ()
  (require-package 'lsp-mode)
  (require-package 'lsp-ui)

  (add-hook 'lsp-mode-hook #'lsp-ui-mode)

  (after 'company
    (require-package 'company-lsp)
    (add-to-list 'company-backends 'company-lsp)))

(provide 'config-lsp)
