;;; dev-git.el --- Git integration

;; best Git client to ever exist
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom
  ;; open magit-status in the current frame (no window splitting), and
  ;; restore the previous window layout when you quit magit (`q`)
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  ;; highlight the exact words that changed within a line, not just the whole line
  (magit-diff-refine-hunk 'all))

;; shows a marker next to the line number for added/modified/deleted lines,
;; kept in sync with Magit (e.g. after staging/committing)
(use-package diff-hl
  :ensure t
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh))
  :init
  (global-diff-hl-mode)
  ;; fall back to the margin when running in a terminal, since there's no
  ;; fringe to draw the marker in
  (unless (display-graphic-p)
    (diff-hl-margin-mode)))

