; -----------------------------------------------
; .dwg file open
; -----------------------------------------------
; Date : 2022-09-28
; -----------------------------------------------
; @param file {STR} : file root
; @param readonly {BOOL} : t or nil
; -----------------------------------------------
(defun qr-FileOpen_Dwg (file ReadOnly / doc )

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

; window tab active
(defun qr-FileOpen_Dwg_Active (file ReadOnly / doc )

	(setq doc (vla-get-documents (vlax-get-acad-object)))

	(if (findfile file)

		(if ReadOnly

			(vla-activate (vla-open doc file :vlax-true))
			(vla-activate (vla-open doc file :vlax-false))
		)

		(progn

			(princ (strcat "not found " file))
			(princ)
		)
	)
)
(defun c:aa (/ filename )

	; (setq f "c:\\d drive\\drawing1.dwg")

	(setq filename
		(getfiled
			"Open Drawing"
			(getvar 'dwgprefix)
			"dwg"
			0
		)
	)

	; t : 'Read' Only
	; nil : 'read' and 'write'
	(qr-FileOpen_Dwg filename t)
)