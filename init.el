(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(add-to-list 'load-path user-emacs-directory)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (not (file-exists-p custom-file))
  (load custom-file))

(fset 'yes-or-no-p 'y-or-n-p)
(xterm-mouse-mode t)

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
(require 'init-eyecandy)

;;; (unload-feature 'foo)
