;; -*- lexical-binding: t -*-

(let ((file-name-handler-alist nil)
      (core-directory (concat user-emacs-directory "core/"))
      (bindings-directory (concat user-emacs-directory "bindings/"))
      (config-directory (concat user-emacs-directory "config/")))

  (defgroup dotemacs nil
    "Custom configuration for dotemacs."
    :group 'local)

  (defcustom dotemacs-completion-engine
    'corfu
    "The completion engine the use."
    :type '(radio
            (const :tag "corfu" corfu)
            (const :tag "company-mode" company))
    :group 'dotemacs)

  (defcustom dotemacs-switch-engine
    'consult
    "The primary engine to use for narrowing and navigation."
    :type '(radio
            (const :tag "helm" helm)
            (const :tag "consult" consult)
            (const :tag "ido" ido))
    :group 'dotemacs)

  (defcustom dotemacs-lsp-engine
    'lsp
    "The primary engine to use for LSP."
    :type '(radio
            (const :tag "lsp" lsp)
            (const :tag "eglot" eglot))
    :group 'dotemacs)

  (defcustom dotemacs-globally-ignored-directories
    '("elpa" ".cache" "target" "dist" "node_modules" ".git" ".hg" ".svn" ".idea")
    "A set of default directories to ignore for anything that involves searching."
    :type '(repeat string)
    :group 'dotemacs)

  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (setq package-enable-at-startup nil)
  (package-initialize)

  (load (concat core-directory "core-boot"))

  (setq custom-file (concat user-emacs-directory "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))

  (cl-loop for file in (append (reverse (directory-files-recursively config-directory "\\.el$"))
                               (reverse (directory-files-recursively bindings-directory "\\.el$")))
           do (condition-case-unless-debug ex
                  (load (file-name-sans-extension file))
                (error (with-current-buffer "*scratch*"
                         (insert (format "[INIT ERROR]\n%s\n%s\n\n" file ex)))))))
