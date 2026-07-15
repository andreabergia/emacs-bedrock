;;; ui.el --- Visual appearance & discoverability

(use-package tokyo-night
  :ensure t
  :config
  (load-theme 'tokyo-night t)
  ;; give the current tab a blue underline accent, and a subtle box around
  ;; inactive tabs so adjacent ones stay visually separated
  (tokyo-night-with-colors
    (set-face-attribute 'tab-bar-tab nil
                         :foreground tokyo-blue :underline t)
    (set-face-attribute 'tab-bar-tab-inactive nil
                         :box (list :line-width 2 :color tokyo-comment))))

;; default font
(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 160 :weight 'regular)

;; show current line in modeline
(setopt line-number-mode t)
;; show column as well
(setopt column-number-mode t)

;; prettier underlines
(setopt x-underline-at-descent-line nil)
;; make switching buffers more consistent
(setopt switch-to-buffer-obey-display-actions t)

;; by default, don't underline trailing spaces
(setopt show-trailing-whitespace nil)
;; show buffer top and bottom in the margin
(setopt indicate-buffer-boundaries 'left)

;; enable horizontal scrolling
(setopt mouse-wheel-tilt-scroll t)
(setopt mouse-wheel-flip-direction t)

;; steady cursor
(blink-cursor-mode -1)
;; smooth scrolling
(pixel-scroll-precision-mode)

;; Common keystrokes by default
(cua-mode)

;; for terminal users, make the mouse more useful
(xterm-mouse-mode 1)

;; display line numbers in programming mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; set a minimum width
(setopt display-line-numbers-width 3)

;; nice line wrapping when working with text
(add-hook 'text-mode-hook 'visual-line-mode)

;; highlight the current line
(let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
  (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

;; always show the tab-bar, not just when there's more than one tab
(tab-bar-mode 1)
;; number each tab, so its position is clear at a glance (matches the SPC t o
;; / SPC t p next/previous bindings)
(setopt tab-bar-tab-hints t)
;; we always create/close tabs via SPC t n / SPC t k, so the mouse-only +/x
;; buttons are just clutter
(setopt tab-bar-new-button-show nil)
(setopt tab-bar-close-button-show nil)
;; add the time to the tab-bar, if visible
(add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
(add-to-list 'tab-bar-format 'tab-bar-format-global 'append)
(setopt display-time-format "%a %F %T")
(setopt display-time-interval 1)
(display-time-mode)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))


;; reversible C-x 1
(winner-mode +1)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)
