(require-package 'company)
(require 'company)

(setq company-auto-complete t)
(setq company-global-modes t)
(setq company-idle-delay t)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 30)
(setq company-auto-complete-chars '(41 46))

(after "ac-js2-autoloads"
  (add-to-list 'company-backends 'ac-js2-company))

(when (executable-find "tern")
  (after "company-tern-autoloads"
    (add-to-list 'company-backends 'company-tern)))

(setq company-global-modes
      '(not
        eshell-mode shell-mode term-mode terminal-mode))

(global-company-mode t)

(defun my-company-tab ()
  (interactive)
  (when (null (yas-expand))
    (company-complete-common)))

(provide 'init-company)
