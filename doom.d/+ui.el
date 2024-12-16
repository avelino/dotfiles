;;; ../dotfiles/doom.d/+ui.el -*- lexical-binding: t; -*-

;; ui
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; no title bar and round corners
(add-to-list 'default-frame-alist '(undecorated-round . t))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Avelino"
      user-mail-address "31996+avelino@users.noreply.github.com"
      user-real-login-name "avelino"
      github-user-name "avelino")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
(setq doom-font (font-spec
                 :family "Maple Mono"
                 :size 20
                 :weight 'semi-light
                 :width 'normal)
      doom-variable-pitch-font (font-spec
                                :family "Maple Mono"
                                :size 20))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `nil)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-ayu-light)
;; (setq doom-theme 'doom-tokyo-night)
(setq doom-theme 'doom-moonlight)

;; evil
(setq evil-normal-state-cursor '(box "light blue")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))

(setq auto-save-default t)

(setq confirm-kill-emacs nil)

(setq doom-modeline-enable-word-count t)

;; check
(use-package! languagetool
  :defer t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :config
  (setq languagetool-api-key (getenv "LANGUAGETOOL_KEY")
        languagetool-username "avelinorun@gmail.com"
        languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "/usr/local/Cellar/languagetool/6.0/libexec/languagetool.jar"
        languagetool-server-command "/usr/local/Cellar/languagetool/6.0/libexec/languagetool-server.jar"))

(use-package! company
  :init
  (setq company-require-match nil            ; Don't require match, so you can still move your cursor as expected.
        company-tooltip-align-annotations t  ; Align annotation to the right side.
        company-eclim-auto-save nil          ; Stop eclim auto save.
        company-dabbrev-downcase nil)        ; No downcase when completion.
  :config
  ;; Enable downcase only when completing the completion.
  (defun jcs--company-complete-selection--advice-around (fn)
    "Advice execute around `company-complete-selection' command."
    (let ((company-dabbrev-downcase t))
      (call-interactively fn)))
  (advice-add 'company-complete-selection :around #'jcs--company-complete-selection--advice-around))

;; (use-package! moody
;;   :config
;;   (setq x-underline-at-descent-line t)
;;   (setq-default mode-line-format
;;                 '(" "
;;                   mode-line-front-space
;;                   mode-line-client
;;                   mode-line-frame-identification
;;                   mode-line-buffer-identification " " mode-line-position
;;                   (vc-mode vc-mode)
;;                   (multiple-cursors-mode mc/mode-line)
;;                   " " mode-line-modes
;;                   mode-line-end-spaces)))

(use-package! face-remap
  :bind(("C-+" . text-scale-increase)
        ("C--" . text-scale-decrease)))
