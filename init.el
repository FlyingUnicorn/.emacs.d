(package-initialize)
 ; MELPA repository list
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
; theme color
(load-theme 'alect-dark t)
; start auto-complte with emacs
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
; add line numbers
(global-linum-mode t)
(setq linum-format "%d ")
; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
; function for auto complete headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (setq achead:include-directories
    (append '("/usr/include/c++/5"
	      "/usr/include/x86_64-linux-gnu/c++/5"
	      "/usr/include/c++/5/backward"
	      "/usr/lib/gcc/x86_64-linux-gnu/5/include"
	      "/usr/local/include"
	      "/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed"
	      "/usr/include/x86_64-linux-gnu"
	      "/usr/include")
	      achead:include-directories))
)
; call function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
; fix key-binding for iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)
; turn on Semantic (CEDET)
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode
(global-ede-mode 1)
; create project for our program
(ede-cpp-root-project "my_test_proj"
		      :file "/mnt/c/test/Makefile"
		      :include-path '("/inc"
				      "/inc2"))
(global-semantic-idle-scheduler-mode 1)
; NYAN cat mode
(require 'nyan-mode)
;(setq nyan-wavy-trail t)
(setq nyan-bar-length 20)
(setq nyan-animate-nyancat t)
(nyan-mode)
; Enable Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)
; Use Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
; use // comments for c
(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
					comment-end "")))
; change key-binding for occur
(global-set-key (kbd "C-c o") 'occur)



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
   '(alect-themes hc-zenburn-theme zenburn-theme creamsody-theme yasnippet nyan-mode iedit function-args flycheck color-theme challenger-deep-theme auto-complete-c-headers)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
