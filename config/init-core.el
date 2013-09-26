;;; configuration for things included in the default Emacs distribution

(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(unless (display-graphic-p)
  (menu-bar-mode -1))

(setq inhibit-splash-screen t
      inhibit-startup-message t)

(setq custom-file (concat user-emacs-directory "config/custom.el"))
(unless (not (file-exists-p custom-file))
  (load custom-file))

;; move cursor to the last position upon open
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory ".cache/places"))
(setq-default save-place t)

(require 'recentf)
(setq recentf-save-file (concat user-emacs-directory ".cache/recentf"))
(recentf-mode +1)

(require 'eshell)
(setq eshell-directory-name (concat user-emacs-directory ".cache/eshell"))

;; make backups even for VCS files
(setq vc-make-backup-files t)

;; store most files in the cache
(setq backup-directory-alist `((".*" . ,(concat user-emacs-directory ".cache/backups")))
      auto-save-list-file-prefix (concat user-emacs-directory ".cache/auto-save-list/.saves-"))

(global-hl-line-mode t)
(global-linum-mode t)
(setq linum-format "%4d "
      linum-delay t
      linum-eager nil)

;; better scrolling
(setq scroll-margin 3
      scroll-conservatively 9999
      scroll-preserve-screen-position t)

(defalias 'yes-or-no-p 'y-or-n-p)
(xterm-mouse-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(provide 'init-core)
