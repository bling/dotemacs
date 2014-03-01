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
    (add-hook 'org-capture-mode-hook (lambda () (evil-insert-state))))

  (require 'ob)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((plantuml . t)))

  (setq org-plantuml-jar-path (expand-file-name "~/plantuml.jar")))


(provide 'init-org)
