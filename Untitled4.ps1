$GC = $GC110, $GC109, $GC108
$GC108 = "A12510W64078982.admin.cps.k12.il.us"
$GC109 = "A12510W64091918.admin.cps.k12.il.us"
$GC110 = "A12510W64091790.admin.cps.k12.il.us"

$GC | ForEach-Object{
    $computer = $_
    $PROCESSMONITOR | ForEach-Object{
        $process = 'netlogon'
        $props = @{
            Server_Name = $computer
            Process_Name = $process
        }

        # Check if the computer is alive. Better this was if $processes is large
        If(Test-Connection $computer -Quiet -Count 1){
            $props.Server_Status = "Running"
            $result = Get-Process -Name $process -ComputerName $computer -ErrorAction SilentlyContinue
            If($result){
                $props.Process_Available = "Yes"
            } else {
                $props.Process_Available = "No"
            }
        } else {
            $props.Server_Status = "Offline"
            $props.Process_Available = "No"
        }

        New-Object -TypeName psobject -Property $props
    }
} | Select Server_Name,Process_Name,Server_Status,Process_Available