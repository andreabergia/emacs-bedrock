;;; project.el --- Project navigation

;; project.el ships with Emacs and is autoloaded; C-x p is already bound to
;; the full project-prefix-map, and plain git-clone repos are auto-detected
;; via VC with no further config needed.

;; use the full project-prefix-map right after switching projects, instead
;; of the restricted default subset of commands
(setopt project-switch-use-entire-map t)

;; project-find-regexp / project-query-replace-regexp shell out to a search
;; program; default to ripgrep instead of grep since it's much faster on
;; large trees
(setopt xref-search-program 'ripgrep)

;; for a top-level folder containing multiple big git repos (where the top
;; folder itself is not a repo): don't make the top folder a project, since
;; that would force a slow non-VC file listing across everything underneath.
;; Instead, bulk-register the nested repos as their own fast projects.
(keymap-set project-prefix-map "u" 'project-remember-projects-under)

(defvar my-persp-layout-directory (expand-file-name "var/persp-layouts/" user-emacs-directory)
  "Where each project's perspective (open files + window layout) is saved,
so it can be restored the next time that project's perspective is created.")

(defun my-persp-layout-file (name)
  "Path to the saved layout file for the perspective named NAME."
  (expand-file-name (concat name ".el") my-persp-layout-directory))

(defun my-persp-buffer-file (buffer)
  "File or directory BUFFER is visiting, or nil if BUFFER isn't worth saving
\(e.g. a *scratch*-like buffer with no file behind it)."
  (unless (string-prefix-p "*" (buffer-name buffer))
    (with-current-buffer buffer
      (or buffer-file-name
          (and (eq major-mode 'dired-mode) default-directory)))))

(defun my-persp-save-layout (name)
  "Save perspective NAME's open files and window layout to disk."
  (with-perspective name
    (let ((files (delq nil (mapcar #'my-persp-buffer-file (persp-current-buffers))))
          (window-state (window-state-get (frame-root-window) t)))
      (make-directory my-persp-layout-directory t)
      (with-temp-file (my-persp-layout-file name)
        (prin1 (list files window-state) (current-buffer))))))

(defun my-persp-load-layout (name dir)
  "Restore perspective NAME's saved layout, or fall back to a Dired listing
of DIR if nothing was saved for it yet."
  (let ((layout-file (my-persp-layout-file name)))
    (if (not (file-exists-p layout-file))
        (dired dir)
      (pcase-let ((`(,files ,window-state)
                   (with-temp-buffer
                     (insert-file-contents layout-file)
                     (read (current-buffer)))))
        (dolist (file files)
          (if (file-directory-p file) (dired file) (find-file-noselect file)))
        (window-state-put window-state (frame-root-window) 'safe)))))

(defun my-project-switch-project (dir)
  "Switch to project at DIR: cd into it and restore (or start) its perspective.
Skips the `project-switch-commands' prompt entirely. Also switches to (or
creates) a perspective named after the project, so each project's buffers
stay isolated from other projects' via `persp-mode'. The first time a
project's perspective is created in a given Emacs session, its previously
saved layout (open files and window splits) is restored via
`my-persp-load-layout'; switching back to an already-open perspective
later in the same session leaves it untouched."
  (interactive (list (project-prompt-project-dir)))
  (let* ((project-current-directory-override dir)
         (name (file-name-nondirectory (directory-file-name dir)))
         (new-perspective (not (member name (persp-names)))))
    (persp-switch name)
    (cd dir)
    (when new-perspective
      (my-persp-load-layout name dir))))

(use-package perspective
  :ensure t
  :after consult
  :init
  ;; we drive perspectives entirely through our own SPC p / SPC t bindings,
  ;; so no need for persp-mode's own prefix key
  (setq persp-suppress-no-prefix-key-warning t)
  ;; show only the current perspective name in the tab bar/mode line,
  ;; instead of the full list of open perspectives
  (setq persp-modestring-short t)
  (persp-mode)
  :config
  ;; scope consult-buffer to the current perspective by default; all buffers
  ;; are still reachable via consult's narrowing (press "b")
  (consult-customize consult-source-buffer :hidden t :default nil)
  (add-to-list 'consult-buffer-sources persp-consult-source)

  ;; save the perspective we're leaving, so its layout survives a restart
  (add-hook 'persp-before-switch-hook
            (lambda () (my-persp-save-layout (persp-current-name))))
  ;; also save every perspective on quit, in case some were never
  ;; explicitly switched away from during this session
  (add-hook 'kill-emacs-hook
            (lambda () (mapc #'my-persp-save-layout (persp-names)))))
