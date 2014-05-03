(defun my-macro-ng-add-string-for-last-arg (&optional arg)
  "Given the cursor is on the last argument for a Javascript function, this will
extract the name of the argument and insert a string with the value value prior
to the function.  Note that this relies on an auto-pairing package such as auto-pair
or smartparens enabled."
  (interactive "p")
  (kmacro-exec-ring-item (quote ([98 121 116 41 63 102 117 110 99 116 105 111 110 return 105 39 escape 112 108 97 44 32 escape] 0 "%d")) arg))

(provide 'init-macros)
