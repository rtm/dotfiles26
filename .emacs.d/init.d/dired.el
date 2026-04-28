;; DIRED

;; make C-o C-s work from dired
;;
;; make empty keymap
(defvar dired-o-map nil)
(or dired-o-map (setq dired-o-map (make-keymap)))

(defvar dired-subtree-map nil)
(or dired-subtree-map (setq dired-subtree-map (make-keymap)))

;; register hook to change keymap
(add-hook 'dired-mode-hook
          (lambda () (define-key dired-mode-map "\C-o" dired-o-map)))

(add-hook 'dired-mode-hook
          (lambda () (define-key dired-mode-map "t" dired-subtree-map)))

;; define favorite mappings
(define-key dired-o-map "s" 'maybe-new-shell)
(define-key dired-mode-map "i" 'dired-subtree-toggle)
(define-key dired-mode-map "p" 'dired-filter-pop)
;;(define-key dired-mode-map ";" 'dired-subtree-remove)
(define-key dired-subtree-map "x" `dired-subtree-narrow)
(define-key dired-subtree-map "r" `dired-subtree-revert)
(define-key dired-subtree-map "n" `dired-subtree-down)
(define-key dired-subtree-map "p" `dired-subtree-up)
(define-key dired-subtree-map "a" `dired-subtree-beginning)
(define-key dired-subtree-map "e" `dired-subtree-end)

;; (define-key dired-mode-map "F" dired-filter-map)
;; (define-key dired-mode-map "M" dired-filter-mark-map)
