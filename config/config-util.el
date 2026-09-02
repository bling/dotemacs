;; -*- lexical-binding: t -*-

(defun /utils/window-killer ()
  "Close the current window, killing the buffer if it is not displayed elsewhere.
If this is the only window in the frame, kill the buffer (or bury it if displayed elsewhere)."
  (interactive)
  (let ((displayed-elsewhere (cdr (get-buffer-window-list (current-buffer) nil t))))
    (cond
     ((one-window-p)
      (if displayed-elsewhere
          (bury-buffer)
        (kill-current-buffer)))
     (displayed-elsewhere
      (delete-window))
     (t
      (kill-buffer-and-window)))))

(defun /utils/minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(defun /utils/set-transparency (alpha)
  "Sets the transparency of the current frame."
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha alpha))

(defun /utils/google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Search Google: "))))))

(defun /utils/goto-scratch-buffer ()
  "Create a new scratch buffer."
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*")))

(defun /utils/insert-last-kbd-macro ()
  (interactive)
  (name-last-kbd-macro 'my-last-macro)
  (insert-kbd-macro 'my-last-macro))

(defun /utils/set-buffer-to-unix-format ()
  "Converts the current buffer to UNIX file format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

(defun /utils/set-buffer-to-dos-format ()
  "Converts the current buffer to DOS file format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))

(provide 'config-util)
