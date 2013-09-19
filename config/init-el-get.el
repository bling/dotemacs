(add-to-list 'load-path (expand-file-name "el-get/el-get" my-user-emacs-directory))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(add-to-list 'el-get-recipe-path (expand-file-name "config/recipes" my-user-emacs-directory))

(provide 'init-el-get)
