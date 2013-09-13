(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(add-to-list 'load-path user-emacs-directory)

(setq custom-file "~/.emacs.d/custom.el")
(unless (not (file-exists-p custom-file))
  (load custom-file))

(fset 'yes-or-no-p 'y-or-n-p)

(require 'init-packages)
(require 'init-editor)
(require 'init-evil)
(require 'init-auto-complete)
(require 'init-projectile)
(require 'init-helm)
(require 'init-ido)
(require 'init-git)
(require 'init-vim)
(require 'init-markdown)
(require 'init-bindings)

;;; (unload-feature 'foo)
