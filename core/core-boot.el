(eval-when-compile (require 'cl))

(let ((base (concat user-emacs-directory "elisp/")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t "^[^.]"))
    (when (file-directory-p dir)
      (add-to-list 'load-path dir))))

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

(defadvice load (around dotemacs activate)
  (/boot/measure-load file ad-do-it))

(defadvice require (around dotemacs activate)
  (if (memq feature features)
      ad-do-it
    (/boot/measure-load feature ad-do-it)))

(defmacro bind (&rest commands)
  "Convenience macro which creates a lambda interactive command."
  `(lambda (arg)
     (interactive "P")
     ,@commands))

(defun require-package (package)
  "Ensures that PACKAGE is installed."
  (unless (or (package-installed-p package)
              (require package nil 'noerror))
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(unless (fboundp 'with-eval-after-load)
  (defmacro with-eval-after-load (file &rest body)
    (declare (indent 1))
    `(eval-after-load ,file (lambda () ,@body))))

(defmacro after (feature &rest body)
  "Executes BODY after FEATURE has been loaded.

FEATURE may be any one of:
    'evil            => (with-eval-after-load 'evil BODY)
    \"evil-autoloads\" => (with-eval-after-load \"evil-autolaods\" BODY)
    [evil cider]     => (with-eval-after-load 'evil
                          (with-eval-after-load 'cider
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

(defmacro /boot/lazy-major-mode (pattern mode)
  "Defines a new major-mode matched by PATTERN, installs MODE if necessary, and activates it."
  `(add-to-list 'auto-mode-alist
                '(,pattern . (lambda ()
                               (require-package (quote ,mode))
                               (,mode)))))

(defmacro /boot/delayed-init (&rest body)
  "Runs BODY after idle for a predetermined amount of time."
  `(run-with-idle-timer
    0.5
    nil
    (lambda () ,@body)))

(provide 'core-boot)
