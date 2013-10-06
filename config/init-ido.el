(defvar ido-enable-prefix nil)
(defvar ido-use-virtual-buffers t)
(defvar ido-enable-flex-matching t)
(defvar ido-create-new-buffer 'prompt)
(defvar ido-use-filename-at-point 'guess)
(defvar ido-save-directory-list-file (concat user-emacs-directory ".cache/ido.last"))

(require 'ido)
(ido-mode t)
(ido-everywhere t)

(require-package 'ido-ubiquitous)
(ido-ubiquitous-mode t)

(require-package 'flx-ido)
(flx-ido-mode t)

(require-package 'ido-vertical-mode)
(ido-vertical-mode)

(defvar smex-save-file (concat user-emacs-directory ".cache/smex-items"))
(require-package 'smex)
(require 'smex)
(smex-initialize)

(provide 'init-ido)
