(add-to-list 'load-path user-emacs-directory)

(setq custom-file "~/.emacs.d/custom.el")
(unless (not (file-exists-p custom-file))
  (load custom-file))

; store all backup files in a directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                  (concat user-emacs-directory ".cache/backups")))))

; make backups even for VCS files
(setq vc-make-backup-files t)

; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".cache/places" user-emacs-directory))

(require 'init-packages)
(require-package 'evil)

(require 'init-evil)
