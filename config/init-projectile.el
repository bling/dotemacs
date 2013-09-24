(require-package 'projectile)
(require-package 'ack-and-a-half)

(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache")
      projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(require 'projectile)
(projectile-global-mode)

(provide 'init-projectile)
