(package-initialize)
 ; MELPA repository list
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
; theme color
(load-theme 'wheatgrass t)
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




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
       (mode . gnus-article-mode))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
