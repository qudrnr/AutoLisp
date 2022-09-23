
; -----------------------------------------------
; Date : 2022-09-22
; https://github.com/qudrnr/qr
; https://velog.io/@list/Autolisp-Circle-Drawing
; -----------------------------------------------

; qr 함수로드
(qr-load-com)

(defun test3 (/ doc spc p1 p2 p3 p4 o1 )

    ; @brief : modelspace 정의
    ; @var doc, spc
    (qr-Modelspace)

    ; 폴리라인 포인트 리스트
    (setq p1 (getpoint)
          p2 (getpoint)
          p3 (getpoint)
          p4 (getpoint)
    )

    ; 4개의 포인트를 가진 폴라라인을 그린다.
    ; (1) : 포인트 리스트
    ; (2) : 폴리라인의 닫힘 여부
    ;    - 0 ; Open
    ;    - 1 ; Close
    (setq o1 (qr-lwpoly (list p1 p2 p3 p4) 1))

    (princ)
)

