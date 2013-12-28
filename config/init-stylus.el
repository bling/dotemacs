(require-package 'stylus-mode)

(defvar my-stylus-command-args nil
  "Additional list of arguments to pass into the stylus command.")

(defun my-stylus-compile (start end)
  (let ((buffer (get-buffer "*Stylus*")))
    (when buffer (with-current-buffer buffer (erase-buffer))))
  (apply 'call-process-region start end "stylus" nil (get-buffer-create "*Stylus*") nil
         my-stylus-command-args)
  (let ((buffer (get-buffer "*Stylus*")))
    (display-buffer buffer)
    (when buffer (with-current-buffer buffer (css-mode)))))

(defun my-stylus-compile-region (start end)
  (interactive "r")
  (my-stylus-compile start end))

(defun my-stylus-compile-buffer ()
  (interactive)
  (my-stylus-compile (point-min) (point-max)))

(provide 'init-stylus)
