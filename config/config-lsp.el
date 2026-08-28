;; -*- lexical-binding: t -*-

(defgroup dotemacs-lsp nil
  "Configuration options for LSP."
  :group 'dotemacs
  :prefix 'dotemacs-lsp)

(defcustom dotemacs-lsp/engine 'lsp
  "The primary engine to use for LSP."
  :type '(radio
          (const :tag "lsp" lsp)
          (const :tag "eglot" eglot)
          (const :tag "disabled" nil))
  :group 'dotemacs-lsp)

(defcustom dotemacs-lsp/inhibit-paths '("node_modules")
  "A list of paths that should not activate LSP."
  :type '(repeat string)
  :group 'dotemacs-lsp)

(defcustom dotemacs-lsp/inhibit-modes
  '(emacs-lisp-mode
    lisp-interaction-mode
    ielm-mode
    lisp-data-mode)
  "A list of major modes that should not activate LSP."
  :type '(repeat symbol)
  :group 'dotemacs-lsp)



(defun /lsp-mode/activate ()
  (use-package lsp-mode :demand t
    :init
    (setq lsp-session-file (concat dotemacs-cache-directory ".lsp-session-v1"))
    (setq lsp-keep-workspace-alive nil)
    (setq lsp-diagnostics-provider :flymake)
    (setq lsp-enable-on-type-formatting nil)
    (setq lsp-enable-suggest-server-download nil)
    (setq lsp-warn-no-matched-clients nil)
    (setq read-process-output-max (* 1024 1024)))

  (use-package lsp-ui :demand t
    :init
    (setq lsp-ui-sideline-show-hover t)
    (setq lsp-ui-sideline-delay 0.5)
    (setq lsp-ui-doc-include-signature t)
    (setq lsp-ui-doc-header t)
    (setq lsp-ui-doc-position 'top)
    (setq lsp-ui-doc-delay 1)
    (setq lsp-ui-doc-show-with-cursor t))

  (lsp-deferred)
  (when (eq dotemacs-explorer/option 'treemacs)
    (use-package lsp-treemacs :demand t)
    (lsp-treemacs-sync-mode t)))

(defun /lsp-mode/suggest-project-root ()
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
     (project-root pr))
   default-directory))

(after 'lsp-mode
  (advice-add #'lsp--suggest-project-root :override #'/lsp-mode/suggest-project-root)

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

(defun /lsp/activate ()
  "Activates the configured LSP engine."
  (interactive)
  (unless (or (null (buffer-file-name))
              (apply #'derived-mode-p dotemacs-lsp/inhibit-modes)
              (seq-filter
               (lambda (path)
                 (string-match-p path (buffer-file-name)))
               dotemacs-lsp/inhibit-paths))
    (cond
     ((eq dotemacs-lsp/engine 'lsp)
      (/lsp-mode/activate))
     ((eq dotemacs-lsp/engine 'eglot)
      (/eglot/activate)))))

(when dotemacs-lsp/engine
  (add-hook 'prog-mode-hook #'/lsp/activate))

(provide 'config-lsp)
