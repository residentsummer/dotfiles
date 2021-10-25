;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     better-defaults
     colors
     command-log
     (evil-snipe :variables
                 ;; Like vim-sneak
                 evil-snipe-repeat-keys t
                 evil-snipe-scope 'visible
                 evil-snipe-repeat-scope 'whole-visible
                 evil-snipe-enable-highlight t
                 evil-snipe-enable-incremental-highlight t)
     helm
     multiple-cursors
     osx
     (spell-checking :variables spell-checking-enable-by-default nil)
     treemacs
     ;; Prog
     auto-completion
     ;; cscope
     dash
     evil-commentary
     git
     ;; lsp
     parinfer
     restclient
     ;; semantic
     syntax-checking
     version-control
     ;; Langu
     ansible
     (clojure :variables
              clojure-enable-fancify-symbols t
              cider-mode-line-show-connection nil)
     csv
     docker
     elixir
     emacs-lisp
     go
     haskell
     html
     markdown
     nginx
     python
     ;; (python :variables python-enable-yapf-format-on-save t)
     ruby
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     solidity
     sql)

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(color-identifiers-mode scad-mode)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(hl-todo)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default spacemacs-27.1.pdmp)
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa t

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(vim :variables
                                    vim-style-remap-Y-to-y$ t
                                    vim-style-retain-visual-state-on-shift t)

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator slant :separator-scale 1.0)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Iosevka SS05"
                               :size 13.0
                               :weight light
                               :width normal)
   ;; dotspacemacs-default-font '("Fira Mono"
   ;;                             :size 11.0
   ;;                             :weight normal
   ;;                             :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key ":"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.8

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; If non nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfer with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;; Minimize bold face freq (Iosevka's bold is too bold)
  (set-face-bold-p 'bold nil)
  (setq
   color-identifiers:min-color-saturation 0.3
   color-identifiers:num-colors 25
   ;; This makes spacemaces look like my cross of xoria and wombat
   spacemacs-theme-custom-colors
   '((bg1 . "#242424")
     (bg2 . "#202020")
     (bg3 . "#1b1b1b")
     (bg4 . "#181818")
     (base . "#f6f3e8")
     (base-dim . "#f2efe4")
     (cursor . "#656565")
     (const . "#e5786d")
     (type . "#e5786d")
     (func . "#cae682")
     (var . "#cae682")
     (str . "#95e454")
     (keyword . "#8ac6f2")
     (comment . "#99968b")
     (comment-bg . "#242424")
     (match . "#f6f3e8"))))

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

; https://bitbucket.org/lyro/evil/issues/187/the-evil-word-variable-is-not-used-for
(defun evil-add-word-constituents (char-string)
  "Add characters in CHAR-STRING as word constituents in the current buffer,
by modifying its syntax table."
  (dolist (char (string-to-list char-string))
    (modify-syntax-entry char "w")))

(defun repl-ns-jump ()
  "Jump to repl, setting ns to current buffer's"
  (interactive)
  (cider-repl-set-ns (cider-current-ns))
  (cider-switch-to-repl-buffer))

(defmacro evil-define-key-in-maps (modes maps &rest body)
  `(progn
     ,@(mapcar
        (lambda (map)
          `(evil-define-key ,modes ,map ,@body))
        (if nil ;; (= #'quote (car maps))
            (cdr maps) maps))))

(defun cider-eval-n-tops (n)
  "Evaluate N top-level forms, starting with the current one."
  (interactive "P")
  (save-excursion
    (goto-char (car (bounds-of-thing-at-point 'defun)))
    (dotimes (i (or n 2))
      (let ((start (point))
            (end (progn (end-of-defun) (point))))
        (cider-eval-region start end)))))

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (setq
   global-hl-line-mode nil
   magit-revert-buffers nil
   projectile-enable-caching nil
   rainbow-delimiters-mode t)
  ;; Spelling
  (setq ispell-program-name "hunspell")
  ;; I don't use layouts
  (setq
   persp-init-new-frame-behaviour-override (lambda (&rest _)))
  ;; Bindings
  (evil-leader/set-key
    "SPC" 'evil-switch-to-windows-last-buffer
    "w" 'evil-write)
  (define-key evil-normal-state-map
    ",/" 'spacemacs/helm-project-smart-do-search-region-or-symbol)
  (define-key evil-normal-state-map ",." 'helm-projectile-find-file)
  (define-key evil-normal-state-map "H" 'sp-newline)
  (evil-define-key 'visual evil-commentary-mode-map
    "\\y" 'evil-commentary-yank
    "\\\\" 'evil-commentary)
  (evil-define-key 'normal evil-commentary-mode-map
    "\\y" 'evil-commentary-yank-line
    "\\\\" 'evil-commentary-line)
  ;; Who needs mappings starting with Esc?
  (setq evil-esc-delay 0)
  ;; Don't pop completion menu here and there
  (setq company-idle-delay nil)
  (define-key evil-insert-state-map
    (kbd "TAB") 'company-indent-or-complete-common)
  ;; Replace evil completion with company, preserving bindings
  (define-key evil-insert-state-map (kbd "C-n") nil)
  (define-key evil-insert-state-map (kbd "C-p") nil)
  (evil-define-key 'insert company-mode-map
    (kbd "C-n") 'company-select-next
    (kbd "C-p") 'company-select-previous)
  ;; Smart parens bindinds for clojure
  (evil-define-key-in-maps
   '(normal insert) (lisp-mode-shared-map clojure-mode-map)
   (kbd "C-.") 'sp-forward-slurp-sexp
   (kbd "C-,") 'sp-forward-barf-sexp
   (kbd "s-.") 'sp-backward-slurp-sexp
   (kbd "s-,") 'sp-backward-barf-sexp)
  (evil-leader/set-key-for-mode 'cider-mode "," 'repl-ns-jump)
  (evil-define-key-in-maps
   '(normal insert) (clojure-mode-map)
   (kbd "C-x C-x") 'cider-eval-n-tops)
  ;; Add language-specific chars to word matcher
  (add-hook 'python-mode-hook
            (lambda ()
              (evil-add-word-constituents "_")))
  (add-hook 'clojure-mode-hook
            (lambda ()
              (evil-add-word-constituents ":/-*!")))
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (evil-add-word-constituents "/-'")))
  (add-hook 'c-mode-hook
            (lambda ()
              (evil-add-word-constituents "_")))
  (setq
   flycheck-check-syntax-automatically
   '(save new-line mode-enabled)
   ;; Show ids for disbling 'em quickly :)
   flycheck-pylint-use-symbolic-id nil
   ;; Quick error navigation
   flycheck-navigation-minimum-level 'error)
  (set-face-background 'evil-ex-lazy-highlight "#ff00ff")
  ;; K&R-escue style
  (c-add-style "k&r4"
               '("k&r"
                 (c-basic-offset . 4)))
  (setq c-default-style "k&r4")
  ;; Higlight unwanted whitespace
  (setq
   whitespace-style '(face trailing tab-mark)
   whitespace-display-mapping
   '(;; WARNING: the mapping below has a problem.
     ;; When a TAB occupies exactly one column, it will display the character
     ;; \xBB at that column followed by a TAB which goes to the next TAB
     ;; column.
     ;; If this is a problem for you, please, comment the line below.
     (tab-mark   \t   [\xBB \t] [\\ \t]) ; tab
     (space-mark \    [\xB7]    [.])     ; space
     (space-mark \xA0 [\xA4]    [_])))   ; hard space
  ;; Remove lightbulb from modeline
  ;; (diminish 'helm-ff-cache-mode)
  (setq
   helm-ff-cache-mode-lighter nil
   helm-ff-cache-mode-lighter-sleep nil
   helm-ff-cache-mode-lighter-updating nil)
  ;; Use magit in fullscreen
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))
  (defadvice magit-mode-quit-window (after magit-fullscreen activate)
    (jump-to-register :magit-fullscreen))
  ;; Start scrolling before cursor hits the edges
  (setq scroll-margin 10))

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(magit-diff-use-overlays nil)
   '(magit-merge-arguments '("--no-ff"))
   '(magit-section-visibility-indicator nil)
   '(package-selected-packages
     '(utop tuareg caml typescript-mode ocp-indent nodejs-repl mvn meghanada maven-test-mode lsp-ui lsp-treemacs lsp-python-ms lsp-java json-navigator hierarchy js2-mode js-doc helm-lsp groovy-mode groovy-imports pcache gradle-mode flycheck-ocaml merlin emojify emoji-cheat-sheet-plus dune company-emoji yasnippet-snippets yapfify yaml-mode ws-butler writeroom-mode winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil toc-org tagedit symon symbol-overlay string-inflection sql-indent spaceline-all-the-icons smeargle slim-mode seeing-is-believing scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor ruby-hash-syntax rubocopfmt rubocop rspec-mode robe reveal-in-osx-finder restclient-helm restart-emacs rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters pytest pyenv-mode py-isort pug-mode prettier-js popwin pippel pipenv pip-requirements password-generator parinfer paradox overseer osx-trash osx-dictionary osx-clipboard org-superstar open-junk-file ob-restclient ob-http ob-elixir nginx-mode nameless mwim move-text mmm-mode minitest markdown-toc magit-svn magit-section magit-gitflow macrostep lsp-haskell lorem-ipsum live-py-mode link-hint launchctl jinja2-mode intero indent-guide importmagic impatient-mode hybrid-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-ls-git helm-hoogle helm-gitignore helm-git-grep helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ gh-md fuzzy font-lock+ flyspell-correct-helm flycheck-pos-tip flycheck-package flycheck-haskell flycheck-elsa flycheck-credo flx-ido fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-snipe evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-commentary evil-cleverparens evil-args evil-anzu emr emmet-mode elisp-slime-nav editorconfig dumb-jump dotenv-mode dockerfile-mode docker diminish devdocs dash-at-point dante cython-mode csv-mode company-web company-restclient company-ghci company-ghc company-cabal company-ansible company-anaconda command-log-mode column-enforce-mode color-identifiers-mode cmm-mode clojure-snippets clean-aindent-mode cider-eval-sexp-fu cider chruby centered-cursor-mode bundler browse-at-remote blacken auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile attrap ansible-doc ansible alchemist aggressive-indent ace-link ace-jump-helm-line ac-ispell))))
