## AUTOLISP Function List

### qr-load-draw.lsp

    * qr-Modelspace
    * qr-Paperspace
    * qr-Line : 라인
    * qr-circle : 원
    * qr-lwpoly : 폴리라인
    * qr-dimrotated : 직선 치수선
    * qr-hatch : 해치 드로잉
    * qr-copy : 객체를 복사한다.

### qr-load-list.lsp

    * qr-push : 리스트의 맨 마지막에 요소를 추가합니다.
    * qr-pushIndexOf : 리스트의 원하는 위치에 요소를 추가합니다.
    * qr-flatten : 리스트를 모두 이어 붙인다.[lee-mac]
    * qr-flat : 리스트를 1 단계만 이어 붙인다.
    * qr-flatDeep : 리스트를 단계를 지정해서 이어 붙인다.
    * qr-entries : 리스트의 각각의 요소에 position 숫자를 추가해준다.
    * qr-positionList : 리스트에서 요소를 찾아서 위치값을 리턴해준다.
    * qr-SelectionSet : ssget으로 객체를 선택하고 vla 객체로 리턴해준다.
    * qr-findVLA : 리스트에서 모든 VLA객체를 찾아서 리턴해준다

### qr-load-obj.lsp

    * qr-ClipBoardWrite : window OS 클립보드에 텍스트를 저장한다.
    * qr-ClipBoardRead : window OS 클립보드에 있는 텍스트를 읽어온다
    * qr-ClipBoardClear : window OS 클립보드에 있는 내용을 지운다.
    * qr-Delay : 해당 시간만큼 동작을 일시중지한다. (1000 ms = 1 sec.)