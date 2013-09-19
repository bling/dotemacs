(require-package 'projectile)
(require 'projectile)
(projectile-global-mode)

(setq projectile-cache-file (expand-file-name ".cache/projectile.cache" my-user-emacs-directory))
(setq projectile-known-projects-file (expand-file-name ".cache/projectile-bookmarks.eld" my-user-emacs-directory))

(provide 'init-projectile)
