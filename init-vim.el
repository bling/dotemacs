(require-package 'vimrc-mode)
(setq auto-mode-alist
      (cons '("\\.vim\\'" . vimrc-mode) auto-mode-alist))

(provide 'init-vim)
