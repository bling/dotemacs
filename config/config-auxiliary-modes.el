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

(/boot/lazy-major-mode "\\.\\(md\\|markdown\\)\\'" markdown-mode)
(/boot/lazy-major-mode "\\.csv\\'" csv-mode)
(/boot/lazy-major-mode "\\.gitlab-ci\\.yml\\'" gitlab-ci-mode)
(/boot/lazy-major-mode "\\.vim\\'" vimrc-mode)
(/boot/lazy-major-mode "\\.rego\\'" rego-mode)

(provide 'config-auxiliary-modes)
