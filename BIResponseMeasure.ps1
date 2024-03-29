# 初めてPowerShellから実行する場合、以下のコマンドを入力する必要あり。
# Set-ExecutionPolicy RemoteSigned

function BIResponseMeasureMain($path)
{
    # 結果出力用ディレクトリ
    $resultdir = $path + "\resultdir_OverOne\"
    New-Item $resultdir -itemType Directory
    # BI接続回数
    $conCount = 0
    # レスポンスの閾値を超えた回数
    $overCount = 0
        
    $files = Get-ChildItem($path)
    for ($i = 0; $i -lt $files.Length; $i++)
    {
        $Mode = $files[$i].Mode
        if ($Mode.Contains("-a"))
        {
            #write-host $path
            #write-host $resultdir
            #write-host $fileNM
            $count = BIResponseMeasureSub ($path + "\" + $files[$i].Name) ($files[$i].Name) ($resultdir)
            # 返却値は、配列の3番目以降に設定されているので注意
            $conCount += [int]($count[2])
            $overCount += [int]($count[3])
        }
    }
    Write-Host "BI接続回数:" $conCount "回"
    Write-Host "レスポンスの閾値を超えた回数:" $overCount "回"
}

function BIResponseMeasureSub($inFile,$fileNM,$resultdir)
{
    #write-host $inFile
    # 検索ファイルの中身を取得
	$lines = Get-Content $inFile
	# フォーマット前csvファイルの行数を取得
	$linescount = $(Get-Content $inFile | Measure-Object).Count
    # BI接続開始時間
    $bistart = ""
    # BI接続終了時間
    $biend = ""
    # 出力ファイル名
    $outFile = $resultdir + $fileNM + "_BIResponse.txt"
    # 出力ファイル名(2秒以上のリクエスト用)
    $outFileOverFive = $resultdir + $fileNM + "_BIResponseOverTwo.txt"
    # BI接続時間
    $restime
    $restseconds
    # BI接続回数
    $conCount = 0
    # レスポンスの閾値を超えた回数
    $overCount = 0
	
	# ファイルの中身が存在する場合のみ処理を行う
    if ($lines -ne $null)
    {
        for ($i = 0; $i -lt $linescount; $i++)
        {
        	#Write-Host $i
            #Write-Host $lines[$i]
            if ($lines[$i] -ne $null -and $lines[$i].Contains("[VerificationProviderManager][check_]") -and $lines[$i].Contains("Inicio"))
            {
                # 検索文字列を含む行をファイルに出力
        		Add-Content $outFile -Value ([System.Convert]::ToString($i,10) + "行目*:" + $lines[$i])
                # BI接続開始時間
                #$index1 = $lines[$i].indexOf(":") + 1 #暫定対応(本来不要)
                #$bistart = $lines[$i].SubString(11+$index1,8)
                $bistart = $lines[$i].SubString(11,8)
                # BI接続回数カウントアップ
                $conCount+=1
            }
            elseif ($lines[$i] -ne $null -and $lines[$i].Contains("[VerificationProviderManager][check_]") -and $lines[$i].Contains("Fin"))
            {
                # 検索文字列を含む行をファイルに出力
        		Add-Content $outFile -Value ([System.Convert]::ToString($i,10) + "行目*:" + $lines[$i])
                try
                {
                    # BI接続開始時間
                    #$index2 = $lines[$i].indexOf(":") + 1 #暫定対応(本来不要)
                    #$biend = $lines[$i].SubString(11+$index2,8)
                    $biend = $lines[$i].SubString(11,8)
                    # レスポンス時間
                    $restime = New-Timespan $bistart $biend
                    $restseconds = $restime.Minutes * 60 + $restime.Seconds
                    Add-Content $outFile -Value ("レスポンス時間" + $restseconds + "秒")
                    
                    if ($restseconds -ge 1)
                    {
                        # 検索文字列を含む行をファイルに出力
        		        Add-Content $outFileOverFive -Value ([System.Convert]::ToString($i,10) + "行目*:" + $lines[$i])
                        # レスポンス時間
                        Add-Content $outFileOverFive -Value ("レスポンス時間" + $restseconds + "秒")
                        # レスポンスの閾値を超えた回数カウントアップ
                        $overCount+=1
                        
                    }
                }
                catch [Exception]
                {
                    Add-Content $outFile -Value ("CTSログファイルではないようです。")
                }
                # 値初期化
                $bistart = ""
                $biend = ""
            }
        }
    }
    #return $conCount
    return $conCount,$overCount
}

# 関数実行
BIResponseMeasureMain $args[0]