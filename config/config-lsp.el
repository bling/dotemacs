(defun /lsp/activate ()
  (interactive)

  (require-package 'lsp-mode)
  (require-package 'lsp-ui)
  (require-package 'company-lsp)

  (setq lsp-prefer-flymake nil) ;; use flycheck
  (setq lsp-session-file (concat dotemacs-cache-directory ".lsp-session-v1"))
  (setq lsp-keep-workspace-alive nil)

  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-header t)

  (lsp))

(defun /lsp/suggest-project-root ()
  "Suggests the nearest project that is not a dependency."
  (locate-dominating-file
   (buffer-file-name)
   (lambda (dir)
     (if (string-match-p "node_modules" dir)
         nil
       (file-exists-p (concat dir "package.json"))))))

(after 'lsp-mode
  (advice-add #'lsp--suggest-project-root :override #'/lsp/suggest-project-root))

(provide 'config-lsp)
