;; -*- lexical-binding: t -*-

(defgroup dotemacs-consult nil
  "Configuration options for Consult."
  :group 'dotemacs
  :prefix 'dotemacs-consult)

(defcustom dotemacs-consult/filtering
  'hotfuzz+orderless
  "The filtering library to use."
  :type '(radio
          (const :tag "hotfuzz+orderless" hotfuzz+orderless)
          (const :tag "prescient" prescient))
  :group 'dotemacs-consult)



(defun /consult/init ()
  (use-package vertico
    :init
    (setq vertico-count 15))

  (use-package marginalia)

  (pcase dotemacs-consult/filtering
    ('hotfuzz+orderless
     (use-package hotfuzz :demand t
       :config
       (unless (fboundp #'hotfuzz--filter-c)
         (warn "Missing compiled module for hotfuzz.")))
     (use-package orderless
       :demand t
       :init
       (setq orderless-matching-styles '(orderless-literal
                                         orderless-initialism
                                         orderless-regexp))))
    ('prescient
     (use-package prescient
       :demand t
       :init
       (setq prescient-save-file (concat dotemacs-cache-directory "prescient-save.el"))
       (setq prescient-filter-method '(literal regexp initialism fuzzy))
       :config
       (prescient-persist-mode t))

     (use-package vertico-prescient
       :init
       (setq vertico-prescient-override-sorting t))))

  (use-package consult)
  (use-package consult-dash)
  (use-package consult-project-extra)

  (after 'eglot
    (use-package consult-eglot))

  (after 'lsp-mode
    (use-package consult-lsp)))

(defun /consult/setup-completion-styles ()
  (if (fboundp #'hotfuzz--filter-c)
      (setq-local completion-styles '(hotfuzz orderless basic))
    (setq-local completion-styles '(orderless basic))))

(defun /consult/activate-as-switch-engine (on)
  (/consult/init)
  (if on
      (progn
        (pcase dotemacs-consult/filtering
          ('hotfuzz+orderless
           (add-hook 'minibuffer-setup-hook #'/consult/setup-completion-styles)
           (add-hook 'text-mode-hook #'/consult/setup-completion-styles)
           (add-hook 'prog-mode-hook #'/consult/setup-completion-styles))
          ('prescient
           (vertico-prescient-mode t)))
        (marginalia-mode t)
        (vertico-mode t))
    (pcase dotemacs-consult/filtering
      ('hotfuzz+orderless
       (remove-hook 'minibuffer-setup-hook #'/consult/setup-completion-styles)
       (remove-hook 'text-mode-hook #'/consult/setup-completion-styles)
       (remove-hook 'prog-mode-hook #'/consult/setup-completion-styles))
      ('prescient
       (vertico-prescient-mode -1)))
    (marginalia-mode -1)
    (vertico-mode -1)))

(when (eq dotemacs-switch-engine 'consult)
  (/consult/activate-as-switch-engine t))

(provide 'config-consult)

