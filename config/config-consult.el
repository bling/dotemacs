;; -*- lexical-binding: t -*-

(defgroup dotemacs-consult nil
  "Configuration options for Consult."
  :group 'dotemacs
  :prefix 'dotemacs-consult)

(defcustom dotemacs-consult/filtering
  'prescient
  "The filtering library to use."
  :type '(radio
          (const :tag "orderless" orderless)
          (const :tag "prescient" prescient))
  :group 'dotemacs-consult)



(defun /consult/init ()
  (require-package 'vertico)
  (setq vertico-count 20)

  (require-package 'marginalia)

  (cond
   ((eq dotemacs-consult/filtering 'orderless)
    (require-package 'orderless)
    (require 'orderless)
    (add-to-list 'orderless-matching-styles 'orderless-flex))
   ((eq dotemacs-consult/filtering 'prescient)
    (require-package 'prescient)
    (require 'prescient)
    (setq prescient-save-file (concat dotemacs-cache-directory "prescient-save.el"))
    (setq prescient-persist-mode t)
    (add-to-list 'prescient-filter-method 'fuzzy)

    (require-package 'vertico-prescient)
    (setq vertico-prescient-override-sorting t)))

  (require-package 'consult)

  (after 'projectile
    (require-package 'consult-projectile)
    (require 'consult-projectile)
    (add-to-list 'consult-projectile-sources 'consult-projectile--source-projectile-recentf))

  (after 'eglot
    (require-package 'consult-eglot))

  (after 'lsp-mode
    (require-package 'consult-lsp)))

(defun /consult/activate-as-switch-engine (on)
  (/consult/init)
  (if on
      (progn
        (setq completion-in-region-function
              (lambda (&rest args)
                (apply (if vertico-mode
                           #'consult-completion-in-region
                         #'completion--in-region)
                       args)))
        (when (eq dotemacs-consult/filtering 'orderless)
          (add-to-list 'completion-styles 'orderless))
        (when (eq dotemacs-consult/filtering 'prescient)
          (vertico-prescient-mode t))
        (marginalia-mode t)
        (vertico-mode t))
    (setq completion-in-region-function #'completion--in-region)
    (when (eq dotemacs-consult/filtering 'orderless)
      (setq completion-styles (delete 'orderless completion-styles)))
    (when (eq dotemacs-consult/filtering 'prescient)
      (vertico-prescient-mode -1))
    (marginalia-mode -1)
    (vertico-mode -1)))

(when (eq dotemacs-switch-engine 'consult)
  (/consult/activate-as-switch-engine t))

(provide 'config-consult)

