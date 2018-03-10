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



(cond
 ((eq dotemacs-explorer/option 'treemacs)
  (require-package 'treemacs)
  (require-package 'treemacs-projectile)

  (setq treemacs-indentation 1)
  (setq treemacs-indentation-string (propertize "|" 'face 'font-lock-comment-face))
  (setq treemacs-follow-mode t)
  (setq treemacs-follow-after-init t)
  (setq treemacs-filewatch-mode t)
  (setq treemacs-file-event-delay 1000)
  (setq treemacs-header-function #'treemacs-projectile-create-header)

  (after 'evil
    (require-package 'treemacs-evil)
    (require 'treemacs-evil))
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
    (if (treemacs--is-visible?)
        (treemacs-projectile-toggle)
      (treemacs-projectile)))
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
