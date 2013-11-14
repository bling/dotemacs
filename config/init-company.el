(setq company-auto-complete t)
(setq company-global-modes t)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 30)

(require-package 'company)
(require 'company)

(after 'ac-js2-autoloads
  (add-to-list 'company-backends 'ac-js2-company))

(global-company-mode t)

(defun my-company-tab ()
  (interactive)
  (when (null (yas-expand))
    (company-complete-common)))

(provide 'init-company)
