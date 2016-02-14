(require-package 'helm)


(setq helm-bookmark-show-location t)
(setq helm-buffer-max-length 40)


(after 'helm-source
  (defun my-helm-make-source (f &rest args)
    (let ((source-type (cadr args))
          (props (cddr args)))
      (unless (eq source-type 'helm-source-async)
        (plist-put props :fuzzy-match t)))
    (apply f args))
  (advice-add 'helm-make-source :around 'my-helm-make-source))


(after 'helm
  (require-package 'helm-descbinds)


  (require-package 'helm-flx)
  (helm-flx-mode t)


  (require-package 'helm-fuzzier)
  (helm-fuzzier-mode t)


  (require-package 'helm-dash)
  (setq helm-dash-browser-func 'eww)


  (require-package 'helm-ag)
  (after 'helm-ag
    (cond ((executable-find "ag")
           t)
          ((executable-find "pt")
           (setq helm-ag-base-command "pt -e --nogroup --nocolor"))
          ((executable-find "ack")
           (setq helm-ag-base-command "ack --nogroup --nocolor"))))


  (setq helm-swoop-pre-input-function #'ignore)
  (setq helm-swoop-use-line-number-face t)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-speed-or-color t)
  (setq helm-swoop-use-fuzzy-match t)
  (require-package 'helm-swoop)
  (after 'helm-swoop
    (after 'evil
      (defadvice helm-swoop--edit (after dotemacs activate)
        (turn-on-evil-mode))))


  (after "projectile-autoloads"
    (require-package 'helm-projectile))


  (after "company-autoloads"
    (require-package 'helm-company))


  ;; take between 10-30% of screen space
  (setq helm-autoresize-min-height 10)
  (setq helm-autoresize-max-height 30)
  (helm-autoresize-mode t))


(when (eq dotemacs-switch-engine 'helm)
  (delayed-init
   (helm-mode t)
   (global-set-key [remap execute-extended-command] #'helm-M-x)
   (global-set-key [remap find-file] #'helm-find-files)))
