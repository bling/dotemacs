;; -*- lexical-binding: t -*-

(let ((emacs-start-time (current-time)))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
                (message "[Emacs initialized in %.3fs]" elapsed)))))

(defvar dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files.")

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache (expand-file-name "eln-cache/" dotemacs-cache-directory)))

;; disable GC during init, gcmh will restore later
(setq gc-cons-threshold most-positive-fixnum)

;; suppress random startup noise
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

(when (fboundp #'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp #'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp #'menu-bar-mode) (menu-bar-mode -1))

;; exclude certain patterns from native comp since they always fail
(setq native-comp-jit-compilation-deny-list '("\\.el\\.gz\\'" "-*-loaddefs\\.el\\'"))
