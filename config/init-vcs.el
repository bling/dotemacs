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


(require-package 'with-editor)
(autoload 'with-editor-export-editor "with-editor")
(add-hook 'shell-mode-hook #'with-editor-export-editor)
(add-hook 'term-mode-hook #'with-editor-export-editor)
(add-hook 'eshell-mode-hook #'with-editor-export-editor)


(lazy-major-mode "^\\.gitignore$" gitignore-mode)
(lazy-major-mode "^\\.gitattributes$" gitattributes-mode)


(evilify diff-mode diff-mode-map
  "j" #'diff-hunk-next
  "k" #'diff-hunk-prev)
(evilify vc-annotate-mode vc-annotate-mode-map
  (kbd "M-p") #'vc-annotate-prev-revision
  (kbd "M-n") #'vc-annotate-next-revision
  "l" #'vc-annotate-show-log-revision-at-line
  "J" #'vc-annotate-revision-at-line)


(provide 'init-vcs)
