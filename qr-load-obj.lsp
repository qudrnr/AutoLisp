; -----------------------------------------------
; https://github.com/qudrnr/qr
; Date : 2023-01-08
; -----------------------------------------------

(vl-load-com)

(defun qr-load-obj ()

	; ==========================================================
	; Clip Board Write
	; ==========================================================
	; @param {String}
	; ==========================================================
	; @return T or nil
	; ==========================================================
	; (qr-ClipboardWrite "test String")
	; ==========================================================
	(defun qr-ClipBoardWrite ( context /

			htmlDoc windows transfer result
		)

		(and

			(= 'STR (type context))

			; DispHTMLDocument
			(setq htmlDoc (vlax-create-object "htmlfile"))

			; DispHTMLWindow2
			(setq windows (vlax-get htmlDoc 'ParentWindow))

			; IHTMLDataTransfer
			(setq transfer (vlax-get windows 'ClipBoardData))

			(setq result
				(vl-catch-all-apply
					'vlax-invoke
					(list transfer 'setData "Text" context)
				)
			)
		)

		; release object
		(vl-catch-all-apply 'vlax-release-object (list htmlDoc))

		; return
		(= -1 result)
	)

	; ==========================================================
	; Clip Board Read
	; ==========================================================
	; @return {String}
	; ==========================================================
	; (qr-ClipBoardRead) --> "test String"
	; ==========================================================
	(defun qr-ClipBoardRead (/ htmlDoc windows transfer result)

		(and

			; DispHTMLDocument
			(setq htmlDoc (vlax-create-object "htmlfile"))

			; DispHTMLWindow2
			(setq windows (vlax-get htmlDoc 'ParentWindow))

			; IHTMLDataTransfer
			(setq transfer (vlax-get windows 'ClipBoardData))

			(setq result
				(vl-catch-all-apply
					'vlax-invoke
					(list transfer 'GetData "Text")
				)
			)
		)

		; release object
		(vl-catch-all-apply 'vlax-release-object (list htmlDoc))

		result
	)
	; ==========================================================
	; Clip Board Clear
	; ==========================================================
	; (qr-ClipBoardClear)
	; ==========================================================
	(defun qr-ClipBoardClear (/ htmlDoc windows transfer result)

		(and

			; DispHTMLDocument
			(setq htmlDoc (vlax-create-object "htmlfile"))

			; DispHTMLWindow2
			(setq windows (vlax-get htmlDoc 'ParentWindow))

			; IHTMLDataTransfer
			(setq transfer (vlax-get windows 'ClipBoardData))

			(setq result
				(vl-catch-all-apply
					'vlax-invoke
					(list transfer 'clearData)
				)
			)
		)

		; release object
		(vl-catch-all-apply 'vlax-release-object (list htmlDoc))

		(= -1 result)
	)
)

(princ)

