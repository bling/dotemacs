(setq helm-command-prefix-key "C-c h")
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)

(require-package 'helm)
(require-package 'helm-swoop)

(after 'projectile
  (require-package 'helm-projectile))

(require 'helm-config)

(provide 'init-helm)
