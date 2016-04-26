(require-package 'swiper)
(after 'swiper
  (defadvice swiper (before dotemacs activate)
    (setq gc-cons-threshold most-positive-fixnum))
  (defadvice swiper-all (before dotemacs activate)
    (setq gc-cons-threshold most-positive-fixnum)))


(require-package 'counsel)
(after 'counsel
  (cond ((executable-find "ag")
         t)
        ((executable-find "pt")
         (setq counsel-ag-base-command "pt -e --nogroup --nocolor %S"))
        ((executable-find "ack")
         (setq counsel-ag-base-command "ack --nogroup --nocolor %S"))))


(setq ivy-use-virtual-buffers t)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(setq ivy-height 12)
(setq ivy-display-style 'fancy)

(defun my-ivy-mini ()
  (interactive)
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (bufnames (mapcar #'(lambda (buf) (concat (propertize "Buffer: " 'face 'error) buf)) buffers))
         (recents (mapcar #'(lambda (file) (concat (propertize "Recent: " 'face 'error) file)) recentf-list)))
    (ivy-read "Search: " (append bufnames recents)
              :action (lambda (f)
                        (with-ivy-window
                          (cond ((member f bufnames)
                                 (switch-to-buffer (substring f 8)))
                                (t
                                 (find-file (substring f 8)))))))))

(defun my-ivy-everything ()
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

(defun my-switch-engine-as-ivy (on)
  (if on
      (progn
        (global-set-key [remap execute-extended-command] #'counsel-M-x)
        (global-set-key [remap find-file] #'counsel-find-file)
        (global-set-key [remap describe-function] #'counsel-describe-function)
        (global-set-key [remap describe-variable] #'counsel-describe-variable)
        (ivy-mode t))
    (global-set-key [remap execute-extended-command] nil)
    (global-set-key [remap find-file] nil)
    (global-set-key [remap describe-function] nil)
    (global-set-key [remap describe-variable] nil)
    (ivy-mode -1)))

(when (eq dotemacs-switch-engine 'ivy)
  (my-switch-engine-as-ivy t))

(provide 'init-ivy)
