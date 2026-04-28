(require 'use-package)

;; turn off abbrevs, which cause some weird problem.
(setq save-abbrevs 'silently)

(global-set-key "\C-x5" 'split-window-horizontally)
(global-auto-revert-mode t)
(defvar global-auto-revert-non-file-buffers t)
(save-place-mode 1)
(savehist-mode 1)

;; Formatting.
(setq require-final-newline t)
(load "editorconfig")
(setq-default fill-column 80)
;; Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(apheleia-global-mode +1)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar compilation-scroll-output t)

;; kill buffer unconditionally
(defun kill-this-buffer-volatile ()
  "Kill current buffer, even if it has been modified."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))))
(global-set-key (kbd "C-x k") 'kill-this-buffer-volatile)

;;; For packaged versions which must use `require'.
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi t t)
  (load-theme 'modus-vivendi t t)
  (load-theme 'modus-vivendi-tinted t t)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

;; Catppuccin
;; (use-package catppuccin-theme)
;; (load-theme 'catppuccin :no-confirm)

;; Enable the preferred one
(enable-theme 'modus-vivendi-tinted)

(load "~/.emacs.d/init.d/revert-all-file-buffers")
(load "~/.emacs.d/init.d/melpa")
(load "~/.emacs.d/init.d/shell")
(load "~/.emacs.d/init.d/keymap")
(load "~/.emacs.d/init.d/modes")
(load "~/.emacs.d/init.d/dired")
(load "~/.emacs.d/init.d/compile")
(load "~/.emacs.d/init.d/buffer-display")
(load "~/.emacs.d/init.d/kern")

;; ANSI colors on file
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

;; Find file at point, remaps C-x C-f etc.
(ffap-bindings)

;; clippetty, for clipboard management
(use-package clipetty
  :ensure t
  )

;; MARKDOWN
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; buffer-move
(use-package buffer-move
  :ensure)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; Allow shift-<arrow> keys to move between buffers.
(windmove-default-keybindings)

;; ag, the silver searcher
(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("" "x"))
  :hook prog-mode)

(global-fira-code-mode)
(set-frame-font "Firacode 14" nil t)

;;; IDO
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; SCREEN
;; Workaround for https://debbugs.gnu.org/cgi/bugreport.cgi?bug=45824, which
;; causes Emacs not to run screen.el when TERM=screen.xterm-256color.
(add-to-list 'term-file-aliases '("screen.xterm-256color" . "screen-256color"))
;; Enable Emacs to write to the system clipboard through OSC 52 codes.
(defvar xterm-screen-extra-capabilities '(modifyOtherKeys setSelection))

;;; server
;; (require 'server)
;; (defun server-ensure-safe-dir (dir) "Noop" t)
;; (server-start)

;; Miscellaneous settings.
(menu-bar-mode -1)
;; (tool-bar-mode -1)
;; (scroll-bar-mode -1)
;; (set-face-attribute 'default nil :height 90)
(desktop-save-mode 1)
(savehist-mode 1)
(require 'dired-x)

(setq grep-highlight-matches t)

;; turn off abbrevs, which cause some weird problem.
(setq save-abbrevs 'silently)

;; go ahead and edit git files via symbolic links
(setq vc-follow-symlinks t)

;; prettier
;; (add-hook 'after-init-hook #'global-prettier-mode)

;; backups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backup files
;; Write backups to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("99d1e29934b9e712651d29735dd8dcd431a651dfbe039df158aa973461af003e" "6e13ff2c27cf87f095db987bf30beca8697814b90cd837ef4edca18bdd381901" "8d146df8bd640320d5ca94d2913392bc6f763d5bc2bb47bed8e14975017eea91" "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" default))
 '(package-selected-packages
   '(catppuccin-theme modus-themes obsidian solarized-theme fira-code-mode markdown-mode flymake apheleia web-mode smex editorconfig clipetty buffer-move ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
