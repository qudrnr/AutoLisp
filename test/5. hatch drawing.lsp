
; -----------------------------------------------
; Date : 2022-09-21
; https://github.com/qudrnr/qr
; https://velog.io/@list/Autolisp-Hatch-Drawing
; -----------------------------------------------

; qr 함수로드
(qr-load-com)

(defun test5 (/ p1 p2 p3 p4 o1 o2)
 
    ; 객체
    (setq p1 (getpoint)
          p2 (polar p1 (* 0.0 pi) 100)
          p3 (polar p2 (* 0.5 pi) 100)
          p4 (polar p1 (* 0.5 pi) 100)
    )

    ; 사각형 객체
    (setq o1 (qr-lwpoly (list p1 p2 p3 p4) 1))

    ; @param1 : 닫힌 폴리라인, 원 객체
    ; @param2 : 해치 이름
    ; @etc : modelspace only
    (setq o2 (qr-Hatch o1 "SOLID"))

    (princ)
)

