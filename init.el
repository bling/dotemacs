(add-to-list 'load-path user-emacs-directory)

(setq custom-file "~/.emacs.d/custom.el")
(unless (not (file-exists-p custom-file))
  (load custom-file))

(require 'init-packages)
(require 'init-editor)
(require 'init-evil)
(require 'init-ido)
(require 'init-auto-complete)
(require 'init-projectile)
(require 'init-helm)

(require-package 'guide-key)
(setq guide-key/guide-key-sequence
      '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(require-package 'markdown-mode)
(require-package 'vimrc-mode)
