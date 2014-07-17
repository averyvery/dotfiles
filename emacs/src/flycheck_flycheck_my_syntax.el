;; syntax.el

;;; Code
;; sass
(require 'haml-mode)
(require 'sass-mode)

;; coffee
(require 'coffee-mode)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; indentation & tabs
(setq-default js2-indent-level 2)
(setq-default js2-basic-offset 2)
(setq-default js2-bounce-indent-p t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode t)

(defun tabs ()
  (setq tab-width 2)
  (setq indent-tabs-mode t)
)
(add-hook 'prog-mode-hook 'tabs)
(add-hook 'web-mode-hook 'tabs)
(add-hook 'html-mode-hook 'tabs)
(add-hook 'php-mode-hook 'tabs)
(add-hook 'js2-mode-hook 'tabs)
(add-hook 'css-mode-hook 'tabs)
(add-hook 'sass-mode-hook 'tabs)
(add-hook 'web-mode-hook 'tabs)

(defun scss-tabs ()
  (local-set-key (kbd "RET") 'newline-and-indent)
)

(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'scss-tabs)
(add-hook 'prelude-scss-mode-hook 'rainbow-mode)
(add-hook 'prelude-scss-mode-hook 'scss-tabs)

(add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . html-mode))

(defun replace-with(symbol)
  "Replaces specific patterns with a single character symbol."
  (compose-region (match-beginning 1)(match-end 1) symbol))

(defun pretty-js-keywords ()
  "A list of keywords to replace."
  ;; (font-lock-add-keywords nil '(("\\(,\n\\)"             (0 (replace-with )))))
  ;; (font-lock-add-keywords nil '(("\\(;\n\\)"             (0 (replace-with )))))
  ;; (font-lock-add-keywords nil '(("\\(require\\)"         (0 (replace-with "ϱ")))))
  ;; (font-lock-add-keywords nil '(("\\(define\\)"          (0 (replace-with "Δ")))))
  ;; (font-lock-add-keywords nil '(("\\(Backbone.\\)"       (0 (replace-with "µ")))))
  ;; (font-lock-add-keywords nil '(("\\(Model\\)"           (0 (replace-with "M")))))
  ;; (font-lock-add-keywords nil '(("\\(View\\)"            (0 (replace-with "V")))))
  ;; (font-lock-add-keywords nil '(("\\(Collection\\)"      (0 (replace-with "C")))))
  ;; (font-lock-add-keywords nil '(("\\(Router\\)"          (0 (replace-with "®")))))
  (font-lock-add-keywords nil '(("\\(function\\)"        (0 (replace-with "ƒ")))))
  (font-lock-add-keywords nil '(("\\(function\(\)\\)"    (0 (replace-with "λ")))))
  (font-lock-add-keywords nil '(("\\(\\.prototype\\.\\)" (0 (replace-with "…")))))
  (font-lock-add-keywords nil '(("\\(this\\.\\)"         (0 (replace-with "@")))))
  (font-lock-add-keywords nil '(("\\(return\\) ."        (0 (replace-with "↩"))))))

(add-hook 'js2-mode-hook 'pretty-js-keywords)

;; whitespace
(require 'whitespace)
(setq whitespace-style (quote
   ( face tabs)))
(global-whitespace-mode t)
(custom-set-faces
	'(whitespace-tab ((t (:background "#1e1f1b" :foreground "#1e1f1b"))))
)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
