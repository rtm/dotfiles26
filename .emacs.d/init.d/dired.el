;; DIRED

(use-package dired-subtree :ensure t)
(use-package dired-filter  :ensure t)

;; Custom keymaps
(defvar dired-o-map (make-keymap))
(defvar dired-subtree-map (make-keymap))

(with-eval-after-load 'dired

  ;; Bind C-o and t to custom submaps
  (define-key dired-mode-map "\C-o" dired-o-map)
  (define-key dired-mode-map "t"    dired-subtree-map)

  ;; Top-level dired-mode-map bindings
  (define-key dired-mode-map "i" 'dired-subtree-toggle)
  (define-key dired-mode-map "p" 'dired-filter-pop)

  ;; C-o submap
  (define-key dired-o-map "s" 'maybe-new-shell)

  ;; t submap (dired-subtree operations)
  (define-key dired-subtree-map "x" 'dired-subtree-narrow)
  (define-key dired-subtree-map "r" 'dired-subtree-revert)
  (define-key dired-subtree-map "n" 'dired-subtree-down)
  (define-key dired-subtree-map "p" 'dired-subtree-up)
  (define-key dired-subtree-map "a" 'dired-subtree-beginning)
  (define-key dired-subtree-map "e" 'dired-subtree-end))
