(defvar parameters
  '(window-parameters . ((no-other-window . t)
                         (no-delete-other-windows . t))))

(setq fit-window-to-buffer-horizontally t)
(setq window-resize-pixelwise t)

;; Requires Emacs 27+
(setq switch-to-buffer-obey-display-actions t)

(setq
 display-buffer-alist
 `(("\\*IBuffer\\*" display-buffer-in-side-window
    (side . right) (slot . 0) (window-width . 50)
    (preserve-size . (nil . t)) ,parameters)
   ("fig: kx" display-buffer-in-side-window
    (side . left) (slot . 0) (window-width . 0.2)
    (preserve-size . (t . nil)) ,parameters)
   ("\\*\\(?:help\\|grep\\|Completions\\|google-lint\\)\\*"
    display-buffer-in-side-window
    (side . bottom) (slot . -1) (preserve-size . (nil . t))
    ,parameters)
   ;; get rid of shitty fig-process windows
   ("fig-process.*"
    display-buffer-in-side-window
    (side . bottom) (slot . 0) (preserve-size . (nil . t))
    ,parameters)
   ;; Put warnings in middle bottom window.
   ("\\*Warnings\\*" display-buffer-in-side-window
    (side . bottom) (slot . 0) (preserve-size . (nil . t))
    ,parameters)
   ("\\*\\(?:shell\\|compilation\\)\\*" display-buffer-in-side-window
    (side . bottom) (slot . 1) (preserve-size . (nil . t))
    ,parameters)))

;; How is this different from switch-to-buffer-obey-display-actions?
(setq switch-to-buffer-in-dedicated-window "pop")
