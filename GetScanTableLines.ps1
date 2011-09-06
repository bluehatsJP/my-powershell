function getScanTableLines($infile,$outfile)
{
    $scantables = Get-Content $infile | Select-String "Table: " 
    Add-Content $outfile -Value $scantables
}

# 関数実行
getScanTableLines $args[0] $args[1]