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

(defun my-project-switch-project (dir)
  "Switch to project at DIR: cd into it and open a Dired listing of its root.
Skips the `project-switch-commands' prompt entirely. Also switches to (or
creates) a perspective named after the project, so each project's buffers
stay isolated from other projects' via `persp-mode'."
  (interactive (list (project-prompt-project-dir)))
  (let ((project-current-directory-override dir))
    (persp-switch (file-name-nondirectory (directory-file-name dir)))
    (dired dir)
    (cd dir)))

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
  (add-to-list 'consult-buffer-sources persp-consult-source))
