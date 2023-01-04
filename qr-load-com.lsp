; -----------------------------------------------
; https://github.com/qudrnr/qr
; https://velog.io/@list
; Date : 2022-09-20
; -----------------------------------------------

(defun qr-load-com ()

	(vl-load-com)

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

	; ==========================================================
	; Adds an element to the end of the list and returns the list.
	; ==========================================================
	; @param item {..} : Elements to Add to List
	; @param lst {list}
	; ==========================================================
	; return : {list}
	; ==========================================================
	; (qr-push "C" '("A" "B"))  --> ("A" "B" "C")
	; ==========================================================
	(defun qr-push ( item lst )

		(cond
			(	(= nil lst)

				(list item)
			)
			(	t

				(append lst (list item))
			)
		)
	)

	; ==========================================================
	; Adds an element to the index of the list and returns the list.
	; ==========================================================
	; @param item {..}: Elements to Add to List
	; @param lst {list}
	; @param index {int}: index number
	; ==========================================================
	; return : {list}
	; ==========================================================
	; (qr-pushIndexOf "C" '("A" "B" "D") 2)  --> ("A" "B" "C" "D")
	; ==========================================================
	(defun qr-pushIndexOf ( item lst index )

		(cond
			(	(= 0 index)

				(reverse
					(qr-push item (reverse lst))
				)
			)
			(	(< 0 index (length lst))

				(cons
					(car lst)
					(qr-pushIndexOf
						item (cdr lst) (1- index)
					)
				)
			)
			(	t

				(qr-push item lst)
			)
		)
	)

	; ==========================================================
	; nested array
	; ==========================================================
	; @param {list} : lst
	; ==========================================================
	; http://www.lee-mac.com/flatten.html
	; ==========================================================
	(defun qr-flatten ( l )

		(if (atom l)
			(list l)
			(append
				(qr-flatten (car l))
				(if (cdr l) (qr-flatten (cdr l)))
			)
		)
	)

	; ==========================================================
	; To flat single level list
	; ==========================================================
	; @param lst {list}
	; @etc : remove 'nil'
	; ==========================================================
	; return : {list}
	; ==========================================================
	; (qr-flat (list 1 (list 2 3) 4 (list 5 (list 6 7)))
	;  --> (1 2 3 4 5 (6 7))
	; ==========================================================
	(defun qr-flat ( lst )

		(if (and lst (listp lst))

			(apply 'append
				(mapcar
					'(lambda ( item )

						(if (listp item)

							item
							(list item)
						)

					) lst
				)
			)
		)
	)

	; ==========================================================
	; flat list (default : 1 depth)
	; ==========================================================
	; @param lst {list}
	; @param depth {int}
	; @etc : remove 'nil'
	; ==========================================================
	; return : {list}
	; ==========================================================
	; (qr-flatDeep (list 1 (list 2 (list 3 (list 4)))) nil) --> (1 2 (3 (4)))
	; (qr-flatDeep (list 1 (list 2 (list 3 (list 4)))) 1) --> (1 2 (3 (4)))
	; (qr-flatDeep (list 1 (list 2 (list 3 (list 4)))) 2) --> (1 2 3 (4))
	; (qr-flatDeep (list 1 (list 2 (list 3 (list 4)))) 3) --> (1 2 3 4)
	; ==========================================================
	(defun qr-flatDeep ( lst depth )

		(if (= nil depth)	(setq depth 1))

		(repeat depth (setq lst (qr-flat lst)))
	)

	; ==========================================================
	; List Entry
	; ==========================================================
	; @param {list}
	; return {List}
	; ==========================================================
	; (qr-entries (list "A" "B" "C"))
	; --> ((0 "A") (1 "B") (2 "C"))
	; ==========================================================
	(defun qr-entries ( lst / iv )

		(setq iv -1)
		(mapcar
			'(lambda ( item )

				(setq iv (1+ iv))

				(cond
					(	(and item (listp item))

						(qr-entries item)
					)
					(	t	(list iv item))
				)

			) lst
		)
	)


	; ==========================================================
	; List of location of elements
	; ==========================================================
	; return {List}
	; ==========================================================
	; (qr-positionList "A" (list "B" "A" "C" "A"))
	; ==========================================================
	(defun qr-positionList ( item lst / i)

		(setq i -1)

		(vl-remove nil
			(mapcar
				'(lambda ( l )

					(setq i (1+ i))

					(if (= item (nth i lst)) i)

				) lst
			)
		)
	)

	; ==========================================================
	; ssget and vla object
	; ==========================================================
	; return {List}
	; ==========================================================
	; (qr-SelectionSet "LINE")
	; ==========================================================
	(defun qr-SelectionSet ( str / i name sst ent lst)

		(setq i -1)

		(if (and
				(setq name (strcat "'((0 . " "\"" str "\"" "))"))

				(setq name (eval (read name)))

				(setq sst (ssget name))
			)

			(while (setq ent (ssname sst (setq i (1+ i))))

				(setq lst (cons (vlax-ename->vla-object ent) lst))
			)
		)

		lst
	)

)

(princ)

