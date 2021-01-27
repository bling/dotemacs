;; -*- lexical-binding: t -*-

(require-package 'projectile)

(setq projectile-cache-file (concat dotemacs-cache-directory "projectile.cache"))
(setq projectile-known-projects-file (concat dotemacs-cache-directory "projectile-bookmarks.eld"))
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)
(setq projectile-files-cache-expire (* 60 60 24 14)) ;; 2 weeks

(after 'helm-projectile
  (add-to-list 'helm-projectile-sources-list 'helm-source-projectile-recentf-list))

(projectile-mode)

(dolist (dir dotemacs-globally-ignored-directories)
  (add-to-list 'projectile-globally-ignored-directories dir))

(cond
 ((executable-find "rg")
  (setq projectile-generic-command
        (concat "rg -0 --hidden --files --color never "
                (mapconcat (lambda (dir) (concat "--glob " "'!" dir "'")) projectile-globally-ignored-directories " "))))
 ((executable-find "ag")
  (setq projectile-generic-command
        (concat "ag -0 -l --hidden --nocolor "
                (mapconcat (lambda (dir) (concat "--ignore-dir=" dir)) projectile-globally-ignored-directories " "))))
 ((executable-find "ack")
  (setq projectile-generic-command
        (concat "ack -f --print0"
                (mapconcat (lambda (dir) (concat "--ignore-dir=" dir)) projectile-globally-ignored-directories " ")))))

(provide 'config-projectile)
