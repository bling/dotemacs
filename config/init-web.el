(defvar js2-highlight-level 3)
(defvar js2-basic-offset 2)
(defvar js2-idle-timer-delay 1)

(require-package 'js2-mode)
(require-package 'ac-js2)
(after 'js2-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(require-package 'js2-refactor)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")


(require-package 'tern)
(require-package 'tern-auto-complete)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(after 'tern
  (require 'tern-auto-complete)
  (tern-ac-setup))


(require-package 'nodejs-repl)
(require-package 'coffee-mode)
(require-package 'jade-mode)
(require-package 'stylus-mode)


;; (require-package 'skewer-mode)
;; (skewer-setup)


(require-package 'rainbow-mode)
(require 'rainbow-mode)
(add-hook 'stylus-mode-hook (lambda () (rainbow-turn-on)))


(require-package 'emmet-mode)


(provide 'init-web)
