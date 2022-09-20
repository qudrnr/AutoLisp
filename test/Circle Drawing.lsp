
; -----------------------------------------------
; Date : 2022-09-19
; https://github.com/qudrnr/qr
; https://velog.io/@list/Autolisp-Circle-Drawing
; -----------------------------------------------

; qr 함수로드
(qr-load-com)

(defun test2 (/ doc spc p1 p2 o1 )

    ; @brief : modelspace 정의
    ; @var doc, spc
    (qr-Modelspace)

    ; 원의 중심점을 마우스로 입력받는다.
    (setq p1 (getpoint)

    )

    ; 반지름이 100mm 원을 그린다.
    (setq o1 (qr-circle p1 100.0))

    (princ)
)

