;;; project.el --- Project navigation

;; project.el ships with Emacs and is autoloaded; C-x p is already bound to
;; the full project-prefix-map, and plain git-clone repos are auto-detected
;; via VC with no further config needed.

;; use the full project-prefix-map right after switching projects, instead
;; of the restricted default subset of commands
(setopt project-switch-use-entire-map t)

;; for a top-level folder containing multiple big git repos (where the top
;; folder itself is not a repo): don't make the top folder a project, since
;; that would force a slow non-VC file listing across everything underneath.
;; Instead, bulk-register the nested repos as their own fast projects.
(keymap-set project-prefix-map "u" 'project-remember-projects-under)
