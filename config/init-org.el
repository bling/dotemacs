(after 'org
  (defgroup dotemacs-org nil
    "Configuration options for org-mode."
    :group 'dotemacs
    :prefix 'dotemacs-org)

  (defcustom dotemacs-org/journal-file (concat org-directory "/journal.org")
    "The path to the file where you want to make journal entries."
    :type 'file
    :group 'dotemacs-org)

  (defcustom dotemacs-org/inbox-file (concat org-directory "/inbox.org")
    "The path to the file where to capture notes."
    :type 'file
    :group 'dotemacs-org)

  (unless (file-exists-p org-directory)
    (make-directory org-directory))

  (setq org-default-notes-file (expand-file-name dotemacs-org/inbox-file))
  (setq org-log-done t)
  (setq org-log-into-drawer t)

  (setq org-startup-indented t)
  (setq org-indent-indentation-per-level 2)
  (setq org-src-fontify-natively t)

  (setq org-agenda-files `(,org-directory))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline (expand-file-name dotemacs-org/inbox-file) "INBOX")
           "* TODO %?\n%U\n%a\n")
          ("n" "Note" entry (file+headline (expand-file-name dotemacs-org/inbox-file) "NOTES")
           "* %? :NOTE:\n%U\n%a\n")
          ("m" "Meeting" entry (file (expand-file-name dotemacs-org/inbox-file))
           "* MEETING %? :MEETING:\n%U")
          ("j" "Journal" entry (file+datetree (expand-file-name dotemacs-org/journal-file))
           "* %U\n** %?")))

  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n@)" "|" "DONE(d@)")
          (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)")))

  (setq org-todo-state-tags-triggers
        ' (("CANCELLED" ("CANCELLED" . t))
           ("WAITING" ("WAITING" . t))
           ("TODO" ("WAITING") ("CANCELLED"))
           ("NEXT" ("WAITING") ("CANCELLED"))
           ("DONE" ("WAITING") ("CANCELLED"))))

  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-completion-use-ido t)

  (when (boundp 'org-plantuml-jar-path)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((plantuml . t))))

  (defun my-org-mode-hook ()
    (toggle-truncate-lines t))
  (add-hook 'org-mode-hook #'my-org-mode-hook)

  (require-package 'org-bullets)
  (setq org-bullets-bullet-list '("✿" "❀" "☢" "☯" "✸" ))
  (add-hook 'org-mode-hook #'org-bullets-mode))

(provide 'init-org)
