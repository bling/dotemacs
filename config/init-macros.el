(defun my-macro-ng-add-string-for-last-arg ()
  "Given the cursor is on the last argument for a Javascript function, this will
extract the name of the argument and insert a string with the value value prior
to the function.  This macro requires evil-mode and an auto-paring package such
as auto-pairs or smartparens."
  (interactive)
  (execute-kbd-macro
   [?F ?, ?w ?y ?w ?F ?\( ?b ?b ?l ?a ?  ?\' escape ?p ?l ?a ?, escape]))

(provide 'init-macros)
