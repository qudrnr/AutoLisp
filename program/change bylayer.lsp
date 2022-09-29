; -----------------------------------------------
; Replace all selected object settings with "BYLAYER"
; -----------------------------------------------
; Date : 2022-09-29
; -----------------------------------------------
; linetype / color / lineweight
; -----------------------------------------------

(vl-load-com)
(defun c:aa (/ doc )
	
	(setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))

	(if (ssget "_:L")

		(vlax-for obj (vla-get-ActiveSelectionSet doc)

			(vlax-put-property obj 'linetype 	"ByLayer")
			(vlax-put-property obj 'color 		acByLayer)
			(vlax-put-property obj 'lineweight 	acLnWtByLayer)
		)
	)

	(princ)
)