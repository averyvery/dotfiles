;; dvorak
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(define-key evil-normal-state-map "j" 'evil-delete)
(define-key evil-visual-state-map "j" 'evil-delete)

(define-key evil-normal-state-map "d" 'evil-backward-char)
(define-key evil-visual-state-map "d" 'evil-backward-char)
(define-key evil-normal-state-map "n" 'evil-forward-char)
(define-key evil-visual-state-map "n" 'evil-forward-char)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-visual-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-visual-state-map "h" 'evil-next-line)

(define-key evil-motion-state-map "k" 'evil-find-char-to)
(define-key evil-motion-state-map "K" 'evil-find-char-to-backward)

(define-key evil-normal-state-map "l" 'evil-search-next)
(define-key evil-normal-state-map "L" 'evil-search-previous)

;; (evil-leader/set-key "x" 'execute-extended-command)

(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-o") 'find-file)

;; (evil-leader/set-key "F" 'projectile-find-file)
;; (evil-leader/set-key "f" 'projectile-recentf)
;; (evil-leader/set-key "p" 'projectile-switch-project)
;; (evil-leader/set-key "P" 'projectile-kill-buffers)
;; (evil-leader/set-key "g" 'projectile-grep)
;; (evil-leader/set-key "G" 'find-grep-dired)
;; (evil-leader/set-key "b" 'buffer-menu)

(evil-leader/set-key "m" 'minimap-mode)


;; tabs and windows

(global-set-key (kbd "s-T") (lambda () (interactive) (elscreen-clone) (delete-other-windows) (projectile-find-file)))
(global-set-key (kbd "s-t") (lambda () (interactive) (elscreen-clone) (delete-other-windows)))
(global-set-key (kbd "s-w") (lambda () (interactive) (elscreen-kill)))

(global-set-key (kbd "s-5") 'elscreen-previous)
(global-set-key (kbd "s-6") 'elscreen-next)

;; (evil-leader/set-key "wt" 'windmove-up)
;; (evil-leader/set-key "wd" 'windmove-down)
;; (evil-leader/set-key "wn" 'windmove-right)
;; (evil-leader/set-key "wd" 'windmove-left)

;; (evil-leader/set-key "wc" (lambda () (interactive) (delete-and-balance-window)))
;; (evil-leader/set-key "wC" (lambda () (interactive) (delete-and-balance-other-windows)))
;; (evil-leader/set-key "wb" 'balance-windows)

;; (evil-leader/set-key "v" (lambda () (interactive) (open-window)))
;; (evil-leader/set-key "V" (lambda () (interactive) (open-window-find)))
;; (evil-leader/set-key "h" (lambda () (interactive) (open-horiz-window)))
;; (evil-leader/set-key "H" (lambda () (interactive) (open-horiz-window-find)))
