
; -----------------------------------------------
; Date : 2022-09-18
; https://github.com/qudrnr/qr
; https://velog.io/@list/Autolisp-Line-Drawing
; -----------------------------------------------

; qr 함수로드
(qr-load-com)

(defun test (/ doc spc p1 p2 o1 )

    ; @brief : modelspace 정의
    ; @var doc, spc
    (qr-Modelspace)

    ; 라인을 그리기 위한 시작점과 끝점을 
    ; 마우스로 입력받는다.
    (setq p1 (getpoint)
          p2 (getpoint)
    )

    ; 라인을 그린다.
    (setq o1 (qr-Line p1 p2))

    (princ)
)

