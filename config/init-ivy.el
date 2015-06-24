(when (eq dotemacs-switch-engine 'ivy)
  (require-package 'smex)
  (setq smex-save-file (concat dotemacs-cache-directory "smex-items"))

  (require-package 'ivy)
  (require-package 'counsel)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

  (ivy-mode t)
  )

(provide 'init-ivy)
