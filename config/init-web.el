(lazy-major-mode "\\.coffee\\'" coffee-mode)
(lazy-major-mode "\\.jade$" jade-mode)
(lazy-major-mode "\\.scss$" scss-mode)
(lazy-major-mode "\\.less$" less-css-mode)


(after "js2-mode-autoloads"
  (require-package 'skewer-mode)
  (skewer-setup))


(require-package 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'web-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'stylus-mode-hook 'rainbow-mode)


(defun my-emmet-mode ()
  (require-package 'emmet-mode)
  (emmet-mode))

(add-hook 'css-mode-hook 'my-emmet-mode)
(add-hook 'sgml-mode-hook 'my-emmet-mode)
(add-hook 'web-mode-hook 'my-emmet-mode)


(lazy-major-mode "\\.html?$" web-mode)


(after 'web-mode
  (add-hook 'web-mode-hook
            (lambda ()
              (electric-pair-mode -1)))

  (setq web-mode-auto-close-style 2) ;; auto-add closing tag
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-part-face t)

  (after 'yasnippet
    (require-package 'angular-snippets)
    (require 'angular-snippets)
    (angular-snippets-initialize)))


;; indent after deleting a tag
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))

(provide 'init-web)
