;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;;(package! another-package
;;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;;(package! this-package
;;  :recipe (:host github :repo "username/repo"
;;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;;(package! builtin-package :recipe (:nonrecursive t))
;;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;;(package! builtin-package :pin "1a2b3c4d5e")

;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;;(unpin! pinned-package)
;; ...or multiple packages
;;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;;(unpin! t)

(package! company-tabnine)
(package! tree-sitter)
(package! tree-sitter-langs)

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

(package! good-scroll)
(package! cdlatex)
(package! auctex)
(package! corfu)
