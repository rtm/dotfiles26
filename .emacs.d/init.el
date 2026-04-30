; See https://g3doc.corp.google.com/javascript/typescript/g3doc/start/setup/emacs.md?cl=head

(require 'use-package)

;; (unless (assoc-default "melpa" package-archives)
;;   (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
;; (unless (assoc-default "nongnu" package-archives)
;;   (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t))

;; turn off abbrevs, which cause some weird problem.
(setq save-abbrevs 'silently)

(global-auto-revert-mode t)
;; (global-auto-revert-non-file-buffers t)

;; Set Ibuffer to automatically update itself.
(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-auto-mode 1)))

(save-place-mode 1)
(savehist-mode 1)

;; Default shell for M-x ansi-term.
(setq explicit-shell-file-name "/bin/bash")
(setq shell-command-switch "-ic")

(setq dired-auto-revert-buffer t)
(setq dired-listing-switches "-alhv")
(setq dired-recursive-copies 'always)
(setq dired-dwim-target t)
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setopt use-short-answers t)
(setq-default fill-column 80)
(setq-default visible-bell t)

;; Following symlinks. See https://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks t)

;; Prevent a mouse click in a window from setting the cursor.
;; (defun mouse-set-point ())

(repeat-mode)

;; Undo and redo window configurations.
(winner-mode 1)

;; Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)

;; kill buffer unconditionally
(defun kill-this-buffer-volatile ()
  "Kill current buffer, even if it has been modified."
  (interactive)
  (set-buffer-modified-p nil)
  (kill-this-buffer))
(global-set-key (kbd "C-x k") 'kill-this-buffer-volatile)

;; Allow quitting emacs without annoying confirmation.
(setq confirm-kill-processes nil)

(load "~/.emacs.d/init.d/appearance");
(load "~/.emacs.d/init.d/revert-all-file-buffers")
(load "~/.emacs.d/init.d/melpa")
(load "~/.emacs.d/init.d/shell")
(load "~/.emacs.d/init.d/keymap")
(load "~/.emacs.d/init.d/modes")
(load "~/.emacs.d/init.d/hs-mode")
(load "~/.emacs.d/init.d/obsidian")
(load "~/.emacs.d/init.d/dired")
(load "~/.emacs.d/init.d/ff-other-file")
(load "~/.emacs.d/init.d/compile")
(load "~/.emacs.d/init.d/display-buffer")
(load "~/.emacs.d/init.d/mouse")

(load "~/.emacs.d/local.el")

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; FIRA CODE
;; https://github.com/jming422/fira-code-mode
;; (use-package fira-code-mode
;; ;;  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x")) ;; List of ligatures to turn off
;;   :hook prog-mode) ;; Enables fira-code-mode automatically for programming major modes

;; ANSI colors on file
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'find-file-hook
          (lambda ()
            (when (and (buffer-file-name) (string-match "\\.log\\'" (buffer-file-name)))
              (display-ansi-colors))))

;; Find file at point, remaps C-x C-f etc.
(ffap-bindings)

;; ;; clippetty, for clipboard management
;; (use-package clipetty
;;               :ensure t
;;               )

;; surround
;; (use-package surround
;;   :ensure t
;;   :bind-keymap ("M-'" . surround-keymap))

;; buffer-move
;; (use-package buffer-move
;;   :ensure)
;; (global-set-key (kbd "<C-S-up>")     'buf-move-up)
;; (global-set-key (kbd "<C-S-down>")   'buf-move-down)
;; (global-set-key (kbd "<C-S-left>")   'buf-move-left)
;; (global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; ;; Allow shift-<arrow> keys to move between buffers.
(windmove-default-keybindings)

(use-package diminish :ensure t)

;; ag, the silver searcher
;; (use-package ag
;;   :ensure t
;;   :commands (ag ag-regexp ag-project))

;; Set the TERM environment variable for all Emacs-started processes
;; to one that supports 256 colors.
(setenv "TERM" "xterm-256color")
(require 'ansi-color)
(ansi-color-for-comint-mode-on)

;;; SCREEN
;; Workaround for https://debbugs.gnu.org/cgi/bugreport.cgi?bug=45824, which
;; causes Emacs not to run screen.el when TERM=screen.xterm-256color.
(add-to-list 'term-file-aliases '("screen.xterm-256color" . "screen-256color"))
;; Enable Emacs to write to the system clipboard through OSC 52 codes.
(setq xterm-screen-extra-capabilities '(modifyOtherKeys setSelection))

;;; server
;; (require 'server)
;; (defun server-ensure-safe-dir (dir) "Noop" t)
;; (server-start)

;; Miscellaneous settings.
(menu-bar-mode -1)
(tool-bar-mode -1)
;; (scroll-bar-mode -1)

;; EDITORCONFIG
(use-package editorconfig
  :ensure t
  :config
;;  :diminish "EC" ;; why doesn't this work?
  (editorconfig-mode 1))
(diminish 'editorconfig-mode)
(diminish 'eldoc-mode)

;; (set-face-attribute 'default nil :height 90)
(desktop-save-mode 1)
(require 'dired-x)

(setq grep-highlight-matches t)

;; ;; Make URLs clickable everywhere.
(add-hook 'after-init-hook #'global-goto-address-mode)
(add-hook 'shell-mode-hook #'goto-address-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backup files
;; Write backups to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; ;; customizations
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(put 'set-goal-column 'disabled nil)

;; SMEX
(use-package smex
  :ensure t
  :bind (("M-x" . smex))
  :config (smex-initialize))
