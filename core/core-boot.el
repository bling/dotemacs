;; -*- lexical-binding: t -*-

(let ((base (concat user-emacs-directory "elisp/")))
  (when (file-directory-p base)
    (add-to-list 'load-path base)
    (dolist (dir (directory-files base t "^[^.]"))
      (when (file-directory-p dir)
        (add-to-list 'load-path dir)))))

(defmacro /boot/measure-load (target &rest body)
  (declare (indent defun))
  `(let ((elapsed)
         (start (current-time)))
     (prog1
         ,@body
       (with-current-buffer (get-buffer-create "*Load Times*")
         (when (= 0 (buffer-size))
           (insert (format "| %-60s | %-23s | elapsed  |\n" "feature" "timestamp"))
           (insert "|------------------------------------------+-------------------------+----------|\n"))
         (goto-char (point-max))
         (setq elapsed (float-time (time-subtract (current-time) start)))
         (insert (format "| %-60s | %s | %f |\n"
                         ,target
                         (format-time-string "%Y-%m-%d %H:%M:%S.%3N" (current-time))
                         elapsed))))))

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

