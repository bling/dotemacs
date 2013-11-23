(require 'org)
(setq org-default-notes-file "~/.notes.org"
      org-log-done t)


(require 'ob)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)))

(setq org-plantuml-jar-path (expand-file-name "~/plantuml.jar"))

(provide 'init-org)
