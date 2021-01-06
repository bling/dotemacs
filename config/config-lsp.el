(defgroup dotemacs-lsp nil
  "Configuration options for LSP."
  :group 'dotemacs
  :prefix 'dotemacs-lsp)

(defcustom dotemacs-lsp/inhibit-paths '("node_modules")
  "A list of paths that should not activate LSP."
  :type '(repeat string)
  :group 'dotemacs-lsp)



(defun /lsp/activate ()
  (interactive)
  (unless (seq-filter
           (lambda (path)
             (string-match-p path (buffer-file-name)))
           dotemacs-lsp/inhibit-paths)
    (/lsp/do-activate)))

(defun /lsp/do-activate ()
  (require-package 'lsp-mode)
  (require-package 'lsp-ui)
  (require-package 'lsp-treemacs)

  (setq lsp-prefer-flymake nil) ;; use flycheck
  (setq lsp-session-file (concat dotemacs-cache-directory ".lsp-session-v1"))
  (setq lsp-keep-workspace-alive nil)

  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-position 'top)

  (lsp)
  (lsp-treemacs-sync-mode t))

(defun /lsp/suggest-project-root ()
  "Suggests the nearest project that is not a dependency."
  (or
   (locate-dominating-file
    (buffer-file-name)
    (lambda (dir)
      (if (string-match-p "node_modules" dir)
          nil
        (file-exists-p (concat dir "package.json")))))
   (projectile-project-root)))

(after 'lsp-mode
  (advice-add #'lsp--suggest-project-root :override #'/lsp/suggest-project-root))

(provide 'config-lsp)
