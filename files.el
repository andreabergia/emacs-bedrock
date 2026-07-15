;;; files.el --- Recent files, saved places, and project navigation

(setopt recentf-max-saved-items 250)
(setopt recentf-exclude '("/elpa/" "/\\.git/" "^/tmp/"))
(recentf-mode)

(save-place-mode)
