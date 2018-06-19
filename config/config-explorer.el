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
      (require 'all-the-icons)
      (treemacs-define-custom-icon (all-the-icons-alltheicon "csharp-line") "cs")
      (treemacs-define-custom-icon (all-the-icons-alltheicon "css3") "css")
      (treemacs-define-custom-icon (all-the-icons-alltheicon "git") "gitignore")
      (treemacs-define-custom-icon (all-the-icons-alltheicon "html5") "html" "htm")
      (treemacs-define-custom-icon (all-the-icons-alltheicon "java") "java")
      (treemacs-define-custom-icon (all-the-icons-alltheicon "javascript") "js")
      (treemacs-define-custom-icon (all-the-icons-fileicon "elisp") "el" "elc")
      (treemacs-define-custom-icon (all-the-icons-fileicon "jsx-2") "jsx")
      (treemacs-define-custom-icon (all-the-icons-fileicon "org") "org")
      (treemacs-define-custom-icon (all-the-icons-fileicon "typescript") "ts")
      (treemacs-define-custom-icon (all-the-icons-octicon "markdown") "md")
      (treemacs-define-custom-icon (all-the-icons-octicon "settings") "json" "yaml" "yml" "ini")
      (treemacs-define-custom-icon (all-the-icons-octicon "file-media") "ico" "png" "jpg" "jpeg" "svg")))

  (after 'treemacs
    (if (and (executable-find "git")
             (executable-find "python3"))
        (treemacs-git-mode 'extended)
      (treemacs-git-mode 'simple)))

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
