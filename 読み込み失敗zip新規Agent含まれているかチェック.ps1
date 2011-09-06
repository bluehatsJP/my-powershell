function check()
{
	$j = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>91</aro_agent_code>"
	$a = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>98</aro_agent_code>"
	$b = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>103</aro_agent_code>"
	$c = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>111</aro_agent_code>"
	$d = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>116</aro_agent_code>"
	$e = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>121</aro_agent_code>"
	$f = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>123</aro_agent_code>"
	$g = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>122</aro_agent_code>"
	$h = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>125</aro_agent_code>"
	$i = Get-Content "Agent20110529_144825.xml" | Select-String "<aro_agent_code>130</aro_agent_code>"
	Write-Host "AgentCode:91 =" $j.count
	Write-Host "AgentCode:98 =" $a.count
	Write-Host "AgentCode:103 =" $b.count
	Write-Host "AgentCode:111 =" $c.count
	Write-Host "AgentCode:116 =" $d.count
	Write-Host "AgentCode:121 =" $e.count
	Write-Host "AgentCode:123 =" $f.count
	Write-Host "AgentCode:122 =" $g.count
	Write-Host "AgentCode:125 =" $h.count
	Write-Host "AgentCode:130 =" $i.count

	$j = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>91</aro_agent_code>"
	$a = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>98</aro_agent_code>"
	$b = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>103</aro_agent_code>"
	$c = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>111</aro_agent_code>"
	$d = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>116</aro_agent_code>"
	$e = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>121</aro_agent_code>"
	$f = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>123</aro_agent_code>"
	$g = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>122</aro_agent_code>"
	$h = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>125</aro_agent_code>"
	$i = Get-Content "Agent20110529_150826.xml" | Select-String "<aro_agent_code>130</aro_agent_code>"
	Write-Host "AgentCode:91 =" $j.count
	Write-Host "AgentCode:98 =" $a.count
	Write-Host "AgentCode:103 =" $b.count
	Write-Host "AgentCode:111 =" $c.count
	Write-Host "AgentCode:116 =" $d.count
	Write-Host "AgentCode:121 =" $e.count
	Write-Host "AgentCode:123 =" $f.count
	Write-Host "AgentCode:122 =" $g.count
	Write-Host "AgentCode:125 =" $h.count
	Write-Host "AgentCode:130 =" $i.count
}

check
