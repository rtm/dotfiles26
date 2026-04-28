;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ff-find-other-file, for Google/Zylon.
(defvar my-zylon-other-file-alist
  '(("_template\\.tsx$" (".scss" ".ts"))
    ("\\.ts$" ("_template.tsx" ".scss"))
    ("\\.scss$" ("_template.tsx" ".ts"))))


(setq-default ff-other-file-alist 'my-zylon-other-file-alist)
(setq-default ff-always-in-other-window t)
