(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(require 'cl)
(require 'init-packages (concat user-emacs-directory "core/init-packages.el"))
(require 'init-util (concat user-emacs-directory "core/init-util.el"))

(let ((base (concat user-emacs-directory "elisp")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t))
    (when (and (file-directory-p dir)
               (not (equal (file-name-nondirectory dir) ".."))
               (not (equal (file-name-nondirectory dir) ".")))
      (add-to-list 'load-path dir))))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(lexical-let ((config-dir (concat user-emacs-directory "config")))
  (add-to-list 'load-path config-dir)
  (add-to-list 'after-init-hook
               (lambda ()
                 (dolist (file (directory-files config-dir t "\\.el$"))
                   (let ((debug-on-error t)
                         (module (file-name-base file)))
                     (require (intern module)))))))
