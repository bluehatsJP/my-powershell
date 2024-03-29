# Log検索関数
# 検索文字列でファイルを検索し、ヒットした行をファイル出力する。
# また、結果出力範囲で指定した前後の行も出力する。
# [本PowerShellを使用するための前提条件]
# 1. PowerShellがインストールされていること。
# 2. PowerShellの外部実行が許可されていること(そうでない場合、以下のコマンドをPowerShellから実行する必要あり。)
#    set-executionpolicy remotesigned(Windows7の場合、右クリック管理者権限で実行が必要)
#
# [入力パラメータ]
# param $inFile 検索するファイル名(文字列)
# param $outFile 結果出力するファイル名(文字列)
# param $range 結果出力範囲(数値)
# param $searchStr 検索文字列(文字列)
#
# [実行例]
# .\LogSearch.ps1 "CTS.log" "result110606.txt" 2 "serviceId"
#
function LogSearch($inFile,$outFile,$range,$searchStr)
{
	#Write-Host $inFile
	#Write-Host $outFile
    #Write-Host $searchStr
    #Write-Host $range
    # 検索ファイルの中身を取得
	$lines = Get-Content $inFile
	# フォーマット前csvファイルの行数を取得
	$linescount = $(Get-Content $inFile | Measure-Object).Count
	
	# ファイルの中身が存在する場合のみ処理を行う
    for ($i = 0; $i -lt $linescount; $i++)
    {
    	#Write-Host $i
        #Write-Host $lines[$i]
        if ($lines[$i] -ne $null -and $lines[$i].Contains($searchStr))
        {
            if ($i -ge $range) 
            {
                for ($j = $range; $j -gt 0; $j--)
                {
                    # 検索文字列を含む行をファイルに出力
    		        Add-Content $outFile -Value ([System.Convert]::ToString(($i - $j),10) + "行目 :" + $lines[$i - $j])
                }
            }
            # 検索文字列を含む行をファイルに出力
    		Add-Content $outFile -Value ([System.Convert]::ToString($i,10) + "行目*:" + $lines[$i])
            for ($j = 1; $j -le $range; $j++)
            {
                # 検索文字列を含む行をファイルに出力
    		    Add-Content $outFile -Value ([System.Convert]::ToString(($i + $j),10) + "行目 :" + $lines[$i + $j])
            }
        }
    }
}

# 関数実行
LogSearch $args[0] $args[1] $args[2] $args[3]