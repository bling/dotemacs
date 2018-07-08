(defun /lsp/activate (mode)
  (require-package 'lsp-mode)
  (require-package 'lsp-ui)

  (add-hook 'lsp-mode-hook #'lsp-ui-mode)

  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-header t)

  (after 'company
    (require-package 'company-lsp)
    (add-to-list 'company-backends 'company-lsp))

  (require-package mode)
  (require mode)
  (funcall (intern (concat (symbol-name mode) "-enable"))))

(provide 'config-lsp)
