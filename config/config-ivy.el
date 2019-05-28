(require-package 'ivy)
(setq ivy-use-virtual-buffers t)
(setq ivy-virtual-abbreviate 'full)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(setq ivy-height 16)
(setq ivy-display-style 'fancy)
(setq ivy-count-format "[%d/%d] ")
(setq ivy-initial-inputs-alist nil)


(require-package 'swiper)
(after 'swiper
  (defadvice swiper (before dotemacs activate)
    (setq gc-cons-threshold most-positive-fixnum))
  (defadvice swiper-all (before dotemacs activate)
    (setq gc-cons-threshold most-positive-fixnum)))


(require-package 'counsel)


(after "projectile-autoloads"
  (require-package 'counsel-projectile))



(after 'ivy
  (defvar /ivy/mini/buffers nil)
  (defvar /ivy/mini/project-files nil)
  (defvar /ivy/mini/recentf-files nil)

  (defun /ivy/everything ()
    (interactive)
    (setq gc-cons-threshold most-positive-fixnum)
    (setq /ivy/mini/buffers (mapcar #'buffer-name (buffer-list)))
    (setq /ivy/mini/project-files (if (projectile-project-p) (projectile-current-project-files) nil))
    (setq /ivy/mini/recentf-files recentf-list)
    (let ((ivy-dynamic-exhibit-delay-ms 100)
          (candidates (append /ivy/mini/buffers /ivy/mini/project-files /ivy/mini/recentf-files)))
      (ivy-read
       "Search: "
       (lambda (input)
         (ivy--filter input candidates))
       :dynamic-collection t
       :caller '/ivy/mini
       :action (lambda (f)
                 (with-ivy-window
                   (cond ((member f /ivy/mini/buffers)
                          (switch-to-buffer f))
                         ((file-exists-p f)
                          (find-file f))
                         (t
                          (find-file (concat (projectile-project-root) f)))))))))

  (ivy-set-display-transformer
   '/ivy/mini
   (lambda (candidate)
     (cond
      ((member candidate /ivy/mini/buffers)
       (concat " buffer      " (propertize candidate 'face 'ivy-virtual)))
      ((member candidate /ivy/mini/project-files)
       (concat " project     " (propertize candidate 'face 'ivy-remote)))
      ((member candidate /ivy/mini/recentf-files)
       (concat " recentf     " (propertize candidate 'face 'ivy-subdir)))))))



(defun /ivy/activate-as-switch-engine (on)
  (if on
      (progn
        (counsel-mode t)
        (counsel-projectile-mode t)
        (ivy-mode t))
    (counsel-mode -1)
    (counsel-projectile-mode -1)
    (ivy-mode -1)))

(when (eq dotemacs-switch-engine 'ivy)
  (/ivy/activate-as-switch-engine t))

(provide 'config-ivy)
