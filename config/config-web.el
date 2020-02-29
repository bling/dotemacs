(defgroup dotemacs-web nil
  "Configuration options for web."
  :group 'dotemacs
  :prefix 'dotemacs-web)

(defcustom dotemacs-web/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-web)

(defcustom dotemacs-web/use-skewer-mode nil
  "When non-nil, enables `skewer-mode' integration."
  :type 'boolean
  :group 'dotemacs-web)

(defcustom dotemacs-web/use-emmet-mode nil
  "When non-nil, enables `emmet-mode' integration."
  :type 'boolean
  :group 'dotemacs-web)

(defcustom dotemacs-web/use-lsp-html
  t
  "Whether to use LSP mode for HTML buffers."
  :type 'boolean
  :group 'dotemacs-web)

(defcustom dotemacs-web/use-lsp-css
  t
  "Whether to use LSP mode for HTML buffers."
  :type 'boolean
  :group 'dotemacs-web)



(/boot/lazy-major-mode "\\.jade$" jade-mode)
(/boot/lazy-major-mode "\\.scss$" scss-mode)
(/boot/lazy-major-mode "\\.sass$" sass-mode)
(/boot/lazy-major-mode "\\.less$" less-css-mode)


(/boot/lazy-major-mode "\\.coffee\\'" coffee-mode)
(setq coffee-indent-like-python-mode t)


(when dotemacs-web/use-skewer-mode
  (require-package 'skewer-mode)
  (skewer-setup))


(when dotemacs-web/use-emmet-mode
  (defun /web/turn-on-emmet-mode ()
    (require-package 'emmet-mode)
    (emmet-mode))

  (add-hook 'css-mode-hook #'/web/turn-on-emmet-mode)
  (add-hook 'sgml-mode-hook #'/web/turn-on-emmet-mode)
  (add-hook 'web-mode-hook #'/web/turn-on-emmet-mode))


(require-package 'rainbow-mode)
(add-hook 'html-mode-hook #'rainbow-mode)
(add-hook 'web-mode-hook #'rainbow-mode)
(add-hook 'css-mode-hook #'rainbow-mode)
(add-hook 'stylus-mode-hook #'rainbow-mode)


(/boot/lazy-major-mode "\\.html?$" web-mode)


(when dotemacs-web/use-lsp-css
  (add-hook 'css-mode-hook #'/lsp/activate))


(after 'web-mode
  (defun /web/web-mode-hook ()
    (electric-pair-mode -1)

    (when (and (equal web-mode-content-type "html")
               dotemacs-web/use-lsp-html)
      (/lsp/activate))

    (setq web-mode-enable-auto-quoting (not (equal web-mode-content-type "jsx"))))

  (add-hook 'web-mode-hook #'/web/web-mode-hook)
  (after 'yasnippet
    (add-hook 'web-mode-hook #'yas-minor-mode))

  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))

  (setq web-mode-code-indent-offset dotemacs-web/indent-offset)
  (setq web-mode-markup-indent-offset dotemacs-web/indent-offset)
  (setq web-mode-css-indent-offset dotemacs-web/indent-offset)
  (setq web-mode-sql-indent-offset dotemacs-web/indent-offset)

  (setq web-mode-enable-auto-pairing (not (eq dotemacs-pair-engine 'smartparens)))
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-element-content-fontification t)
  (setq web-mode-enable-element-tag-fontification t)
  (setq web-mode-enable-html-entities-fontification t)
  (setq web-mode-enable-inlays t)
  (setq web-mode-enable-sql-detection t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-part-face t))


;; indent after deleting a tag
(defadvice sgml-delete-tag (after dotemacs activate)
  (indent-region (point-min) (point-max)))


(provide 'config-web)
