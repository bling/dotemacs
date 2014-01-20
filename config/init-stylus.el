(require-package 'stylus-mode)

(defvar my-stylus-command-args nil
  "Additional list of arguments to pass into the stylus command.")

(defun my-stylus-compile (start end &optional eval-buffer)
  (let ((buffer (get-buffer "*Stylus*")))
    (when buffer (with-current-buffer buffer (erase-buffer))))
  (apply 'call-process-region start end "stylus" nil (get-buffer-create "*Stylus*") nil
         my-stylus-command-args)
  (let ((buffer (get-buffer "*Stylus*")))
    (if eval-buffer
        (with-current-buffer buffer (skewer-css-eval-buffer))
      (progn
        (display-buffer buffer)
        (with-current-buffer buffer (css-mode))))))

(defun my-stylus-compile-and-eval ()
  (interactive)
  (my-stylus-compile (point-min) (point-max) t))

(defun my-stylus-compile-and-show-region (start end)
  (interactive "r")
  (my-stylus-compile start end))

(defun my-stylus-compile-and-show-buffer ()
  (interactive)
  (my-stylus-compile (point-min) (point-max)))

(provide 'init-stylus)
