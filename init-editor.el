(when (fboundp 'electric-pair-mode)
  (setq-default electric-pair-mode 1))

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(require-package 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)

(global-set-key (kbd "RET") 'newline-and-indent)

(require-package 'mic-paren)
(paren-activate)

;;; move cursor to last position upon open
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".cache/places" user-emacs-directory))

;;; store all backup files in a directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory ".cache/backups")))))

;;; make backups even for VCS files
(setq vc-make-backup-files t)
(provide 'init-editor)
