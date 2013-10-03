(defvar js2-highlight-level 3)
(require-package 'js2-mode)
(after 'js2-mode-autoloads
  (setq auto-mode-alist (cons '("\\.js\\'" . js2-mode) auto-mode-alist)))


(require-package 'ac-js2)
(after 'ac-js2-autoloads
  (after 'auto-complete-autoloads
    (ac-js2-setup-auto-complete-mode)))


(require-package 'nodejs-repl)


(require-package 'coffee-mode)


(require-package 'skewer-mode)
(skewer-setup)


(provide 'init-web)
