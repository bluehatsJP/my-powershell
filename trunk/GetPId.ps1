$processes = get-process
$id = ""
for ($i = 0; $i -lt $processes.Length; $i++) {
    if ($processes[$i].Name.Contains("ccApp")) {
        $id = $processes[$i].Id
    }
}

return $id