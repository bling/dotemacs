(with-current-buffer (get-buffer-create "*Require Times*")
  (insert "| feature | elapsed | timestamp |\n")
  (insert "|---------+---------+-----------|\n")
  (setq-local require-times (make-hash-table))
  (put 'require-times 'permanent-local t))

(defadvice require (around require-advice activate)
  (let ((start (current-time))
        (elapsed)
        (buffer (get-buffer-create "*Require Times*")))
    ad-do-it
    (setq elapsed (float-time (time-subtract (current-time) start)))
    (with-current-buffer buffer
      (let ((match (gethash feature require-times)))
        (unless match
          (goto-char (point-max))
          (insert (format "| %s | %s | %f |\n"
                          feature (format-time-string "%Y-%m-%d %H:%M:%S.%3N" (current-time)) elapsed))
          (puthash feature t require-times))))))

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(add-to-list 'load-path (concat user-emacs-directory "/config"))
(let ((base (concat user-emacs-directory "/elisp")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t "^[^.]"))
    (when (file-directory-p dir)
      (add-to-list 'load-path dir))))

(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(defcustom dotemacs-completion-engine
  'company
  "The completion engine the use."
  :type '(radio
          (const :tag "company-mode" company)
          (const :tag "auto-complete-mode" auto-complete))
  :group 'dotemacs)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(add-to-list 'load-path (concat user-emacs-directory "/config"))
(let ((base (concat user-emacs-directory "/elisp")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t "^[^.]"))
    (when (file-directory-p dir)
      (add-to-list 'load-path dir))))

(eval-when-compile
  (require 'cl))

(require 'init-packages)
(require 'init-util)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(let ((debug-on-error t))
  (cl-loop for file in (directory-files (concat user-emacs-directory "config/"))
           if (not (file-directory-p file))
           do (require (intern (file-name-base file)))))
