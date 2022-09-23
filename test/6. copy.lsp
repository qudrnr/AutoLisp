
; -----------------------------------------------
; Date : 2022-09-23
; https://github.com/qudrnr/qr
; https://velog.io/@list/Autolisp-Copy-Object
; -----------------------------------------------

; qr 함수로드
(qr-load-com)

(defun test6 (/ doc spc p1 p2 p3 p4 o1 o2)
    
    (qr-Modelspace)

    ; 객체를 그리기 위해서 마우스로 시작점을
    ; 입력받고 나머지 포인트를 계산한다.
    (setq p1 (getpoint)
          p2 (polar p1 (* 0.0 pi) 100)
          p3 (polar p2 (* 0.5 pi) 100)
          p4 (polar p1 (* 0.5 pi) 100)
    )

    ; 가로 세로 100인 사각형 객체
    (setq o1 (qr-lwpoly (list p1 p2 p3 p4) 1))

    ; @param1 : vla-object
    ; 같은 자리에 객체를 그대로 복사한다.
    (setq o2 (qr-copy o1))

    (princ)
)

