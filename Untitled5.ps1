$GC = $GC110, $GC109, $GC108
$GC108 = "A12510W64078982.admin.cps.k12.il.us"
$GC109 = "A12510W64091918.admin.cps.k12.il.us"
$GC110 = "A12510W64091790.admin.cps.k12.il.us"
function Test-GC { 
     $gc | foreach {
        
        $connection = Test-Connection -cn $_ -count 1 -EA SilentlyContinue
        $name     = $_
        $online   = $null
        $bootTime = $null

        If ($connection) {
            $Address  = $connection.IPV4Address
            $name     = (Get-WmiObject -cn $address -class win32_computersystem).Name
            $bootTime = (Get-WmiObject -cn $address -class win32_operatingsystem) | % { $_.ConvertToDateTime($_.LastBootUpTime) }
            $online   = $true
        }
        Else {
             $online = $false
        }
       return [pscustomobject]@{'Name'=$name;'Online'=$online;'LastBootUpTime'=$bootTime}
    }
}

[boolean] 

create-object 