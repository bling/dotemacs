(add-to-list 'auto-mode-alist
             '("\\.styl$" . (lambda ()
                              (require-package 'stylus-mode)
                              (stylus-mode))))

(after 'stylus-mode

  (defvar /stylus/command-args nil
    "Additional list of arguments to pass into the stylus command.")

  (defvar /stylus/display-buffer-name "*Stylus Output*"
    "The name of the Stylus buffer with CSS output.")

  (defvar /stylus/last-command-mode nil)

  (defun /stylus/process-sentinel (process event)
    (when (equal event "finished\n")
      (if /stylus/last-command-mode
          (display-buffer /stylus/display-buffer-name)
        (with-current-buffer /stylus/display-buffer-name
          (skewer-css-eval-buffer)))))

  (defun /stylus/setup-output-buffer (show)
    (let ((buffer (get-buffer-create /stylus/display-buffer-name)))
      (with-current-buffer buffer
        (erase-buffer)
        (when show
          (display-buffer buffer))
        (css-mode))))

  (defun /stylus/async (begin end show)
    (require 'skewer-css)
    (/stylus/setup-output-buffer show)
    (setq /stylus/last-command-mode show)
    (let ((process (apply 'start-process
                          "stylus" /stylus/display-buffer-name "stylus" /stylus/command-args)))
      (set-process-sentinel process '/stylus/process-sentinel)
      (process-send-region process begin end)
      (process-send-eof process)))

  (defun /stylus/compile-and-show-region (start end)
    (interactive "r")
    (/stylus/async start end t))

  (defun /stylus/compile-and-show-buffer ()
    (interactive)
    (/stylus/async (point-min) (point-max) t))

  (defun /stylus/compile-and-eval-buffer ()
    (interactive)
    (/stylus/async (point-min) (point-max) nil))

  (add-hook 'stylus-mode-hook (lambda ()
                                (unless (process-status "httpd")
                                  (httpd-start)))))

(provide 'config-stylus)
