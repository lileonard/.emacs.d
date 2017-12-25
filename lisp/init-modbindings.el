;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;mode and expand name settings
(setq major-mode 'text-mode)
(mapc
 (function (lambda (setting)
             (setq auto-mode-alist
                   (cons setting auto-mode-alist))))
 '(
   ("\\.l$"         .          c-mode)   
   ("\\.c$"         .          c-mode)   
   ("\\.h$"         .          c++-mode)    
   ("\\.cpp$"       .          c++-mode)    
   ("\\.cc$"        .          c++-mode)    
   ("\\.cu$"        .          c++-mode)    
   ("\\.tex$"       .          latex-mode)  
   ("emacs"         .          emacs-lisp-mode)
   ("gnus"          .          emacs-lisp-mode)
   ("\\.session$"   .          emacs-lisp-mode)
   ("\\.el$"        .          emacs-lisp-mode)
   ("\\.emacs$"     .          emacs-lisp-mode)
   ("\\.org$"       .          org-mode)    
   ("\\.xml$"       .          sgml-mode)   
   ("\\\.bash"      .          sh-mode)     
   ("\\.rdf$"       .          sgml-mode)   
   ("\\.css$"       .          css-mode)    
   ("\\.cfm$"       .          html-mode)   
   ("\\.idl$"       .          idl-mode)    
   ("\\.m$"         .          matlab-mode) 
   ("\\.py$"        .          python-mode)
   ("CMakeLists\\.txt\\'"   .  cmake-mode)
   ("\\.pr[io]$"            .  qt-pro-mode)
   ("\\.cmake\\'"           .  cmake-mode)
  ))

(provide 'init-modbindings)



