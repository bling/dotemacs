;; -*- lexical-binding: t -*-

(defvar /helm/initialized nil)

(defun /helm/initialize ()
  (use-package helm
    :init
    (setq helm-adaptive-history-file (concat dotemacs-cache-directory "helm-adaptive-history"))
    (setq helm-bookmark-show-location t)
    (setq helm-buffer-max-length 40)
    (setq helm-autoresize-min-height 10)
    (setq helm-autoresize-max-height 30)
    :config
    (defun /helm/make-source (f &rest args)
      (let* ((name (car args))
             (source-type (cadr args))
             (props (cddr args)))
        (unless (child-of-class-p source-type 'helm-source-async)
          (setq props (plist-put (copy-sequence props) :fuzzy-match t)))
        (apply f name source-type props)))
    (advice-add 'helm-make-source :around '/helm/make-source)

    (helm-adaptive-mode t)
    (helm-autoresize-mode t))

  (use-package helm-dash)
  (use-package helm-descbinds))

(defun /helm/activate-as-switch-engine (on)
  (unless /helm/initialized
    (setq /helm/initialized t)
    (/helm/initialize))
  (if on
      (progn
        (global-set-key [remap execute-extended-command] #'helm-M-x)
        (global-set-key [remap find-file] #'helm-find-files)
        (helm-mode t))
    (global-set-key [remap execute-extended-command] nil)
    (global-set-key [remap find-file] nil)
    (helm-mode -1)))

(when (eq dotemacs-switch-engine 'helm)
  (/helm/activate-as-switch-engine t))

(provide 'config-helm)
