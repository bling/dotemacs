(after 'selectrum
  (setq selectrum-num-candidates-displayed 16)
  (setq selectrum-count-style 'current/matches)

  (require-package 'prescient)
  (setq prescient-filter-method '(literal regexp initialism fuzzy))
  (setq prescient-save-file (concat dotemacs-cache-directory "prescient-save.el"))
  (setq prescient-history-length 500)

  (require-package 'selectrum)
  (require-package 'selectrum-prescient)
  (require-package 'marginalia)

  (require-package 'consult)
  (setq consult-project-root-function #'projectile-project-root)
  (setq consult-async-default-split nil)

  (require-package 'consult-selectrum)
  (require 'consult-selectrum)

  (require-package 'consult-flycheck)

  (require-package 'company-prescient))



(defun /selectrum/activate-as-switch-engine (on)
  (if on
      (progn
        (setq projectile-completion-system 'default)
        (selectrum-mode t)
        (selectrum-prescient-mode t)
        (company-prescient-mode t)
        (prescient-persist-mode t)
        (consult-preview-mode t)
        (marginalia-mode t))
    (marginalia-mode -1)
    (consult-preview-mode -1)
    (prescient-persist-mode -1)
    (company-prescient-mode -1)
    (selectrum-prescient-mode -1)
    (selectrum-mode -1)))

(when (eq dotemacs-switch-engine 'selectrum)
  (/selectrum/activate-as-switch-engine t))

(provide 'config-selectrum)
