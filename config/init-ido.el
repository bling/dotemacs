(setq ido-enable-prefix nil)
(setq ido-use-virtual-buffers t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'prompt)
(setq ido-use-filename-at-point 'guess)
(setq ido-save-directory-list-file (concat user-emacs-directory ".cache/ido.last"))

(require 'ido)
(ido-mode t)
(ido-everywhere t)

(require-package 'ido-ubiquitous)
(ido-ubiquitous-mode t)

(require-package 'flx-ido)
(flx-ido-mode t)

(require-package 'ido-vertical-mode)
(ido-vertical-mode)

(setq smex-save-file (concat user-emacs-directory ".cache/smex-items"))
(require-package 'smex)
(require 'smex)
(smex-initialize)

(provide 'init-ido)
