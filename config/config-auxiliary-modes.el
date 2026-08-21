;; -*- lexical-binding: t -*-

(when (fboundp 'json-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode)))
(when (fboundp 'yaml-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode)))
(when (fboundp 'toml-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-ts-mode)))
(when (fboundp 'lua-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode)))
(when (fboundp 'dockerfile-ts-mode)
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-ts-mode)))

(use-package-lazy-mode "\\.\\(md\\|markdown\\)\\'" markdown-mode)
(use-package-lazy-mode "\\.csv\\'" csv-mode)
(use-package-lazy-mode "\\.gitlab-ci\\.ya?ml\\'" gitlab-ci-mode)
(use-package-lazy-mode "\\.vim\\'" vimrc-mode)
(use-package-lazy-mode "\\.rego\\'" rego-mode)

(provide 'config-auxiliary-modes)
