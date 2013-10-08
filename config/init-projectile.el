(defvar projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
(defvar projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(require-package 'projectile)
(require-package 'ag)

(require 'projectile)
(require 'ag)

(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")

(projectile-global-mode t)

(defun projectile-ag ()
  "Run an `ag' search in the project"
  (interactive)
  (let ((search-regexp (if (and transient-mark-mode mark-active)
                           (buffer-substring (region-beginning) (region-end))
                         (read-string (projectile-prepend-project-name "Ag for: ") (thing-at-point 'symbol))))
        (root-dir (expand-file-name (projectile-project-root))))
    (ag/search search-regexp root-dir)))

(provide 'init-projectile)
