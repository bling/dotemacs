(require-package 'projectile)


(setq projectile-cache-file (concat dotemacs-cache-directory "projectile.cache"))
(setq projectile-known-projects-file (concat dotemacs-cache-directory "projectile-bookmarks.eld"))
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)
(after "helm-autoloads"
  (setq projectile-completion-system 'helm)
  (after 'helm-projectile
    (add-to-list 'helm-projectile-sources-list 'helm-source-projectile-recentf-list)))


(require 'projectile)


(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")


(when (executable-find "ack")
  (require-package 's)
  (require 's)
  (let ((val (concat "ack -f --print0" (s-join " --ignore-dir=" (cons "" projectile-globally-ignored-directories)))))
    (setq projectile-generic-command val)
    (setq projectile-svn-command val)))


(projectile-global-mode t)


(provide 'init-projectile)
