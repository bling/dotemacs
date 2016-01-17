(require-package 'helm)


(setq helm-bookmark-show-location t)


(after 'helm-source
  (defun my-helm-make-source (f &rest args)
    (nconc args '(:fuzzy-match t))
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


  (setq helm-swoop-pre-input-function #'ignore)
  (setq helm-swoop-use-line-number-face t)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-speed-or-color t)
  (setq helm-swoop-use-fuzzy-match t)
  (require-package 'helm-swoop)
  (after 'helm-swoop
    (after 'evil
      (defadvice helm-swoop--edit (after helm-swoop--edit-advice activate)
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


(provide 'init-helm)
