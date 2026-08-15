;; -*- lexical-binding: t -*-

(require 'project)

(setq project-list-file (concat dotemacs-cache-directory "projects"))
(setq project-buffers-viewer #'project-list-buffers-ibuffer)
(setq project-switch-commands #'project-find-file)
(setq project-vc-ignores dotemacs-globally-ignored-directories)
(setq project-vc-extra-root-markers '(".git"))

(provide 'config-project)
