;; Deal with mouse issues.
;; See https://emacs.stackexchange.com/questions/61079/how-to-make-the-mouse-only-change-point-only-when-clicked-in-the-same-window.

(defun bobmyers/event-in-current-window-p (event)
  "Check if EVENT happened in the current window."
  (eq (selected-window) (posn-window (event-start event))))

(defun bobmyers/mouse-set-point (click &optional promote-to-region)
  "Set point based on click location.

If CLICK happened in an inactive window, select that window without setting point"
  (interactive "e\np")
  (if (bobmyers/event-in-current-window-p click)
      (call-interactively 'mouse-set-point)
    (call-interactively 'mouse-select-window)))

(global-set-key [mouse-1] 'bobmyers/mouse-set-point)
(global-unset-key [down-mouse-1])
