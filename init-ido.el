(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)

;;; this breaks evil
;;; (when (eval-when-compile (>= emacs-major-version 24))
;;;   (require-package 'ido-ubiquitous)
;;;   (ido-ubiquitous-mode t))

(require-package 'flx-ido)
(flx-ido-mode t)

(require-package 'ido-vertical-mode)
(ido-vertical-mode)

(require-package 'smex)
(global-set-key (kbd "M-x") 'smex)

(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-c C-m") 'smex)

(provide 'init-ido)
