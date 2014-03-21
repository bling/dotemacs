(after 'org
  (unless (file-exists-p org-directory)
    (make-directory org-directory))

  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-log-done t)

  (setq org-agenda-files `(,org-directory))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline (concat org-directory "/notes.org") "Tasks")
           "* TODO %?  %T")
          ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
           "* %?\n%U\n")))

  (after 'evil
    (add-hook 'org-capture-mode-hook 'evil-insert-state))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((plantuml . t)))

  (after 'ob-core
    (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)))


(provide 'init-org)
