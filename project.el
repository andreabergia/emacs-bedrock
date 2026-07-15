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
  "Switch to project at DIR: cd into it and list its files.
Skips the `project-switch-commands' prompt entirely."
  (interactive (list (project-prompt-project-dir)))
  (let ((default-directory dir)
        (project-current-directory-override dir))
    (project-find-file)))
