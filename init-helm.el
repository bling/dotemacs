(require-package 'helm)
(require-package 'helm-projectile)
(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-c h") 'helm-projectile)

(provide 'init-helm)
