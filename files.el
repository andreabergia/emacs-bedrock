;;; files.el --- Recent files, saved places, and project navigation

(setopt recentf-max-saved-items 250)
(setopt recentf-exclude '("/elpa/" "/\\.git/" "^/tmp/"))
(recentf-mode)

(save-place-mode)

;; restore open buffers and window layout from the previous session
(desktop-save-mode 1)

;; colorize dired listings (directories, symlinks, dates, file types)
(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode)
  :config
  ;; diredfl gives each permission-bit character (rwxrwxrwx) its own background
  ;; color by default, which is too busy; strip those down to the default face
  (dolist (face '(diredfl-read-priv diredfl-write-priv diredfl-exec-priv
                  diredfl-dir-priv diredfl-no-priv diredfl-other-priv
                  diredfl-rare-priv diredfl-link-priv diredfl-number
                  diredfl-file-name diredfl-file-suffix))
    (set-face-attribute face nil :foreground 'unspecified :background 'unspecified :inherit 'default)))
