function getScanTableCounts($infile,$outfile)
{
    $scantables = Get-Content $infile | Select-String "Table: " 
    # 行数取得
    $totalCount = $scantables.count
    # 行数が1以上の場合のみ処理
    if ($totalCount -gt 1)
    {
        # scan countが100以上の行のみ抽出
        for ($i = 0;$i -lt $totalCount;$i++)
        {
            # Stringに変換
            $line = $scantables[$i].ToString()
            # 文字列"scan count"のindexを取得
            $index = $line.indexOf("scan count")
            # 文字列","のindexを取得
            $index2 = $line.indexOf(",")
            # count
            $count = [System.Convert]::ToInt32($line.SubString($index + 10,$index2 - ($index + 10)))
            
            if ($count -gt 99) {
                Add-Content $outfile -Value $line
            }
        }
    }
    else
    {
        Write-Host "no scantable"
    }
}

# 関数実行
getScanTableCounts $args[0] $args[1]