;;; init.el --- Startup file for nano Emacs          -*- lexical-binding: t; -*-

;; Copyright (C) 2022

;; Author:  <avelino>
;; Keywords: lisp,convenience

;; Bootstrap straight package installer

;;; Commentary:

;;; Code:

;; M is set to CMD (much easier)
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(global-set-key (kbd "C-z ") 'undo)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install Nano Emacs repository.
(straight-use-package
 '(nano-emacs :type git :host github :repo "rougier/nano-emacs"))

;; Use use-package to install packages.
(straight-use-package 'use-package)
(customize-set-variable 'straight-use-package-by-default t)

;; Use no-littering to minimize pollution.
(use-package no-littering
  :config (require 'no-littering))

;; These are requiered for the nano-packages that will be used.
(use-package smex)
(use-package counsel)
(use-package mini-frame)

;; Set fonts for Nano Emacs before it is loaded.
(setq nano-font-family-monospaced "Maple Mono")
(setq nano-font-family-proportional "Maple Mono")
(setq nano-font-size 20)

;; Load required modules.
(require 'nano-layout)
(require 'nano-base-colors)
(require 'nano-colors)
(require 'nano-faces)
(require 'nano-theme)
(require 'nano-theme-light)
(require 'nano-theme-dark)
(require 'nano-defaults)
(require 'nano-session)
(require 'nano-modeline)
(require 'nano-bindings)
(require 'nano-counsel)
;; (require 'nano-command)
(require 'nano-help)
(require 'nano-minibuffer)
(nano-faces)
(nano-theme)
(nano-theme-set-dark)
(nano-refresh-theme)
;; (nano-defaults)
;; (nano-command)
;; (nano-minibuffer)

;; No menu, tool or scrollbars.
(tool-bar-mode 0)
(set-scroll-bar-mode nil)
(menu-bar-mode 0)

;; These are optional packages.

;; Magit is a very useful tool.
(use-package magit
  :bind ("C-x g" . 'magit-status))

;; Utilities, nice to have.
(use-package elgrep)
(use-package htmlize)
(use-package powershell)
(use-package ob-powershell
  :config (require 'ob-powershell))
(use-package try)

;;
(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.8)) ;; default is 0.2

;; :lang :writer
(use-package markdown-mode
:ensure t
:mode ("README\\.md\\'" . gfm-mode)
:init (setq markdown-command "multimarkdown"))

;; :lang :d2
(use-package ob-d2
  :ensure t
  :after d2-mode)
(require 'ob-d2)
(setq d2-location "/opt/homebrew/bin/d2")
(setq d2-output-format ".png") ;; Emacs sometimes chokes on svg

;; :lang :clojure
(use-package clojure-mode-extra-font-locking
  :ensure t)

(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojure-mode)
         ("\\.cljd\\'" . clojure-mode)
         ("\\.cljc\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode))
  :init
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'clojure-mode-extra-font-locking)
  (add-hook 'clojure-mode-hook #'eldoc-mode)
  (add-hook 'clojure-mode-hook #'lsp)
  (add-hook 'clojure-mode-hook #'flycheck-mode)
  (add-hook 'clojure-mode-hook #'idle-highlight-mode))

(use-package cider
  :ensure t
  :defer t
  :diminish subword-mode
  :config
  (setq nrepl-log-messages t
        cider-repl-display-in-current-window t
        cider-repl-use-clojure-font-lock t
        cider-prompt-save-file-on-load 'always-save
        cider-font-lock-dynamically '(macro core function var)
        nrepl-hide-special-buffers t
        cider-overlays-use-font-lock t)
  (cider-repl-toggle-pretty-printing))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c C-u" ;; aids which-key
        gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil
        company-minimum-prefix-length 1
        lsp-idle-delay 0.800
        lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
                                        ; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
        cider-eldoc-display-for-symbol-at-point t ; disable cider showing eldoc during symbol at point
        )
  :config
  (define-key lsp-mode-map (kbd "C-c C-u") lsp-command-map)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (clojure-mode . lsp)
         ;; if you want which-key integration
         ;;(lsp-mode . lsp-enable-which-key-integration)
         )
  :commands lsp)

;; optionally
(use-package lsp-ui       :ensure t :commands lsp-ui-mode)
(use-package lsp-ivy      :ensure t :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)

(provide 'init)
;;; init.el ends here
