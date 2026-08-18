;; -*- lexical-binding: t -*-

(defgroup dotemacs-js nil
  "Configuration options for Javascript."
  :group 'dotemacs
  :prefix 'dotemacs-js)

(defcustom dotemacs-js/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-js)



(setq js-indent-level dotemacs-js/indent-offset)

(when (fboundp 'js-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.[mc]?js\\'" . js-ts-mode))
  (add-hook 'js-ts-mode-hook #'/utils/activate-lsp))

(when (fboundp 'tsx-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-ts-mode))
  (add-hook 'tsx-ts-mode-hook #'/utils/activate-lsp))

(provide 'config-js)
