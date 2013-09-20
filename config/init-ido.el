(ido-mode t)
(ido-everywhere t)

(setq ido-enable-flex-matching t
      ido-save-directory-list-file (concat my-user-emacs-directory ".cache/ido.last"))

(require-package 'ido-ubiquitous)
(ido-ubiquitous-mode t)

(require-package 'flx-ido)
(flx-ido-mode t)

(require-package 'ido-vertical-mode)
(ido-vertical-mode)

(require-package 'smex)
(setq smex-save-file (concat my-user-emacs-directory ".cache/smex-items"))

(provide 'init-ido)
