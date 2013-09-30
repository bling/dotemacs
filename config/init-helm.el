(require-package 'helm)

(after-load 'projectile
  (require-package 'helm-projectile))

(require 'helm-config)
(helm-mode 1)

(provide 'init-helm)
