;;; init.el --- Minimal bootstrap

(when (< emacs-major-version 29)
  (error "This config requires Emacs 29 or newer; you have version %s" emacs-major-version))

(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

(defun my-config-load (file)
  (load-file (expand-file-name file user-emacs-directory)))

(my-config-load "core.el")
(my-config-load "ui.el")
(my-config-load "completion-minibuf.el")
(my-config-load "completion-at-point.el")
(my-config-load "search.el")
(my-config-load "editing.el")
(my-config-load "dev.el")
(my-config-load "dev-git.el")
(my-config-load "dev-writing.el")
(my-config-load "lang-markdown.el")
(my-config-load "lang-yaml.el")
(my-config-load "lang-json.el")
(my-config-load "vim.el")

(setq gc-cons-threshold (or bedrock--initial-gc-threshold 800000))
