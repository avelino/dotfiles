;;; config.el -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Avelino

;; Personal info
(setq user-full-name "Avelino"
      user-mail-address (rot13 "31996+avelino@users.noreply.github.com"))

;; Set a theme for MinEmacs, supported themes include these from `doom-themes'
;; or built-in themes
(setq minemacs-theme 'doom-one) ; `doom-one' is a dark theme, `doom-one-light' is the light one

;; You can set a list of fonts to be used, like the snippet below. The first
;; font found on the system will be used:
(plist-put minemacs-fonts-plist
           :default ;; <- applies to the `default' face using `custom-theme-set-faces'
           '((:family "Iosevka Fixed Curly Slab" :height 130) ; <- priority 1
             (:family "JetBrains Mono" :height 110 :weight light) ; <- priority 2
             (:family "Cascadia Code" :height 120 :weight semi-light))) ; <- priority 3

;; To set font for arbitrary Emacs face, you need just to write the face name as
;; a keyword. For example `variable-pitch' -> `:variable-pitch':
(plist-put minemacs-fonts-plist
           :variable-pitch ;; <- applies to the `variable-pitch' face using `custom-theme-set-faces'
           '("Lato"
             "Roboto"
             "Inter"
             "Helvetica"))

;; For example to set custom font for `mode-line' -> `:mode-line':
(plist-put minemacs-fonts-plist
           :mode-line ;; <- applies to the `mode-line' face using `custom-theme-set-faces'
           '((:family "Lato" :weight regular)
             (:family "Roboto" :weight light)))

(plist-put minemacs-fonts-plist
           :mode-line-inactive ;; <- applies to the `mode-line-inactive'
           '((:family "Lato" :weight regular)
             (:family "Roboto" :weight light)))

;; You can also setup some language-specific fonts. For example, to use "Amiri"
;; or "KacstOne" for Arabic script (the first to be found). All scripts
;; supported by Emacs can be found in `+known-scripts'. The value of the extra
;; `:prepend' is passed the last argument to `set-fontset-font'. The extra
;; `:scale' parameter can be used to set a scaling factor for the font in Emacs'
;; `face-font-rescale-alist'.
(plist-put minemacs-fonts-plist
           :arabic ;; <- applies to arabic script using `set-fontset-font'
           '((:family "Amiri" :scale 0.9)
             (:family "KacstOne")))

;; Use "LXGW WenKai Mono" for Han (Chinese) script
(plist-put minemacs-fonts-plist
           :han
           '((:family "LXGW WenKai Mono" :scale 1.3)))
