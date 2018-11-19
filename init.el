(require 'package)
(add-to-list 'package-archives
	         '("melpa" . "http://melpa.org/packages/") t)
               ;("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(add-to-list 'load-path "~/.emacs.d/custom")

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    GENERAL CONFIG    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(defalias 'yes-or-no-p 'y-or-n-p)

; theme color
;(load-theme 'alect-dark t)
(load-theme 'wombat)

; add line numbers
(global-linum-mode t)
(setq linum-format "%d ")

; fix key-binding for iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)

; NYAN cat mode
;(require 'nyan-mode)
;(setq nyan-bar-length 20)1
;(setq nyan-animate-nyancat t)
;(nyan-mode)

; Use Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
; use // comments for c
;(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
;					comment-end "")))

(defun comment-or-uncomment-line-or-region ()
  "Comment or uncomment the current line or region"
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    )
  )
(global-set-key (kbd "C-;") 'comment-or-uncomment-line-or-region)


(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)

(global-set-key (kbd "C-z") 'eshell)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
(global-set-key (kbd "C-c d") 'duplicate-line)

(global-set-key (kbd "C-x C-x") 'kill-this-buffer)

(defun open-this-hdr-src()
  "Open this files header or source file."
  (interactive)
  (setq target_filename nil)
  (setq this_filename (buffer-file-name))
  (setq this_filename_ext (file-name-extension this_filename))

  (cond ((string-equal this_filename_ext "c")
           (setq target_filename (replace-regexp-in-string "\\.c" ".h" this_filename nil 'literal)))
         ((string-equal this_filename_ext "h")
            (setq target_filename (replace-regexp-in-string "\\.h" ".c" this_filename nil 'literal))))

  (if target_filename
    (if (file-exists-p target_filename)
      (find-file target_filename)
      (message "open-this-hdr-src - file does not exist: %s" target_filename))
    (message "open-this-hdr-src - not valid file extention: .%s" this_filename_ext)))
(global-set-key (kbd "C-c C-f") 'open-this-hdr-src)

;;(global-set-key (kbd "<f1>") 'keyboard-escape-quit)
;; (global-unset-key (kbd "<ESC> <ESC>"))

(global-set-key (kbd "C-c C-g") 'projectile-grep)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "C-q") 'backward-delete-char)
                
;;;;;;;;;;;;;;;;;;;;;;;
;;    Development    ;;
;;;;;;;;;;;;;;;;;;;;;;;
;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 2 spaces
(setq-default  tab-width 2)
;(setq tab-stop-list (number-sequence 4 20 4))
;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; Package zygospore
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows)
         ("RET" .   newline-and-indent))) ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
(windmove-default-keybindings)

; GDB
(setq
 gdb-many-windows t
 gdb-show-main t
)

(setq
 c-default-style "bsd"
 c-basic-offset 2
)
(which-function-mode 1)

;;;;;;;;;;;;;;;;;;
;;    GGTAGS    ;;
;;;;;;;;;;;;;;;;;;
(require 'setup-ggtags)

;;;;;;;;;;;;;;;;;
;;    HELM     ;;
;;;;;;;;;;;;;;;;;
(require 'setup-helm)
;; (setq helm-split-window-default-side 'below)
;(setq helm-split-window-preferred-function 'right)
;; (setq helm-split-window-

;;;;;;;;;;;;;;;;;;;;
;;    SEMANTIC    ;;
;;;;;;;;;;;;;;;;;;;;
(semantic-mode 1)
(semantic-add-system-include "/usr/local/include")
(semantic-add-system-include "/mnt/c/devtools/WindRiver/diab/5.9.4.8/include")
;;;;;;;;;;;;;;;;;;;;;;;;
;;    COMPANY MODE    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(require 'company-c-headers)
(company-mode 1)
(add-hook 'global-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/mnt/c/devtools/WindRiver/diab/5.9.4.8/include/")
; IRONY
;; (use-package irony
;;   :ensure t
;;   :defer t
;;   :init
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   :config
;;   (defun my-irony-mode-hook ()
;;     (define-key irony-mode-map [remap completion-at-point]
;;       'irony-completion-at-point-async)
;;     (define-key irony-mode-map [remap complete-symbol]
;;       'irony-completion-at-point-async))
;;   (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;   )

;; (use-package company
;;   :ensure t
;;   :defer t
;;   :init (add-hook 'after-init-hook 'global-company-mode)
;;   :config
;;   (use-package company-irony :ensure t :defer t)
;;   (setq company-idle-delay              nil
;;         company-minimum-prefix-length   2
;;         company-show-numbers            t
;;         company-tooltip-limit           20
;;         company-dabbrev-downcase        nil
;;         company-backends                '((company-irony company-gtags))
;;         )
;;   :bind ("C-;" . company-complete-common)
;;   )


;;;;;;;;;;;;;;;;;;;;
;;    Speedbar    ;;
;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c C-SPC ") 'sr-speedbar-toggle)
(setq speedbar-directory-unshown-regexp
      "^\\(CSV\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width-x 40)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bf390ecb203806cbe351b966a88fc3036f3ff68cd2547db6ee3676e87327b311" "10a31b6c251640d04b2fa74bd2c05aaaee915cbca6501bcc82820cdc177f5a93" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "0ee3fc6d2e0fc8715ff59aed2432510d98f7e76fe81d183a0eb96789f4d897ca" default)))
 '(ibuffer-saved-filter-groups
   (quote
    (("c-files-filter"
      ("C-files-filter"
       (used-mode . c-mode))))))
 '(ibuffer-saved-filters
   (quote
    (("programming"
      (or
       (derived-mode . prog-mode)
       (mode . ess-mode)
       (mode . compilation-mode)))
     ("text document"
      (and
       (derived-mode . text-mode)
       (not
        (starred-name))))
     ("TeX"
      (or
       (derived-mode . tex-mode)
       (mode . latex-mode)
       (mode . context-mode)
       (mode . ams-tex-mode)
       (mode . bibtex-mode)))
     ("web"
      (or
       (derived-mode . sgml-mode)
       (derived-mode . css-mode)
       (mode . javascript-mode)
       (mode . js2-mode)
       (mode . scss-mode)
       (derived-mode . haml-mode)
       (mode . sass-mode)))
     ("gnus"
      (or
       (mode . message-mode)
       (mode . mail-mode)
       (mode . gnus-group-mode)
       (mode . gnus-summary-mode)
       (mode . gnus-article-mode))))))
 '(package-selected-packages
   (quote
    (company-irony company-irony-c-headers company-c-headers company ac-c-headers persistent-scratch sr-speedbar use-package helm-projectile alect-themes hc-zenburn-theme zenburn-theme creamsody-theme yasnippet nyan-mode iedit function-args flycheck color-theme challenger-deep-theme auto-complete-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
