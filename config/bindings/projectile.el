(after 'evil
  (after "projectile-autoloads"
    (-define-keys evil-normal-state-map
      ("SPC p" #'projectile-command-map "projectile...")
      ("SPC /"
       (bind
        (if current-prefix-arg
            (cond
             ((executable-find "ag")  (call-interactively #'projectile-ag))
             ((executable-find "pt")  (call-interactively #'projectile-pt))
             ((executable-find "ack") (call-interactively #'projectile-ack))
             (t                       (call-interactively #'projectile-grep)))
          (cond
           ((eq dotemacs-switch-engine 'ivy)
            (cond
             ((executable-find "ag") (counsel-ag))
             ((executable-find "pt") (counsel-pt))))
           ((eq dotemacs-switch-engine 'helm)
            (helm-do-ag (projectile-project-root))))))
       "search..."))
    (-define-keys evil-normal-state-map
      ("C-p" (bind
              (cond ((eq dotemacs-switch-engine 'helm)
                     (call-interactively #'helm-projectile))
                    ((eq dotemacs-switch-engine 'ivy)
                     (if (projectile-project-p)
                         (call-interactively #'counsel-projectile-find-file)
                       (call-interactively #'counsel-projectile)))
                    (t
                     (call-interactively #'projectile-find-file-dwim)))))))
  )

(provide 'config-binding-projectile)
