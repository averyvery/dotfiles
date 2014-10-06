;; shortcuts.el

;;; Code
(setq mac-command-modifier 'hyper)
(setq ns-function-modifier 'super)
(global-set-key (kbd "H-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "H-s") 'save-buffer)
(global-set-key (kbd "H-a") 'mark-whole-buffer)

(defun follow-me ()
  (split-window-right)
  (windmove-right)
  (follow-mode)
  (split-window-right)
  (balance-windows)
  (windmove-right)
  (follow-mode)
  (windmove-left)
  (windmove-left)
)
(evil-leader/set-key "w f" (lambda () (interactive) (follow-me)))

(global-set-key [(hyper wheel-down)] 'text-scale-increase)
(global-set-key [(hyper wheel-up)] 'text-scale-decrease)

(evil-leader/set-key "d" 'dash-at-point)
(evil-leader/set-key "D" 'dash-at-point-with-docset)
