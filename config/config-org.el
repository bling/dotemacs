;; -*- lexical-binding: t -*-

;; must be set before loading org
(setq org-fold-core-style 'text-properties)

(after 'org
  (defgroup dotemacs-org nil
    "Configuration options for org-mode."
    :group 'dotemacs
    :prefix "dotemacs-org")

  (defcustom dotemacs-org/journal-file (expand-file-name "journal.org" org-directory)
    "The path to the file where you want to make journal entries."
    :type 'file
    :group 'dotemacs-org)

  (defcustom dotemacs-org/inbox-file (expand-file-name "inbox.org" org-directory)
    "The path to the file where to capture notes."
    :type 'file
    :group 'dotemacs-org)

  (unless (file-exists-p org-directory)
    (make-directory org-directory t))

  (setq org-default-notes-file dotemacs-org/inbox-file)
  (setq org-agenda-files `(,org-directory))
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-startup-indented t)
  (setq org-pretty-entities t)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n@)" "|" "DONE(d@)")
          (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)")))
  (setq org-todo-state-tags-triggers
        '(("CANCELLED" ("CANCELLED" . t))
          ("WAITING" ("WAITING" . t))
          ("TODO" ("WAITING") ("CANCELLED"))
          ("NEXT" ("WAITING") ("CANCELLED"))
          ("DONE" ("WAITING") ("CANCELLED"))))

  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-return-follows-link t)

  ;; capturing
  (setq org-capture-templates
        `(("t" "Todo" entry (file+headline dotemacs-org/inbox-file "INBOX")
           "* TODO %?\n%U\n%a\n")
          ("n" "Note" entry (file+headline dotemacs-org/inbox-file "NOTES")
           "* %? :NOTE:\n%U\n%a\n")
          ("m" "Meeting" entry (file+headline dotemacs-org/inbox-file "MEETINGS")
           "* MEETING %? :MEETING:\n%U")
          ("j" "Journal" entry (file+olp+datetree dotemacs-org/journal-file)
           "* %U\n** %?")))

  ;; refiling
  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)

  (add-hook 'org-babel-after-execute-hook #'org-link-preview-refresh)

  (use-package org-modern
    :hook ((org-mode . org-modern-mode)
           (org-agenda-finalize . org-modern-agenda)))

  (use-package org-appear
    :hook (org-mode . org-appear-mode)
    :init
    (setq org-appear-autolinks t)
    (setq org-appear-autosubmarkers t)))

(provide 'config-org)
