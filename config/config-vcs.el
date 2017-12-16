(defgroup dotemacs-vcs nil
  "Configuration options for version control."
  :group 'dotemacs
  :prefix 'dotemacs-vcs)

(defcustom dotemacs-vcs/inhibit-vc-integration (eq system-type 'windows-nt)
  "When non-nil, disables integration with `vc.el'.
This is non-nil by default on Windows machines, where this is a heavy performance cost."
  :type 'boolean
  :group 'dotemacs-vcs)



(when dotemacs-vcs/inhibit-vc-integration
  (after 'vc-hooks
    (setq vc-handled-backends nil)))

(setq vc-make-backup-files t)



(require-package 'magit)

(defun /vcs/magit-post-display-buffer-hook()
  (if (string-match "*magit:" (buffer-name))
      (delete-other-windows)))
(add-hook 'magit-post-display-buffer-hook #'/vcs/magit-post-display-buffer-hook)

(setq magit-section-show-child-count t)
(setq magit-diff-arguments '("--histogram"))
(setq magit-ediff-dwim-show-on-hunks t)



(if (display-graphic-p)
    (progn
      (require-package 'git-gutter-fringe+)
      (require 'git-gutter-fringe+))
  (require-package 'git-gutter+))
(global-git-gutter+-mode)



(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(unless (display-graphic-p)
  (diff-hl-margin-mode))



(after 'eshell
  (require-package 'pcmpl-git)
  (require 'pcmpl-git))



(require-package 'with-editor)
(autoload 'with-editor-export-editor "with-editor")
(defun /vcs/with-editor-export ()
  (unless (equal (buffer-name) "*fzf*")
    (with-editor-export-editor)
    (message "")))
(add-hook 'shell-mode-hook #'/vcs/with-editor-export)
(add-hook 'term-exec-hook #'/vcs/with-editor-export)
(add-hook 'eshell-mode-hook #'/vcs/with-editor-export)



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

(provide 'config-vcs)
