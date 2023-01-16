;; -*- lexical-binding: t -*-

(when (and (functionp 'module-load) module-file-suffix)
  (require-package 'tree-sitter)
  (require 'tree-sitter)

  (require-package 'tree-sitter-langs)
  (require 'tree-sitter-langs)

  (global-tree-sitter-mode t)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
