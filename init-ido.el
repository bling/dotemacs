(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)

(when (eval-when-compile (>= emacs-major-version 24))
  (require-package 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

(provide 'init-ido)
