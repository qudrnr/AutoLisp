; -----------------------------------------------
; https://github.com/qudrnr/qr
; https://velog.io/@list
; Date : 2022-09-20
; -----------------------------------------------

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

	; @extvar spc {vla-object} : Active Document Space
	; @param lst {LIST} : Point List
	; @param cls {INT} : close
	; @return : VLA-OBJECT
	(defun qr-LWPoly ( lst cls / qr-flat var obj)

		; list를 flat하게 만든다. 
		(defun qr-flat ( lst )

			(if (atom lst)

				(list lst)

				(append 
					(qr-flat (car lst)) 
					(if (cdr lst) (qr-flat (cdr lst)))
				)
			)
		)

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

	
	; @extvar spc {vla-object} : Active Document Space
	; @param p1 {point} : first point
	; @param p2 {point} : second point
	; @param p3 {point} : text point
	; @param ang {real} : angle
	(defun qr-DimRotated ( p1 p2 p3 ang )

		(if (and p1 p2 p3 ang)

			(vl-catch-all-apply 'vlax-invoke 	
				(list spc 'AddDimRotated p1 p2 p3 ang)
			)
		)
	)

	; @param Obj {VLA-OBJECT} : Polyline, Circle object
	; @param Shape {STR} : Hatch shape
	; @etc : modelspace only
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
)

(princ)