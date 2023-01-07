; -----------------------------------------------
; https://github.com/qudrnr/qr
; Date : 2023-01-08
; -----------------------------------------------

(vl-load-com)

(defun qr-load-drawing ()

	; ==========================================================
	; space define
	; ==========================================================
	(defun qr-Modelspace ()

		(setq doc (vla-get-activedocument (vlax-get-acad-object))
			  spc (vlax-get-property doc 'Modelspace)
		)

		(princ)
	)

	; ==========================================================
	; space define
	; ==========================================================
	(defun qr-Paperspace ()

		(setq doc (vla-get-activedocument (vlax-get-acad-object))
			  spc (vlax-get-property doc 'Paperspace)
		)

		(princ)
	)

	; ==========================================================
	; line drawing
	; ==========================================================
	; @param p1 {point} : start point
	; @param p2 {point} : end point
	; @extvar spc {vla-object} : Active Document Space
	; ==========================================================
	; return : IAcadLine
	; ==========================================================
	(defun qr-Line ( p1 p2 )

		(if (and spc p1 p2)

			(vl-catch-all-apply
				'vlax-invoke
				(list spc 'addline p1 p2)
			)
		)
	)

	; ==========================================================
	; circle drawing
	; ==========================================================
	; @param ptr {point} : center point
	; @param rad {real} : radius
	; @extvar spc {vla-object} : Active Document Space
	; ==========================================================
	; return : IAcadCircle
	; ==========================================================
	(defun qr-circle ( ptr rad )

		(if (and spc ptr rad)

			(vl-catch-all-apply
				'vlax-invoke
				(list spc 'addcircle ptr rad)
			)
		)
	)

	; ==========================================================
	; LwPolyline drawing
	; ==========================================================
	; @param lst {LIST} : Point List
	; @param cls {INT} : close
	; @extvar spc {vla-object} : Active Document Space
	; ==========================================================
	; @return : IAcadLWPolyline
	; ==========================================================
	(defun qr-LWPoly ( lst cls / var obj)

		(and
			(setq var
				(qr-flatten
					(mapcar 'list
						(mapcar 'car lst)
						(mapcar 'cadr lst)
					)
				)
			)

			(setq obj
				(vl-catch-all-apply 'vlax-invoke
					(list spc 'addlightweightpolyline var)
				)
			)
		)

		(if (and obj (not (vl-catch-all-error-p obj)))

			(if (= 1 cls)

				(vla-put-Closed obj 1)
				(vla-put-Closed obj 0)
			)
		)

		; return
		obj
	)

	; ==========================================================
	; dimRotated Dimension drawing
	; ==========================================================
	; @param p1 {point} : first point
	; @param p2 {point} : second point
	; @param p3 {point} : text point
	; @param ang {real} : angle
	; @extvar spc {vla-object} : Active Document Space
	; ==========================================================
	; return : IAcadDimRotated
	; ==========================================================
	(defun qr-DimRotated ( p1 p2 p3 ang )

		(if (and p1 p2 p3 ang)

			(vl-catch-all-apply 'vlax-invoke
				(list spc 'AddDimRotated p1 p2 p3 ang)
			)
		)
	)

	; ==========================================================
	; Hatch drawing
	; ==========================================================
	; @param Obj {VLA-OBJECT} : Polyline, Circle object
	; @param Shape {STR} : Pattern name
	; @etc : modelspace only
	; ==========================================================
	; return : IAcadHatch
	; ==========================================================
	(defun qr-Hatch ( Obj Shape / doc spc hat ole )

		(qr-modelspace)

		(setq hat (vla-AddHatch spc 0 Shape :vlax-true))

  		(if (and Obj hat)

			(progn

				(setq ole
					(vlax-make-safearray vlax-vbObject
						'(0 . 0)
					)
				)

				(vlax-safearray-put-element ole 0 Obj)

				(vla-AppendInnerLoop hat ole)

				hat
			)
		)
	)

	; ==========================================================
	; Copy the VLA-object.
	; ==========================================================
	; @param obj {VLA-OBJECT}
	; ==========================================================
	; return : {VLA-OBJECT}
	; ==========================================================
	(defun qr-copy ( obj )

		(vl-catch-all-apply 'vlax-invoke
			(list obj 'Copy)
		)
	)
)

(princ)

