(require-package 'go-mode)
(require 'go-mode)

(require-package 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(after "company-autoloads"
  (require-package 'company-go)
  (require 'company-go)
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go)))))

(provide 'init-go)
