;; note that all of these macros assume that you're in evil-mode, and a host of other
;; packages such as smartparens.

(defun /macros/ng-add-string-for-last-arg ()
  "With the cursor on the last argument of a function, this will extract the name
of the argument and insert a string with the value value prior to the function."
  (save-excursion
    (evil-execute-macro 1 [?F ?, ?w ?y ?w ?F ?\( ?b ?b ?l ?a ?  ?\' escape ?p ?l ?a ?, escape])))

(defun /macros/ng-function-to-array-injected ()
  "With the cursor inside the parameter list of a function, wraps the function inside
an array and adds a string for the first argument in the parameter list."
  (save-excursion
    (evil-execute-macro 1 [?F ?\( ?l ?y ?w ?F ?f ?i ?\[ ?\' escape ?p ?l ?l ?c ?w ?, ?  escape ?f ?\{ ?% ?a ?\] escape])))

(provide 'config-macros)
