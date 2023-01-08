; ---------------------------------------------------------
; draw test code
; ---------------------------------------------------------
(qr-load-draw)

(defun c:a1 (/ doc spc p01 p02 o01 )

	; doc spc
	(qr-Modelspace)

	(setq p01 (getpoint)
		  p02 (getpoint)
	)

	(setq o01 (qr-Line p01 p02))

	; color change : red
	(vla-put-color o01 1)

	o01
)

(defun c:b1 (/ doc spc p01 o01 )

	; doc spc
	(qr-Modelspace)

	(setq p01 (getpoint)
	)

	(setq o01 (qr-circle p01 10))

	; color change
	(vla-put-color o01 2)

	o01
)

(defun c:c1 (/ doc spc p01 p02 p03 p04 o01 )

	; doc spc
	(qr-Modelspace)

	(setq p01 (getpoint)
		  p02 (getpoint p01)
		  p03 (getpoint p02)
		  p04 (getpoint p03)
	)

	(setq o01 (qr-LWPoly (list p01 p02 p03 p04) 1))

	; color change
	(vla-put-color o01 3)

	o01
)

(defun c:d1 (/ doc spc p01 p02 p03  o01 )

	; doc spc
	(qr-Modelspace)

	(setq p01 (getpoint)
		  p02 (getpoint p01)
		  p03 (getpoint p02)
	)

	(setq o01 (qr-DimRotated p01 p02 p03 (angle p01 p02)))

	o01
)

(defun c:e1 (/ doc spc p01 p02 p03 p04 o01 o02 )

	; doc spc
	(qr-Modelspace)

	(setq p01 (getpoint)
		  p02 (getpoint p01)
		  p03 (getpoint p02)
		  p04 (getpoint p03)
	)

	(setq o01 (qr-LWPoly (list p01 p02 p03 p04) 1)
		  o02 (qr-hatch o01 "SOLID")
	)

	o02
)

(defun c:f1 (/ doc spc p01 p02 p03 p04 o01 o02 )

	; doc spc
	(qr-Modelspace)

	(setq p01 (getpoint)
		  p02 (getpoint p01)
		  p03 (getpoint p02)
		  p04 (getpoint p03)
	)

	(setq o01 (qr-LWPoly (list p01 p02 p03 p04) 1))

	(setq o02 (qr-copy o01))

	o02
)
