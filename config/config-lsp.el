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
  (unless (fboundp 'lsp-mode)
    (use-package lsp-mode
      :init
      (setq lsp-session-file (concat dotemacs-cache-directory ".lsp-session-v1"))
      (setq lsp-keep-workspace-alive nil)
      (setq lsp-diagnostics-provider :flymake)
      (setq lsp-enable-on-type-formatting nil)
      (setq lsp-enable-suggest-server-download nil)
      (setq lsp-warn-no-matched-clients nil)
      (setq read-process-output-max (* 1024 1024)))

    (use-package lsp-ui
      :init
      (setq lsp-ui-sideline-show-hover t)
      (setq lsp-ui-sideline-delay 0.5)
      (setq lsp-ui-doc-include-signature t)
      (setq lsp-ui-doc-header t)
      (setq lsp-ui-doc-position 'top)
      (setq lsp-ui-doc-delay 1)
      (setq lsp-ui-doc-show-with-cursor t))

    (when (eq dotemacs-explorer/option 'treemacs)
      (use-package lsp-treemacs)))

  (lsp-deferred)
  (when (eq dotemacs-explorer/option 'treemacs)
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

(defun /lsp-mode/strip-nils (tree)
  "Recursively strip any alist entry whose value is nil."
  (cond
   ((and (consp tree) (consp (car tree)))
    (delq nil
          (mapcar (lambda (pair)
                    (if (consp pair)
                        (let ((val (cdr pair)))
                          (cond
                           ((null val) nil)
                           ((consp val)
                            (let ((cleaned (/lsp-mode/strip-nils val)))
                              (when cleaned (cons (car pair) cleaned))))
                           (t pair)))
                      pair))
                  tree)))
   (t tree)))

(defun /lsp-mode/strip-space-trigger (workspace)
  "Stops popup from appearing prematurely after typing things like \"if (\".
lsp-mode has a lookback algorithm which will pick up the space before the (."
  (let* ((caps (lsp--workspace-server-capabilities workspace))
         (comp (lsp:server-capabilities-completion-provider? caps))
         (triggers (append (lsp:completion-options-trigger-characters? comp) nil)))
    (when (member " " triggers)
      (lsp:set-completion-options-trigger-characters?
       comp
       (vconcat (delete " " triggers))))))

(after 'lsp-mode
  (advice-add #'lsp--suggest-project-root :override #'/lsp-mode/suggest-project-root)

  (when (executable-find "vtsls")
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("vtsls" "--stdio"))
                      :activation-fn 'lsp-typescript-javascript-tsx-jsx-activate-p
                      :priority 100
                      :completion-in-comments? t
                      :initialized-fn #'/lsp-mode/strip-space-trigger
                      :server-id 'vtsls))
    (lsp-disable-method-for-server "textDocument/documentColor" 'vtsls))

  (when (executable-find "tsgo")
    (after 'lsp-javascript
      (when-let* ((client (gethash 'tsgo lsp-clients)))
        (aset client (cl-struct-slot-offset 'lsp--client 'priority) 99)
        (aset client (cl-struct-slot-offset 'lsp--client 'initialized-fn) #'/lsp-mode/strip-space-trigger)))

    ;; tsgo is strict and disallows null, so we must strip them out
    (advice-add #'lsp--client-capabilities :filter-return
                (lambda (caps)
                  (if (eq (and lsp--cur-workspace
                               (lsp--workspace-server-id lsp--cur-workspace))
                          'tsgo)
                      (/lsp-mode/strip-nils caps)
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
