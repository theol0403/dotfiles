(package! company-tabnine)

(package! scroll-on-jump)

(package! treemacs-all-the-icons)

(package! evil-args)

(package! evil-replace-with-register)

(package! evil-little-word
  :recipe (:host github :repo "tarao/evil-plugins"
           :files ("evil-little-word.el")))

(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table"))

(package! org-fragtog)
(package! org-appear :recipe (:host github :repo "awth13/org-appear"))
(package! org-pretty-tags)

;; (package! centered-window-mode
;;   :recipe (:host github :repo "anler/centered-window-mode"
;;            :files ("centered-window.el")))

;; (package! git-gutter :recipe (:host github :repo "theol0403/git-gutter"))
;; (package! git-gutter :recipe (:local-repo "~/Documents/github/git-gutter" :build (:not compile)))

;; (package! solaire-mode :disable t)

(package! aas :recipe (:host github :repo "ymarco/auto-activating-snippets"))
(package! laas :recipe (:local-repo "lisp/LaTeX-auto-activating-snippets"))

;; (unpin! doom-themes)
;; (package! doom-themes :recipe (:host github :repo "theol0403/emacs-doom-themes"))

(package! monokai-pro-theme)

(package! evil-textobj-syntax)

(package! beacon :recipe (:host github :repo "Malabarba/beacon"))

;; (package! good-scroll)
(package! cdlatex)
(package! auctex)
(package! corfu)
