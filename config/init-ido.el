(setq ido-enable-prefix nil)
(setq ido-use-virtual-buffers t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-save-directory-list-file (concat dotemacs-cache-directory "ido.last"))

(after 'ido
  (require-package 'ido-ubiquitous)

  (require-package 'flx-ido)
  (flx-ido-mode t)

  (require-package 'ido-vertical-mode)
  (ido-vertical-mode))

(defun my-switch-engine-as-ido (on)
  (if on
      (progn
        (ido-mode t)
        (ido-everywhere t)
        (ido-ubiquitous-mode t))
    (ido-mode -1)
    (ido-everywhere -1)
    (ido-ubiquitous-mode -1)))

(when (eq dotemacs-switch-engine 'ido)
  (my-switch-engine-as-ido t))

(provide 'init-ido)
