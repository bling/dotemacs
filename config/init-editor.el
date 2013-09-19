;;; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".cache/places" my-user-emacs-directory))

;;; store all backup files in a directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat my-user-emacs-directory ".cache/backups")))))

;;; make backups even for VCS files
(setq vc-make-backup-files t)

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(global-hl-line-mode)
(global-linum-mode t)
(setq linum-format "%4d "
      linum-delay t)

(show-paren-mode t)

(require-package 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)
(smartparens-global-strict-mode t)
(setq sp-autoescape-string-quote nil
      sp-autoskip-closing-pair 'always)

(require-package 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq-default undo-tree-history-directory-alist
              `(("." . ,(concat my-user-emacs-directory ".cache/undo"))))

(require-package 'multiple-cursors)

(require-package 'monokai-theme)
(load-theme 'monokai t)

(provide 'init-editor)
