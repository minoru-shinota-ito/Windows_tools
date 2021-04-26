#Change physical keyboard layout JPN 101/102 <->JPN 106/109

#Constant
$Path = "HKLM:\SYSTEM\CurrentControlSet\services\i8042prt\Parameters"
$LayterDriverJPN = @("kbd106.dll","kbd101.dll")
$OverrideKeyboardIdentifier = @("PCAT_106KEY", "PCAT_101KEY")
$OverrideKeyboardSubtype = @(2, 0)

function Change-physical-keyboard-layout-JPN(){

    Write-Host "Change physical keyboard layout JPN 101/102 <->JPN 106/109"
    Write-Host "Reboot your computer after changing the registry" -ForegroundColor Red
    Write-Host "0: JPN 106/109"
    Write-Host "1: JPN 101/102(US)"
    Write-Host "9: Check the current settings" 
    Write-Host "Other: exit"

    $Selecter = Read-Host

    if(($Selecter -eq 0) -or ($Selecter -eq 1))
    {
        #Change Registry
        Set-ItemProperty -Path $Path -Name "LayerDriver JPN" -Value $LayterDriverJPN[$Selecter]
        Set-ItemProperty -Path $Path -Name "OverrideKeyboardIdentifier" -Value $OverrideKeyboardIdentifier[$Selecter]
        Set-ItemProperty -Path $Path -Name "OverrideKeyboardSubtype" -Value $OverrideKeyboardSubtype[$Selecter]
        
        #Reboot
        Restart-Computer -Confirm

    }
    elseif($Selecter -eq 9)
    {
        Write-Host "Current settings"
        Get-ItemProperty -Path $Path
    }
    else
    {
        exit
    }

    Change-physical-keyboard-layout-JPN
}

Change-physical-keyboard-layout-JPN