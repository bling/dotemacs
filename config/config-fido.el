;; -*- lexical-binding: t -*-

(setq icomplete-prospects-height 12)
(setq icomplete-scroll t)

(defun /fido/activate-as-switch-engine (on)
  (if on
      (fido-vertical-mode 1)
    (fido-vertical-mode -1)
    (fido-mode -1)
    (icomplete-mode -1)))

(when (eq dotemacs-switch-engine 'fido)
  (/fido/activate-as-switch-engine t))

(provide 'config-fido)
