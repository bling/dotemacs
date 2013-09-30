(defvar company-auto-complete t)
(defvar company-global-modes t)
(defvar company-idle-delay 0.2)
(defvar company-minimum-prefix-length 1)
(defvar company-show-numbers t)
(defvar company-tooltip-limit 30)

(require-package 'company)
(require 'company)

(after-load 'ac-js2
  (add-to-list 'company-backends 'ac-js2-company))

(global-company-mode t)

(defun my-company-tab ()
  (interactive)
  (when (null (yas-expand))
    (company-complete-common)))

(provide 'init-company)
