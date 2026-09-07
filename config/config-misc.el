;; -*- lexical-binding: t -*-

(use-package pcache
  :init
  (setq pcache-directory (concat dotemacs-cache-directory "pcache/")))

(use-package request
  :init
  (setq request-storage-directory (concat dotemacs-cache-directory "request/")))

(use-package undo-fu)
(use-package undo-fu-session
  :init
  (setq undo-fu-session-directory (concat dotemacs-cache-directory "undo-fu/"))
  :config
  (global-undo-fu-session-mode))

(use-package multiple-cursors
  :defer t
  :init
  (setq mc/list-file (concat dotemacs-cache-directory "mc-lists.el")))
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook #'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook #'evil-normal-state))

(use-package dumb-jump)
(after 'xref
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate t)
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read))

(use-package wgrep :defer t)

(when (executable-find "rg")
  (use-package ripgrep :defer t))

(use-package avy :defer t)

(use-package expand-region :defer t)

(use-package crux :defer t)

(use-package aggressive-indent
  :hook (emacs-lisp-mode lisp-mode))

(use-package rainbow-delimiters
  :hook (prog-mode))

(use-package vlf
  :init
  (setq vlf-application 'dont-ask))

(use-package dash-docs
  :defer t
  :init
  (setq dash-docs-browser-func #'eww))

(use-package apheleia
  :init
  (setq apheleia-formatters-respect-indent-level nil)
  :config
  (apheleia-global-mode t))

(use-package gcmh
  :config
  (gcmh-mode))

(provide 'config-misc)
