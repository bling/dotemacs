(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(unless (display-graphic-p)
  (menu-bar-mode -1))

(setq inhibit-splash-screen t
      inhibit-startup-message t)

(setq custom-file (concat user-emacs-directory "config/custom.el"))
(unless (not (file-exists-p custom-file))
  (load custom-file))

;; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)

;; make backups even for VCS files
(setq vc-make-backup-files t)

;; store most files in the cache
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory ".cache/backups")))
      save-place-file (concat user-emacs-directory ".cache/places")
      auto-save-list-file-prefix (concat user-emacs-directory ".cache/auto-save-list/.saves-")
      eshell-directory-name (concat user-emacs-directory ".cache/eshell"))

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
