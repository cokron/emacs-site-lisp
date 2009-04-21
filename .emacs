;(defun load-local-site-start (site-lisp-director)
;"Load site-start.el from a given site-lisp directory"
;  (let((current-default-directory default-directory))
;    (setq default-directory site-lisp-directory)
;    (normal-to-level-add-subdirs-to-load-path)
;    (setq default-direcotry current-default-directory)
;    (setq load-path (cons site-lisp-directory load-path))
;    (load (concat site-lisp-directory ""))
;))

(setq load-path(append '("~/site-lisp") load-path))
(setq load-path(append '("~/site-lisp/emacs-rails-trunk") load-path))
;;(setq load-path (cons (expand-file-name "~/site-lisp/rails-reloaded") load-path))

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "English")
 '(face-font-family-alternatives (quote (("apple-monaco" "courier" "fixed") ("helv" "helvetica" "arial" "fixed"))))
 '(global-font-lock-mode t nil (font-lock))
 '(isearch-lazy-highlight nil)
 '(menu-bar-mode t)
 '(mouse-avoidance-mode (quote animate) nil (avoid))
 '(pc-select-selection-keys-only nil)
 '(perl-tab-to-comment t)
 '(save-place t nil (saveplace))
 '(search-highlight t)
 '(show-paren-mode t nil (paren))
 '(tool-bar-mode nil))

; Default-Schriftgroesse: 30.09.2007
(custom-set-faces
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :family "apple-monaco")))))

;---------
; Ergaenzung am 14.10.93 von Olaf
;---------
;
;
; Abbrev-File einlesen (enthaelt die C-Kommentarformulare)

;(quietly-read-abbrev-file ())
;wieder rein 2008-10-22
;(setq-default abbrev-mode t)

;; Delete excess middle versions without asking
(setq delete-old-versions t)

;--------------------------
; Ergaenzung am 8.4.97
; highlighting auto update
; don´t care about buffer size
; choose maximum colors
;----------------------------
(global-font-lock-mode t)
(setq font-lock-maximum-size nil)
(setq font-lock-maximum-decoration 3)

;------------------------------------------
; dynamische Ergaenzung im Editorfenster
;------------------------------------------
;auskommentiert 25.8.2006
(global-set-key [S-iso-lefttab] 'dabbrev-expand)
(global-set-key [C-tab] 'dabbrev-expand)


;;==========================================
; Function to run Tidy HTML parser on region
; NOTE: this requires external Tidy program
; by pete@arraycomm.com
; Function to run Tidy HTML parser on region
; NOTE: this requires external Tidy program
(global-set-key "\C-xt" 'tidy-region)
(setq shell-command-default-error-buffer "tidy-errors") ; define an error buffer
(defun tidy-region ()
  "Run Tidy HTML parser on current region."
  (interactive)
  (let ((start (mark))
        (end (point))
        (command "tidy -i -q"))
        (save-excursion
        (shell-command-on-region start end command t t  shell-command-default-error-buffer))))


;;=============================================
; Kill other window and and enlarge current buffer
;(global-set-key [f8] 'kill-buffer-other-window)
;(defun kill-buffer-other-window (arg)
;  "Kill the buffer in the other window, and make the current buffer full size.
;If no other window, kills current buffer."
;  (interactive "p")
;  (let ((buf (save-window-excursion
;              (other-window arg)
;              (current-buffer))))
;    (delete-windows-on buf)
;    (kill-buffer buf))  )



;Tastaturbelegungen
(global-set-key [f3] 'auto-fill-mode)
(global-set-key [f4] 'replace-regexp)
(global-set-key [f5] 'goto-line)
;(global-set-key [f7] 'cperl-mode)
;(global-set-key [f8] 'menu-bar-mode)
(global-set-key [(control f9)] 'revert-buffer)
;; Toggle between two buffers
;(global-set-key [(control tab))
(global-set-key [(meta f12)] 'recentf-open-files)
(global-set-key [(f12)] (lambda ()
                         (interactive)
                         (switch-to-buffer (other-buffer))))

; 2009-04-16
(defun toggle-fullscreen ()
  "toggles whether the currently selected frame consumes the entire display or is decorated with a window border"
  (interactive)
  (let ((f (selected-frame)))
    (modify-frame-parameters f `((fullscreen . ,(if (eq nil (frame-parameter f 'fullscreen)) 'fullboth nil))))))
(global-set-key [f8] 'toggle-fullscreen)

;(global-set-key [(control f6)]
;                 s11a2        (interactive)
 ;                        (swbuff-switch-to-next-buffer))

;24.08.2007
;  (global-set-key [(f2)]       'swbuff-switch-to-next-buffer)
;  (global-set-key [(f1)]       'swbuff-switch-to-previous-buffer)


;indentation level
(setq cperl-indent-level 3)
(setq c-indent-level 3)

;(load "vc-hooks")
;(setq vc-path "d:/programme/cs-rcs/system")



; Emacs 21
(when (>= emacs-major-version 21)
  (global-set-key (kbd "<end>") 'end-of-buffer)
  (global-set-key (kbd "<home>") 'beginning-of-buffer))


; neu 11.04.02

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; extension to mode mapping
;
(setq auto-mode-alist
      (append '(
                ("\\.s?html?\\'" . html-mode)
                ("\\.tmpl\\'" . html-mode)
                ("\\.rhtml\\'" . html-mode)
                ("\\.erb\\'" . html-mode)
                ("\\.pod\\'" . cperl-mode)
                ("\\.asp$" . html-helper-mode)
                ("\\.aspx$" . html-helper-mode)
                ("\\.md$" . emacs-lisp-mode)
                ("\\.cs$" . csharp-mode)
                ("\\.jsp$" . java-mode)
                ("\\.textile$" . textile-mode)
                ) auto-mode-alist ))

;(setq auto-mode-alist (cons '("\\. rhtml$" . html-mode) auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;              C# Mode support
;;;
(autoload 'csharp-mode "cc-mode")

(c-add-style "myC#Style"
  '("C#"
  (c-basic-offset . 2)
  (c-comment-only-line-offset . (0 . 0))
  (c-offsets-alist . (
    (c                     . c-lineup-C-comments)
    (inclass               . 0)
    (namespace-open        . +)
    (namespace-close       . +)
    (innamespace           . 0)
    (class-open            . +)
    (class-close           . 0)
    (inclass               . 0)
    (defun-open            . +)
    (defun-block-intro     . 0)
    (inline-open           . ++)
    (statement-block-intro . 0)
    (brace-list-intro      . +)
    ))
  ))

(defun my-csharp-mode-hook ()
  (cond (window-system
         (turn-on-font-lock)
         (c-set-style "myC#Style")
         )))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
(setq auto-mode-alist
      (append '(
                ("\\.cs$" . csharp-mode)
                ) auto-mode-alist ))

;    (setq compilation-error-regexp-alist
;       (append '(
;    ;C# Compiler
;    ;t.cs(6,18): error SC1006: Name of constructor must match name of class
;    ;
;    ("\\(\\([a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)[,]\\([0-9]+\\)): \\(error\\|warning\\) CS[0-9]+:" 1 3 4)
;            )
;       compilation-error-regexp-alist))
;





;;; VB editing
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist
      (append '(
                ("\\.vb$" . visual-basic-mode)
                ("\\.frm$" . visual-basic-mode)
                ("\\.bas$" . visual-basic-mode)
                ("\\.cls$" . visual-basic-mode)
                ) auto-mode-alist))

(autoload 'vbp-mode "visual-basic-mode" "VBP mode." t)
;   (setq auto-mode-alist (append '(("\.\(vbg\\|vbg\\)$" .
;                                     vbp-mode)) auto-mode-alist))
;   (setq visual-basic-ide-pathname "E:/Program Files/DevStudio/VB/VB5.EXE")
;
;   (autoload 'vbp-mode "vbp-mode" "VBP mode." t)
;   (setq auto-mode-alist (append '(("\.vbp$" .
;                        vbp-mode)) auto-mode-alist))


; printing added 23.04.2002
(setq ps-printer-name "\\\\Pham0004\\HAM00PRT01")
;(setq ps-lpr-command "D:\\Programme\\Ghostgum\\gsview\\gsprint.exe")
;
;      ;; THis line causes ghostscript to query which printer to
;      ;; use - which you may not need if, for example, you only
;      ;; have one printer.
;      (setq ps-lpr-switches '("-query"))
;
;      (setq ps-printer-name t)


; added 2002-10-21:
; toolbar abschalten
;    (tool-bar-mode -1)
; und die menubar auch gleich:
;    (if (fboundp 'menu-bar-mode)
;        (menu-bar-mode -1); Emacs
;      (set-menubar nil)); XEmacs

; und wer will schon eine scrollbar haben?
;     (scroll-bar-mode -1)


(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))
(defun my-matlab-mode-hook ()
  (setq matlab-indent-function t)       ; if you want function bodies indented
  (setq fill-column 76)         ; where auto-fill should wrap
  (matlab-mode-hilit)
  (turn-on-auto-fill))
(setq matlab-mode-hook 'my-matlab-mode-hook)
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)
(defun my-matlab-shell-mode-hook ()
  '())
(setq matlab-mode-hook 'my-matlab-mode-hook)

; JSP mode
;;multi-mode
;           (autoload 'multi-mode
;                     "multi-mode"
;                     "Allowing multiple major modes in a buffer."
;                     t)
;
;           (defun jsp-mode () (interactive)
;             (multi-mode 1
;                         'html-mode
;                         ;;your choice of modes for java and html
;                         ;;'("<%" java-mode)
;                         '("<%" jde-mode)
;                         '("%>" html-mode)))
;
;           (setq auto-mode-alist
;                 (cons '("\\.jsp$" . jsp-mode)
;                 auto-mode-alist))
;
;
;(add-to-list 'load-path "C:/Programme/emacs-20.7/lisp/mmm")
;(require 'mmm-auto)
;(setq mmm-global-mode 'auto)
;
;  (require 'mmm-sample)
;  (mmm-add-find-file-hook)
;
  ;; Use jsp-helper-mode + mmm-mode for JSP files
;  (add-to-list 'auto-mode-alist '("\\.jsp$" . jsp-html-helper-mode))
  ;; Use mmm-mode to activate jde mode for the Java part of the JSP file
  ;; and javascript mode for any JavaScript code in it.
;  (mmm-add-mode-ext-class 'jsp-html-helper-mode "\\.jsp\\'" 'jsp)
;  (mmm-add-mode-ext-class 'jsp-html-helper-mode "\\.jsp\\'" 'html-js)
;  (mmm-add-mode-ext-class 'html-helper-mode     "\\.js\\'"  'html-js)

;  (mmm-add-mode-ext-class 'java-mode "\\.jsp\\'" 'jsp)
;  (mmm-add-mode-ext-class 'java-mode "\\.jsp\\'" 'html-js)
;  (mmm-add-mode-ext-class 'java-mode     "\\.js\\'"  'html-js)

;(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;
;(add-hook 'html-helper-load-hook (function (lambda () (load "jsp-html-helper-mode.el"))))
;


;27.05.2006
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;25.08.2006 Ruby on Rails
  (require 'snippet)
;  (require 'arorem)

 (defun try-complete-abbrev (old)
   (if (expand-abbrev) t nil))

  (setq hippie-expand-try-functions-list
       '(try-complete-abbrev
         ;try-complete-file-name
         try-expand-dabbrev))


(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))
; aukommentiert 15.02.2009
  (require 'rails)
  (require 'rails-ruby)

; BG 2009-02-16
;(require 'rails-autoload)

  (require 'my-global-abbrev)

; 2007-09-16
;(require 'mmm-mode)
;(require 'mmm-mode)
;(require 'mmm-auto)
;(setq mmm-global-mode 'maybe)
;(setq mmm-submode-decoration-level 2)
;(set-face-background 'mmm-output-submode-face  "LightGrey")
;(set-face-background 'mmm-code-submode-face    "white")
;(set-face-background 'mmm-comment-submode-face "lightgrey")
;(mmm-add-classes
; '((erb-code
;    :submode ruby-mode
;    :match-face (("<%#" . mmm-comment-submode-face)
;                 ("<%=" . mmm-output-submode-face)
;                 ("<%"  . mmm-code-submode-face))
;    :front "<%[#=]?"
;    :back "-?%>"
;    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
;             (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
;             (?= erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
;    )))
;(add-hook 'html-mode-hook
;          (lambda ()
;            (setq mmm-classes '(erb-code))
;            (mmm-mode-on)))
;(add-to-list 'auto-mode-alist '(".rhtml$" . html-mode))

;; shortcut to reparse the buffer
;(global-set-key [f8] ‘mmm-parse-buffer)


;end Ruby on Rails



(autoload 'css-mode "css-mode")
(setq auto-mode-alist
  (cons '("\\.css\\'" . css-mode) auto-mode-alist))

; 2009-04-17 SASS
(require 'sass-mode)
;Coding

;25.08.2006 Ruby on Rails
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)
(modify-coding-system-alist 'file "\\.css$" 'utf-8)
(modify-coding-system-alist 'file "\\.feature$" 'utf-8)

;24.08.2007 UTF-8 doch nicht
;(set-clipboard-coding-system 'utf-8)
;;(set-w32-system-coding-system 'utf-8)
;;(setq default-file-name-coding-system 'utf-8)
;(set-default-coding-systems 'utf-8)
;;
;;;; ??? set-default-coding-systems ??????
;(setq-default buffer-file-coding-system 'utf-8)
;;(setq default-file-name-coding-system 'utf-8)
;(setq default-terminal-coding-system 'utf-8)
;(setq default-keyboard-coding-system 'utf-8)
;;(setq default-process-coding-system
;;      '(utf-8. utf-8))
;
;(setq locale-coding-system 'utf-8)
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;(set-selection-coding-system 'utf-8)
;(prefer-coding-system 'utf-8)

;(modify-coding-system-alist 'file "\\.txt$" 'iso-latin-1)

    (defun recode-region (start end &optional coding-system)
      "Replace the region with a recoded text."
      (interactive "r\n\zCoding System (utf-8): ")
      (setq coding-system (or coding-system 'utf-8))
      (let ((buffer-read-only nil)
            (text (buffer-substring start end)))
        (delete-region start end)
        (insert (decode-coding-string (string-make-unibyte text) coding-system))))

; 22.08.2007 maximize on startup
;
;(require 'maxframe)
;(add-hook 'window-setup-hook 'maximize-frame t)
;oder
;(set-frame-height (selected-frame) 40)
;(set-frame-width (selected-frame) 80)

; NOTIZ: htmlize - macht HTML aus fontlock Auszeichnung
; supergeil!!!!
; M-x htmlize-buffer

;24.08.2007
;# Bind M-F12 to recentf-open-files
;;recentf
;*(require 'recentf)
;*(recentf-mode 1)
;*(setq recentf-max-saved-items 500)
;*(setq recentf-max-menu-items 12)
;siehe oben: (global-set-key [(f12)] 'recentf-open-files)

;24.08.2007
; switch between buffers using C-f6/C-S-f6
;(require 'swbuff)


;24.08.2007
;*(require 'psvn)
; Start the svn interface with M-x svn-status

;24.08.2007
(require 'rails-test)

;2007-09-17
(setq inhibit-startup-message t) ;will inhibit startup messages.
(setq require-final-newline t) ;will make the last line end in a carriage return.
;(fset 'yes-or-no-p 'y-or-n-p) ;will allow you to type just "y" instead of "yes" when you exit.
(setq next-line-add-newlines nil) ;will disallow creation of new lines when you press the "arrow-down key" at end of the buffer.

(setq kill-whole-line t)
(global-set-key [S-right]     'other-window)
(global-set-key [S-left]      'other-window)

;(split-window-horizontally)   ;; want two windows at startup
;(other-window 1)              ;; move to other window
;(global-set-key "\C-o" 'openolive)
;(defun openolive (arg)
;  (find-file "/Volumes/Beruf/Projekte/web/olive/trunk/shop/")
;)

;(global-set-key "\C-cm" 'compile)

;(find-file "/Volumes/Beruf/Projekte/web/olive/trunk/shop/")
;(shell)                       ;; start a shell
;(rename-buffer "shell-first") ;; rename it
;(other-window 1)              ;; move back to first window
;(my-key-swap my-key-pairs)    ;; zap keyboard


; BG 2007-11-22
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path (getenv "PATH"))


;BG 2008-10-22
;(require 'project-nav)


;BG 2008-10-05
(defun tweakemacs-duplicate-one-line ()
  "Duplicate the current line. There is a little bug: when current line is the last line of the buffer, this will not work as expected. Anyway, that's ok for me."
  (interactive)
  (let ((start (progn (beginning-of-line) (point)))
	(end (progn (next-line 1) (beginning-of-line) (point))))
    (insert-buffer-substring (current-buffer) start end)
    (forward-line -1)))
(global-set-key (kbd "C-<") 'tweakemacs-duplicate-one-line)

;Indentation of CSS
(setq cssm-indent-level 3)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-mirror-mode nil)

; Global key for indentation
(defun indent-buffer ()
    (interactive)
    (save-excursion (indent-region (point-min) (point-max) nil))
)
(global-set-key [f2] 'indent-buffer)

;2008-12-16
;have emacs write backups to ~/emacs-backups dir
(setq version-control t)              ; Numbered backups.
(setq backup-directory-alist          ; Backup directory          
      `(("." .                        
         ,(expand-file-name "~/emacs-backups")))) 

; rails rinari 2009-02-15
;(require 'ido)
;(ido-mode t)

;(setq load-path(append '("~/site-lisp/rinari") load-path))
;(require 'rinari)
(global-set-key "\M-v" 'rails-find:view)
(global-set-key "\M-c" 'rails-find:controller)
(global-set-key "\M-m" 'rails-find:models)

;BG 2009-02-17
(defun find_emacs_file ()
  (interactive)
  (find-file "~/.emacs")
)
(global-set-key "\C-c\C-cfe" 'find_emacs_file)
                       
(defun find_musikerseiten_translation_file ()
  (interactive)
  (find-file "/Volumes/Projekte/musikerseiten/config/locales/de.yml")
)
(global-set-key "\C-c\C-cm" 'find_musikerseiten_translation_file)

(global-set-key "\C-c\C-cfro" (lambda () (interactive) (let ((default-directory "/Volumes/Projekte/olmoling/trunk/"))  (call-interactively 'ido-find-file))))
(global-set-key "\C-c\C-cfrl" (lambda () (interactive) (let ((default-directory "/Volumes/Projekte/lakonikos/trunk/"))  (call-interactively 'ido-find-file))))
(global-set-key "\C-c\C-cfrm" (lambda () (interactive) (let ((default-directory "/Volumes/Projekte/musikerseiten/trunk/"))  (call-interactively 'ido-find-file))))
(global-set-key "\C-c\C-cfre" (lambda () (interactive) (let ((default-directory "/Volumes/Projekte/emilio/trunk/"))  (call-interactively 'ido-find-file))))
(global-set-key "\C-c\C-cfr4" (lambda () (interactive) (let ((default-directory "/Volumes/Beruf/Projekte/web/m4/trunk/"))  (call-interactively 'ido-find-file))))


(setq default-directory "/Volumes/Projekte")



;(defmacro bind_find_dir (name key dir)
;  "Define new find function"
;    `(defun ,(intern (concat "find_" name)) ()
;       ,(format "Run find-file in Rails \"%s\" dir" dir)
;       (interactive)
;       (let ((default-directory dir))
;	 (call-interactively 'ido-find-file))
;
;       )
;    (global-set-key key (concat "find_" name))
;
;)
;
;(bind_find_dir "olmoling"  "\C-c\C-cfro" "/Volumes/Projekte/olmoling/trunk/app")

;(global-set-key "\M-v" 'rails-find:view)
;(global-set-key "\M-m" 'rails-nav:goto-models)
;(global-set-key "\M-c" 'rails-nav:goto-controllers)

;2009-04-21
(require 'textmate-links)
