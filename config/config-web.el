;; -*- lexical-binding: t -*-

(defgroup dotemacs-web nil
  "Configuration options for web."
  :group 'dotemacs
  :prefix 'dotemacs-web)

(defcustom dotemacs-web/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-web)

(defcustom dotemacs-web/engine 'lsp
  "The engine to drive web modes (HTML, CSS, SCSS, LESS)."
  :type '(radio
          (const :tag "none" nil)
          (const :tag "eglot" eglot)
          (const :tag "lsp" lsp))
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


(defun /web/setup ()
  (cond
   ((eq dotemacs-web/engine 'lsp)
    (/lsp/activate))
   ((eq dotemacs-web/engine 'eglot)
    (/eglot/activate))))


(setq-default sgml-basic-offset dotemacs-web/indent-offset)
(setq-default html-ts-mode-indent-offset dotemacs-web/indent-offset)
(setq-default css-indent-offset dotemacs-web/indent-offset)
(setq-default css-ts-mode-indent-offset dotemacs-web/indent-offset)


(when (fboundp 'html-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . html-ts-mode))
  (add-hook 'html-ts-mode-hook #'/web/setup))

(add-to-list 'auto-mode-alist '("\\.xhtml\\'" . mhtml-mode))
(add-hook 'html-mode-hook #'/web/setup)
(add-hook 'mhtml-mode-hook #'/web/setup)

(when (fboundp 'css-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.css\\'" . css-ts-mode))
  (add-hook 'css-ts-mode-hook #'/web/setup))

(add-hook 'css-mode-hook #'/web/setup)
(add-hook 'scss-mode-hook #'/web/setup)
(add-hook 'less-css-mode-hook #'/web/setup)


(after 'yasnippet
  (dolist (hook '(html-mode-hook
                  html-ts-mode-hook
                  mhtml-mode-hook
                  css-mode-hook
                  css-ts-mode-hook
                  scss-mode-hook
                  less-css-mode-hook))
    (add-hook hook #'yas-minor-mode)))


;; indent after deleting a tag
(advice-add
 'sgml-delete-tag :after
 (lambda (&rest _) (indent-region (point-min) (point-max))))


(provide 'config-web)
