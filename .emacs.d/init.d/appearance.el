(require-theme 'modus-themes)

;; Add all your customizations prior to loading the themes.
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil)

(setq modus-themes-common-palette-overrides modus-themes-preset-overrides-intense)

;; Load the theme of your choice.
(load-theme 'modus-operandi-tinted)

;; Optionally define a key to switch between Modus themes.  Also check
;; the user option `modus-themes-to-toggle'.
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

;; (set-frame-font "Liberation Mono 10" nil t)
