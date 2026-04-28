                                        ; BOB'S SHORTCUTS

(global-set-key (kbd "C-c s") 'shell)
(global-set-key (kbd "C-c C-c s") 'recompile)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c q") 'ff-get-other-file)
(global-set-key (kbd "C-c b") 'ibuffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "C-c l") 'goto-line)
(global-set-key (kbd "C-c e l") 'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-c e n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c e p") 'flymake-goto-prev-error)
(global-set-key (kbd "C-c o") 'back)
(global-set-key (kbd "C-c z") 'sort-lines)

(defun back()
  (interactive)
  (other-window -1))
