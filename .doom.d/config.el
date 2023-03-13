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

(setq rustic-lsp-server 'rust-analyzer)

(after! rustic
  (setq lsp-rust-server 'rust-analyzer))

(after! lsp-rust
  (setq lsp-rust-server 'rust-analyzer))

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

;; (use-package corfu
;;   ;; TAB-and-Go customizations
;;   :custom
;;   (corfu-cycle t)             ;; Enable cycling for `corfu-next/previous'
;;   (corfu-auto t)
;;   (corfu-preselect-first nil) ;; Disable candidate preselection

;;   ;; Use TAB for cycling, default is `corfu-complete'.
;;   :bind
;;   (:map corfu-map
;;         ("TAB" . corfu-next)
;;         ([tab] . corfu-next)
;;         ("S-TAB" . corfu-previous)
;;         ([backtab] . corfu-previous))

;;   :init
;;   (corfu-global-mode))

;; (after! company-tng
;; (setq company-require-match nil
;;     company-clang-insert-arguments t
;;     company-semantic-insert-arguments t
;;     company-rtags-insert-arguments t
;;     lsp-enable-snippet t))

(after! company-tabnine
  (setq company-tabnine-max-num-results 3
        company-tabnine-always-trigger t))

;; (after! doom-themes
;;   (custom-set-faces!
;;     `(line-number :foreground ,(doom-color 'base4))
;;     ;; `(line-number :foreground "#5b595c")
;;     `(line-number-current-line :foreground "#c1c0c0")
;;     `(hl-line :background "#373538")
;;     `(treemacs-file-face :foreground ,(doom-color 'white))
;;     `(org-block :background ,(doom-color 'bg))
;;     `(org-block-begin-line :background ,(doom-color 'bg))
;;     `(org-block-end-line :background ,(doom-color 'bg))
;;     `(vertical-border :background "#221F22" :foreground "#221F22")
;;     `(eldoc-box-body :background "#423f42")
;;     `(font-lock-doc-face :foreground ,(doom-color 'grey))
;;     `(lsp-face-semhl-parameter :slant italic :foreground ,(doom-color 'orange))
;;     `(highlight-numbers-number :bold nil)
;;     ))

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

(use-package! evil
  :init
  (add-hook 'evil-normal-state-entry-hook (lambda () (setq-local display-line-numbers 'relative)))
  (add-hook 'evil-insert-state-entry-hook (lambda () (setq-local display-line-numbers t)))
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
  ;; make _ part of a word
  (add-hook 'c-mode-common-hook (lambda () (modify-syntax-entry ?_ "w"))))

(after! evil
  (define-key evil-inner-text-objects-map "," 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "," 'evil-outer-arg))

;; (after! evil-replace-with-register
;;   (setq evil-replace-with-register-key "yr")
;;   (evil-replace-with-register-install))

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

;; AucTeX settings - almost no changes
(use-package latex
  :ensure auctex
  :hook ((LaTeX-mode . prettify-symbols-mode))
  :bind (:map LaTeX-mode-map
         ("C-S-e" . latex-math-from-calc))
  :config
  ;; Format math as a Latex string with Calc
  (defun latex-math-from-calc ()
    "Evaluate `calc' on the contents of line at point."
    (interactive)
    (cond ((region-active-p)
           (let* ((beg (region-beginning))
                  (end (region-end))
                  (string (buffer-substring-no-properties beg end)))
             (kill-region beg end)
             (insert (calc-eval `(,string calc-language latex
                                          calc-prefer-frac t
                                          calc-angle-mode rad)))))
          (t (let ((l (thing-at-point 'line)))
               (end-of-line 1) (kill-line 0)
               (insert (calc-eval `(,l
                                    calc-language latex
                                    calc-prefer-frac t
                                    calc-angle-mode rad))))))))

(use-package preview
  :after latex
  :hook ((LaTeX-mode . preview-larger-previews))
  :config
  (defun preview-larger-previews ()
    (setq preview-scale-function
          (lambda () (* 1.25
                   (funcall (preview-scale-from-face)))))))

;; CDLatex settings
(use-package cdlatex
  :ensure t
  :hook (LaTeX-mode . turn-on-cdlatex)
  :bind (:map cdlatex-mode-map
              ("<tab>" . cdlatex-tab)))

;; Yasnippet settings
(use-package yasnippet
  :ensure t
  :hook ((LaTeX-mode . yas-minor-mode)
         (post-self-insert . my/yas-try-expanding-auto-snippets))
  :config
  (use-package warnings
    :config
    (cl-pushnew '(yasnippet backquote-change)
                warning-suppress-types
                :test 'equal))

  (setq yas-triggers-in-field t)

  ;; Function that tries to autoexpand YaSnippets
  ;; The double quoting is NOT a typo!
  (defun my/yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand)))))

;; CDLatex integration with YaSnippet: Allow cdlatex tab to work inside Yas
;; fields
(use-package cdlatex
  :hook ((cdlatex-tab . yas-expand)
         (cdlatex-tab . cdlatex-in-yas-field))
  :config
  (use-package yasnippet
    :bind (:map yas-keymap
           ("<tab>" . yas-next-field-or-cdlatex)
           ("TAB" . yas-next-field-or-cdlatex))
    :config
    (defun cdlatex-in-yas-field ()
      ;; Check if we're at the end of the Yas field
      (when-let* ((_ (overlayp yas--active-field-overlay))
                  (end (overlay-end yas--active-field-overlay)))
        (if (>= (point) end)
            ;; Call yas-next-field if cdlatex can't expand here
            (let ((s (thing-at-point 'sexp)))
              (unless (and s (assoc (substring-no-properties s)
                                    cdlatex-command-alist-comb))
                (yas-next-field-or-maybe-expand)
                t))
          ;; otherwise expand and jump to the correct location
          (let (cdlatex-tab-hook minp)
            (setq minp
                  (min (save-excursion (cdlatex-tab)
                                       (point))
                       (overlay-end yas--active-field-overlay)))
            (goto-char minp) t))))

    (defun yas-next-field-or-cdlatex nil
      (interactive)
      "Jump to the next Yas field correctly with cdlatex active."
      (if
          (or (bound-and-true-p cdlatex-mode)
              (bound-and-true-p org-cdlatex-mode))
          (cdlatex-tab)
        (yas-next-field-or-maybe-expand)))))

;; Array/tabular input with org-tables and cdlatex
(use-package org-table
  :after cdlatex
  :bind (:map orgtbl-mode-map
              ("<tab>" . lazytab-org-table-next-field-maybe)
              ("TAB" . lazytab-org-table-next-field-maybe))
  :init
  (add-hook 'cdlatex-tab-hook 'lazytab-cdlatex-or-orgtbl-next-field 90)
  ;; Tabular environments using cdlatex
  (add-to-list 'cdlatex-command-alist '("smat" "Insert smallmatrix env"
                                       "\\left( \\begin{smallmatrix} ? \\end{smallmatrix} \\right)"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("bmat" "Insert bmatrix env"
                                       "\\begin{bmatrix} ? \\end{bmatrix}"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("pmat" "Insert pmatrix env"
                                       "\\begin{pmatrix} ? \\end{pmatrix}"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("tbl" "Insert table"
                                        "\\begin{table}\n\\centering ? \\caption{}\n\\end{table}\n"
                                       lazytab-position-cursor-and-edit
                                       nil t nil))
  :config
  ;; Tab handling in org tables
  (defun lazytab-position-cursor-and-edit ()
    ;; (if (search-backward "\?" (- (point) 100) t)
    ;;     (delete-char 1))
    (cdlatex-position-cursor)
    (lazytab-orgtbl-edit))

  (defun lazytab-orgtbl-edit ()
    (advice-add 'orgtbl-ctrl-c-ctrl-c :after #'lazytab-orgtbl-replace)
    (orgtbl-mode 1)
    (open-line 1)
    (insert "\n|"))

  (defun lazytab-orgtbl-replace (_)
    (interactive "P")
    (unless (org-at-table-p) (user-error "Not at a table"))
    (let* ((table (org-table-to-lisp))
           params
           (replacement-table
            (if (texmathp)
                (lazytab-orgtbl-to-amsmath table params)
              (orgtbl-to-latex table params))))
      (kill-region (org-table-begin) (org-table-end))
      (open-line 1)
      (push-mark)
      (insert replacement-table)
      (align-regexp (region-beginning) (region-end) "\\([:space:]*\\)& ")
      (orgtbl-mode -1)
      (advice-remove 'orgtbl-ctrl-c-ctrl-c #'lazytab-orgtbl-replace)))

  (defun lazytab-orgtbl-to-amsmath (table params)
    (orgtbl-to-generic
     table
     (org-combine-plists
      '(:splice t
                :lstart ""
                :lend " \\\\"
                :sep " & "
                :hline nil
                :llend "")
      params)))

  (defun lazytab-cdlatex-or-orgtbl-next-field ()
    (when (and (bound-and-true-p orgtbl-mode)
               (org-table-p)
               (looking-at "[[:space:]]*\\(?:|\\|$\\)")
               (let ((s (thing-at-point 'sexp)))
                 (not (and s (assoc s cdlatex-command-alist-comb)))))
      (call-interactively #'org-table-next-field)
      t))

  (defun lazytab-org-table-next-field-maybe ()
    (interactive)
    (if (bound-and-true-p cdlatex-mode)
        (cdlatex-tab)
      (org-table-next-field))))
