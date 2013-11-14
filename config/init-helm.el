(setq helm-command-prefix-key "C-c h")
(setq helm-quick-update t)

(require-package 'helm)
(require-package 'helm-swoop)

(after 'projectile
  (require-package 'helm-projectile))

(require 'helm-config)
(require 'helm-swoop)

(provide 'init-helm)
