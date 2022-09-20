(defun qr-load-com ()
 
	(defun qr-Modelspace ()

		(setq doc (vla-get-activedocument (vlax-get-acad-object))
				spc (vlax-get-property doc 'Modelspace)
		)

		(princ)
	)
	
	(defun qr-Paperspace ()

		(setq doc (vla-get-activedocument (vlax-get-acad-object))
			spc (vlax-get-property doc 'Paperspace)
		)

		(princ)
	)

	; @extvar spc {vla-object} : Active Document Space
	; @param p1 {point} : start point
	; @param p2 {point} : end point
	(defun qr-Line ( p1 p2 )

		(if (and spc p1 p2)

			(vl-catch-all-apply 
				'vlax-invoke 
				(list spc 'addline p1 p2)
			)
		)
	)

	; @extvar spc {vla-object} : Active Document Space
	; @param ptr {point} : center point
	; @param rad {real} : radius
	(defun qr-circle ( ptr rad )
		
		(if (and spc ptr rad)
		
			(vl-catch-all-apply 
				'vlax-invoke 
				(list spc 'addcircle ptr rad)
			)
		)
	)

	; @brief : polyline drawing
	; @param lst {LIST} : Point List
	; @param cls {INT} : close
	; @return : VLA-OBJECT
	(defun qr-LWPoly ( lst cls / var obj)

		(and 
	
			(setq var
				(qr-flat 
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
)

(princ)