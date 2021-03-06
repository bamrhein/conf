(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(jde-compiler (quote ("javac" "")))
 '(load-home-init-file t t)
 '(mumamo-chunk-coloring 5)
 '(scroll-bar-mode nil)
;; '(session-initialize t nil (session))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(menu-bar-mode nil)

;;=================================================================================;
;; Custom Environment Settings
;;=================================================================================;
(setq inhibit-startup-message t) ;; Removes unnecessary startup message
(setq initial-scratch-message nil) ;; Removes initial message from *scratch* buffer
(global-font-lock-mode 1) ;; for all buffers
(setq-default indent-tabs-mode nil) ;; Use spaces instead of the TAB character
(setq-default tab-width 4)
(setq read-file-name-completion-ignore-case t)
(setq x-select-enable-clipboard 't)

;; Set text coloring and size
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(require 'color-theme)
(color-theme-initialize)
(load "~/.emacs.d/color-themes/pastellic-slate-theme.el")
(color-theme-pastellic-slate)

(cond ((string-equal system-type "gnu/linux")
       ;; slateblue1 / darkseagreen / LightCyan / ...
       ;; (set-foreground-color "darkseagreen")
       ;; (set-background-color "black")
       (cond ((< emacs-major-version 23)
              (set-default-font "fixed"))
             ((and (= emacs-major-version 23))
              (set-frame-font "mono-10"))))
      ((and (string-equal system-type "darwin")) ;; Aquamacs settings
       (tabbar-mode -1) ;; Turn off tabbar-mode for Aquamacs.
       (setq minibuffer-prompt "white")
       (set-default-font "Monaco-12")
       (set-frame-font "Monaco-12")
       (setq aquamacs-autoface-mode nil)
       (setq aquamacs-default-major-mode 'lisp-interaction-mode)
       (setq initial-major-mode 'lisp-interaction-mode)
       (setq smart-spacing-mode nil)
       (setq magic-mode-alist nil)
       (setq aquamacs-additional-fontsets nil)
       (setq mac-command-modifier 'meta)))


;; Puts all temp files into a single folder; keeps emacs from
;; crapping up the .svn directories with a temp copy of every
;; single file.
(setq backup-directory-alist '(("." . "~/.emacs.d/.emacs-backups")))

;; Keybindings for moving between split windows
(windmove-default-keybindings 'shift)

;; Turn on ido-mode only for buffer switching
(ido-mode 'buffers)


;;=================================================================================;
;; My Personal Functions
;;=================================================================================;

(defun maximize-frame ()
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

(defun init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun move-line-down ()
  "Move line down"
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (next-line)
      (transpose-lines 1))
    (next-line)
    (move-to-column col)))

(defun move-line-up ()
  "Move line up"
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (next-line)
      (transpose-lines -1))
    (move-to-column col)))

(defun move-word-right ()
  "Move word right"
  (interactive)
  (transpose-words 1))

(defun move-word-left ()
  "Move word left"
  (interactive)
  (transpose-words -1))

(defun open-shell-other-buffer ()
  "If screen is split, will open a shell
in the alternate window."
  (interactive)
  (other-window 1)
  (shell))

(defun comment-or-uncomment-line (&optional lines)
  "Comment current line. Argument gives the number of lines
forward to comment"
  (interactive "P")
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-end-position lines)))

(defun comment-or-uncomment-region-or-line
  (&optional lines)
  "If the line or region is not a comment, comments region
if mark is active, line otherwise. If the line or region
is a comment, uncomment."
  (interactive "P")
  (if mark-active
      (if (< (mark) (point))
          (comment-or-uncomment-region (mark) (point))
        (comment-or-uncomment-region (point) (mark)))
    (comment-or-uncomment-line lines)))

(defun inline-close-tag ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (sgml-close-tag))
    (move-to-column col)))

(defun newline-close-tag ()
  (interactive)
  (inline-close-tag)
  (newline)
  (newline-and-indent)
  (previous-line)
  (indent-for-tab-command))

(defun dired-list-subdir ()
  (interactive)
  (let ((line (line-number-at-pos))
        (col (current-column)))
    (save-excursion
      (dired-maybe-insert-subdir (dired-get-filename)))
    (goto-line line)
    (move-to-column col)))

(defun dired-display-file-or-insert-subdir ()
  (interactive)
  (if (file-directory-p (dired-get-filename))
      (dired-list-subdir)
    (dired-display-file)))

(defun mouse-dired-display (event)
  (interactive "e")
  (setq window (posn-window (event-end event))
        pos (posn-point (event-end event)))
  (select-window window)
  (goto-char pos)
  (dired-display-file-or-insert-subdir))


;;=================================================================================;
;; My Personal Keyboard Shortcuts
;;=================================================================================;
(define-key global-map [M-S-return] 'maximize-frame)
(global-set-key "\C-c\C-c" 'comment-or-uncomment-region-or-line)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key [M-return] 'newline-and-indent)
(global-set-key [C-S-up] 'move-line-up)
(global-set-key [C-S-down] 'move-line-down)
(global-set-key [C-S-left] 'move-word-left)
(global-set-key [C-S-right] 'move-word-right)
(global-set-key [f1] 'open-shell-other-buffer)
(global-set-key [f3] 'flymake-goto-prev-error)
(global-set-key [f4] 'flymake-goto-next-error)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'flymake-display-err-menu-for-current-line)


;;=================================================================================;
;; Site-Lisp, Modes, and Mode Customizations
;;=================================================================================;
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; Auto-pair brackets, braces, quotes, etc.
;;(require 'autopair)
;;(autopair-global-mode) ;; enable autopair in all buffers

;;; Customization for all C-like languages
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "k&r") ;; Kernihan & Richie's style
             (setq c-basic-offset 4) ;; 4 spaces for indentations
             ;;(local-set-key [return] 'newline-and-indent)
             (c-set-offset 'substatement-open 0))) ;; No indent for open bracket


;;; nXhtml-mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/nxhtml/related")
;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; (add-to-list 'auto-mode-alist '("\\.tpl$" . nxhtml-mumamo-mode))

;;; Multi-Web-Mode
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/multi-web-mode")
;; (load "~/.emacs.d/site-lisp/multi-web-mode/mweb-example-config.el")


;;; JavaScript
(add-to-list 'load-path "~/.emacs.d/site-lisp/js")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Inferior-js
;; (autoload 'run-js "inf-js" nil t)
;; (autoload 'inf-js-keys "inf-js" nil)
;; (add-hook 'js2-mode-hook
;;           '(lambda ()
;;              (setq autopair-dont-activate t)
;;              (inf-js-keys)))


;;; Wikipedia-mode
(require 'wikipedia-mode)
(add-to-list 'auto-mode-alist '("\\.wiki$" . wikipedia-mode))
(add-hook 'wikipedia-mode-hook
          '(lambda ()
             (set-fill-column 100)
             (flyspell-mode 1)
             (local-set-key [mouse-3] 'flyspell-correct-word)))


;;; HTML-mode & SGML-mode
(add-to-list 'auto-mode-alist '("\\.html$" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.htm$" . sgml-mode))
(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 4.
            (set 'sgml-basic-offset 4)
            (local-set-key "\C-c/" 'inline-close-tag)
            (local-set-key [M-return] 'newline-close-tag)
            (auto-fill-mode nil)
            (sgml-guess-indent)))


(add-hook 'sgml-mode-hook
          (lambda ()
            ;; Default indentation to 4, but let SGML mode guess, too.
            ;; (set (make-local-variable 'sgml-basic-offset) 4)
            (set 'sgml-basic-offset 4)
            (auto-fill-mode nil)
            (sgml-guess-indent)))


;;; Python customizations
(if (string-equal system-type "gnu/linux")
    (progn
      (add-to-list 'load-path "~/.emacs.d/site-lisp/python")
      (autoload 'python-mode "python-mode" "Python Mode." t)
      (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
      (add-to-list 'interpreter-mode-alist '("python" . python-mode))))


;;; PHP-mode requirements
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(require 'php-mode)

;; Load the php-imenu index function
(autoload 'php-imenu-create-index "php-imenu" nil t)

;; Add the index creation function to the php-mode-hook
(add-hook 'php-mode-user-hook 'php-imenu-setup)

(defun php-imenu-setup ()
  (setq imenu-create-index-function (function php-imenu-create-index))
  ;; uncomment if you prefer speedbar:
  ;(setq php-imenu-alist-postprocessor (function reverse))
  (imenu-add-menubar-index))


;;; Haskell-mode
(load "~/.emacs.d/site-lisp/haskell/haskell-site-file.el")
(add-hook 'haskell-mode-hook
          '(lambda ()
             (haskell-indent-mode)))


;; Org-mode
(autoload 'org-mode "org" nil t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.notes$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(add-hook 'org-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
             (flyspell-mode 1)
             (local-set-key [M-return] 'org-meta-return)
             (local-set-key "\C-c\C-h" 'hide-sublevels)
             (local-set-key "\C-ch" 'hide-subtree)))


;; Flyspell bindings
(add-hook 'flyspell-mode-hook
          '(lambda ()
             (local-set-key [mouse-3] 'flyspell-correct-word)))


;; Shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/site-lisp/yasnippet/snippets")


;; Dired-mode
(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map [down-mouse-1] 'mouse-dired-display)
             (define-key dired-mode-map [return] 'dired-display-file-or-insert-subdir)
             (define-key dired-mode-map "o" 'dired-display-file)
             (define-key dired-mode-map "i" 'dired-list-subdir)))


;;=================================================================================;
;; Messages (for display in the *Messages* buffer)
;;=================================================================================;
;; Helpful *Messages* upon startup
(message (concat "Java JDEE commands:\n"
                 "  - Compile: C-c C-v C-c\n"
                 "  - Run: C-c C-v C-r\n"
                 "  - Run w/ args: C-u C-c C-v C-r\n"))

(message (concat "Org-mode commands:\n"
                 "  - Meta-return: M-return\n"
                 "  - show-all: M-x show-all\n"
                 "  - hide-sublevels (ALL sublevels): C-c C-h\n"
                 "  - show-subtree (shows subtree of header under the cursor): TAB (x2)\n"
                 "  - hide-subtree (hides subtree of header under the cursor): C-c h OR TAB cycle\n"
                 "  - org-time-stamp (inserts time stamp to current buffer): C-u C-c .\n"))

(message (concat "Dired Commands:\n"
                 "  - Dired-up-directory: ^\n"
                 "  - Dired-flag-file-deletion: d\n"
                 "  - Dired-do-flagged-delete: x\n"
                 "  - Dired-create-directory: M-x dired-created-directory\n"
                 "  - Dired-unmark-all-marks: M-x dired-unmark-all-marks\n"
                 "  - Dired-do-delete (delete file without prompt): D\n"
                 "  - Revert-buffer (i.e., \"refresh buffer\"): g\n"
                 "  - Dired-list-subdir (custom function): i\n"))

(message (concat "Handy editing commands:\n"
                 "  - Remove ^M in files: M-x replace-string C-q C-m RET\n"))

(message (concat "Misc command-line fu:\n"
                 "  - find \* -type f \| grep \".php$\\|.js$\" --exclude \"svn\" \| xargs wc -l\n"))
