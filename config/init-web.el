(require-package 'coffee-mode)
(require-package 'jade-mode)


(require-package 'skewer-mode)
(skewer-setup)


(require-package 'rainbow-mode)
(require 'rainbow-mode)
(add-to-list 'rainbow-html-colors-major-mode-list 'stylus-mode)


(require-package 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)


(require-package 'web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;; indent after deleting a tag
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))


(provide 'init-web)
