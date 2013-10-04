(defvar helm-command-prefix-key "C-c h")

(require-package 'helm)

(after 'projectile
  (require-package 'helm-projectile))

(require 'helm-config)

(provide 'init-helm)
