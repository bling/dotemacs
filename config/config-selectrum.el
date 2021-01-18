;; -*- lexical-binding: t -*-

(defun /selectrum/init ()
  (require-package 'selectrum)
  (setq selectrum-num-candidates-displayed 16)
  (setq selectrum-count-style 'current/matches)

  (require-package 'selectrum-prescient)
  (require-package 'marginalia)

  (require-package 'consult)
  (setq consult-project-root-function #'projectile-project-root)
  (setq consult-async-default-split nil)

  (require-package 'consult-selectrum)
  (require 'consult-selectrum)

  (require-package 'consult-flycheck))



(defun /selectrum/activate-as-switch-engine (on)
  (/selectrum/init)
  (if on
      (progn
        (setq projectile-completion-system 'default)
        (selectrum-mode t)
        (selectrum-prescient-mode t)
        (prescient-persist-mode t)
        (marginalia-mode t))
    (marginalia-mode -1)
    (prescient-persist-mode -1)
    (selectrum-prescient-mode -1)
    (selectrum-mode -1)))

(when (eq dotemacs-switch-engine 'selectrum)
  (/selectrum/activate-as-switch-engine t))

(provide 'config-selectrum)
