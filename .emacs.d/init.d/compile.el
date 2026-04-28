(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; OR
;; (use-package ansi-color
;;   :hook (compilation-filter . ansi-color-compilation-filter))

(setq compilation-always-kill t)
(add-hook 'compilation-mode-hook 'goto-address-mode)
(setq compilation-ask-about-save nil)
(setq compilation-scroll-output t)
