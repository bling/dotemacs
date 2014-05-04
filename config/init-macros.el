(defun my-macro-ng-add-string-for-last-arg ()
  "Given the cursor is on the last argument for a Javascript function, this will
extract the name of the argument and insert a string with the value value prior
to the function.  Note that this relies on an auto-pairing package such as auto-pair
or smartparens enabled."
  (interactive)
  (execute-kbd-macro
   [?b ?y ?w ?F ?\( ?b ?i ?\' escape ?p ?l ?a ?, ?  escape]))

(provide 'init-macros)
