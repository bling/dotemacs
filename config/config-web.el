;; -*- lexical-binding: t -*-

(defgroup dotemacs-web nil
  "Configuration options for web."
  :group 'dotemacs
  :prefix 'dotemacs-web)

(defcustom dotemacs-web/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-web)



(require-package 'rainbow-mode)
(dolist (hook '(html-mode-hook
                html-ts-mode-hook
                mhtml-mode-hook
                css-mode-hook
                css-ts-mode-hook
                scss-mode-hook
                sass-mode-hook
                less-css-mode-hook
                stylus-mode-hook))
  (add-hook hook #'rainbow-mode))


(setq-default sgml-basic-offset dotemacs-web/indent-offset)
(setq-default html-ts-mode-indent-offset dotemacs-web/indent-offset)
(setq-default css-indent-offset dotemacs-web/indent-offset)
(setq-default css-ts-mode-indent-offset dotemacs-web/indent-offset)


(when (fboundp 'html-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . html-ts-mode))
  (add-hook 'html-ts-mode-hook #'/utils/activate-lsp))

(add-to-list 'auto-mode-alist '("\\.xhtml\\'" . mhtml-mode))
(add-hook 'html-mode-hook #'/utils/activate-lsp)
(add-hook 'mhtml-mode-hook #'/utils/activate-lsp)

(when (fboundp 'css-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.css\\'" . css-ts-mode))
  (add-hook 'css-ts-mode-hook #'/utils/activate-lsp))

(add-hook 'css-mode-hook #'/utils/activate-lsp)
(add-hook 'scss-mode-hook #'/utils/activate-lsp)
(add-hook 'less-css-mode-hook #'/utils/activate-lsp)

;; indent after deleting a tag
(advice-add
 'sgml-delete-tag :after
 (lambda (&rest _) (indent-region (point-min) (point-max))))


(provide 'config-web)
