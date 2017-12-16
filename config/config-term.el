(require-package 'xterm-color)
(require 'xterm-color)

(add-hook 'comint-preoutput-filter-functions #'xterm-color-filter)
(setq comint-output-filter-functions (remove #'ansi-color-process-output comint-output-filter-functions))

(after 'esh-mode
  (add-to-list 'eshell-preoutput-filter-functions #'xterm-color-filter)
  (add-hook 'eshell-mode-hook
            (lambda ()
              (setenv "TERM" "xterm-256color")
              (setq xterm-color-preserve-properties t))))

(provide 'config-term)
