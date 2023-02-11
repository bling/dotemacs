;; -*- lexical-binding: t -*-

(defgroup dotemacs-vcs nil
  "Configuration options for version control."
  :group 'dotemacs
  :prefix 'dotemacs-vcs)

(defcustom dotemacs-vcs/inhibit-vc-integration (eq system-type 'windows-nt)
  "When non-nil, disables integration with `vc.el'.
This is non-nil by default on Windows machines, where this is a heavy performance cost."
  :type 'boolean
  :group 'dotemacs-vcs)

(defcustom dotemacs-vcs/gutter (not (eq system-type 'windows-nt))
  "When non-nil, enables VCS changes in the gutter.
This is non-nil by default on Windows machines, where this is a heavy performance cost."
  :type 'boolean
  :group 'dotemacs-vcs)

(defcustom dotemacs-vcs/diff
  'ediff
  "The default diffing tool."
  :type '(radio
          (const :tag "ediff" ediff)
          (const :tag "vdiff" vdiff))
  :group 'dotemacs-vcs)



(when dotemacs-vcs/inhibit-vc-integration
  (after 'vc-hooks
    (setq vc-handled-backends nil)))

(setq vc-make-backup-files t)



(when (executable-find "git")
  (require-package 'magit)

  (defun /vcs/magit-post-display-buffer-hook()
    (if (string-match "*magit:" (buffer-name))
        (delete-other-windows)))
  (add-hook 'magit-post-display-buffer-hook #'/vcs/magit-post-display-buffer-hook)

  (setq magit-section-show-child-count t)
  (setq magit-display-buffer-function #'magit-display-buffer-fullcolumn-most-v1)
  (setq magit-ediff-dwim-show-on-hunks t)

  (after 'eshell
    (require-package 'pcmpl-git)
    (require 'pcmpl-git)

    (defalias 'pcomplete/g #'pcomplete/git)

    (defun pcomplete/gbr ()
      (pcomplete-here* (pcmpl-git-branches)))

    (defun pcomplete/gco ()
      (pcomplete-here* (pcmpl-git-complete-commit)))

    (defun pcomplete/grb ()
      (pcomplete-here* (pcmpl-git-complete-commit))))

  (when dotemacs-vcs/gutter
    (if (display-graphic-p)
        (progn
          (require-package 'git-gutter-fringe+)
          (require 'git-gutter-fringe+))
      (require-package 'git-gutter+))
    (global-git-gutter+-mode))

  (require-package 'git-timemachine))



(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(unless (display-graphic-p)
  (diff-hl-margin-mode))



(require-package 'with-editor)
(autoload 'with-editor-export-editor "with-editor")
(defun /vcs/with-editor-export ()
  (unless (equal (buffer-name) "*fzf*")
    (with-editor-export-editor)
    (message "")))
(add-hook 'shell-mode-hook #'/vcs/with-editor-export)
(add-hook 'term-exec-hook #'/vcs/with-editor-export)
(add-hook 'eshell-mode-hook #'/vcs/with-editor-export)



(defun /vcs/setup-vdiff ()
  (require-package 'vdiff)
  (require 'vdiff)
  (after 'magit
    (require-package 'vdiff-magit)
    (require 'vdiff-magit)))

(when (eq dotemacs-vcs/diff 'vdiff)
  (/vcs/setup-vdiff)
  (after 'config-bindings-vdiff
    (/bindings/vdiff/turn-on)))



(/boot/lazy-major-mode "^\\.gitignore$" gitignore-mode)
(/boot/lazy-major-mode "^\\.gitattributes$" gitattributes-mode)



(provide 'config-vcs)
