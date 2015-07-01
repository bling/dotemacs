(setq vc-make-backup-files t)

(after 'vc-git
  (require-package 'magit)

  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-section-show-child-count t)
  (setq magit-diff-arguments '("--histogram"))

  (if (display-graphic-p)
      (progn
        (require-package 'git-gutter-fringe)
        (require 'git-gutter-fringe))
    (require-package 'git-gutter))
  (global-git-gutter-mode))


(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(unless (display-graphic-p)
  (diff-hl-margin-mode))


(provide 'init-vcs)
