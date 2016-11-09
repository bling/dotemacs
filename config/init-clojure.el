(add-hook 'clojure-mode-hook
          (lambda ()
            (require-package 'cider)
            (cider-mode t)))

(after [evil cider]
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)

  (evil-set-initial-state 'cider-popup-buffer-mode 'motion)
  (evil-set-initial-state 'cider-browse-ns-mode 'motion)
  (evil-set-initial-state 'cider-repl-mode 'emacs)

  (evilify cider-docview-mode cider-docview-mode-map
    (kbd "q") #'cider-popup-buffer-quit)

  (evilify cider-inspector-mode cider-inspector-mode-map
    (kbd "L") #'cider-inspector-pop
    (kbd "n") #'cider-inspector-next-page
    (kbd "N") #'cider-inspector-previous-page
    (kbd "r") #'cider-inspector-refresh)

  (evilify cider-test-report-mode cider-test-report-mode-map
    (kbd "C-j") #'cider-test-next-result
    (kbd "C-k") #'cider-test-previous-result
    (kbd "RET") #'cider-test-jump
    (kbd "d")   #'cider-test-ediff
    (kbd "e")   #'cider-test-stacktrace
    (kbd "q")   #'cider-popup-buffer-quit
    (kbd "r")   #'cider-test-rerun-tests
    (kbd "t")   #'cider-test-run-test
    (kbd "T")   #'cider-test-run-ns-tests)

  (evilify cider-stacktrace-mode cider-stacktrace-mode-map
    (kbd "C-j") #'cider-stacktrace-next-cause
    (kbd "C-k") #'cider-stacktrace-previous-cause
    (kbd "TAB") #'cider-stacktrace-cycle-current-cause
    (kbd "0")   #'cider-stacktrace-cycle-all-causes
    (kbd "1")   #'cider-stacktrace-cycle-cause-1
    (kbd "2")   #'cider-stacktrace-cycle-cause-2
    (kbd "3")   #'cider-stacktrace-cycle-cause-3
    (kbd "4")   #'cider-stacktrace-cycle-cause-4
    (kbd "5")   #'cider-stacktrace-cycle-cause-5
    (kbd "a")   #'cider-stacktrace-toggle-all
    (kbd "c")   #'cider-stacktrace-toggle-clj
    (kbd "d")   #'cider-stacktrace-toggle-duplicates
    (kbd "J")   #'cider-stacktrace-toggle-java
    (kbd "r")   #'cider-stacktrace-toggle-repl
    (kbd "T")   #'cider-stacktrace-toggle-tooling))

(provide 'init-clojure)

