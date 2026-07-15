;;; dashboard.el --- Startup screen

;; Replaces the default *scratch*/splash screen with a startup page listing
;; recent files, projects and bookmarks, each clickable/RET-able to jump
;; straight there.

(use-package dashboard
  :ensure t
  :config
  (setopt dashboard-projects-backend 'project-el)
  ;; open projects the same way as <leader> p p (my-project-switch-project
  ;; in project.el), instead of dashboard's own project-switch prompt
  (setopt dashboard-projects-switch-function 'my-project-switch-project)
  (setopt dashboard-items '((projects . 10)
                            (recents . 10)
                            (bookmarks . 5)))
  ;; no footer quote under the banner (dashboard-set-footer is obsolete;
  ;; the footer step has to be dropped from the widget list instead)
  (setopt dashboard-startupify-list (remove 'dashboard-insert-footer
                                            dashboard-startupify-list))
  (dashboard-setup-startup-hook)
  ;; land on the first project instead of the top of the buffer
  (add-hook 'dashboard-after-initialize-hook 'dashboard-jump-to-projects))
