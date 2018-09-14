(require-package 'helm)


(setq helm-bookmark-show-location t)
(setq helm-buffer-max-length 40)


(after 'helm-source
  (defun /helm/make-source (f &rest args)
    (let ((source-type (cadr args))
          (props (cddr args)))
      (unless (child-of-class-p source-type 'helm-source-async)
        (plist-put props :fuzzy-match t))
      (apply f args)))
  (advice-add 'helm-make-source :around '/helm/make-source))


(after 'helm
  (require-package 'helm-descbinds)


  (require-package 'helm-flx)
  (helm-flx-mode t)


  (require-package 'helm-dash)
  (setq helm-dash-browser-func 'eww)


  (require-package 'helm-ag)
  (setq helm-ag-fuzzy-match t)
  (setq helm-ag-use-agignore t)
  (setq helm-ag-ignore-patterns dotemacs-globally-ignored-directories)
  (after 'helm-ag
    (cond ((executable-find "ag")
           t)
          ((executable-find "pt")
           (setq helm-ag-base-command "pt -e --nogroup --nocolor"))
          ((executable-find "ack")
           (setq helm-ag-base-command "ack --nogroup --nocolor"))))


  (setq helm-adaptive-history-file (concat dotemacs-cache-directory "helm-adaptive-history"))
  (helm-adaptive-mode t)


  (setq helm-swoop-pre-input-function #'ignore)
  (setq helm-swoop-use-line-number-face t)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-speed-or-color t)
  (setq helm-swoop-use-fuzzy-match t)
  (require-package 'helm-swoop)


  (require-package 'helm-projectile)


  (defun /helm/everything ()
    (interactive)
    (require 'helm-projectile)
    (if (projectile-project-p)
        (let ((helm-mini-default-sources
               (append
                '(helm-source-projectile-recentf-list
                  helm-source-projectile-files-list)
                helm-mini-default-sources)))
          (helm-mini))
      (helm-mini)))


  ;; take between 10-30% of screen space
  (setq helm-autoresize-min-height 10)
  (setq helm-autoresize-max-height 30)
  (helm-autoresize-mode t))

(defun /helm/activate-as-switch-engine (on)
  (if on
      (progn
        (global-set-key [remap execute-extended-command] #'helm-M-x)
        (global-set-key [remap find-file] #'helm-find-files)
        (helm-mode t))
    (global-set-key [remap execute-extended-command] nil)
    (global-set-key [remap find-file] nil)
    (helm-mode -1)))

(when (eq dotemacs-switch-engine 'helm)
  (/boot/delayed-init
   (/helm/activate-as-switch-engine t)))

(provide 'config-helm)
