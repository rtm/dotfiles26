;; company-mode
;; (use-package company
;;   :defer 1
;;   :init (setq
;;          company-tooltip-align-annotations t
;;          company-tooltip-minimum-width 30)
;;   :config (global-company-mode)
;;   :bind ("M-<tab>" . company-complete))

(setq company-tooltip-align-annotations t)

;; (use-package typescript-mode
;;   :mode (("\\.ts\\'" . typescript-mode))
;;   :mode (("\\.tsx" . typescript-mode)))

;; Format files on save.
;; Replaced by prettier, see below.
;; (add-hook 'typescript-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook #'google-clang-format-file nil :local)))

;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; (setq google3-eglot-enabled-modes
;;       (append google3-eglot-enabled-modes '(tsx-ts-mode)))

(setq-default typescript-indent-level 2)

;;cursor movement takes into account camelcasing bullshit
(add-hook 'js2-mode-hook 'subword-mode)
(add-hook 'typescript-mode-hook 'subword-mode)
;; Would (add-hook 'typescript-ts-base-mode-hook 'subword-mode) do the job?
(add-hook 'typescript-ts-mode-hook 'subword-mode)
(add-hook 'tsx-ts-mode-hook 'subword-mode)

;; This used to work, but now is undefined?
;; (add-to-list 'eglot-server-programs '(scss-mode . ("css-languageserver" "--stdio")))
