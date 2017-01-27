##############################################################################################
# Get-GPSCopmputer V1 7/26/16                                                                #
# Known issues:                                                                              #
# $Lastbootuptime outputs a vlue with "@{}"                                                  #
#                                                                                            #
# Next planned release will include an output log into a network share with Windows update,  #
# software installed and general system information                                          #
##############################################################################################

##################
# Value Appendix #
##################

# RTN is the value set to test connection
$rtn = $null
# Name is the Machine Name taken from Active Directory  
$name = $null
# DNSHostName is the Fully Qualified Domain Name taken from Active Directory
$dnshostname = $null
# IPv4Address is the last known IP Address logged by Active Directory
$ipv4address = $null
# LastLogonDate is the last time Active Directory recorded the machine being online. 
$Lastlogondate = $null
# OperatingSystem is the Operating System reported to be installed by Active Directory
$Operatingsystem = $null
# LastBootupTime is the last time the machine has booted according to the local WMI Objects
$LastBootupTime = $null
# TotalPhysicalMemory is the ammount of memory (in Bytes) according to the local WMI Objects 
$TotalPhysicalMemory = $null
# Model is the Model name of the machine according to the local WMI Objects
$Model = $null
# SerialNumber is the Serial Number (or Service Tag) of the machine according to the local WMI Objects
$Serialnumber = $null
# $BiosVersion is the version of Bios installed onto the machine according to the local WMI Objects
$Biosversion = $null
# Privilage is a value (1 being Administrator, 2 being user, 3 being Guest) set to account for local administration, pulle from local WMI
$Privilage = $null

get-date | select Month,Day,Hour,Minute,Second | Foreach {
$M = $_.Month
$D = $_.Day
$H = $_.Hour
$Min = $_.Minute
$Sec = $_.Second
}

$Timestamp = "$M$D$H$Min$Sec"

function Get-CPSComputer {
    $asset = read-host "Please enter the Asset Tag."
    cls
    get-adcomputer -filter "Name -like '*$asset'" -prop * |select CN,Name,DNSHostName,IPV4Address,LastLogonDate,OperatingSystem |
        foreach {
Write-Progress -activity "Scanning Active Directory Please Wait..."
 $rtn = Test-Connection -CN $_.dnshostname -Count 1 -BufferSize 16 -Quiet
  IF($rtn -match ‘True’) {
    $name = $_.Name
    $dnshostname = $_.dnshostname
    $ipv4address = $_.ipv4address 
    $lastlogondate = $_.lastlogondate
    $operatingsystem = $_.Operatingsystem

            Get-WmiObject -computername $dnshostname -class win32_bios |select SMBIOSBIOSVersion,SerialNumber |
            foreach {
            Write-Progress -activity "Scanning WMI Objects for Bios Version and Serial Number. Please Wait..."
            $Biosversion = $_.SMBIOSBIOSVersion
            $Serialnumber = $_.Serialnumber
            }

            Get-WmiObject -computername $dnshostname -class win32_ComputerSystem |select Model,TotalPhysicalMemory,PrimaryOwnerName |
            foreach {
            Write-Progress -activity "Scanning WMI Objects for Model Name and Memory Please Wait..."
            $Model = $_.Model
            $PrimaryOwnerName = $_.PrimaryOwnerName
            $TotalPhysicalMemory = $_.TotalPhysicalMemory
            }

            Get-WmiObject -computername $dnshostname -class Win32_NetworkLoginProfile |select Privileges |
            foreach {
            Write-Progress -activity "Scanning WMI Objects Please Wait..."
            $Privilage = $_.Privileges
            $Adminoutput = $null
                IF($Privilage -match '1') {
                    $AdminOutput = "and this user is not a local Administrator"
                    }
                Else {
                    $Adminoutput = "and this user is a local administrator"
                     }
                
            }
 
            Get-WmiObject -computername $dnshostname -class Win32_NetworkLoginProfile |
            foreach ($_.Caption) {
            $caption = $_.Caption
            }

           $LastBootupTime = (Get-WmiObject -computername $dnshostname  win32_operatingsystem | select csname, @{LABEL=’LastBootUpTime’
           ;EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}} | select lastbootuptime)
           
           
           New-Item "C:\Diagnostics\$Name\$Timestamp" -ItemType container -force
           cls
           
           get-hotfix -ComputerName $dnshostname | select HotfixID,InstalledOn | sort installedon -Descending | Out-file "C:\Diagnostics\$name\$Timestamp\Hotfix Information.txt" -force

           
           Get-Process -ComputerName $dnshostname | Select Name,ID,PM,Handles | Out-File "C:\Diagnostics\$Name\$Timestamp\Active Processes.txt" -force
                
           Get-Wmiobject -ComputerName $dnshostname -class win32_product | sort Installdate -descending | select Name,Vendor,Installdate,Version | Out-file "C:\Diagnostics\$name\$Timestamp\Installed Software.txt" -force
                
    write-host -foregroundcolor Gray "**Active Directory Information**"
    write-host -ForegroundColor green $name "is online!"
    Write-Host "The asset tag of this machine is:"
    Write-host -ForegroundColor DarkYellow $asset
    Write-Host "The FQDN of this machie is:"
    Write-host -ForegroundColor DarkYellow $dnshostname
    Write-Host "The last known IP Address is:"
    Write-host -ForegroundColor DarkYellow $IPV4Address
    Write-Host "The last time this machine was logged into was:"
    Write-Host -ForegroundColor DarkYellow $LastLogonDate
    Write-Host "The Operating System installed is:"
    Write-host -ForegroundColor DarkYellow $OperatingSystem
    write-host " "
    write-host -foregroundcolor Gray "**WMI Information**"
    Write-Host "The BIOS version on this machine is:"
    write-host -ForegroundColor DarkYellow "Dell System BIOS Version" $Biosversion
    Write-Host "The Serial Number on this machine is:"
    Write-Host -ForegroundColor DarkYellow $Serialnumber
    Write-Host "The Model of this machine is:"
    Write-Host -ForegroundColor DarkYellow $Model
    Write-Host "This machines primary user is:"
    Write-Host -ForegroundColor DarkYellow "$Caption, $Adminoutput"
    Write-Host "The ammount of memory in this machine is (Kb):"
    Write-Host -ForegroundColor DarkYellow $TotalPhysicalMemory
    Write-Host "The last time this machine was rebooted is:"
    Write-Host -ForegroundColor DarkYellow $LastBootupTime

    }    
 ELSE {
    $name = $_.Name
    $dnshostname = $_.dnshostname
    $ipv4address = $_.ipv4address 
    $lastlogondate = $_.lastlogondate
    $operatingsystem = $_.Operatingsystem
    
    write-host -foregroundcolor Gray "**Active Directory Information**"
    Write-host -ForegroundColor red $name "is not online!"
    Write-Host "The asset tag of this machine is:"
    Write-host -ForegroundColor DarkYellow $asset
    Write-Host "The FQDN of this machie is:"
    Write-host -ForegroundColor DarkYellow $dnshostname
    Write-Host "The last known IP Address is:"
    Write-host -ForegroundColor DarkYellow $IPV4Address
    Write-Host "The last time this machine was logged into was:"
    Write-Host -ForegroundColor DarkYellow $LastLogonDate
    Write-Host "The Operating System installed is:"
    Write-host -ForegroundColor DarkYellow $OperatingSystem
     }
    }
} 
