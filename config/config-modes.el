;; -*- lexical-binding: t -*-

(setq treesit-font-lock-level 4)
(setq treesit-extra-load-path (list (concat dotemacs-cache-directory "tree-sitter")))

;; for default modes, detect installed grammars and remap to the treesit mode
(pcase-dolist (`(,lang ,orig ,ts)
               '((c          c-mode          c-ts-mode)
                 (cpp        c++-mode        c++-ts-mode)
                 (python     python-mode     python-ts-mode)
                 (ruby       ruby-mode       ruby-ts-mode)
                 (bash       sh-mode         bash-ts-mode)
                 (java       java-mode       java-ts-mode)
                 (c-sharp    csharp-mode     csharp-ts-mode)
                 (javascript js-mode         js-ts-mode)
                 (javascript javascript-mode js-ts-mode)
                 (json       js-json-mode    json-ts-mode)
                 (css        css-mode        css-ts-mode)
                 (html       mhtml-mode      html-ts-mode)
                 (html       html-mode       html-ts-mode)
                 (toml       conf-toml-mode  toml-ts-mode)))
  (when (treesit-language-available-p lang)
    (add-to-list 'major-mode-remap-alist (cons orig ts))))

;; for non-default modes, register treesit if grammar is available, otherwise install 3rd party mode
(pcase-dolist (`(,lang ,pattern ,mode ,fallback)
               '((typescript "\\.[mc]?ts\\'"                          typescript-ts-mode nil)
                 (tsx        "\\.[mc]?tsx\\'"                         tsx-ts-mode        nil)
                 (yaml       "\\.ya?ml\\'"                            yaml-ts-mode       yaml-mode)
                 (dockerfile "Dockerfile\\'"                          dockerfile-ts-mode dockerfile-mode)
                 (rust       "\\.rs\\'"                               rust-ts-mode       rust-mode)
                 (go         "\\.go\\'"                               go-ts-mode         go-mode)
                 (gomod      "/go\\.mod\\'"                           go-mod-ts-mode     nil)
                 (lua        "\\.lua\\'"                              lua-ts-mode        lua-mode)
                 (cmake      "\\(?:CMakeLists\\.txt\\|\\.cmake\\)\\'" cmake-ts-mode      cmake-mode)
                 (elixir     "\\.exs?\\'"                             elixir-ts-mode     elixir-mode)
                 (heex       "\\.heex\\'"                             heex-ts-mode       nil)
                 (php        "\\.php\\'"                              php-ts-mode        php-mode)))
  (cond
   ((treesit-language-available-p lang)
    (add-to-list 'auto-mode-alist (cons pattern mode)))
   (fallback
    (eval `(use-package-lazy-mode ,pattern ,fallback)))))

(use-package-lazy-mode "\\.\\(md\\|markdown\\)\\'" markdown-mode)
(use-package-lazy-mode "\\.csv\\'" csv-mode)
(use-package-lazy-mode "\\(?:\\.gitlab-ci\\|/\\.gitlab/.*\\)\\.ya?ml\\'" gitlab-ci-mode)
(use-package-lazy-mode "\\.vim\\'" vimrc-mode)
(use-package-lazy-mode "\\.rego\\'" rego-mode)

(provide 'config-modes)
