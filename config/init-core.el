(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(unless (display-graphic-p)
  (menu-bar-mode -1))

(setq inhibit-splash-screen t
      inhibit-startup-message t)

(setq custom-file (concat my-user-emacs-directory "config/custom.el"))
(unless (not (file-exists-p custom-file))
  (load custom-file))

;; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat my-user-emacs-directory ".cache/places"))

;; store all backup files in the cache
(setq backup-directory-alist
      `(("." . ,(concat my-user-emacs-directory ".cache/backups"))))

;; make backups even for VCS files
(setq vc-make-backup-files t)

(setq auto-save-list-file-prefix
      (concat my-user-emacs-directory ".cache/auto-save-list/.saves-"))

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(global-hl-line-mode)
(global-linum-mode t)
(setq linum-format "%4d "
      linum-delay t)

(defalias 'yes-or-no-p 'y-or-n-p)
(xterm-mouse-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(provide 'init-core)
