;; -*- lexical-binding: t -*-

(setq ido-enable-prefix nil)
(setq ido-use-virtual-buffers t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-save-directory-list-file (concat dotemacs-cache-directory "ido.last"))

(after 'ido
  (use-package flx-ido :demand t
    :config
    (flx-ido-mode t))

  (use-package ido-vertical-mode :demand t
    :config
    (ido-vertical-mode)))

(defun /ido/activate-as-switch-engine (on)
  (if on
      (progn
        (ido-mode t)
        (ido-everywhere t)
        )
    (ido-mode -1)
    (ido-everywhere -1)))

(when (eq dotemacs-switch-engine 'ido)
  (/ido/activate-as-switch-engine t))

(provide 'config-ido)
