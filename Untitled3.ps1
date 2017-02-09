$GC = $GC110, $GC109, $GC108
$GC108 = "A12510W64078982.admin.cps.k12.il.us"
$GC109 = "A12510W64091918.admin.cps.k12.il.us"
$GC110 = "A12510W64091790.admin.cps.k12.il.us"

function Test-GC {
test-connection -cn $gc -count 1 | foreach {
IF(-not $false){
$Address = $_.IPV4Address
Get-WmiObject -cn $address -class win32_computersystem | select @{name='Name';ex={$_.name}} 
Get-WmiObject -cn $address -class win32_operatingsystem | select @{name='LastBootupTime';ex={%{ $_.ConvertToDateTime($_.LastBootUpTime) }}} 
Set-Variable -name Status -value "Online!" 
Get-variable -name Status | select @{name='Status';ex={$_.Value}}
}
Else {
Set-Variable -name Status -value "Offline!"
Get-variable -name Status | select @{name='Value';ex={$_.Value}}
}
}
}
