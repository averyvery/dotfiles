;; matching.el

;;; Code

;; (require 'ido-better-flex)
;; (ido-better-flex/enable)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
