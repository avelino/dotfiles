;;; packages/clojure.el -*- lexical-binding: t; -*-

;; Use the latest available packages for Clojure
;; - cider, clojure-mode
(unpin! (:lang clojure))
(package! flycheck-clj-kondo)
(package! cider)
(package! flycheck-clj-kondo)
(package! clj-refactor)
(package! rainbow-delimiters)
(package! paredit)
