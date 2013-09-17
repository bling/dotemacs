(require-package 'projectile)
(require 'projectile)
(projectile-global-mode)

(setq projectile-cache-file (expand-file-name ".cache/projectile.cache" user-emacs-directory))
(setq projectile-known-projects-file (expand-file-name ".cache/projectile-bookmarks.eld" user-emacs-directory))

(provide 'init-projectile)
