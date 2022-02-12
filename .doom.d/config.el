;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq
 ;; doom settings
 user-full-name "Theo Lemay"
 user-mail-address "theol0403"

 ;; doom settings
 doom-theme 'doom-monokai-pro
 doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
 doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 12 :weight 'semi-light)
 display-line-numbers-type 'relative

 read-process-output-max (* 1024 1024)
 delete-by-moving-to-trash t ; Delete files to trash
 window-combination-resize t ; take new window space from all other windows (not just current
 auto-save-default t
 make-backup-files t

 history-length 200

 git-gutter:update-interval 2
 git-gutter:ask-p nil

 +zen-text-scale 1

 org-directory "~/Documents/github/org-notes/"
 truncate-string-ellipsis "…"
 treemacs-width 36
 centaur-tabs-gray-out-icons nil

 yas-triggers-in-field t

 calc-angle-mode 'rad  ; radians are rad
 calc-symbolic-mode t
 )

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(select-frame-set-input-focus (selected-frame)))

(after! format-all  (setq +format-on-save-enabled-modes '(not sql-mode)))

;; projectile
(setq
 projectile-project-search-path    '("~/Documents/github")
 counsel-projectile-sort-projects  t
 counsel-projectile-sort-files     t
 counsel-projectile-sort-directory t
 counsel-projectile-sort-buffers   t)

(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("--all-scopes-completion"
          "--background-index"
          "--clang-tidy"
          "--completion-style=bundled"
          "--header-insertion=iwyu"
          "--header-insertion-decorators"
          "--suggest-missing-includes"
          "--pch-storage=memory"
          ;; "--limit-results=10"
          "-j=8"
          "--cross-file-rename"
          "--ranking-model=decision_forest")
        lsp-semantic-tokens-enable t
        ;; lsp-semantic-tokens-warn-on-missing-face t
        lsp-semantic-tokens-apply-modifiers t
        lsp-headerline-breadcrumb-enable t
        lsp-headerline-breadcrumb-enable-diagnostics t
        lsp-auto-guess-root t
        lsp-lens-enable t
        lsp-lens-debounce-interval 0.3
        )
  (set-lsp-priority! 'clangd 2))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(after! company
  (setq
   company-idle-delay 0.01
   company-minimum-prefix-length 1
   company-show-numbers t
   company-backends '((company-tabnine :separate company-capf company-yasnippet))
   +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet)
   ;; +company-backend-alist '((org-mode company-tabnine company-capf)
   ;;                          (text-mode (:separate company-tabnine company-dabbrev company-yasnippet company-ispell))
   ;;                          (prog-mode company-tabnine company-capf company-yasnippet)
   ;;                          (conf-mode company-tabnine company-capf company-dabbrev-code company-yasnippet))
   )
  (add-hook 'evil-normal-state-entry-hook #'company-abort)
  )

(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-cycle t)             ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)
  (corfu-preselect-first nil) ;; Disable candidate preselection

  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :init
  (corfu-global-mode))

;; (after! company-tng
;; (setq company-require-match nil
;;     company-clang-insert-arguments t
;;     company-semantic-insert-arguments t
;;     company-rtags-insert-arguments t
;;     lsp-enable-snippet t))

(after! company-tabnine
  (setq company-tabnine-max-num-results 3
        company-tabnine-always-trigger t))

(after! doom-themes
  (custom-set-faces!
    `(line-number :foreground ,(doom-color 'base4))
    ;; `(line-number :foreground "#5b595c")
    `(line-number-current-line :foreground "#c1c0c0")
    `(hl-line :background "#373538")
    `(treemacs-file-face :foreground ,(doom-color 'white))
    `(org-block :background ,(doom-color 'bg))
    `(org-block-begin-line :background ,(doom-color 'bg))
    `(org-block-end-line :background ,(doom-color 'bg))
    `(vertical-border :background "#221F22" :foreground "#221F22")
    `(eldoc-box-body :background "#423f42")
    `(font-lock-doc-face :foreground ,(doom-color 'grey))
    `(lsp-face-semhl-parameter :slant italic :foreground ,(doom-color 'orange))
    `(highlight-numbers-number :bold nil)
    ))

(use-package scroll-on-jump
  :config
  (setq scroll-on-jump-duration 0.2))

(after! evil
  (scroll-on-jump-advice-add evil-undo)
  (scroll-on-jump-advice-add evil-redo)
  (scroll-on-jump-advice-add evil-jump-item)
  (scroll-on-jump-advice-add evil-jump-forward)
  (scroll-on-jump-advice-add evil-jump-backward)
  (scroll-on-jump-advice-add evil-ex-search-next)
  (scroll-on-jump-advice-add evil-ex-search-previous)
  (scroll-on-jump-advice-add evil-forward-paragraph)
  (scroll-on-jump-advice-add evil-backward-paragraph)
  (scroll-on-jump-advice-add evil-goto-mark)
  (scroll-on-jump-advice-add evil-goto-first-line)

  ;; Actions that themselves scroll.
  (scroll-on-jump-with-scroll-advice-add evil-goto-line)
  (scroll-on-jump-advice-add evil-scroll-down)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom))

(after! goto-chg
  (scroll-on-jump-advice-add goto-last-change)
  (scroll-on-jump-advice-add goto-last-change-reverse))

(use-package! doom-themes
  :init
  (setq doom-themes-neotree-file-icons t)
  (setq doom-themes-treemacs-theme nil
        treemacs-window-background-color '("#221F22" . "#423f42"))
  :config
  (require 'treemacs-all-the-icons)
  (treemacs-load-theme "all-the-icons"))

(after! treemacs
    (treemacs-follow-mode 1)
    (treemacs-git-mode 'deferred)
    (treemacs-filewatch-mode 1))
(after! lsp-treemacs
    (lsp-treemacs-sync-mode 1))

(after! vterm
  (add-hook 'vterm-mode-hook
            (lambda () (face-remap-add-relative 'default '(:background "#423f42")))))
(define-key! vterm-mode-map
  "C-w" nil
  "<C-w>" nil
  )

;; (add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))

;; (after! centaur-tabs
;;   (defun centaur-tabs-buffer-groups ()
;;     "`centaur-tabs-buffer-groups' control buffers' group rules.
;; Group centaur-tabs with mode if buffer is derived from `eshell-mode'
;; `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
;; All buffer name start with * will group to \"Emacs\".
;; Other buffer group by `centaur-tabs-get-group-name' with project name."
;;     (list
;;      (cond
;;       ((or (string-equal "*" (substring (buffer-name) 0 1))
;;            (memq major-mode '(magit-process-mode
;;                               magit-status-mode
;;                               magit-diff-mode
;;                               magit-log-mode
;;                               magit-file-mode
;;                               magit-blob-mode
;;                               magit-blame-mode
;;                               )))
;;        "Emacs")
;;       ((derived-mode-p 'eshell-mode)
;;        "EShell")
;;       ((derived-mode-p 'emacs-lisp-mode)
;;        "Elisp")
;;       ((derived-mode-p 'dired-mode)
;;        "Dired")
;;       ((memq major-mode '(org-mode org-agenda-mode diary-mode))
;;        "Common")
;;       (t "Common")))))

(use-package! evil
  :init
  ;; (add-hook 'evil-normal-state-entry-hook (lambda () (setq-local display-line-numbers 'relative)))
  ;; (add-hook 'evil-insert-state-entry-hook (lambda () (setq-local display-line-numbers t)))
  (setq
   evil-respect-visual-line-mode     nil
   evil-split-window-below           t
   evil-vsplit-window-right          t
   ;; evil-want-fine-undo t
   evil-collection-setup-minibuffer  t
   evil-ex-substitute-global t
   )
  (define-key evil-normal-state-map (kbd "C-z") 'evil-undo)

  :config

  (defun flip-window ()
    "Switch to the most recently visited window, across frames. It will also switch between buffers if there is only one window."
    (interactive)
    (let ((win  (get-mru-window 'visible t t)))
      (if win
          (progn
            (select-frame-set-input-focus (window-frame win))
            (select-window win))
        (mode-line-other-buffer))))

  (define-key! evil-window-map
    ;; Navigation
    [left]    #'evil-window-left
    [down]    #'evil-window-down
    [up]      #'evil-window-up
    [right]   #'evil-window-right
    ;; Swapping windows
    [S-left]  #'+evil/window-move-left
    [S-down]  #'+evil/window-move-down
    [S-up]    #'+evil/window-move-up
    [S-right] #'+evil/window-move-right
    "SPC" #'rotate-layout
    "W" #'other-window
    "TAB" #'other-window
    "w" #'flip-window
    "<backspace>" #'evil-quit
    )
  (map! :leader
        ;; Navigation
        [left]    #'evil-window-left
        [down]    #'evil-window-down
        [up]      #'evil-window-up
        [right]   #'evil-window-right
        ;; Swapping windows
        [S-left]  #'+evil/window-move-left
        [S-down]  #'+evil/window-move-down
        [S-up]    #'+evil/window-move-up
        [S-right] #'+evil/window-move-right
        )
  ;; make _ part of a word
  (add-hook 'c-mode-common-hook (lambda () (modify-syntax-entry ?_ "w"))))

(after! evil
  (define-key evil-inner-text-objects-map "," 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "," 'evil-outer-arg))

;; (after! evil-replace-with-register
;;   (setq evil-replace-with-register-key "yr")
;;   (evil-replace-with-register-install))

;; (add-to-list 'load-path "~/.doom.d/")
;; (after! 'c-transpose
;; (define-key evil-normal-state-map (kbd "S->,") 'c-transpose-args-forward)
;; (define-key evil-normal-state-map (kbd "S-<,") 'c-transpose-args-backward)
;; (evil-define-key 'normal 'global (kbd "> ,") 'c-transpose-args-forward)
;; (evil-define-key 'normal 'global (kbd "< ,") 'c-transpose-args-backward))

(after! evil-little-word
  ;; (define-key evil-motion-state-map (kbd "w") 'evil-forward-little-word-begin)
  ;; (define-key evil-motion-state-map (kbd "b") 'evil-backward-little-word-begin)
  ;; (define-key evil-motion-state-map (kbd "W") 'evil-forward-little-word-end)
  ;; (define-key evil-motion-state-map (kbd "B") 'evil-backward-little-word-end)
  ;; (define-key evil-visual-state-map (kbd "w") 'evil-forward-little-word-begin)
  ;; (define-key evil-visual-state-map (kbd "b") 'evil-backward-little-word-begin)
  (define-key evil-visual-state-map (kbd "i v") 'evil-inner-little-word)
  (define-key evil-outer-text-objects-map (kbd "v") 'evil-a-little-word)
  (define-key evil-inner-text-objects-map (kbd "v") 'evil-inner-little-word))

(after! avy
  (setq
   ;; avy-keys '(?a ?s ?h ?n ?t ?o ?y ?i
   ;;               ?l ?r ?u ?d ?p ?c
   ;;               ?f ?w ?j ?g ?m ?x ?v)
   avy-all-windows t))

(map!
 (:after evil-easymotion
  :m "<backspace>" evilem-map
  (:map evilem-map
   "<down>" #'evilem-motion-next-line
   "<up>" #'evilem-motion-previous-line
   "<backspace>" #'evil-avy-goto-char-timer
   )))

(after! evil-snipe
  (setq evil-snipe-scope 'buffer
        evil-snipe-spillover-scope 'whole-buffer
        evil-snipe-repeat-scope 'whole-buffer
        evil-snipe-tab-increment t))

(after! ranger
  (setq ranger-override-dired t
        ranger-hide-cursor nil
        ranger-preview-delay 0.2
        ranger-dont-show-binary t
        ranger-max-preview-size 500
        ranger-cleanup-eagerly t
        ))

(after! which-key
  (setq which-key-idle-delay 0.4))

(after! evil-lion (evil-lion-mode))

(after! mixed-pitch
(setq mixed-pitch-variable-pitch-cursor nil
      mixed-pitch-set-height t)

(add-hook! org-mode :append #'mixed-pitch-mode)
)

(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook #'org-babel-tangle
                               :append :local)))

(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))

(use-package! info-colors
  :defer t
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)
