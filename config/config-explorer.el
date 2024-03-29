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

(defcustom dotemacs-explorer/all-the-icons
  nil
  "Integrates with all-the-icons if available."
  :type 'boolean
  :group 'dotemacs-explorer)



(cond
 ((eq dotemacs-explorer/option 'treemacs)
  (/boot/delayed-init ;; delay load to allow treemacs to calculate icon colors based on the current theme
   (require-package 'treemacs)
   (require-package 'treemacs-projectile)

   (setq treemacs-indentation 1)
   (setq treemacs-indentation-string (propertize "|" 'face 'font-lock-comment-face))
   (setq treemacs-follow-after-init t)
   (setq treemacs-filewatch-mode t)
   (setq treemacs-tag-follow-mode t)
   (setq treemacs-file-event-delay 1000)

   (when (and dotemacs-explorer/all-the-icons (font-info "all-the-icons"))
     (after 'treemacs
       (require-package 'treemacs-all-the-icons)
       (require 'treemacs-all-the-icons)))

   (after 'treemacs
     (when (executable-find "git")
       (require-package 'treemacs-magit)
       (require 'treemacs-magit)

       (if (executable-find "python3")
           (treemacs-git-mode 'extended)
         (treemacs-git-mode 'simple))))

   (after [evil treemacs]
     (require-package 'treemacs-evil)
     (require 'treemacs-evil)))
  )

 ((eq dotemacs-explorer/option 'dired-sidebar)
  (require-package 'dired-sidebar)
  (setq dired-sidebar-should-follow-file t)
  (setq dired-sidebar-follow-file-idle-delay 0.2))
 )

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
    (require 'treemacs)
    (treemacs-find-file))
   ((eq dotemacs-explorer/option 'dired-sidebar)
    (dired-sidebar-find-file))))

(provide 'config-explorer)
