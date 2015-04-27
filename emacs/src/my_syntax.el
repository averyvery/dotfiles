;; syntax.el

;;; Code

(require 'haml-mode)
(require 'sass-mode)
(require 'js2-mode)

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

(add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.region\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.block\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.item\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.list\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.scss.erb\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass.erb\\'" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.react$" . js2-mode))
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
  ;; (font-lock-add-keywords nil '(("\\(this\\.\\)"             (0 (replace-with "@")))))
  ;; (font-lock-add-keywords nil '(("\\(module.exports =\\)"    (0 (replace-with "^")))))
  ;; (font-lock-add-keywords nil '(("\\(var \\)"                (0 (replace-with "+")))))
  ;; (font-lock-add-keywords nil '(("\\(let \\)"                (0 (replace-with "-")))))
  ;; (font-lock-add-keywords nil '(("\\(return\\)"              (0 (replace-with "<=")))))
  (font-lock-add-keywords nil '(("\\(console.log\\)"         (0 (replace-with "?")))))

  (font-lock-add-keywords nil '(("\\('\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(;\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(,\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(\\.\\)"         1 '(:foreground "#6d5e52") t)))

)

(add-hook 'js2-mode-hook 'pretty-js-keywords)
(setq js2-strict-missing-semi-warning nil)

(defun pretty-coffee-keywords ()
  (font-lock-add-keywords nil '(("\\(module.exports =\\)"    (0 (replace-with "⇇"))))))

(add-hook 'coffee-mode-hook 'pretty-js-keywords)

(global-color-identifiers-mode 1)

(require 'jsx-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
