(require-package 'smex)
(setq smex-save-file (concat dotemacs-cache-directory "smex-items"))

(require-package 'ivy)
(require-package 'counsel)

(setq ivy-use-virtual-buffers t)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

(when (eq dotemacs-switch-engine 'ivy)
  (ivy-mode t)
  (global-set-key [remap execute-extended-command] #'counsel-M-x)
  (global-set-key [remap describe-function] #'counsel-describe-function)
  (global-set-key [remap describe-variable] #'counsel-describe-variable)
  (global-set-key [remap find-file] #'counsel-find-file))

(provide 'init-ivy)
