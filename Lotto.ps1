#PS

$host.UI.RawUI.WindowTitle = "로또번호 생성기 -_-"

# 1. 번호별 통계 추출
    Clear-Host
    Write-Host
    Write-Warning "Gettering. Wait..."
    $ie = new-object -ComObject "InternetExplorer.Application"
    $url = 'http://m.nlotto.co.kr/gameResult.do?method=statByNumber'
    $ie.silent = $true
    $ie.navigate($url)
    while($ie.Busy) { Start-Sleep -Milliseconds 100 }
    Start-Sleep 10
    [array]$x = $ie.Document.documentElement.getElementsByClassName('tbbghn') | Select-Object -ExpandProperty innertext
    $ie.Stop()
    $ie.Quit()

Remove-Variable ie

# 2. 가중치 정의하기
    # 2-1. 당첨횟수 모두 더하기
        Write-Host
        Write-Warning "Get Variable Summary"
            $x_sum = 0
            $x | ForEach-Object {
            $x_sum += $_
        }
    # 2-2. 각 자리수 백분률(소수 2자리 반올림) 계산 후 배열추가
        Write-Host
        Write-Warning "Math Operating"
        $Weight_Array= @()
        $x | ForEach-Object {
            $Weight_Array += [math]::round((($_ / $x_sum) * 100),2)
        }
        $i = 1
        $Weight_sum = 0
        #Write-Host "가중치 정보"
        #Write-Host "==========="
        $Weight_Array | ForEach-Object {
            #Write-Host "$i : $_%"
            $i++
            $Weight_sum += $_ # 혹시 몰라서 합계 생성
        }
        #Write-Host "==========="
    Remove-Variable x
    Write-Host

# 3. 각 자리수 백분률의 가중치에 따라 Random 생성
for ($i = 0; $i -lt 10; $i++) {
    $temp = $i + 1
    Write-Host "$temp" : 
    $Result_Array = @()
    while ($Result_Array.Count -lt 6) {
    #for ($i  = 0; $i  -lt 1000 ; $i ++) {
        $value = Get-Random -Minimum 1 -Maximum 45
        $r = Get-Random $Weight_Array
        $Result = $Weight_Array.get($value)
        if ($r -le $Result) {
            #Write-Host "$r", " & ", "$value : $Result"
            if ( -not ($Result_Array -match $value)) {
                $Result_Array += $value
            }
        }
    }
    $Result_Array = $Result_Array | Sort-Object
    Write-Host "   " "$Result_Array"
    Write-Host    
    Remove-Variable Result_Array
    Start-Sleep -Seconds 3
}

Write-Host "Done!!!"
cmd /c pause | Out-Null
