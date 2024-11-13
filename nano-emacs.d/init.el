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
(require 'nano-theme-dark)
(require 'nano-defaults)
(require 'nano-session)
(require 'nano-modeline)
(require 'nano-bindings)
(require 'nano-counsel)
(require 'nano-help)
(require 'nano-minibuffer)
(nano-faces)
(nano-theme)
(nano-theme-set-dark)
(nano-refresh-theme)

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

(provide 'init)
;;; init.el ends here
