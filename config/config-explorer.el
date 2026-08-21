;; -*- lexical-binding: t -*-

(defgroup dotemacs-explorer nil
  "Configuration options for file explorers."
  :group 'dotemacs
  :prefix 'dotemacs-explorer)

(defcustom dotemacs-explorer/option
  'treemacs
  "List of options for the file explorer."
  :type '(radio
          (const :tag "treemacs" treemacs)
          (const :tag "dired-sidebar" dired-sidebar))
  :group 'dotemacs-explorer)

(defcustom dotemacs-explorer/nerd-icons
  nil
  "Integrates with nerd-icons if available."
  :type 'boolean
  :group 'dotemacs-explorer)



(cond
 ((eq dotemacs-explorer/option 'treemacs)
  (use-package treemacs
    :init
    (setq treemacs-indentation 1)
    (setq treemacs-indentation-string (propertize "|" 'face 'font-lock-comment-face))
    (setq treemacs-follow-after-init t)
    (setq treemacs-file-event-delay 1000)
    :config
    (treemacs-filewatch-mode t)
    (treemacs-tag-follow-mode t))

  (when dotemacs-explorer/nerd-icons
    (after 'treemacs
      (use-package treemacs-nerd-icons :demand t)))

  (after 'treemacs
    (when (executable-find "git")
      (use-package treemacs-magit :demand t)

      (if (executable-find "python3")
          (treemacs-git-mode 'extended)
        (treemacs-git-mode 'simple))))

  (after [evil treemacs]
    (use-package treemacs-evil :demand t)))

 ((eq dotemacs-explorer/option 'dired-sidebar)
  (use-package dired-sidebar
    :init
    (setq dired-sidebar-should-follow-file t)
    (setq dired-sidebar-follow-file-idle-delay 0.2))))

(defun /explorer/toggle ()
  (interactive)
  (cond
   ((eq dotemacs-explorer/option 'treemacs)
    (treemacs))
   ((eq dotemacs-explorer/option 'dired-sidebar)
    (dired-sidebar-toggle-sidebar))))

(defun /explorer/find-file ()
  (interactive)
  (cond
   ((eq dotemacs-explorer/option 'treemacs)
    (treemacs-find-file))
   ((eq dotemacs-explorer/option 'dired-sidebar)
    (dired-sidebar-find-file))))

(provide 'config-explorer)
