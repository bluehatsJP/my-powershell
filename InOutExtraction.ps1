function InOutExtraction($file,$inFile,$outFile)
{
    $inputXml = Get-Content $file | Select-String "input xml" 
    Add-Content $inFile -Value $inputXml
    
    $outputXml = Get-Content $file | Select-String "output xml"
    Add-Content $outFile -Value $outputXml
}

# 関数実行
InOutExtraction $args[0] $args[1] $args[2]