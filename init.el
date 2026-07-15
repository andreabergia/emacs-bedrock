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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(avy cape corfu-terminal eat embark-consult evil exec-path-from-shell
	 jinx json-mode kind-icon magit marginalia markdown-mode
	 olivetti orderless prescient tokyo-night vertico
	 vertico-prescient wgrep yaml-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
