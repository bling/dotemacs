(setq org-default-notes-file "~/.notes.org")
(setq org-log-done t)


(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.notes.org" "Tasks")
         "* TODO %?  %T")
        ("j" "Journal" entry (file+datetree "~/.journal.org")
         "* %?\n%U\n")))
(after 'evil
  (add-hook 'org-capture-mode-hook (lambda () (evil-insert-state))))


(after 'org
  (require 'ob)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((plantuml . t))))


(setq org-plantuml-jar-path (expand-file-name "~/plantuml.jar"))


(provide 'init-org)
