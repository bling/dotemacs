(require-package 'js2-mode)
(require 'js2-mode)

(setq auto-mode-alist
      (cons '("\\.js\\'" . js2-mode) auto-mode-alist))

(require-package 'ac-js2)
(require 'ac-js2)
(ac-js2-setup-auto-complete-mode)

(provide 'init-js)
