(after 'org
  (unless (file-exists-p org-directory)
    (make-directory org-directory))

  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-log-done t)

  (setq org-startup-indented t)
  (setq org-agenda-files `(,org-directory))
  (setq org-capture-templates
        '(("t" "Todo" entry (file (concat org-directory "/notes.org"))
           "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
          ("n" "Note" entry (file (concat org-directory "/notes.org"))
           "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
          ("m" "Metting" entry (file (concat org-directory "/notes.org"))
           "* MEETING %? :MEETING:\n%U" :clock-in t :clock-resume t)
          ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
           "* %?\n%U\n" :clock-in t :clock-resume t)))

  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "BLOCKED(b@/!)" "|" "CANCELLED(c@/!)")))

  (setq org-todo-state-tags-triggers
        ' (("CANCELLED" ("CANCELLED" . t))
           ("BLOCKED" ("BLOCKED" . t))
           ("TODO" ("BLOCKED") ("CANCELLED"))
           ("NEXT" ("BLOCKED") ("CANCELLED"))
           ("DONE" ("BLOCKED") ("CANCELLED"))))

  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))
  (setq org-completion-use-ido t)

  (after 'evil
    (add-hook 'org-capture-mode-hook 'evil-insert-state))

  (when (boundp 'org-plantuml-jar-path)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((plantuml . t))))

  (after 'ob-core
    (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)))

(provide 'init-org)
