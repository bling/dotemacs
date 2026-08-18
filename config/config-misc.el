;; -*- lexical-binding: t -*-

(defgroup dotemacs-misc nil
  "Configuration options for miscellaneous."
  :group 'dotemacs
  :prefix 'dotemacs-misc)

(defcustom dotemacs-misc/inhibit-undo-tree
  t
  "If non-nil, disables undo-tree and replaces it with desktop-mode."
  :type 'boolean
  :group 'dotemacs-evil)



(require-package 'pcache)
(setq pcache-directory (concat dotemacs-cache-directory "pcache/"))


(require-package 'request)
(setq request-storage-directory (concat dotemacs-cache-directory "request/"))


(require-package 'undo-tree)
(if dotemacs-misc/inhibit-undo-tree
    (after 'evil-integration
      (global-undo-tree-mode -1)

      (defun /misc/append-buffer-undo-list (alist)
        (append `(,(cons 'buffer-undo-list buffer-undo-list)) alist))

      ;; due to a bug, buffer-undo-list is not included here, so we have to patch it in
      (advice-add #'buffer-local-variables :filter-return #'/misc/append-buffer-undo-list)

      (add-to-list 'desktop-locals-to-save 'buffer-undo-list))
  (require-package 'undo-tree)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-enable-undo-in-region nil)
  (setq undo-tree-history-directory-alist
        `(("." . ,(concat dotemacs-cache-directory "undo/"))))
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t)
  (global-undo-tree-mode))


(require-package 'multiple-cursors)
(setq mc/list-file (concat dotemacs-cache-directory "mc-lists.el"))
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook #'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook #'evil-normal-state))


(require-package 'dumb-jump)
(after 'xref
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate t)
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read))


(require-package 'wgrep)


(when (executable-find "rg")
  (require-package 'ripgrep))


(require-package 'avy)


(require-package 'expand-region)


(require-package 'aggressive-indent)
(require 'aggressive-indent)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'lisp-mode-hook #'aggressive-indent-mode)


(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


(require-package 'vlf)
(setq vlf-application 'dont-ask)
(require 'vlf-setup)


(require-package 'dash-docs)
(setq dash-docs-browser-func #'eww)


(require-package 'apheleia)
(setq apheleia-formatters-respect-indent-level nil)
(apheleia-global-mode t)


(provide 'config-misc)
