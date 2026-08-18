;; -*- lexical-binding: t -*-


(require-package 'pcache)
(setq pcache-directory (concat dotemacs-cache-directory "pcache/"))


(require-package 'request)
(setq request-storage-directory (concat dotemacs-cache-directory "request/"))


(require-package 'undo-fu)
(require-package 'undo-fu-session)
(setq undo-fu-session-directory (concat dotemacs-cache-directory "undo-fu/"))
(require 'undo-fu-session)
(global-undo-fu-session-mode)


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
