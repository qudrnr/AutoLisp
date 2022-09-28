; -----------------------------------------------
; .dwg file open
; -----------------------------------------------
; Date : 2022-09-28
; -----------------------------------------------
; file : filename
; readonly : t or nil
; -----------------------------------------------
(defun qr-DwgFileOpen (file ReadOnly / doc )

	(setq doc (vla-get-documents (vlax-get-acad-object))) 

	(if (findfile file)

		(if ReadOnly

			(vla-open doc file :vlax-true)
			(vla-open doc file :vlax-false)
		)

		(progn
			
			(princ (strcat "not found " file))
			(princ)
		)
	)
)
(defun c:aa (/ f )

	(setq f "c:\\d drive\\drawing1.dwg")

	(qr-dwgfileopen f t)
)