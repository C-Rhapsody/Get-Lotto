# Get-Lotto
로또나눔 사이트 당첨통계를 가져온 후, 랜덤가중치 생성(10개)

  - Windows Powershell에서 작성
    - Invoke-WebRequest에서는 Cookie Exception 문제로, IE Object를 생성해서 실제로 Browser를 호출한 다음
    - 생성된 Object에서 HTML의 DOM Parsing하여 outertext의 Value 값을 배열로 담아 백분율을 환산
    - 이후 최종 산출물의 가중치 연산을 위하여 
      - 배열 중 임의로 Value를 Get-Random으로 구하고 : 기준값
      - 위와 동일한 배열에서 별개의 Value를 Get-Random으로 지정 : 산출값
    - 산출값의 Index Number를 담기위한 비어진 배열을 생성하여 총 6자리가 될 때까지 While
    - 산출 배열을 오름차순으로 Sort
