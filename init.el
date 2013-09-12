(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(add-to-list 'load-path user-emacs-directory)

(setq custom-file "~/.emacs.d/custom.el")
(unless (not (file-exists-p custom-file))
  (load custom-file))

(require 'init-packages)
(require 'init-editor)
(require 'init-evil)
(require 'init-auto-complete)
(require 'init-projectile)
(require 'init-helm)
(require 'init-ido)
(require 'init-git)
(require 'init-bindings)

(require-package 'markdown-mode)

(require-package 'vimrc-mode)
(setq auto-mode-alist
      (cons '("\\.vim\\'" . vimrc-mode) auto-mode-alist))

;;; (unload-feature 'foo)
