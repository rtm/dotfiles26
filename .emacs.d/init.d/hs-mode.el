;; Settings for hide/show minor mode.

;; Hide the comments too when you do a 'hs-hide-all'
(setq hs-hide-comments nil)
;; Set whether isearch opens folded comments, code, or both
;; where x is code, comments, t (both), or nil (neither)
(setq hs-isearch-open t)

(add-hook `typescript-mode-hook 'hs-minor-mode)
