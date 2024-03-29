# 初めてPowerShellから実行する場合、以下のコマンドを入力する必要あり。
# Set-ExecutionPolicy RemoteSigned

function RMSOutOfMemoryCountMain($path)
{
    # 結果出力用ディレクトリ
    $resultdir = $path + "\resultdir\"
    New-Item $resultdir -itemType Directory
        
    $files = Get-ChildItem($path)
    for ($i = 0; $i -lt $files.Length; $i++)
    {
        $Mode = $files[$i].Mode
        if ($Mode.Contains("-a"))
        {
            #write-host $path
            #write-host $resultdir
            #write-host $fileNM
            RMSOutOfMemoryCountSub ($path + "\" + $files[$i].Name) ($files[$i].Name) ($resultdir)
        }
    }
}

function RMSOutOfMemoryCountSub($inFile,$fileNM,$resultdir)
{
    #write-host $inFile
    # 検索ファイルの中身を取得
	$lines = Get-Content $inFile
	# フォーマット前csvファイルの行数を取得
	$linescount = $(Get-Content $inFile | Measure-Object).Count
    # 出力ファイル名
    $outFile = $resultdir + $fileNM + "_RMSOutOfMemoryCount.txt"
	
	# ファイルの中身が存在する場合のみ処理を行う
    if ($lines -ne $null)
    {
        for ($i = 0; $i -lt $linescount; $i++)
        {
        	#Write-Host $i
            #Write-Host $lines[$i]
            if ($lines[$i] -ne $null -and $lines[$i].Contains("OutOfMemory"))
            {
                # 検索文字列を含む行をファイルに出力
        		Add-Content $outFile -Value ([System.Convert]::ToString($i,10) + "行目*:" + $lines[$i])
            }
        }
    }
}

# 関数実行
RMSOutOfMemoryCountMain $args[0]