(defun /consult/init ()
  (require-package 'vertico)
  (setq vertico-count 16)

  (require-package 'marginalia)

  (require-package 'orderless)
  (require 'orderless)
  (add-to-list 'orderless-matching-styles 'orderless-flex)

  (require-package 'consult)

  (after 'projectile
    (require-package 'consult-projectile)
    (require 'consult-projectile))

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
        (add-to-list 'completion-styles 'orderless)
        (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)
        (marginalia-mode t)
        (vertico-mode t))
    (setq completion-in-region-function #'completion--in-region)
    (setq completion-styles (delete 'orderless completion-styles))
    (advice-remove #'completing-read-multiple #'consult-completing-read-multiple)
    (marginalia-mode -1)
    (vertico-mode -1)))

(when (eq dotemacs-switch-engine 'consult)
  (/consult/activate-as-switch-engine t))

(provide 'config-consult)

