;; -*- lexical-binding: t -*-

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

  (setq lsp-session-file (concat dotemacs-cache-directory ".lsp-session-v1"))
  (setq lsp-keep-workspace-alive nil)
  (setq lsp-diagnostics-provider :flymake)
  (setq lsp-enable-on-type-formatting nil)
  (setq read-process-output-max (* 1024 1024))

  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-delay 0.5)

  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-delay 1)
  (setq lsp-ui-doc-show-with-cursor t)

  (lsp)
  (lsp-treemacs-sync-mode t))

(defun /lsp/suggest-project-root ()
  "Suggests the nearest project that is not a dependency."
  (or
   (when-let* ((file (buffer-file-name)))
     (locate-dominating-file
      file
      (lambda (dir)
        (if (string-match-p "node_modules" dir)
            nil
          (file-exists-p (concat dir "package.json"))))))
   (when-let* ((pr (project-current)))
     (project-root pr))))

(after 'lsp-mode
  (advice-add #'lsp--suggest-project-root :override #'/lsp/suggest-project-root)

  (when (executable-find "tsgo")
    (add-to-list 'lsp-disabled-clients 'ts-ls)
    (add-to-list 'lsp-disabled-clients 'jsts-ls)
    (advice-add #'lsp--client-capabilities :filter-return
                (lambda (caps)
                  (let* ((td (assq 'textDocument caps))
                         (td-val (cdr td)))
                    (when td
                      (setcdr td (assq-delete-all 'inlineCompletion td-val)))
                    caps)))))

(provide 'config-lsp)
