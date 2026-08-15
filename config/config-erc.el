;; -*- lexical-binding: t -*-

(after 'erc
  (setq erc-log-channels-directory (concat dotemacs-cache-directory "erc/logs"))
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))

  (setq erc-timestamp-only-if-changed-flag nil)
  (setq erc-timestamp-format "[%H:%M] ")
  (setq erc-insert-timestamp-function 'erc-insert-timestamp-left)

  (erc-truncate-mode t)

  (add-hook 'window-size-change-functions
            (lambda (&optional frame)
              (setq erc-fill-column (- (window-width) 2)))))

(provide 'config-erc)
