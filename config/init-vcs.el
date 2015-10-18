(setq vc-make-backup-files t)

(after 'vc-git
  (require-package 'magit)

  (add-hook 'magit-post-display-buffer-hook #'delete-other-windows)
  (setq magit-section-show-child-count t)
  (setq magit-diff-arguments '("--histogram"))
  (setq magit-push-always-verify nil)

  (if (display-graphic-p)
      (progn
        (require-package 'git-gutter-fringe+)
        (require 'git-gutter-fringe+))
    (require-package 'git-gutter+))
  (global-git-gutter+-mode))


(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(unless (display-graphic-p)
  (diff-hl-margin-mode))


(provide 'init-vcs)
