

(defun tags_inactivate(root_path)
  "Change file name of tags in <root_paht>"
  (interactive)
  (setq ina_gtags (concat root_path "GTAGS"))
  (setq ina_grtags (concat root_path "GRTAGS"))
  (setq ina_gpath (concat root_path "GPATH"))

  (if (file-exists-p ina_gtags)
      (rename-file ina_gtags (concat ina_gtags "_inactive"))
    (message "file not found: %s" ina_gtags)
    )

  (if (file-exists-p ina_grtags)
      (rename-file ina_grtags (concat ina_grtags "_inactive"))
    (message "file not found: %s" ina_grtags)
    )

  (if (file-exists-p ina_gpath)
      (rename-file ina_gpath (concat ina_gpath "_inactive"))
    (message "file not found: %s" ina_gpath)
    )
  )

(defun tags_activate(root_path)
 "Change file name of tags in <root_paht>"
  (interactive)
  (setq ina_gtags (concat root_path "GTAGS_inactive"))
  (setq ina_grtags (concat root_path "GRTAGS_inactive"))
  (setq ina_gpath (concat root_path "GPATH_inactive"))

  (if (file-exists-p ina_gtags)
      (rename-file ina_gtags (concat root_path "/GTAGS"))
    (message "file not found: %s" ina_gtags)
    )

  (if (file-exists-p ina_grtags)
      (rename-file ina_grtags (concat root_path "/GRTAGS"))
    (message "file not found: %s" ina_grtags)
    )

  (if (file-exists-p ina_gpath)
      (rename-file ina_gpath (concat root_path "/GPATH"))
    (message "file not found: %s" ina_gpath)
   )
  )

(defun tags-change()
  "Change tags database."
  (interactive)
  (setq project (read-string "Enter project to switch to:"))
  (cond ((string-equal project "epg")
         (message "Switching to EPG")
         (tags_inactivate "/repo/eonjdan/epg/upf/")
         (tags_activate "/repo/eonjdan/epg/")
         (setq ggtags-project-root "/repo/eonjdan/epg/")
         )
        ((string-equal project "upf")
         (message "UPF")
         (tags_activate "/repo/eonjdan/epg/upf/")
         (tags_inactivate "/repo/eonjdan/epg/")
         (setq ggtags-project-root "/repo/eonjdan/epg/upf/")
         )
        )
  (helm-gtags-clear-all-cache)
  (helm-gtags-clear-all-stacks)
  ;(helm-gtags-update-tags)
  (ggtags-find-project)
  ;(ggtags-mode)
  ;(ggtags-mode)
)

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
(global-set-key (kbd "C-c C-j") 'open-this-hdr-src)



(provide 'setup-misc-functions)
