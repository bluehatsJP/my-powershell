# Log不要箇所Cut関数
# param $file Cut前のlogファイル名
# param $formatFile Cut後のlogファイル名
# [本PowerShellを使用するための前提条件]
# 1. PowerShellがインストールされていること。
# 2. PowerShellの外部実行が許可されていること(そうでない場合、以下のコマンドをPowerShellから実行する必要あり。)
#    set-executionpolicy remotesigned(Windows7の場合、右クリック管理者権限で実行が必要)
#
function LogCut($file,$formatFile)
{
	#Write-Host $file
	#Write-Host $formatFile
    # フォーマット前csvファイルの中身を取得
	$lines = Get-Content $file
	# フォーマット前csvファイルの行数を取得
	$linescount = $(Get-Content $file | Measure-Object).Count
	#Write-Host $linescount
	
	# ファイルの中身が存在する場合のみ処理を行う
    for ($i = 0; $i -lt $linescount; $i++)
    {
    	#Write-Host $i
        #Write-Host $lines[$i]
        if ($lines[$i] -ne $null -and $lines[$i].Length -gt 31) {
    		$line = $lines[$i].Remove(0,31)
            # フォーマットした行をcsvファイルに出力
    		Add-Content $formatFile -Value $line
        }
    }
}

# 関数実行
LogCut $args[0] $args[1]