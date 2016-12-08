(add-hook 'csharp-mode-hook
          (lambda ()
            (require-package 'omnisharp)
            (omnisharp-mode t)))

(setq omnisharp-company-match-sort-by-flx-score t)
(setq omnisharp-company-match-type 'company-match-flex)

(after [omnisharp company]
  (add-to-list 'company-backends #'company-omnisharp))

(after 'omnisharp
  ;; upstream uses curl to make calls, which spawns an external process and is much slower;
  ;; this replaces HTTP calls with pure elisp
  (defun omnisharp-post-message-curl (url &optional params)
    (let ((url-request-method "POST")
          (url-request-extra-headers `(("Content-Type" . "application/json")))
          (url-request-data (json-encode params)))
      (with-current-buffer (url-retrieve-synchronously url t t)
        (goto-char (point-min))
        (search-forward-regexp "\n\n")
        (buffer-substring (point) (point-max)))))

  (after 'flycheck
    (flycheck-define-generic-checker 'csharp-omnisharp-codecheck
      "custom omnisharp checker"
      :start (lambda (checker callback)
               (let* ((buffer (current-buffer))
                      (json (omnisharp-post-message-curl
                             (concat (omnisharp-get-host) "codecheck")
                             (omnisharp--get-common-params)))
                      (errors (omnisharp--flycheck-error-parser-raw-json json checker buffer)))
                 (funcall callback 'finished errors)))
      :error-patterns '((error line-start (file-name) ":" line ":" column " " (message (one-or-more not-newline))))
      :error-parser '(lambda (output checker buffer)
                       (message buffer)
                       (omnisharp--flycheck-error-parser-raw-json output checker buffer))
      :modes '(csharp-mode omnisharp-mode))))

(provide 'init-csharp)
