(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(unless (display-graphic-p)
  (menu-bar-mode -1))

(setq inhibit-splash-screen t
      inhibit-startup-message t)

(add-to-list 'load-path my-user-emacs-directory)
(add-to-list 'load-path (expand-file-name "config" my-user-emacs-directory))

(setq custom-file (expand-file-name "config/custom.el" my-user-emacs-directory))
(unless (not (file-exists-p custom-file))
  (load custom-file))

;;; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".cache/places" my-user-emacs-directory))

;;; store all backup files in the cache
(setq backup-directory-alist
      `(("." . ,(expand-file-name ".cache/backups" my-user-emacs-directory))))

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

(defalias 'yes-or-no-p 'y-or-n-p)
(xterm-mouse-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(provide 'init-core)
