(require-package 'ivy)
(setq ivy-use-virtual-buffers t)
(setq ivy-virtual-abbreviate 'full)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(setq ivy-height 12)
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


(defun /ivy/mini ()
  (interactive)
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (bufnames (mapcar #'(lambda (buf) (propertize buf 'line-prefix "[Buffer] ")) buffers))
         (recents (mapcar #'(lambda (file) (propertize file 'line-prefix "[Recent] ")) recentf-list)))
    (ivy-read "Search: " (append bufnames recents)
              :action (lambda (f)
                        (with-ivy-window
                         (cond ((member f bufnames)
                                (switch-to-buffer f))
                               (t
                                (find-file f))))))))

(defun /ivy/everything ()
  (interactive)
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (base-files (append buffers recentf-list))
         (files (delete-dups (if (projectile-project-p)
                                 (append
                                  (projectile-project-buffer-files)
                                  (projectile-recentf-files)
                                  (projectile-current-project-files)
                                  base-files)
                               base-files))))
    (ivy-read "Uber Buffers: " files
              :action
              (lambda (f)
                (with-ivy-window
                 (cond ((member f buffers)
                        (switch-to-buffer f))
                       ((file-exists-p f)
                        (find-file f))
                       (t
                        (find-file (concat (projectile-project-root) f)))))))))

(defun /ivy/activate-as-switch-engine (on)
  (if on
      (progn
        (counsel-mode t)
        (ivy-mode t))
    (counsel-mode -1)
    (ivy-mode -1)))

(when (eq dotemacs-switch-engine 'ivy)
  (/ivy/activate-as-switch-engine t))

(provide 'config-ivy)
