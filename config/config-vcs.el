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



(when dotemacs-vcs/inhibit-vc-integration
  (after 'vc-hooks
    (setq vc-handled-backends nil)))

(setq vc-make-backup-files t)



(when (executable-find "git")
  (use-package magit
    :defer t
    :init
    (setq magit-section-show-child-count t)
    (setq magit-display-buffer-function #'magit-display-buffer-fullcolumn-most-v1)
    (setq magit-ediff-dwim-show-on-hunks t))

  (use-package git-timemachine :defer t))



(use-package diff-hl
  :hook ((dired-mode . diff-hl-dired-mode)
         (prog-mode . (lambda ()
                        (if (display-graphic-p)
                            (diff-hl-mode)
                          (diff-hl-margin-mode))))))



(use-package with-editor :defer t)
(defun /vcs/with-editor-export ()
  (unless (equal (buffer-name) "*fzf*")
    (with-editor-export-editor)
    (message "")))
(add-hook 'shell-mode-hook #'/vcs/with-editor-export)
(add-hook 'term-exec-hook #'/vcs/with-editor-export)
(add-hook 'eshell-mode-hook #'/vcs/with-editor-export)

(provide 'config-vcs)
