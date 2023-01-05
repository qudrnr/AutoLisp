(defun c:aa (/

		qr-LWPoly qr-flatten qr-SelectionSet
		doc spc del lst des
	)

	(subfuncLoad_230105)

	(setq doc (vla-get-activedocument (vlax-get-acad-object))
		  spc (vlax-get-property doc 'Modelspace)
	)

	; (setq del "false")	; 기존 라인을 유지한다.
	(setq del "true")		; 기존 라인을 지운다

	; 라인선택
	(setq lst (qr-SelectionSet '((0 . "LINE"))))

	; 대상 객체 선택
	(setq des (car (entsel)))

	(if (and lst des)

		(mapcar
			'(lambda ( obj / p1 p2 p3 p4 new )

				(setq p1 (vlax-curve-getStartPoint obj)
					  p2 (vlax-curve-getEndPoint obj)
					  p3 (vlax-curve-getclosestpointto des p2)
					  p4 (vlax-curve-getclosestpointto des p1)
				)

				; 라인과 수직인 사각형면 그리는 조건
				(if (= (distance p1 p2) (distance p3 p4))

					(progn

						(vla-startundomark doc)

						(setq new (qr-LWPoly (list p1 p2 p3 p4) 1))

						; 사각형에 라인의 레이어와 색상을 적용해준다.
						(vla-put-layer new (vla-get-layer obj))
						(vla-put-color new (vla-get-color obj))

						; 기존 라인객체를 지운다.
						(if (= "true" del) (vla-delete obj))

						(vla-endundomark doc)
					)
				)

			) lst
		)
	)
)

(defun subfuncLoad_230105 ()

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

	(defun qr-flatten ( l )

		(if (atom l)
			(list l)
			(append
				(qr-flatten (car l))
				(if (cdr l) (qr-flatten (cdr l)))
			)
		)
	)

	(defun qr-SelectionSet ( types / i sst ent lst)

		(setq i -1)

		(if (and types (setq sst (ssget types)))

			(while (setq ent (ssname sst (setq i (1+ i))))

				(setq lst
					(cons
						(vlax-ename->vla-object ent)
						lst
					)
				)
			)
		)

		lst
	)
)

