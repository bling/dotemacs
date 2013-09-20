(ido-mode t)
(ido-everywhere t)

(setq ido-enable-flex-matching t
      ido-save-directory-list-file (expand-file-name ".cache/ido.last" my-user-emacs-directory))

(when (eval-when-compile (>= emacs-major-version 24))
  (require-package 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

(require-package 'flx-ido)
(flx-ido-mode t)

(require-package 'ido-vertical-mode)
(ido-vertical-mode)

(require-package 'smex)
(setq smex-save-file (expand-file-name ".cache/smex-items" my-user-emacs-directory))

(provide 'init-ido)
