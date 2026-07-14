;;; dev.el --- Core development configuration

;; prefer treesitter modes; run M-x treesit-install-language-grammar first
(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
        (bash-mode . bash-ts-mode)
        (js2-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (json-mode . json-ts-mode)
        (css-mode . css-ts-mode)
        (python-mode . python-ts-mode)))

;; show project name in modeline
(use-package project
  :if (>= emacs-major-version 30)
  :custom
  (project-mode-line t))

(use-package eglot
  :custom
  (eglot-send-changes-idle-time 0.1)
  ;; activate Eglot in referenced non-project files
  (eglot-extend-to-xref t)
  :config
  ;; massive perf boost---don't log every event
  (fset #'jsonrpc--log-event #'ignore))

