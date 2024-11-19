Function ShowMenu {
	Param(
	[ValidateRange(1,9)] #Validate menu input
	[int]
	$selection=1
		 )
	clear
	Write-Host "Which share do you want to mount?"
	Write-Host ""
	Write-Host "1: To mount trustee"
    Write-Host ""
	Write-Host "2: To mount Ap"
    Write-Host ""
    Write-Host "3: Custom"
    Write-Host ""
	Write-Host "Press 9 to quit."
	Try {
		$selection = Read-Host "Select 1-9: "
	} Catch {
		ShowMenu
	}
switch ($selection) {
	1 {
        $user_Name = "staff\" + $Credentials.GetNetworkCredential().Username
        net use \\staff.ad.curtin.edu.au\public\trustee $Credentials.GetNetworkCredential().Password /user:$user_Name
        explorer \\staff.ad.curtin.edu.au\public\trustee
		ShowMenu
	}
	2 {
        $user_Name = "staff\" + $Credentials.GetNetworkCredential().Username
        net use \\staff.ad.curtin.edu.au\md\ap $Credentials.GetNetworkCredential().Password /user:$user_Name
        explorer \\staff.ad.curtin.edu.au\md\ap
		ShowMenu
	}
	3 {
        net use * /del /y
        if ($netpath -eq $null) {
        $netpath = Read-Host 'Enter Custom location'
        }
        $user_Name = "staff\" + $Credentials.GetNetworkCredential().Username
		net use y: $netpath $Credentials.GetNetworkCredential().Password /user:$user_Name
        explorer "y:\"
		ShowMenu
	}
	4{
		findoldcomputers
		ShowMenu
	}
	5{
		disableComputers
		ShowMenu
	}
	6{
		deletecomputers
		ShowMenu
	}
	9 {
        net use * /del /y		
        exit
	}
	default {
		Write-Host "Invalid Selection, select a valid." -ForegroundColor Red
		Pause
		ShowMenu
	}
}
}

$username = "staff\pa.244412c"
$pass = $null
$pass = Get-Credential -credential $username
if(!$pass){exit}
$credentials = New-Object System.Management.Automation.PSCredential -ArgumentList @($pass.UserName,$pass.Password)


ShowMenu