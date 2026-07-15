;;; dev-git.el --- Git integration

;; best Git client to ever exist
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  ;; open magit-status in the current frame (no window splitting), and
  ;; restore the previous window layout when you quit magit (`q`)
  :custom (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

