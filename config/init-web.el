(defvar js2-highlight-level 3)
(defvar js2-basic-offset 2)
(defvar js2-idle-timer-delay 1)


(require-package 'js2-mode)
(after 'js2-mode-autoloads
  (setq auto-mode-alist (cons '("\\.js\\'" . js2-mode) auto-mode-alist)))


(require-package 'ac-js2)


(require-package 'tern)
(require-package 'tern-auto-complete)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(after 'tern
  (require 'tern-auto-complete)
  (tern-ac-setup))


(require-package 'nodejs-repl)


(require-package 'coffee-mode)


(require-package 'jade-mode)


(require-package 'skewer-mode)
(skewer-setup)


(provide 'init-web)
