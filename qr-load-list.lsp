; -----------------------------------------------
; https://github.com/qudrnr/qr
; Date : 2023-01-08
; -----------------------------------------------

(vl-load-com)

(defun qr-load-list ()

	; =====================================================
	; Adds an element to the end of the list and returns the list.
	; =====================================================
	; @param item {..} : Elements to Add to List
	; @param lst {list}
	; =====================================================
	; return : {list}
	; =====================================================
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

	; =====================================================
	; Adds an element to the index of the list and returns the list.
	; =====================================================
	; @param item {..}: Elements to Add to List
	; @param lst {list}
	; @param index {int}: index number
	; =====================================================
	; return : {list}
	; =====================================================
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

	; =====================================================
	; nested array
	; =====================================================
	; @param {list} : lst
	; =====================================================
	; http://www.lee-mac.com/flatten.html
	; =====================================================
	(defun qr-flatten ( l )

		(if (atom l)
			(list l)
			(append
				(qr-flatten (car l))
				(if (cdr l) (qr-flatten (cdr l)))
			)
		)
	)

	; =====================================================
	; To flat single level list
	; =====================================================
	; @param lst {list}
	; @etc : remove 'nil'
	; =====================================================
	; return : {list}
	; =====================================================
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

	; =====================================================
	; flat list (default : 1 depth)
	; =====================================================
	; @param lst {list}
	; @param depth {int}
	; @etc : remove 'nil'
	; =====================================================
	; return : {list}
	; =====================================================
	(defun qr-flatDeep ( lst depth )

		(if (= nil depth)	(setq depth 1))

		(repeat depth (setq lst (qr-flat lst)))
	)

	; =====================================================
	; List Entry
	; =====================================================
	; @param {list}
	; return {List}
	; =====================================================
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

	; =====================================================
	; List of location of elements
	; =====================================================
	; return {List}
	; =====================================================
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

	; =====================================================
	; ssget and vla object
	; =====================================================
	; return {List}
	; =====================================================
	(defun qr-SelectionSet ( types / i sst ent lst)

		(cond
			(	types	(setq sst (ssget types)))
			(	t		(setq sst (ssget)))
		)

		(setq i -1)

		(if sst

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

	; =====================================================
	; find VLA-OBJECT from List
	; =====================================================
	(defun qr-findVLA ( lst )

		(vl-remove-if-not
			'(lambda ( obj)

				(and
					(= 'VLA-OBJECT (type obj))
					(not (vlax-erased-p obj))
				)

			) (qr-flatten lst)
		)
	)
)

(princ)

