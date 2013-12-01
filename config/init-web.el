(require-package 'js2-mode)
(require 'js2-mode)
(setq js2-highlight-level 3)
(setq-default js2-basic-offset 2)

(require-package 'ac-js2)
(after 'js2-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(require-package 'js2-refactor)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")


(require-package 'tern)
(require-package 'tern-auto-complete)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(after 'tern
  (after 'auto-complete
    (require 'tern-auto-complete)
    (tern-ac-setup)))


(require-package 'coffee-mode)
(require-package 'jade-mode)


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


(require-package 'skewer-mode)
(skewer-setup)


(require-package 'rainbow-mode)
(require 'rainbow-mode)
(add-hook 'stylus-mode-hook (lambda () (rainbow-turn-on)))


(require-package 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)


(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;; indent after deleting a tag
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))


(provide 'init-web)
