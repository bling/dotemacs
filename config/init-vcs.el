(setq vc-make-backup-files t)

(after 'vc-git
  (require-package 'magit)

  (defun my-magit-post-display-buffer ()
    (if (string-match "*magit:" (buffer-name))
        (delete-other-windows)))
  (add-hook 'magit-post-display-buffer-hook #'my-magit-post-display-buffer)

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


(after 'eshell
  (require-package 'pcmpl-git)
  (require 'pcmpl-git))
