################################
###CO Conference PC Functions###
################################

######Lower Level########
#GC108 - A12510W64078982#
#GC109 - A12510W64091918#
#GC110 - A12510W64091790#
#########################

########Floor 2##########
#2C107 - A12510W64091804#
#2C108 - A12510W64091871#
#2C110 - A12510W64091941#
#2C111 - A12510W64094632#
#########################

########Floor 3##########
#GC102 - A12510W64091860#
#GC103 - A12510W64091952#
#3C106 - A12510W64091837#
#3C109 - A12510W64091985#
#########################

###########
#Variables#
###########

#Lower Level#
$GC = $GC110, $GC109, $GC108
$GC108 = "A12510W64078982.admin.cps.k12.il.us"
$GC109 = "A12510W64091918.admin.cps.k12.il.us"
$GC110 = "A12510W64091790.admin.cps.k12.il.us"

#Floor 2#
$2F = $2C107, $2C108, $2C110, $2C111
$2C107 = "A12510W64091804.admin.cps.k12.il.us"
$2C108 = "A12510W64091871.admin.cps.k12.il.us"
$2C110 = "A12510W64091941.admin.cps.k12.il.us"
$2C111 = "A12510W64094632.admin.cps.k12.il.us"

#Floor 3#
$3F = $3C102, $3C103, $3C106, $3C109
$3C102 = "A12510W64091860.admin.cps.k12.il.us"
$3C103 = "A12510W64091952.admin.cps.k12.il.us"
$3C106 = "A12510W64091837.admin.cps.k12.il.us"
$3C109 = "A12510W64091985.admin.cps.k12.il.us"

###########
#Functions#
###########

#Reboot Functions#

Function Restart-GC
{
Restart-Computer $GC
}

Function Restart-2F
{
Restart-Computer $2F
}

Function Restart-3F
{
Restart-Computer $3F
}

#Monitoring Functions#

Function Test-GC
{
Test-Connection $GC
}

Function Test-2F
{
Test-Connection $2F
}

Function Test-3F
{
Test-Connection $3F
}


$inputXML = @"
<Window x:Class="WpfApp4.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp4"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525" ResizeMode="NoResize">
    <Grid>
        <TabControl HorizontalAlignment="Left" Height="299" VerticalAlignment="Top" Width="497" Margin="10,10,0,0">
            <TabItem x:Name="Garden_Level" Header="Garden Level">
                <Grid Background="#FFE5E5E5">
                    <Button x:Name="Analyze" Content="Analyze" HorizontalAlignment="Left" Height="38" Margin="10,11,0,0" VerticalAlignment="Top" Width="116"/>
                    <Button x:Name="Reboot" Content="Reboot" HorizontalAlignment="Left" Height="38" Margin="365,10,0,0" VerticalAlignment="Top" Width="116"/>
                    <ListView x:Name="GC_Output" HorizontalAlignment="Left" Height="207" Margin="10,54,0,0" VerticalAlignment="Top" Width="471">
                        <ListView.View>
                            <GridView>
                                <GridViewColumn Header="Room" Width="116"/>
                                <GridViewColumn Header="Machine Name" Width="116"/>
                                <GridViewColumn Header="Status" Width="116"/>
                                <GridViewColumn Header="Last Reboot" Width="113"/>
                            </GridView>
                        </ListView.View>
                        <ListBoxItem/>
                        <ListBoxItem/>
                        <ListBoxItem/>
                    </ListView>
                </Grid>
            </TabItem>
            <TabItem x:Name="_2F" Header="2F">
                <Grid Background="#FFE5E5E5">
                    <Button x:Name="Analyze_2F" Content="Analyze" HorizontalAlignment="Left" Height="38" Margin="10,11,0,0" VerticalAlignment="Top" Width="116"/>
                    <Button x:Name="Reboot_2F" Content="Reboot" HorizontalAlignment="Left" Height="38" Margin="365,10,0,0" VerticalAlignment="Top" Width="116"/>
                    <ListView x:Name="_2F_Output" HorizontalAlignment="Left" Height="207" Margin="10,54,0,0" VerticalAlignment="Top" Width="471">
                        <ListView.View>
                            <GridView>
                                <GridViewColumn Header="Room" Width="116"/>
                                <GridViewColumn Header="Machine Name" Width="116"/>
                                <GridViewColumn Header="Status" Width="116"/>
                                <GridViewColumn Header="Last Reboot" Width="113"/>
                            </GridView>
                        </ListView.View>
                        <ListBoxItem/>
                        <ListBoxItem/>
                        <ListBoxItem/>
                    </ListView>
                </Grid>
            </TabItem>
            <TabItem x:Name="_3F_Output" Header="3F">
                <Grid Background="#FFE5E5E5">
                    <Button x:Name="Analyze_3F" Content="Analyze" HorizontalAlignment="Left" Height="38" Margin="10,11,0,0" VerticalAlignment="Top" Width="116"/>
                    <Button x:Name="Reboot_3F" Content="Reboot" HorizontalAlignment="Left" Height="38" Margin="365,10,0,0" VerticalAlignment="Top" Width="116"/>
                    <ListView x:Name="_3F_Output1" HorizontalAlignment="Left" Height="207" Margin="10,54,0,0" VerticalAlignment="Top" Width="471">
                        <ListView.View>
                            <GridView>
                                <GridViewColumn Header="Room" Width="116"/>
                                <GridViewColumn Header="Machine Name" Width="116"/>
                                <GridViewColumn Header="Status" Width="116"/>
                                <GridViewColumn Header="Last Reboot" Width="113"/>
                            </GridView>
                        </ListView.View>
                        <ListBoxItem/>
                        <ListBoxItem/>
                        <ListBoxItem/>
                    </ListView>
                </Grid>
            </TabItem>
        </TabControl>
        <TextBlock x:Name="Header_Text" HorizontalAlignment="Left" Height="26" Margin="181,11,0,0" TextWrapping="Wrap" Text="CPS Conference Room Management Tool Preview" VerticalAlignment="Top" Width="330" FontWeight="Bold" FontSize="14" Foreground="#FF0F24A6"/>

    </Grid>
</Window>

"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# post import functions
#===========================================================================
 
$WPFAnalyze.Add_Click({
Test-GC | % {$WPFGC_Output.AddChild($_)}
})

$WPFAnalyze_2F.Add_Click({
Test-2F | % {$WPF_2F_Output.AddChild($_)}
})

$WPFAnalyze_3F.Add_Click({
Test-3F | % {$WPF_3F_Output.AddChild($_)}
})
#===========================================================================
# Shows the form
#===========================================================================
write-host "To show the form, run the following" -ForegroundColor Cyan
'$Form.ShowDialog() | out-null'