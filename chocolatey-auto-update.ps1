if(-not (Get-Module -ListAvailable -Name 'BurntToast'))
{
    $mbresult = [System.Windows.MessageBox]::Show("This script needs an additional module called 'BurntToast'. Install it?", 'Chocolatey Auto-Update', 'OkCancel', 'Information', 'Ok')
    if($mbresult -eq 'OK') {
        Start-Process 'powershell' -Verb RunAs -ArgumentList ('-Command Install-Module -Name BurntToast') -Wait
    } else {
        echo Alright
        exit;
    }
}
Import-Module -Name BurntToast


$outfile = New-TemporaryFile
Start-Process 'cup' -NoNewWindow -Wait -ArgumentList ('all', '--noop', '--yes') -RedirectStandardOutput $outfile
$output = Get-Content -Path $outfile
$matches = $output -match 'Chocolatey can upgrade (\d)*[1-9]+\/\d+ packages.'
if ($matches.Count -gt 0) {
    $mbresult = [System.Windows.MessageBox]::Show("$matches`nDo you want to update?", 'Chocolatey', 'YesNo','Question', 'Yes')
    if($mbresult -eq 'Yes') {
        Start-Process 'cup' -Verb RunAs -ArgumentList ('all', '--yes') -Wait
        New-BurntToastNotification -AppLogo 'C:\Windows\WinSxS\wow64_microsoft-windows-healthcenter_31bf3856ad364e35_10.0.18362.1_none_880f3c81156dac88\SecurityAndMaintenance.png' -Text 'Chocolatey Auto-Update', 'Your packages have been updated.'
    }
 } else {
    New-BurntToastNotification -AppLogo 'C:\Windows\WinSxS\wow64_microsoft-windows-healthcenter_31bf3856ad364e35_10.0.18362.1_none_880f3c81156dac88\SecurityAndMaintenance.png' -Text 'Chocolatey Auto-Update', 'Your packages are up-to-date.'
 }
 

