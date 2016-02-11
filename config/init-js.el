(defgroup dotemacs-js nil
  "Configuration options for Javascript."
  :group 'dotemacs
  :prefix 'dotemacs-js)

(defcustom dotemacs-js/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-js)

(setq js-indent-level dotemacs-js/indent-offset)

(add-to-list 'auto-mode-alist
             '("\\.js$" . (lambda ()
                            (if (< (buffer-size) (* 1024 20))
                                (progn
                                  (require-package 'js2-mode)
                                  (js2-mode))
                              (js-mode)))))

(after 'js2-mode

  (defun my-dotemacs-js-ctrl-c-ctrl-c ()
    (interactive)
    (require 'thingatpt)
    (let ((val (thing-at-point 'list)))
      ;; inside parameter list?
      (when (and (equal (substring val 0 1) "(")
                 (equal (substring val -1) ")"))
        (if (string-match-p "," val)
            (my-macro-ng-add-string-for-last-arg)
          (my-macro-ng-function-to-array-injected)))))

  (add-hook 'js2-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-c") #'my-dotemacs-js-ctrl-c-ctrl-c)))

  (require-package 'js2-refactor)
  (js2r-add-keybindings-with-prefix "C-c C-m")

  (setq js2-highlight-level 3)
  (setq-default js2-basic-offset dotemacs-js/indent-offset)

  (when (executable-find "tern")
    (require-package 'tern)
    (add-hook 'js2-mode-hook 'tern-mode)
    (after 'tern
      (after 'auto-complete
        (require-package 'tern-auto-complete)
        (tern-ac-setup))
      (after 'company-mode
        (require-package 'company-tern)))))
