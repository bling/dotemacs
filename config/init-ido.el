(require 'ido)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'prompt
      ido-use-faces nil ;; disabled so we can see flx highlights
      ido-use-filename-at-point 'guess
      ido-save-directory-list-file (concat user-emacs-directory ".cache/ido.last"))

(ido-mode t)
(ido-everywhere t)

(require-package 'ido-ubiquitous)
(ido-ubiquitous-mode t)

(require-package 'flx-ido)
(flx-ido-mode t)

(require-package 'ido-vertical-mode)
(ido-vertical-mode)

(require-package 'smex)
(require 'smex)
(setq smex-save-file (concat user-emacs-directory ".cache/smex-items"))
(smex-initialize)

(provide 'init-ido)
