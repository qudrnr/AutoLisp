
; -----------------------------------------------
; Date : 2022-09-21
; https://github.com/qudrnr/qr
; https://velog.io/@list/Autolisp-Rotated-Dimension
; -----------------------------------------------

; qr 함수로드
(qr-load-com)

(defun test4 (/ doc spc p1 p2 p3 o1 o2 o3 )

    ; @brief : modelspace 정의
    ; @var doc, spc
    (qr-Modelspace)

    ; 포인트
    (setq p1 (getpoint)
          p2 (getpoint)
          p3 (getpoint) 
    )

    ; 직선 치수선은 3개의 포인트와 각도가 필요하다
    (setq o1 (qr-DimRotated p1 p2 p3 (angle p1 p2)))

    ; 가로
    ; (setq o2 (qr-DimRotated p1 p2 p3 0.0))
    
    ; 세로
    ; (setq o3 (qr-DimRotated p1 p2 p3 (* 0.5 pi)))

    (princ)
)

