;; -*- lexical-binding: t -*-

(let ((base (concat user-emacs-directory "elisp/")))
  (when (file-directory-p base)
    (add-to-list 'load-path base)
    (dolist (dir (directory-files base t "^[^.]"))
      (when (file-directory-p dir)
        (add-to-list 'load-path dir)))))

(defvar /boot/load-time-entries nil)
(defvar /boot/load-stack nil)
(defvar /boot/load-seq 0)

(defun /boot/load-times ()
  "Shows the load times of all files/features."
  (interactive)
  (with-current-buffer (get-buffer-create "*Load Times*")
    (require 'tabulated-list)
    (tabulated-list-mode)
    (setq tabulated-list-format
          [("Feature / File" 50 t)
           ("Timestamp"      15 (lambda (a b) (< (aref (car a) 0) (aref (car b) 0))))
           ("Elapsed (s)"    12 (lambda (a b) (< (aref (car a) 1) (aref (car b) 1))) :right-align t)
           ("Self (s)"       12 (lambda (a b) (< (aref (car a) 2) (aref (car b) 2))) :right-align t)])
    (setq tabulated-list-sort-key nil)
    (setq tabulated-list-entries (reverse /boot/load-time-entries))
    (tabulated-list-init-header)
    (tabulated-list-print)
    (pop-to-buffer (current-buffer))))

(defmacro /boot/measure-load (target &rest body)
  (declare (indent defun))
  `(let* ((seq (setq /boot/load-seq (1+ /boot/load-seq)))
          (depth (length /boot/load-stack))
          (start (current-time))
          (child-cell (list 0.0))
          (frame (cons ,target child-cell))
          (entry (list nil nil)))
     (push entry /boot/load-time-entries)
     (let ((/boot/load-stack (cons frame /boot/load-stack)))
       (unwind-protect
           (progn ,@body)
         (let* ((elapsed (float-time (time-subtract (current-time) start)))
                (self-time (max 0.0 (- elapsed (car child-cell))))
                (parent-child-cell (when (cdr /boot/load-stack)
                                     (cdr (cadr /boot/load-stack)))))
           (when parent-child-cell
             (setcar parent-child-cell (+ (car parent-child-cell) elapsed)))
           (setcar entry (vector seq elapsed self-time))
           (setcar (cdr entry)
                   (vector
                    (concat (make-string (* 2 depth) ?\s) (format "%s" ,target))
                    (format-time-string "%T.%3N" start)
                    (format "%.4f" elapsed)
                    (format "%.4f" self-time))))))))

(advice-add
 'load :around
 (lambda (orig-fn file &optional noerror nomessage nosuffix must-suffix)
   (/boot/measure-load file (funcall orig-fn file noerror nomessage nosuffix must-suffix))))

(advice-add
 'require :around
 (lambda (orig-fn feature &optional filename noerror)
   (if (memq feature features)
       (funcall orig-fn feature filename noerror)
     (/boot/measure-load feature (funcall orig-fn feature filename noerror)))))

(defmacro bind (&rest commands)
  "Convenience macro which creates a lambda interactive command."
  `(lambda (arg)
     (interactive "P")
     ,@commands))

(defmacro after (feature &rest body)
  "Executes BODY after FEATURE has been loaded.

FEATURE may be any one of:
    'evil            => (with-eval-after-load 'evil BODY)
    \"evil-autoloads\" => (with-eval-after-load \"evil-autoloads\" BODY)
    [evil project]     => (with-eval-after-load 'evil
                          (with-eval-after-load 'project
                            BODY))
"
  (declare (indent 1))
  (cond
   ((vectorp feature)
    (let ((prog (macroexp-progn body)))
      (cl-loop for f across feature
               do
               (progn
                 (setq prog (append `(',f) `(,prog)))
                 (setq prog (append '(with-eval-after-load) prog))))
      prog))
   (t
    `(with-eval-after-load ,feature ,@body))))

(defmacro /boot/delayed-init (&rest body)
  "Runs BODY after idle for a predetermined amount of time."
  `(run-with-idle-timer
    0.5
    nil
    (lambda () ,@body)))

(defmacro use-package-lazy-mode (pattern mode &rest args)
  "Defines a new major-mode matched by PATTERN, installs MODE using `use-package', and activates it."
  (declare (indent 2))
  `(add-to-list 'auto-mode-alist
                '(,pattern . (lambda ()
                               (use-package ,mode :ensure t ,@args)
                               (,mode)))))

(provide 'core-boot)
