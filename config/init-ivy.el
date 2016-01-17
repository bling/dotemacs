(require-package 'swiper)
(require-package 'counsel)

(setq ivy-use-virtual-buffers t)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(setq ivy-height 12)
(setq ivy-display-style 'fancy)

(defun my-ivy-kill-ring ()
  (interactive)
  (ivy-read "Insert: " kill-ring :action #'insert))

(defun my-ivy-mini ()
  (interactive)
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (bufnames (mapcar #'(lambda (buf) (concat "Buffer: " buf)) buffers))
         (recents (mapcar #'(lambda (file) (concat "Recent: " file)) recentf-list)))
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

(when (eq dotemacs-switch-engine 'ivy)
  (ivy-mode t)
  (global-set-key [remap execute-extended-command] #'counsel-M-x)
  (global-set-key [remap describe-function] #'counsel-describe-function)
  (global-set-key [remap describe-variable] #'counsel-describe-variable)
  (global-set-key [remap find-file] #'counsel-find-file))

(provide 'init-ivy)
