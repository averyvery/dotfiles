;; -*- mode: dotspacemacs -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; --------------------------------------------------------
     ;; Example of useful layers you may want to use right away
     ;; Uncomment a layer name and press C-c C-c to install it
     ;; --------------------------------------------------------
     averyvery
     auto-completion
     markdown
     osx
     themes-megapack
     javascript
     ;; better-defaults
     (git :variables
          git-gutter-use-fringe t)
     ;; markdown
     ;; org
     ;; syntax-checking
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progess in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to a .PNG file.
   ;; If the value is nil then no banner is displayed.
   ;; dotspacemacs-startup-banner 'official
   dotspacemacs-startup-banner 'official
   ;; t if you always want to see the changelog at startup
   dotspacemacs-always-show-changelog t
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.


   line-spacing 10
   dotspacemacs-default-font '("Input Mono Narrow"
                             :size 14
                             ;; :size 12
                             :weight extra-light
                             :width normal
                             :powerline-scale 1.7)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil the paste micro-state is enabled. While enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state t
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil
   )
  ;; User initialization goes here
  )

(defun dotspacemacs/config ()
  ;; (load-theme 'tronesque)
  ;; (load-theme 'molokai)
  ;; (load-theme 'subatomic)
  (load-theme 'django)
  ;; (add-to-list 'custom-theme-load-path "~/.emacs.d/private/emacs-ectoplasm-theme")
  ;; (load-theme 'ectoplasm t)

  (load "~/.emacs.d/private/visual-indentation-mode/visual-indentation-mode.el")
  (add-hook 'prog-mode-hook 'visual-indentation-mode)

  (set-face-underline-p 'highlight t)

  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-strict-trailing-comma-warning t)
  (setq-default js2-mode-display-warnings-and-errors nil)

  (add-hook 'before-save-hook 'whitespace-cleanup)

  (add-hook 'js2-mode-hook (lambda ()
          (js2-mode-hide-warnings-and-errors)
          (electric-indent-mode -1)
  ))

  (setq css-indent-offset 2)

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
  (setq-default evil-shift-width 2)
  (defun disable-click ()
    (setq-default mouse-1-click-follows-link nil)
  )
  (add-hook 'prog-mode-hook 'disable-click)

  (global-vi-tilde-fringe-mode -1)

  (defun coffee-tabs ()
    (setq coffee-indent-tabs-mode nil)
    (setq indent-tabs-mode nil)
    (setq coffee-tab-width 2)
  )
  (add-hook 'coffee-mode-hook 'coffee-tabs)

  (defun sass-tweaks ()
    ;; (auto-complete-mode)
    ;; (yas-minor-mode)
  )
  (add-hook 'sass-mode-hook 'sass-tweaks)
  (add-hook 'scss-mode-hook 'sass-tweaks)

  (defun disable-goto-address ()
    (goto-address-mode nil)
  )

  (add-hook 'js2-mode-hook 'disable-goto-address)
  (add-hook 'html-mode-hook 'disable-goto-address)

  (add-to-list 'auto-mode-alist '("\\.erb$" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.region$" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.block$" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp$" . html-mode))

  (defun sudo-edit (&optional arg)
    (interactive "P")
    (if (or arg (not buffer-file-name))
        (find-file (concat "/sudo:root@localhost:"
                          (ido-read-file-name "Find file(as root): ")))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

  (defun sudo-edit-on-etc-files ()
    (when (string= (substring (file-name-directory buffer-file-name) 1 4) "etc")
      (print "Foo")
      (sudo-edit)))

  (add-hook 'find-file-hook 'sudo-edit-on-etc-files)

  (load "~/.emacs.d/private/move-text/move-text.el")

  (custom-set-faces
   '(helm-selection ((t (:background "#081a11")))) ;; Face used by ido for highlighting subdirs in the alternatives.
   '(helm-match ((t (:foreground "#9adb47" :background "#081a11")))) ;; Face used by ido for highlighting subdirs in the alternatives.
  )
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(custom-safe-themes
   (quote
    ("2d16f85f22f1841390dfc1234bd5acfcce202d9bb1512aa8eabd0068051ac8c3" "cedd3b4295ac0a41ef48376e16b4745c25fa8e7b4f706173083f16d5792bb379" default)))
 '(ring-bell-function (quote ignore) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(underline ((t nil))))
