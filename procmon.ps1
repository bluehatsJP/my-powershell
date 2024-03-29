if (test-path "procmon.out") { mv -fo "procmon.out" "procmon.prev" }
while(1) {
    $proc = gwmi win32_process
    if (! $proc_prev) { $proc_prev = $proc }
    if ($result = diff $proc_prev $proc -pa | Format-Table -AutoSize -Wrap -HideTableHeaders -Property `
        processid,name,commandline) {
        date >> "procmon.out"
        $result >> "procmon.out"
        $result
    }
    $proc_prev = $proc
    write-host -n "."
    sleep 1
}