;;; dev.el --- Core development configuration

;; auto-install tree-sitter grammars and switch to -ts-mode when available
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install t)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; show project name in modeline
(use-package project
  :if (>= emacs-major-version 30)
  :custom
  (project-mode-line t))

(use-package treesit-fold
  :ensure t
  :hook (prog-mode . treesit-fold-mode))

(use-package eglot
  :custom
  (eglot-send-changes-idle-time 0.1)
  ;; activate Eglot in referenced non-project files
  (eglot-extend-to-xref t)
  :config
  ;; massive perf boost---don't log every event
  (fset #'jsonrpc--log-event #'ignore))

