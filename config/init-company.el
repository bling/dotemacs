(require-package 'company)
(require 'company)

(setq company-auto-complete t)
(setq company-auto-complete-chars '(41 46))

(setq company-idle-delay t)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 30)

(set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
(set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
(set-face-attribute 'company-preview nil :background "black")
(set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
(set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
(set-face-attribute 'company-scrollbar-fg nil :background "gray40")

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
