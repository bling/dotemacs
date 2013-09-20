;;; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".cache/places" my-user-emacs-directory))

;;; store all backup files in a directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name "./cache/backups" my-user-emacs-directory))))

;;; make backups even for VCS files
(setq vc-make-backup-files t)

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(global-hl-line-mode)
(global-linum-mode t)
(setq linum-format "%4d "
      linum-delay t)

(show-paren-mode t)

(provide 'init-core)
