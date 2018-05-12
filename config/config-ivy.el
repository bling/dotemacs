(require-package 'ivy)
(setq ivy-use-virtual-buffers t)
(setq ivy-virtual-abbreviate 'full)
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
(setq ivy-height 16)
(setq ivy-display-style 'fancy)
(setq ivy-count-format "[%d/%d] ")
(setq ivy-initial-inputs-alist nil)

(after 'lv
  (setq ivy-display-function
        (defun /ivy/display-function (text)
          (let ((lv-force-update t))
            (lv-message
             (if (string-match "\\`\n" text)
                 (substring text 1)
               text))))))

(require-package 'swiper)
(after 'swiper
  (defadvice swiper (before dotemacs activate)
    (setq gc-cons-threshold most-positive-fixnum))
  (defadvice swiper-all (before dotemacs activate)
    (setq gc-cons-threshold most-positive-fixnum)))


(require-package 'counsel)


(after "projectile-autoloads"
  (require-package 'counsel-projectile))


(defmacro /ivy/propertize (prefix face)
  `(lambda (str)
     (propertize str 'line-prefix ,prefix 'face ,face)))


(defun /ivy/mini ()
  (interactive)
  (setq gc-cons-threshold most-positive-fixnum)
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (project-files
          (if (projectile-project-p)
              (mapcar (/ivy/propertize "[ project ] " 'ivy-virtual) (projectile-current-project-files))
            nil))
         (bufnames (mapcar (/ivy/propertize "[ buffer  ] " 'ivy-remote) buffers))
         (recents (mapcar (/ivy/propertize "[ recent  ] " 'ivy-subdir) recentf-list)))
    (ivy-read "Search: " (append project-files bufnames recents)
              :action (lambda (f)
                        (with-ivy-window
                          (cond ((member f bufnames)
                                 (switch-to-buffer f))
                                ((file-exists-p f)
                                 (find-file f))
                                (t
                                 (find-file (concat (projectile-project-root) f)))))))))

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
