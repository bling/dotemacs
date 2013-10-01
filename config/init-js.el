(defvar js2-highlight-level 3)

(require-package 'js2-mode)
(require 'js2-mode)

(setq auto-mode-alist (cons '("\\.js\\'" . js2-mode) auto-mode-alist))

(require-package 'ac-js2)
(require 'ac-js2)

(after 'auto-complete
  (ac-js2-setup-auto-complete-mode))

(provide 'init-js)
