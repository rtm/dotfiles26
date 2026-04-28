;; Sacha Coen's completion ideas.

(use-package vertico :config (vertico-mode +1))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package prescient :config (prescient-persist-mode +1))
(use-package company-prescient :init (company-prescient-mode +1))
