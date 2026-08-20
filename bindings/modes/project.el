;; -*- lexical-binding: t -*-

(require 'project)

(global-set-key (kbd "C-c p") project-prefix-map)

(defun /transients/project/search ()
  (interactive)
  (if current-prefix-arg
      (cond
       ((executable-find "rg")
        (ripgrep-regexp
         (read-regexp "Ripgrep for" 'grep-tag-default 'grep-regexp-history)
         (if-let* ((pr (project-current)))
             (project-root pr)
           default-directory)))
       (t
        (call-interactively #'project-find-regexp)))
    (cond
     ((eq dotemacs-switch-engine 'consult)
      (cond
       ((executable-find "rg")
        (consult-ripgrep))
       (t
        (consult-grep))))
     ((eq dotemacs-switch-engine 'helm)
      (helm-do-grep-ag-project))
     (t
      (call-interactively #'project-find-regexp)))))

(defun /transients/project/ctrl+p ()
  (interactive)
  (cond
   ((eq dotemacs-switch-engine 'consult)
    (call-interactively #'consult-project-extra-find))
   ((eq dotemacs-switch-engine 'helm)
    (call-interactively #'helm-mini))
   (t
    (call-interactively #'project-find-file))))

(/bindings/define-prefix-keys /bindings/normal-space-leader-map "SPC"
  ("p" project-prefix-map "project...")
  ("/" #'/transients/project/search "search..."))

(after 'evil
  (/bindings/define-keys evil-normal-state-map
    ("C-p" #'/transients/project/ctrl+p)))

(provide 'config-bindings-project)
