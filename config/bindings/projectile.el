(after "projectile-autoloads"
  (/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
    ("p" #'projectile-command-map "projectile...")
    ("/"
     (bind
      (setq gc-cons-threshold most-positive-fixnum)
      (if current-prefix-arg
          (cond
           ((executable-find "rg")  (call-interactively #'projectile-ripgrep))
           ((executable-find "ag")  (call-interactively #'projectile-ag))
           ((executable-find "pt")  (call-interactively #'projectile-pt))
           ((executable-find "ack") (call-interactively #'projectile-ack))
           (t                       (call-interactively #'projectile-grep)))
        (cond
         ((eq dotemacs-switch-engine 'ivy)
          (cond
           ((executable-find "rg") (counsel-projectile-rg))
           ((executable-find "ag") (counsel-projectile-ag))
           ((executable-find "pt") (counsel-pt))
           ((executable-find "ack") (counsel-ack))
           (t (counsel-grep))))
         ((eq dotemacs-switch-engine 'helm)
          (cond
           ((executable-find "rg") (helm-projectile-rg))
           ((executable-find "ag") (helm-projectile-ag))
           ((executable-find "ack") (helm-projectile-ack))
           (t (helm-projectile-grep)))))))
     "search...")))

(after 'evil
  (/bindings/define-keys evil-normal-state-map
    ("C-p" (bind
            (setq gc-cons-threshold most-positive-fixnum)
            (cond ((eq dotemacs-switch-engine 'helm)
                   (call-interactively #'helm-projectile))
                  ((eq dotemacs-switch-engine 'ivy)
                   (call-interactively #'counsel-projectile))
                  (t
                   (call-interactively #'projectile-find-file-dwim)))))))

(provide 'config-bindings-projectile)
