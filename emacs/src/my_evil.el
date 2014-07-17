;; evil.el

;;; Code:
(setq evil-shift-width 2)
(require 'evil-leader)
(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "x" 'execute-extended-command)
(evil-leader/set-key "e" (lambda () (interactive) (elscreen-create) (find-file "~/.emacs.d/init.el")))
(evil-leader/set-key "/" 'comment-dwim)
(evil-leader/set-key "d" 'dired)
(evil-leader/set-key "r" 'replace-string)
(evil-leader/set-key "t" 'tabify)
(evil-leader/set-key "T" 'untabify)

;; dvorak
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

(define-key evil-normal-state-map ":" 'goto-line)

;; convenient "new line" enter
(defun insert-two-lines ()
	(newline)
	(newline)
  (indent-according-to-mode)
	(previous-line)
	(indent-according-to-mode)
)
(define-key evil-insert-state-map [(shift return)] (lambda () (interactive) (insert-two-lines)))


(evil-leader/set-key "v" (lambda () (interactive) (open-window)))

;; dired
(require 'dired)
(eval-after-load 'dired
 '(progn
    (evil-make-overriding-map dired-mode-map 'normal t)
    (evil-define-key 'normal dired-mode-map
      "d" 'evil-backward-char
      "h" 'evil-next-line
      "t" 'evil-previous-line
      "n" 'evil-forward-char
      "H" 'dired-goto-file
      "T" 'dired-do-kill-lines
      "r" 'dired-do-redisplay)))

;; buffer menu
(eval-after-load "buff-menu"
 '(progn
    (evil-make-overriding-map Buffer-menu-mode-map)
    (evil-define-key 'motion Buffer-menu-mode-map
      "d" 'evil-backward-char
      "h" 'evil-next-line
      "t" 'evil-previous-line
      "n" 'evil-forward-char
      "j" 'Buffer-menu-delete)))

;; prelude-move-line-up
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(define-key evil-normal-state-map (kbd "C-M-h") 'move-line-down)
(define-key evil-normal-state-map (kbd "C-M-t") 'move-line-up)


;; ace
(require 'ace-jump-mode)
(evil-leader/set-key "j" 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "<RET>") 'ace-jump-word-mode)
(evil-leader/set-key "k" 'ace-jump-line-mode)
(define-key evil-normal-state-map (kbd "<S-RET>") 'ace-jump-line-mode)
(evil-leader/set-key "<SPC>" 'ace-jump-word-mode)
(evil-leader/set-key "<RET>" 'ace-jump-line-mode)


;; lose the :
;; (define-key evil-normal-state-map ":" 'execute-extended-command)
