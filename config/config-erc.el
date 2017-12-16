(after 'erc
  (setq erc-log-channels-directory (concat dotemacs-cache-directory "erc/logs"))
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))

  (setq erc-timestamp-only-if-changed-flag nil)
  (setq erc-timestamp-format "[%H:%M] ")
  (setq erc-insert-timestamp-function 'erc-insert-timestamp-left)

  (setq erc-truncate-mode t)

  (add-hook 'window-configuration-change-hook
            (lambda ()
              (setq erc-fill-column (- (window-width) 2)))))

(provide 'config-erc)
