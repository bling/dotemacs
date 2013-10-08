(defvar helm-command-prefix-key "C-c h")
(defvar helm-quick-update t)

(require-package 'helm)

(after 'projectile
  (require-package 'helm-projectile))

(require 'helm-config)

(provide 'init-helm)
