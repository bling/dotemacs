(require-package 'projectile)


(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
(setq projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))
(setq projectile-indexing-method 'alien)


(require 'projectile)


(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")


(when (executable-find "ack")
  (require-package 's)
  (let ((val (concat "ack -f --print0" (s-join " --ignore-dir=" (cons "" projectile-globally-ignored-directories)))))
    (setq projectile-generic-command val)
    (setq projectile-svn-command val)))


(projectile-global-mode t)


(provide 'init-projectile)
