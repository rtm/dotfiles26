;; SHELL-RELATED

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Default shell for M-x ansi-term.
(defvar explicit-shell-file-name "/bin/bash")
(setq shell-command-switch "-ic")

;;maybe-new-shell -- go to existing shell, or make new shell, based on argument
(defun maybe-new-shell (arg)
  "Create new or jump to existing shell if the command has an argument."
  (interactive "p")

                                        ; no matter what happens, we will need to go to (after creating if necessary) the first shell buffer
  (eshell)
  (if (/= arg 1)
      (let ((new-shell-name (concat "*eshell-" (number-to-string arg) "*")))
        (if (get-buffer new-shell-name)
            (switch-to-buffer new-shell-name)
          (rename-buffer " temp-shell" nil)   ; space-prefixed buffer names are reserved for internal use
          (shell)
          (rename-buffer new-shell-name)
          (set-buffer " temp-shell")
          (rename-buffer "*eshell*")
          (set-buffer new-shell-name)
          )
        )
    )
  )

;; eshell customization
(add-hook 'eshell-preoutput-filter-functions
          ;;  'ansi-color-filter-apply) ;; this doesn't work, but the next line does!!
          'ansi-color-apply)

(add-hook 'eshell-mode-hook
   (lambda ()
     (setenv "TERM" "emacs") ; enable colors
     ))

(defun pwd-repl-home (pwd)
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
   (home-len (length home)))
    (if (and
   (>= (length pwd) home-len)
   (equal home (substring pwd 0 home-len)))
  (concat "~" (substring pwd home-len))
  pwd)))

;; eshell prompt
(defvar eshell-prompt-function
      (lambda ()
        (concat
         (propertize ((lambda (p-lst)
            (if (> (length p-lst) 3)
                (concat
                 (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                            (substring elm 0 1)))
                            (butlast p-lst 3)
                            "/")
                 "/"
                 (mapconcat (lambda (elm) elm)
                            (last p-lst 3)
                            "/"))
              (mapconcat (lambda (elm) elm)
                         p-lst
                         "/")))
          (split-string (pwd-repl-home (eshell/pwd)) "/")) 'face `(:foreground "yellow"))
;;         (or (curr-dir-git-branch-string (eshell/pwd)))
         (or "")
         (propertize " # " 'face 'default))))

(defvar eshell-highlight-prompt nil)

;; (use-package load-bash-alias
;;   :ensure t
;;   :config
;;   (setq load-bash-alias-bashrc-file "~/.bash_aliases")
;;   (setq load-bash-alias-exclude-aliases-regexp "^alias magit\\|^alias oc"))
