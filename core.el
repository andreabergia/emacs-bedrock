;;; core.el --- Essential Emacs behavior settings

(setq user-full-name "Andrea Bergia"
      user-mail-address "andreabergia@gmail.com")

(setopt inhibit-splash-screen t)
;; default mode for the *scratch* buffer
(setopt initial-major-mode 'fundamental-mode)
;; this information is useless for most
(setopt display-time-default-load-average nil)

(setopt auto-revert-avoid-polling t)
;; some systems don't do file notifications well
(setopt auto-revert-interval 5)
(setopt auto-revert-check-vc-info t)
(global-auto-revert-mode)

;; save minibuffer history
(savehist-mode)

;; move through windows with Cmd-<arrow keys>
(windmove-default-keybindings 'super)

(setopt sentence-end-double-space nil)

;; make right-click do something sensible
(when (display-graphic-p)
  (context-menu-mode))

;; don't create *~ backup files
(setopt make-backup-files nil)

;; send deleted files to the macOS Trash instead of deleting them permanently
(setopt delete-by-moving-to-trash t)

;; GUI Emacs on macOS is launched by launchd, not a shell, so it doesn't see
;; PATH/env vars set in .zshrc etc.; this copies them over
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

;; No BIDI
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; maybe faster?
(setq redisplay-skip-fontification-on-input t)

;; bigger buffer for LSPs
(setq read-process-output-max (* 4 1024 1024))

;; No cursor in background windows
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Save existing clipboard content into the kill ring before overwriting it
(setq save-interprogram-paste-before-kill t)

;; no duplicate in kill ring
(setq kill-do-not-save-duplicates t)

;; ask for confirmation before exiting Emacs (C-x C-c)
(setq confirm-kill-emacs 'y-or-n-p)

;; accept "y"/"n" instead of "yes"/"no" in confirmation prompts
(setopt use-short-answers t)

