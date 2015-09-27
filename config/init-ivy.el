(require-package 'smex)
(setq smex-save-file (concat dotemacs-cache-directory "smex-items"))

(require-package 'ivy)
(require-package 'swiper)
(require-package 'counsel)

(setq ivy-use-virtual-buffers t)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

(defun my-ivy-projectile-buffers ()
  (interactive)
  (let ((files (if (projectile-project-p)
                   (delete-dups (append
                                 (projectile-project-buffer-files)
                                 (projectile-recentf-files)
                                 (projectile-current-project-files)))
                 recentf-list)))
    (ivy-read "Uber Buffers: " files
              :action
              (lambda (f)
                (with-ivy-window (if (projectile-project-p)
                                     (find-file (concat (projectile-project-root) f))
                                   (find-file f)))))))


(when (eq dotemacs-switch-engine 'ivy)
  (ivy-mode t)
  (global-set-key [remap execute-extended-command] #'counsel-M-x)
  (global-set-key [remap describe-function] #'counsel-describe-function)
  (global-set-key [remap describe-variable] #'counsel-describe-variable)
  (global-set-key [remap find-file] #'counsel-find-file))

(provide 'init-ivy)
