;; system

;;; Code
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq create-lockfiles nil)

(require 'smooth-scroll)
(smooth-scroll-mode t)

(require 'magit)
