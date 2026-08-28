;; -*- lexical-binding: t -*-

(defgroup dotemacs-web nil
  "Configuration options for web."
  :group 'dotemacs
  :prefix 'dotemacs-web)

(defcustom dotemacs-web/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-web)



(use-package rainbow-mode
  :hook (sgml-mode css-base-mode))

(setq-default sgml-basic-offset dotemacs-web/indent-offset)
(setq-default html-ts-mode-indent-offset dotemacs-web/indent-offset)
(setq-default css-indent-offset dotemacs-web/indent-offset)
(setq-default css-ts-mode-indent-offset dotemacs-web/indent-offset)

;; indent after deleting a tag
(after 'sgml-mode
  (advice-add
   'sgml-delete-tag :after
   (lambda (&rest _) (indent-region (point-min) (point-max)))))

(provide 'config-web)
