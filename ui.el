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

;; prettier, less cluttered mode-line: shows the git branch (via vc-mode)
;; but hides the usual wall of minor-mode lighters
(use-package mood-line
  :ensure t
  :config
  ;; mood-line ships ascii/fira-code/unicode glyph sets; since the default
  ;; font is a Nerd Font, use the nicer unicode set for the buffer-status and
  ;; checker segments (the git segment below draws its own icon)
  (setq mood-line-glyph-alist mood-line-glyphs-unicode)

  ;; mood-line's own vc segment distinguishes states via face color alone,
  ;; and several of those faces turned out low-contrast in tokyo-night. So
  ;; instead: pick the icon based on state (clean / locally modified / needs
  ;; attention), always render it in one consistently high-contrast color,
  ;; and append a `*' whenever the working tree isn't clean
  (defface ab/mood-line-vc-branch '((t :inherit mood-line-major-mode))
    "Face for the git branch segment in the mode-line.")
  (tokyo-night-with-colors
    (set-face-attribute 'ab/mood-line-vc-branch nil :foreground tokyo-green))

  (defun ab/mood-line-segment-vc ()
    "Show a git branch icon (varies with state) + name, `*' when dirty."
    (when-let* ((file (buffer-file-name (buffer-base-buffer)))
                (backend (vc-backend file))
                (state (vc-state file))
                (branch (mood-line-segment-vc--rev vc-mode backend)))
      (let ((icon (cond
                   ;; locally modified/added/untracked: pencil
                   ((memq state '(edited added unregistered unlocked-changes)) ?\uF040)
                   ;; needs attention: conflict, or diverged from upstream
                   ((memq state '(needs-merge needs-update conflict removed)) ?\uF071)
                   ;; clean: plain branch icon
                   (t ?\uE0A0)))
            (dirty (not (memq state '(up-to-date ignored)))))
        (propertize (format "%c %s%s" icon branch (if dirty "*" ""))
                    'face 'ab/mood-line-vc-branch))))

  (defun ab/mood-line-segment-project-file ()
    "Return the file path relative to the current project root, or the buffer name."
    (propertize
     (if-let* ((file (buffer-file-name (buffer-base-buffer)))
               (proj (project-current))
               (root (project-root proj)))
         (file-relative-name file root)
       (format-mode-line "%b"))
     'face 'mood-line-buffer-name))

  (setq mood-line-format
        (mood-line-defformat
         :left
         (((mood-line-segment-buffer-status)      . " ")
          ((ab/mood-line-segment-project-file)    . "  ")
          (mood-line-segment-cursor-position))
         :right
         (((ab/mood-line-segment-vc)      . "  ")
          ((mood-line-segment-major-mode) . "  ")
          ((mood-line-segment-checker)    . "  "))))

  (mood-line-mode))

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
;; show the current perspective name (via the `perspective' package, see
;; project.el) right-aligned in the tab-bar
(add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
(add-to-list 'tab-bar-format 'tab-bar-format-global 'append)

(use-package which-key
  :ensure t
  :custom
  ;; which-key normally shrinks the popup to as few rows as possible (so it
  ;; prefers many short columns); asking for a tall minimum instead makes it
  ;; fill a single column top-to-bottom first, only spilling into more
  ;; columns once the entries don't fit in that height
  (which-key-min-display-lines 20)
  (which-key-max-display-columns nil)
  ;; extra gap between columns so key/description pairs don't run together
  ;; when there are multiple columns
  (which-key-add-column-padding 3)
  (which-key-side-window-location 'bottom)
  (which-key-side-window-max-height 0.4)
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
