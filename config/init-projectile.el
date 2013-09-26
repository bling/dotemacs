(require-package 'projectile)
(require-package 'ack-and-a-half)

(require 'projectile)

(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache")
      projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(projectile-global-mode t)

(provide 'init-projectile)
