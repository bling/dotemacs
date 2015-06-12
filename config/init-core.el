(require 'server)
(unless (server-running-p)
  (server-start))


;; move cursor to the last position upon open
(require 'saveplace)
(setq save-place-file (concat dotemacs-cache-directory "places"))
(setq-default save-place t)


;; minibuffer history
(require 'savehist)
(setq savehist-file (concat dotemacs-cache-directory "savehist")
      savehist-additional-variables '(search ring regexp-search-ring)
      savehist-autosave-interval 60
      history-length 1000)
(savehist-mode t)


;; recent files
(require 'recentf)
(setq recentf-save-file (concat dotemacs-cache-directory "recentf"))
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 500)
(setq recentf-auto-cleanup 300)
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
(recentf-mode t)
(run-with-timer 1800 1800 'recentf-save-list)


;; pcomplete
(setq pcomplete-ignore-case t)


;; imenu
(setq-default imenu-auto-rescan t)


;; narrowing
(put 'narrow-to-region 'disabled nil)


;; dired
(require 'dired-x)


;; comint
(after 'comint
  (defun my-toggle-comint-scroll-to-bottom-on-output ()
    (interactive)
    (if comint-scroll-to-bottom-on-output
        (setq comint-scroll-to-bottom-on-output nil)
      (setq comint-scroll-to-bottom-on-output t))))


;; compile
(setq compilation-always-kill t)
(setq compilation-ask-about-save nil)
(add-hook 'compilation-filter-hook
          (lambda ()
            (when (eq major-mode 'compilation-mode)
              (require 'ansi-color)
              (let ((inhibit-read-only t))
                (ansi-color-apply-on-region (point-min) (point-max))))))


;; bookmarks
(setq bookmark-default-file (concat dotemacs-cache-directory "bookmarks"))
(setq bookmark-save-flag 1) ;; save after every change


;; fringe
(when (display-graphic-p)
  (fringe-mode 16))


;; ediff
(setq ediff-split-window-function 'split-window-horizontally) ;; side-by-side diffs
(setq ediff-window-setup-function 'ediff-setup-windows-plain) ;; no extra frames


;; re-builder
(setq reb-re-syntax 'string) ;; fix backslash madness


;; clean up old buffers periodically
(require 'midnight)
(midnight-delay-set 'midnight-delay 0)


;; ibuffer
(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)


;; store most files in the cache
(setq backup-directory-alist
      `((".*" . ,(concat dotemacs-cache-directory "backups")))
      auto-save-file-name-transforms
      `((".*" ,(concat dotemacs-cache-directory "backups") t))
      auto-save-list-file-prefix
      (concat dotemacs-cache-directory "auto-save-list/saves-"))


;; better scrolling
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t
      scroll-margin 3)


;; better buffer names for duplicates
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-ignore-buffers-re "^\\*" ; leave special buffers alone
      uniquify-after-kill-buffer-p t)


(defun my-do-not-kill-scratch-buffer ()
  (if (member (buffer-name (current-buffer))
              '("*scratch*" "*Messages*" "*Require Times*"))
      (progn
        (bury-buffer)
        nil)
    t))
(add-hook 'kill-buffer-query-functions 'my-do-not-kill-scratch-buffer)


(defalias 'yes-or-no-p 'y-or-n-p)


(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


(setq sentence-end-double-space nil)
(setq delete-by-moving-to-trash t)
(setq ring-bell-function 'ignore)
(setq mark-ring-max 64)
(setq global-mark-ring-max 128)
(setq save-interprogram-paste-before-kill t)
(setq create-lockfiles nil)
(setq echo-keystrokes 0.01)
(setq gc-cons-threshold 10000000)
(setq initial-major-mode 'emacs-lisp-mode)
(setq eval-expression-print-level nil)
(setq-default indent-tabs-mode nil)

(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)


(xterm-mouse-mode t)
(which-function-mode t)
(blink-cursor-mode -1)
(global-auto-revert-mode t)
(electric-indent-mode t)
(electric-pair-mode t)
(transient-mark-mode t)
(delete-selection-mode t)
(random t) ;; seed


(defun my-find-file-check-large-file ()
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (when (fboundp #'undo-tree-mode)
      (undo-tree-mode -1))
    (fundamental-mode)))


(add-hook 'find-file-hook (lambda ()
                            (unless (eq major-mode 'org-mode)
                              (setq show-trailing-whitespace t))))
(add-hook 'find-file-hook #'visual-line-mode)
(add-hook 'find-file-hook #'my-find-file-check-large-file)

(provide 'init-core)
