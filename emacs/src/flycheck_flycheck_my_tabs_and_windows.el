;; tabs.el

;;; Code
(load "elscreen" "ElScreen" t)
(elscreen-start)
(global-set-key (kbd "H-t") (lambda () (interactive) (elscreen-create) (projectile-switch-project)))
(global-set-key (kbd "H-T") (lambda () (interactive) (elscreen-create)))
(global-set-key (kbd "H-w") 'elscreen-kill)
(global-set-key (kbd "H-5") 'elscreen-previous)
(global-set-key (kbd "H-6") 'elscreen-next)

(evil-leader/set-key "wt" 'windmove-up)
(evil-leader/set-key "wd" 'windmove-down)
(evil-leader/set-key "wn" 'windmove-right)
(evil-leader/set-key "wd" 'windmove-left)
