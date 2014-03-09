(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)

(defun require-package (package)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;; (add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))
;; (el-get 'sync)


(provide 'init-packages)
