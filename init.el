(let ((debug-on-error t)
      (gc-cons-threshold (* 1024 1024 1024))
      (file-name-handler-alist nil)
      (config-directory (concat user-emacs-directory "config/")))

  (eval-when-compile (require 'cl))

  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (unless (display-graphic-p) (menu-bar-mode -1))

  (defgroup dotemacs nil
    "Custom configuration for dotemacs."
    :group 'local)

  (defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
    "The storage location for various persistent files."
    :group 'dotemacs)

  (defcustom dotemacs-completion-engine
    'company
    "The completion engine the use."
    :type '(radio
            (const :tag "company-mode" company)
            (const :tag "auto-complete-mode" auto-complete))
    :group 'dotemacs)

  (defcustom dotemacs-switch-engine
    'helm
    "The primary engine to use for narrowing and navigation."
    :type '(radio
            (const :tag "helm" helm)
            (const :tag "ido" ido)
            (const :tag "ivy" ivy))
    :group 'dotemacs)

  (defcustom dotemacs-pair-engine
    'emacs
    "The primary engine to use auto-pairing and parens matching."
    :type '(radio
            (const :tag "emacs" emacs)
            (const :tag "smartparens" smartparens))
    :group 'dotemacs)

  (setq package-archives '(("melpa" . "http://melpa.org/packages/")
                           ("org" . "http://orgmode.org/elpa/")
                           ("gnu" . "http://elpa.gnu.org/packages/")))
  (setq package-enable-at-startup nil)
  (package-initialize)

  (require 'init-util (concat config-directory "init-util.el"))

  (setq custom-file (concat user-emacs-directory "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))

  (cl-loop for file in (directory-files config-directory t)
           when (string-match "\\.el$" file)
           do (require (intern (file-name-base file)) file)))
