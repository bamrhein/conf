;; MIT License Copyright (c) 2009 Burke Libbey <burke@burkelibbey.org>

(defun color-theme-pastellic-slate ()
  (interactive)

  (let ((*normal*       "LightSteelBlue")
        (*background*   "#1C1D21") ;; slightly blueish-tinted dark gray (#141418)
        (*cursor*       "#FFA560") ;; light orange
        (*mouse*        "sienna1") ;; peach
        (*region*       "#1D1E4C") ;; dark blue
        (*current-line* "#151515") ;; ?
        (*string*       "chocolate") ;; darkish orange
        (*keyword*      "SteelBlue2") ;; (formerly #ffff70 bright yellow)
        (*method*       "goldenrod2") ;; yellow-gold
        (*comment*      "#525F6B") ;; dark gray (#444444)
        (*constant*     "#97FF75") ;; light green (#55FF77)
        (*red*          "#FF6C60") ;; red
        (*operator*     "red") ;; red
        (*class*        "#FFFFB6") ;; very bright yellow (almost white)
        (*type*         "#FFFF77")
        (*variable*     "#A575FF")) ;; very bright purple (formerly MediumPurple2)

    (flet ((color (fgcolor &optional (bgcolor nil) (bold nil) (italic nil) (underline nil))
                  `((t (,@(if fgcolor   `(:foreground ,fgcolor))
                        ,@(if bgcolor   `(:background ,bgcolor))
                        ,@(if bold      '(:bold       t))
                        ,@(if italic    '(:italic     t))
                        ,@(if underline '(:underline  t))))))
           (face (face &rest args)
                 `(,(intern (concat "font-lock-" face "-face"))
                   ,(apply #'color args))))

      (color-theme-install
       `(color-theme-pastellic-slate
         ((background-color . ,*background*)
          (background-mode  . dark)
          (border-color     . ,*background*)
          (cursor-color     . ,*cursor*)
          (foreground-color . ,*normal*)
          (mouse-color      . ,*mouse*))
         (default ,(color *normal* *background*))
         (blue ,(color "blue"))
         (border-glyph ((t (nil))))
         (buffers-tab ,(color *normal* *background*))
         ,(face "builtin" *constant*)
         ,(face "comment" *comment*)
         ,(face "constant" *constant*)
         ,(face "doc-string" *comment*)
         ,(face "function-name" *method*)
         ,(face "keyword" *keyword*)
         ,(face "preprocessor" *keyword*)
         ,(face "reference" "#99CC99")
         ,(face "regexp-grouping-backslash" *red*)
         ,(face "regexp-grouping-construct" *red*)
         ,(face "string" *string*)
         ,(face "type" *type*)
         ,(face "variable-name" *variable*)
         ,(face "warning" "white" *red*)
         (gui-element ,(color *background* "#D4D0C8"))
         (region ,(color nil *region*))
         (mode-line ,(color *background* "grey75"))
         (highlight ,(color nil *current-line*))
         (highline-face ,(color nil *current-line*))
         (italic ((t (nil))))
         (left-margin ((t (nil))))
         (text-cursor ,(color *background* "yellow"))
         (toolbar ((t (nil))))
         (bold ((t (:bold t))))
         (bold-italic ((t (:bold t))))
         (underline ((nil (:underline nil)))))))))

(provide 'color-theme-pastellic-slate)
