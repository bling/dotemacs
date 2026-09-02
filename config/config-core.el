;; -*- lexical-binding: t -*-

(defgroup dotemacs-core nil
  "Configuration options for core Emacs functionality."
  :group 'dotemacs
  :prefix 'dotemacs-core)

(defcustom dotemacs-core/maximum-file-size (* 1024 1024 20)
  "The threshold for when `fundamental-mode' is used instead of the desired major mode."
  :type 'integer
  :group 'dotemacs-core)



;; server
(setq server-auth-dir (concat dotemacs-cache-directory "server"))

;; saveplace
(setq save-place-file (concat dotemacs-cache-directory "places"))
(save-place-mode 1)

;; savehist
(setq savehist-file (concat dotemacs-cache-directory "savehist"))
(setq savehist-additional-variables '(search-ring regexp-search-ring))
(setq savehist-autosave-interval 60)
(setq history-length 1000)
(savehist-mode 1)

;; desktop
(setq desktop-path `(,dotemacs-cache-directory))
(setq desktop-base-file-name "emacs.desktop")
(setq desktop-base-lock-name "emacs.desktop.lock")
(setq desktop-save t)
(desktop-save-mode 1)

;; recentf
(require 'recentf)
(setq recentf-save-file (concat dotemacs-cache-directory "recentf"))
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 500)
(setq recentf-auto-cleanup 300)
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
(add-to-list 'recentf-exclude ".*elpa.*autoloads\\.el\\'")
(recentf-mode 1)
(run-with-idle-timer 600 t #'recentf-save-list)

;; completion
(setq completion-ignore-case t)
(setq completions-format 'vertical)

;; imenu
(setq-default imenu-auto-rescan t)

;; narrowing
(put 'narrow-to-region 'disabled nil)

;; electricity
(setq electric-pair-skip-whitespace-chars '(32 9)) ;; don't complete pairs across newline
(electric-pair-mode t)
(add-hook 'minibuffer-setup-hook (defun /core/electric-pair-off () (electric-pair-mode -1)))
(add-hook 'minibuffer-exit-hook (defun /core/electric-pair-on () (electric-pair-mode t)))

;; dired
(setq dired-listing-switches "-alh")
(after 'dired
  (require 'dired-x))

;; url
(setq url-configuration-directory (concat dotemacs-cache-directory "url/"))

;; tramp
(setq tramp-persistency-file-name (concat dotemacs-cache-directory "tramp"))

;; compile
(setq compilation-always-kill t)
(setq compilation-ask-about-save nil)
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)
(add-hook 'compilation-filter-hook #'ansi-osc-compilation-filter)

;; bookmarks
(setq bookmark-default-file (concat dotemacs-cache-directory "bookmarks"))
(setq bookmark-save-flag 1)

;; fringe
(when (display-graphic-p)
  (fringe-mode 16))

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; re-builder
(setq reb-re-syntax 'string)

;; midnight
(midnight-mode 1)
(midnight-delay-set 'midnight-delay 0)

;; proced
(setq proced-auto-update-flag t)
(setq proced-auto-update-interval 1)
(setq proced-enable-color-flag t)

;; ibuffer
(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-use-other-window t)
(add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)

;; which-key
(setq which-key-idle-delay 0.2)
(setq which-key-min-display-lines 3)
(which-key-mode 1)

;; move auto-save to the cache
(let ((dir (expand-file-name (concat dotemacs-cache-directory "auto-save/"))))
  (setq auto-save-list-file-prefix (concat dir "saves-"))
  (setq auto-save-file-name-transforms `((".*" ,(concat dir "save-") t))))

;; multiple-backups
(setq backup-directory-alist `((".*" . ,(expand-file-name (concat dotemacs-cache-directory "backups/")))))
(setq backup-by-copying t)
(setq version-control t)
(setq kept-old-versions 0)
(setq kept-new-versions 20)
(setq delete-old-versions t)

;; better scrolling
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t
      scroll-margin 3)

;; uniquify
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-ignore-buffers-re "^\\*")
(setq uniquify-after-kill-buffer-p t)

(defun /core/do-not-kill-scratch-buffer ()
  (if (member (buffer-name (current-buffer))
              '("*scratch*" "*Messages*" "*Require Times*"))
      (progn
        (bury-buffer)
        nil)
    t))
(add-hook 'kill-buffer-query-functions '/core/do-not-kill-scratch-buffer)

;; https://stackoverflow.com/questions/2901541/which-coding-system-should-i-use-in-emacs
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
(prefer-coding-system 'utf-8)

(setq use-short-answers t)
(setq sentence-end-double-space nil)
(setq ring-bell-function 'ignore)
(setq mark-ring-max 64)
(setq global-mark-ring-max 128)
(setq save-interprogram-paste-before-kill t)
(setq create-lockfiles nil)
(setq echo-keystrokes 0.01)
(setq initial-major-mode 'emacs-lisp-mode)
(setq eval-expression-print-level nil)
(setq read-extended-command-predicate #'command-completion-default-include-p)
(setq-default indent-tabs-mode nil)

(global-so-long-mode 1)
(global-visual-line-mode)
(xterm-mouse-mode t)
(which-function-mode t)
(blink-cursor-mode -1)
(global-auto-revert-mode t)
(electric-indent-mode t)
(transient-mark-mode t)
(delete-selection-mode t)

(defun /core/find-file-hook ()
  (when (or (and (buffer-file-name)
                 (string-match-p "\\.min\\." (buffer-file-name)))
            (> (buffer-size) dotemacs-core/maximum-file-size))
    (buffer-disable-undo)
    (when (bound-and-true-p display-line-numbers-mode)
      (display-line-numbers-mode -1))
    (fundamental-mode)
    (message "Large file detected. Switched to fundamental mode.")))
(add-hook 'find-file-hook #'/core/find-file-hook)

(provide 'config-core)
