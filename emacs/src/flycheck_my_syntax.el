;; syntax.el

;;; Code

;; sass

(require 'haml-mode)
(require 'sass-mode)
(require 'js2-mode)

(electric-pair-mode 1)

(defun sass-indent-p ()
  "Return t if the current line can have lines nested beneath it."
  (unless (or (looking-at "^.* :.*$")
              (looking-at "^.*: .*$"))
    (loop for opener in sass-non-block-openers
          if (looking-at opener) return nil
          finally return t)))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; indentation & tabs
(setq-default js2-indent-level 2)
(setq-default js2-basic-offset 2)
(setq-default js2-bounce-indent-p t)
(setq-default tab-width 2)

(defun tabs ()
  (setq tab-width 2)
  (setq indent-tabs-mode t)
)
;; (add-hook 'web-mode-hook 'tabs)
;; (add-hook 'html-mode-hook 'tabs)
;; (add-hook 'php-mode-hook 'tabs)
;; (add-hook 'js2-mode-hook 'tabs)
;; (add-hook 'css-mode-hook 'tabs)
;; (add-hook 'sass-mode-hook 'tabs)

(defun coffee-tabs ()
  ;; (setq coffee-indent-tabs-mode t)
  ;; (setq indent-tabs-mode t)
  ;; (setq coffee-tab-width 2)
  (setq coffee-indent-tabs-mode nil)
  (setq indent-tabs-mode nil)
  (setq coffee-tab-width 2)
)
(add-hook 'coffee-mode-hook 'coffee-tabs)

(defun sass-tweaks ()
	(auto-complete-mode)
	(yas-minor-mode)
)
(add-hook 'sass-mode-hook 'sass-tweaks)
(add-hook 'scss-mode-hook 'sass-tweaks)

;; (defun scss-tabs ()
;;   (local-set-key (kbd "RET") 'newline-and-indent)
;; )

;; https://github.com/XuHaoJun/emacs.d/blob/master/prog/lng/setup-coffee-mode.el
(add-hook 'coffee-mode-hook (lambda ()
	(define-key evil-insert-state-local-map (kbd "RET") 'coffee-newline-and-indent)
	(setq evil-auto-indent nil)
	(eval-after-load 'evil-mode
		(progn
			(defun evil-coffee-open-below ()
				(interactive)
				(end-of-line)
				(coffee-newline-and-indent)
				(evil-insert 1))
			(defun evil-coffee-open-above ()
				(interactive)
				(previous-line 1)
				(end-of-line)
				(coffee-newline-and-indent)
				(evil-insert 1))))
	(define-key evil-normal-state-local-map "o" 'evil-coffee-open-below)
	(define-key evil-normal-state-local-map "O" 'evil-coffee-open-above)))

;; (add-hook 'prelude-scss-mode-hook 'rainbow-mode)
;; (add-hook 'prelude-scss-mode-hook 'scss-tabs)

(add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.scss.erb\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass.erb\\'" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

(defun replace-with(symbol)
  "Replaces specific patterns with a single character symbol."
  (compose-region (match-beginning 1)(match-end 1) symbol))

(defun pretty-js-keywords ()
	(set-face-foreground 'rainbow-delimiters-depth-1-face "#796c63")
	(set-face-foreground 'rainbow-delimiters-depth-2-face "#6b5c51")
	(set-face-foreground 'rainbow-delimiters-depth-3-face "#85786e")
	(set-face-foreground 'rainbow-delimiters-depth-4-face "#a69689")
	(set-face-foreground 'rainbow-delimiters-depth-5-face "#b9aa9d")
	(set-face-foreground 'rainbow-delimiters-depth-6-face "#ccbeb3")
	(set-face-foreground 'rainbow-delimiters-depth-7-face "#e3d9d2")

  "A list of keywords to replace."
  (font-lock-add-keywords nil '(("\\(function\\)"            (0 (replace-with "ƒ")))))
  (font-lock-add-keywords nil '(("\\(\\.prototype\\.\\)"     (0 (replace-with "::")))))
  (font-lock-add-keywords nil '(("\\(this\\.\\)"             (0 (replace-with "@")))))
  (font-lock-add-keywords nil '(("\\(module.exports =\\)"    (0 (replace-with "^")))))
  (font-lock-add-keywords nil '(("\\(var \\)"                (0 (replace-with "+")))))
  (font-lock-add-keywords nil '(("\\(return\\)"              (0 (replace-with "<=")))))
  (font-lock-add-keywords nil '(("\\(console.log\\)"         (0 (replace-with "?")))))

  (font-lock-add-keywords nil '(("\\('\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(;\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(,\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(\\.\\)"         1 '(:foreground "#6d5e52") t)))

)

(add-hook 'js2-mode-hook 'pretty-js-keywords)

(defun pretty-coffee-keywords ()
  (font-lock-add-keywords nil '(("\\(module.exports =\\)"    (0 (replace-with "⇇"))))))

(add-hook 'coffee-mode-hook 'pretty-js-keywords)

(global-color-identifiers-mode 1)
