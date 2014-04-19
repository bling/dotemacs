(after 'vc-git
  (require-package 'magit)

  (after 'magit
    (setq magit-diff-options '("--histogram"))
    (setq magit-stage-all-confirm nil)

    (defadvice magit-status (around my-magit-fullscreen activate)
      (window-configuration-to-register :magit-fullscreen)
      ad-do-it
      (delete-other-windows))

    (defun my-magit-quit-session ()
      (interactive)
      (kill-buffer)
      (jump-to-register :magit-fullscreen)))

  (after 'evil
    (after 'magit-blame
      (defadvice magit-blame-file-on (after advice-for-magit-blame-file-on activate)
        (evil-emacs-state))
      (defadvice magit-blame-file-off (after advice-for-magit-blame-file-off activate)
        (evil-exit-emacs-state))))

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
