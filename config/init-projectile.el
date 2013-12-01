(require-package 'projectile)
(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
(setq projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))
(require 'projectile)

(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")

(projectile-global-mode t)

(provide 'init-projectile)
