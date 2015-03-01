(add-hook
 'org-load-hook
 (lambda ()
   (unless (file-exists-p org-directory)
     (make-directory org-directory))

   (setq my-inbox-org-file (concat org-directory "/inbox.org"))

   (setq org-default-notes-file my-inbox-org-file)
   (setq org-log-done t)

   (setq org-startup-indented t)
   (setq org-indent-indentation-per-level 2)
   (setq org-src-fontify-natively t)

   (setq org-agenda-files `(,org-directory))
   (setq org-capture-templates
         '(("t" "Todo" entry (file+headline my-inbox-org-file "INBOX")
            "* TODO %?\n%U\n%a\n")
           ("n" "Note" entry (file+headline my-inbox-org-file "NOTES")
            "* %? :NOTE:\n%U\n%a\n")
           ("m" "Meeting" entry (file my-inbox-org-file)
            "* MEETING %? :MEETING:\n%U")
           ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
            "* %?\n%U\n")))

   (setq org-use-fast-todo-selection t)
   (setq org-treat-S-cursor-todo-selection-as-state-change nil)
   (setq org-todo-keywords
         '((sequence "TODO(t)" "NEXT(n@)" "|" "DONE(d)")
           (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)")))

   (setq org-todo-state-tags-triggers
         ' (("CANCELLED" ("CANCELLED" . t))
            ("WAITING" ("WAITING" . t))
            ("TODO" ("WAITING") ("CANCELLED"))
            ("NEXT" ("WAITING") ("CANCELLED"))
            ("DONE" ("WAITING") ("CANCELLED"))))

   (setq org-refile-targets '((nil :maxlevel . 9)
                              (org-agenda-files :maxlevel . 9)))
   (setq org-completion-use-ido t)

   (after 'org-mobile
     (setq org-mobile-directory (concat org-directory "/MobileOrg"))
     (unless (file-exists-p org-mobile-directory)
       (make-directory org-mobile-directory))
     (setq org-mobile-inbox-for-pull (concat org-directory "/from-mobile.org")))

   (after 'evil
     (add-hook 'org-capture-mode-hook #'evil-emacs-state))

   (when (boundp 'org-plantuml-jar-path)
     (org-babel-do-load-languages
      'org-babel-load-languages
      '((plantuml . t))))

   (defun my-org-mode-hook ()
     (when (or (executable-find "aspell")
               (executable-find "ispell")
               (executable-find "hunspell"))
       (turn-on-flyspell))
     (toggle-truncate-lines t))
   (add-hook 'org-mode-hook #'my-org-mode-hook)

   (require-package 'org-bullets)
   (setq org-bullets-bullet-list '("✿" "❀" "☢" "☯" "✸" ))
   (add-hook 'org-mode-hook #'org-bullets-mode)))


(provide 'init-org)
