;; -*- lexical-binding: t -*-

(after 'helm-source
  (defun /helm/make-source (f &rest args)
    (let* ((name (car args))
           (source-type (cadr args))
           (props (cddr args)))
      (unless (child-of-class-p source-type 'helm-source-async)
        (setq props (plist-put (copy-sequence props) :fuzzy-match t)))
      (apply f name source-type props)))
  (advice-add 'helm-make-source :around '/helm/make-source))


(after 'helm
  (setq helm-bookmark-show-location t)
  (setq helm-buffer-max-length 40)

  (require-package 'helm-descbinds)
  (require-package 'helm-dash)

  (setq helm-adaptive-history-file (concat dotemacs-cache-directory "helm-adaptive-history"))
  (helm-adaptive-mode t)


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
  (require-package 'helm)

  (if on
      (progn
        (setq projectile-completion-system 'helm)
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
