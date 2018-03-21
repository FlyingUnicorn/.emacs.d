
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
(load-theme 'alect-dark t)

; add line numbers
(global-linum-mode t)
(setq linum-format "%d ")

; fix key-binding for iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)

; NYAN cat mode
(require 'nyan-mode)
(setq nyan-bar-length 20)
(setq nyan-animate-nyancat t)
(nyan-mode)

; Use Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
; use // comments for c
(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
					comment-end "")))

(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;
;;    Development    ;;
;;;;;;;;;;;;;;;;;;;;;;;
;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default  tab-width 4)
(setq tab-stop-list (number-sequence 4 20 4))
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


;;;;;;;;;;;;;;;;;;
;;    GGTAGS    ;;
;;;;;;;;;;;;;;;;;;
(require 'setup-ggtags)
;;  (require 'ggtags)
;;  (ggtags-mode 1)
;;  (add-hook 'c-mode-common-hook
;;            (lambda ()
;;              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;                (ggtags-mode 1))))
;; (dolist (map (list ggtags-mode-map))
;;   (define-key map  (kbd "C-c g s") 'ggtags-find-other-symbol)
;;   (define-key map  (kbd "C-c g h") 'ggtags-view-tag-history)
;;   (define-key map  (kbd "C-c g r") 'ggtags-find-reference)
;;   (define-key map  (kbd "C-c g f") 'ggtags-find-file)
;;   (define-key map  (kbd "C-c g c") 'ggtags-create-tags)
;;   (define-key map  (kbd "C-c g u") 'ggtags-update-tags)
;;   (define-key map  (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;;   (define-key map  (kbd "M-.") 'ggtags-find-tag-dwim)
;;   (define-key map  (kbd "M-,") 'pop-tag-mark)
;;   (define-key map  (kbd "C-c <") 'ggtags-prev-mark)
;;   (define-key map  (kbd "C-c >") 'ggtags-next-mark))



;;;;;;;;;;;;;;;;;
;;    HELM     ;;
;;;;;;;;;;;;;;;;;
(require 'setup-helm)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x b") 'helm-mini)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-c h o") 'helm-occur)
;; (global-set-key (kbd "C-c h SPC") 'helm-all-mark-rings)
;; (global-set-key (kbd "C-c h x") 'helm-register)
;; (global-set-key (kbd "C-c p h") 'helm-projectile)
;; (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
;; (setq helm-M-fuzzy-match t
;;       helm-recentf-fuzzy-match t
;;       helm-semantic-fuzzy-match t
;;       helm-imenu-fuzzy-match t)
;; (require 'helm)
;; (require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
;; (global-unset-key (kbd "C-x c"))

;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; (when (executable-find "curl")
;;   (setq helm-google-suggest-use-curl-p t))

;; (when (executable-find "ack-grep")
;;   (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
;; 	helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

;; (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;       helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;       helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;       helm-ff-file-name-history-use-recentf t
;;       helm-echo-input-in-header-line t)

;; (defun spacemacs//helm-hide-minibuffer-maybe ()
;;   "Hide minibuffer in Helm session if we use the header line as input field."
;;   (when (with-helm-buffer helm-echo-input-in-header-line)
;;     (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;       (overlay-put ov 'window (selected-window))
;;       (overlay-put ov 'face
;;                    (let ((bg-color (face-background 'default nil)))
;;                      `(:background ,bg-color :foreground ,bg-color)))
;;       (setq-local cursor-type nil))))

;; (add-hook 'helm-minibuffer-set-up-hook
;;           'spacemacs//helm-hide-minibuffer-maybe)

;; (setq helm-autoresize-max-height 0)
;; (setq helm-autoresize-min-height 20)
;; (helm-autoresize-mode 1)

;; (helm-mode 1)



;;;;;;;;;;;;;;;;;;;;;;;;;
;;    AUTO COMPLETE    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (ac-config-default)

;; (require 'yasnippet)
;; (yas-global-mode 1)
;; ; function for auto complete headers
;; (defun my:ac-c-header-init ()
;;   (require 'auto-complete-c-headers)
;;   (add-to-list 'ac-sources 'ac-source-c-headers)
;;   (setq achead:include-directories
;;     (append '("/usr/include/c++/5"
;; 	      "/usr/include/x86_64-linux-gnu/c++/5"
;; 	      "/usr/include/c++/5/backward"
;; 	      "/usr/lib/gcc/x86_64-linux-gnu/5/include"
;; 	      "/usr/local/include"
;; 	      "/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed"
;; 	      "/usr/include/x86_64-linux-gnu"
;; 	      "/usr/include")
;; 	      achead:include-directories))
;; )
;; ; call function from c/c++ hooks
;; (add-hook 'c++-mode-hook 'my:ac-c-header-init)
;; (add-hook 'c-mode-hook 'my:ac-c-header-init)

;; ; turn on Semantic
;; (semantic-mode 1)
;; (defun my:add-semantic-to-autocomplete()
;;   (add-to-list 'ac-sources 'ac-source-semantic)
;; )
;; (add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;turn on ede mode
;(global-ede-mode 1)
; create project for our program
;(ede-cpp-root-project "my_test_proj"
;		      :file "/mnt/c/test/Makefile"
;		      :include-path '("/inc"
;				      "/inc2"))
;(global-semantic-idle-scheduler-mode 1)
; Enable Ido mode
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(setq ido-use-filename-at-point 'guess)
;(ido-mode 1)
; change key-binding for occur
;(global-set-key (kbd "C-c o") 'occur)


;;;;;;;;;;;;;;;;;;;;
;;    SEMANTIC    ;;
;;;;;;;;;;;;;;;;;;;;
(semantic-mode 1)
(semantic-add-system-include "/usr/local/include")

;;;;;;;;;;;;;;;;;;;;;;;;
;;    COMPANY MODE    ;;
;;;;;;;;;;;;;;;;;;;;;;;;

; IRONY
(use-package irony
  :ensure t
  :defer t
  :init
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  :config
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
  (setq company-idle-delay              nil
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20
        company-dabbrev-downcase        nil
        company-backends                '((company-irony company-gtags))
        )
  :bind ("C-;" . company-complete-common)
  )

;;;;;;;;;;;;;;;;;;;;
;;    Speedbar    ;;
;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c C-SPC ") 'sr-speedbar-toggle)
(setq speedbar-directory-unshown-regexp
      "^\\(CSV\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "0ee3fc6d2e0fc8715ff59aed2432510d98f7e76fe81d183a0eb96789f4d897ca" default))
 '(ibuffer-saved-filter-groups
   '(("c-files-filter"
      ("C-files-filter"
       (used-mode . c-mode)))))
 '(ibuffer-saved-filters
   '(("programming"
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
       (mode . gnus-article-mode)))))
 '(package-selected-packages
   '(company-irony company-irony-c-headers company-c-headers company ac-c-headers persistent-scratch sr-speedbar use-package helm-projectile alect-themes hc-zenburn-theme zenburn-theme creamsody-theme yasnippet nyan-mode iedit function-args flycheck color-theme challenger-deep-theme auto-complete-c-headers)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
