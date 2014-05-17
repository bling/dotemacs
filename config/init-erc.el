(after 'erc
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (setq erc-fill-mode nil)

  (setq erc-timestamp-only-if-changed-flag nil)
  (setq erc-timestamp-format "[%H:%M] ")
  (setq erc-insert-timestamp-function 'erc-insert-timestamp-left)

  (setq erc-truncate-mode t))

(provide 'init-erc)
