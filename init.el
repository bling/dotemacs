(add-to-list 'load-path user-emacs-directory)

(setq custom-file "~/.emacs.d/custom.el")
(unless (not (file-exists-p custom-file))
  (load custom-file))

(require 'init-packages)
(require 'init-editor)
(require 'init-evil)
(require 'init-ido)
(require 'init-auto-complete)
