function getScanTables($infile,$outfile)
{
    $scantables = Get-Content $infile | Select-String "Table: " 
    # 行数取得
    $totalCount = $scantables.count
    # 行数が1以上の場合のみ処理
    if ($totalCount -gt 1)
    {
        # 重複テーブル調査用Hash
        $tableHash = @{}
        # table名のみ抽出
        for ($i = 0;$i -lt $totalCount;$i++)
        {
            # Stringに変換後、先頭の"Tables: "を削除して行を取得
            $line = $scantables[$i].ToString().Remove(0,7)
            # 文字列"scan count"のindexを取得
            $index = $line.indexOf("scan count")
            # table取得
            $tableName = $line.SubString(0,$index -1)
            
            if (!$tableHash.Contains($tableName)) {
                Add-Content $outfile -Value $tableName
                $tableHash.Add($tableName,1)
            }
        }
    }
    else
    {
        Write-Host "no scantable"
    }
}

# 関数実行
getScanTables $args[0] $args[1]