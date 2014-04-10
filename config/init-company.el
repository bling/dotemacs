(require-package 'company)
(require 'company)

(setq company-auto-complete t)
(setq company-auto-complete-chars '(41 46))

(setq company-idle-delay t)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 30)

(when (executable-find "tern")
  (after "company-tern-autoloads"
    (add-to-list 'company-backends 'company-tern)))

(setq company-global-modes
      '(not
        eshell-mode shell-mode term-mode terminal-mode))

(add-hook 'after-init-hook 'global-company-mode)

(defun my-company-tab ()
  (interactive)
  (when (null (yas-expand))
    (company-complete-common)))

(provide 'init-company)
