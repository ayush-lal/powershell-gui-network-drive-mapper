<#############################################################################################################################
.SYNOPSIS
  Originally this GUI App was created as a tool for users to connect to network drives/printers with a GUI interface. This App was developed using Powershell and the help of https://poshgui.com to create the inital form layouts.  

.INPUTS
  Start-Transcript is used to output commands/errors to PS_App_Logs.txt file. 

.OUTPUTS
  Log files will be located in C:\Logs after executing the script.

.NOTES 
  Version:        2.0
  Author:         Ayush Lal
  Creation Date:  10/05/19
##############################################################################################################################>

#START - PoshGUI Form Layout
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.Opacity                    = 1.0
$Form.ClientSize                 = '405,210'
$Form.text                       = "Powershell GUI App Connector"
$Form.TopMost                    = $false
$Form.MaximizeBox                = $false
$Form.FormBorderStyle            = 'Fixed3D'
$CenterScreen                    = [System.Windows.Forms.FormStartPosition]::CenterScreen;
$Form.StartPosition              = $CenterScreen;
$Form.BackColor                  = "White"
# Below code to add a .ico picture as the shortcut/application icon. 
# $Form.Icon =  [System.Drawing.Icon]::ExtractAssociatedIcon('C:\Logo.ico')

$userbox                         = New-Object system.Windows.Forms.TextBox
$userbox.multiline               = $false
$userbox.width                   = 150
$userbox.height                  = 50
$userbox.location                = New-Object System.Drawing.Point(130,30)
$userbox.Font                    = 'Calibri,12'

$passbox                         = New-Object system.Windows.Forms.TextBox
$passbox.PasswordChar            = '*'
$passbox.multiline               = $false
$passbox.width                   = 150
$passbox.height                  = 50
$passbox.location                = New-Object System.Drawing.Point(130,70)
$passbox.Font                    = 'Calibri,12'

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Connect"
$Button1.width                   = 150
$Button1.height                  = 35
$Button1.location                = New-Object System.Drawing.Point(130,110)
$Button1.Font                    = 'Calibri,12'
$button1.FlatStyle               = "System"

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Username:"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(52,35)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Password:"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(55,76)
$Label2.Font                     = 'Microsoft Sans Serif,10'

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Password"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(64,83)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$connectlabel                    = New-Object system.Windows.Forms.Label
$connectlabel.text               = "Connection Success!"
$connectLabel.Visible            = $false
$connectlabel.AutoSize           = $true
$connectlabel.width              = 10
$connectlabel.height             = 10
$connectlabel.location           = New-Object System.Drawing.Point(140,155)
$connectlabel.Font               = 'Microsoft Sans Serif,10'
$connectlabel.ForeColor          = "#00cc00"

$mypclink                        = New-Object System.Windows.Forms.LinkLabel 
$mypclink.text                   = "View drives"
$mypclink.Visible                = $false
$mypclink.AutoSize               = $true
$mypclink.width                  = 15
$mypclink.height                 = 10
$mypclink.location               = New-Object System.Drawing.Point(165,190)
$mypclink.Font                   = 'Microsoft Sans Serif,10'
$mypclink.LinkColor              = "Gray"
$mypclink.BackColor              = "LightGray"
$mypclink.add_Click({[system.Diagnostics.Process]::start("Shell:mycomputerfolder")}) 

$failtext                        = New-Object system.Windows.Forms.Label
$failtext.text                   = "Something has gone wrong. Please try again..."
$failtext.Visible                = $false
$failtext.AutoSize               = $true
$failtext.width                  = 25
$failtext.height                 = 10
$failtext.location               = New-Object System.Drawing.Point(70,155)
$failtext.Font                   = 'Microsoft Sans Serif,10'
$failtext.ForeColor              = "red"
$failtext.BackColor              = ""

$versionlabel                    = New-Object system.Windows.Forms.Label
$versionlabel.text               = "v2"
$versionlabel.Visible            = $True
$versionlabel.AutoSize           = $true
$versionlabel.width              = 25
$versionlabel.height             = 10
$versionlabel.location           = New-Object System.Drawing.Point(5,190)
$versionlabel.Font               = 'Microsoft Sans Serif,10'
$versionlabel.ForeColor          = "Gray"
$versionlabel.BackColor          = "LightGray"

$LinkLabel                       = New-Object System.Windows.Forms.LinkLabel 
$LinkLabel.Location              = New-Object System.Drawing.Size(310,190) 
$LinkLabel.Size                  = New-Object System.Drawing.Size(100,20) 
$LinkLabel.LinkColor             = "Gray" 
$LinkLabel.BackColor             = "LightGray"
$LinkLabel.ActiveLinkColor       = "RED" 
$LinkLabel.Text                  = "Homepage" 
$LinkLabel.Font                  = 'Microsoft Sans Serif,10'
$LinkLabel.add_Click({[system.Diagnostics.Process]::start("https://www.google.com")}) 

$errorlabel                      = New-Object system.Windows.Forms.Label
$errorlabel.text                 = "Error"
$errorlabel.Visible              = $false
$errorlabel.AutoSize             = $true
$errorlabel.width                = 25
$errorlabel.height               = 10
$errorlabel.location             = New-Object System.Drawing.Point(100,182)
$errorlabel.Font                 = 'Microsoft Sans Serif,10'
$errorlabel.ForeColor            = "#00cc00"
$errorlabel.BackColor            = "#c1c1c1"

$Panel                           = New-Object system.Windows.Forms.Panel
$Panel.height                    = 25
$Panel.width                     = 425
$Panel.BackColor                 = "LightGray"
$Panel.location                  = New-Object System.Drawing.Point(0,185)

$Form.controls.AddRange(@($userbox,$passbox,$Button1,$Label1,$Label2,$connectlabel,$mypclink,$failtext,$errorlabel,$linkLabel,$versionlabel,$panel))
#END - PoshGUI Form Layout

#Network Drive Path Variables (You will need to customise this to your own site)
$S_Drive = "\\XXX.XXX.XXX\Software$"
$W_Drive = "\\XXX.XXX.XXX\StaffData$"
$Q_Drive = "\\XXX.XXX.XXX\Data"
$G_Drive = "\\XXX.XXX.XXX\General"
$P_Drive = "\\XXX.XXX.XXX\TestData"

Add-Type -AssemblyName PresentationFramework

#Function for installing network drives/printers
# ** NOTE "net use" is the method used for connecting network drives/printers. You can also use "PS-drive" for connecting to network drives which may work better as its a powershell cmdlet. 
function NetConnect {

$Button1.text = 'Connecting...'

Start-Transcript -Path "C:\Logs\PS_App_Logs.txt"

$user = $userbox.text
$pass = $passbox.text

#Mapping Network Printer
net use lpt2: \\XXX.XXX.XXX\Printer /user:Domain\$user $pass
Write-Host "Network Printer has been Mapped!"

#S Drive
If(!(Test-Path S:))
    {
       net use S: $S_Drive /user:Domain\$user $pass /persistent:no
       Write-Host "S Drive has been SUCCESSFULLY Mapped"
    }
else {write-host "Mapping S Drive has FAILED..."}

#W Drive
If(!(Test-Path W:))
    {                
        net use W: $W_Drive /user:Domain\$user $pass /persistent:no
        Write-Host "W Drive has been SUCCESSFULLY Mapped"
    }
else {Write-Host "Mapping W Drive has FAILED..."}

#Q Drive
If(!(Test-Path Q:))
    {                
        net use Q: $Q_Drive /user:Domain\$user $pass /persistent:no
        Write-Host "Q Drive has been SUCCESSFULLY Mapped"
    }
else {Write-Host "Mapping Q Drive has FAILED..."}

#G Drive
If(!(Test-Path G:))
    {                
        net use G: $G_Drive /user:Domain\$user $pass /persistent:no
        Write-Host "G Drive has been SUCCESSFULLY Mapped"
    }
else {Write-Host "Mapping G Drive has FAILED..."}

#P Drive
If(!(Test-Path P:))
    {                
        net use G: $P_Drive /user:Domain\$user $pass /persistent:no
        Write-Host "P Drive has been SUCCESSFULLY Mapped"
    }
else {Write-Host "Mapping P Drive has FAILED..."}

#Stop writing to log file 
 Stop-Transcript

#End fucntion
}

#This function will test the connection to S Drive and it will provide feedback on the application / Connection Success or Failed. This was an 'easy' solution to test network drive connection because 99% of the time, users only needed connection to S Drive (rather than printer or W: etc) so this method of testing connectivity was easier then testing everything.  
function testconnection {
If(!(Test-Path S:))
 {                
  $failtext.Visible =$true
  $Button1.text = 'Reconnect'
 }
 else {
  $connectLabel.Visible = $true
  $Button1.Enabled = $false
  $Button1.text = 'Connected'
  $mypclink.Visible = $true
 }
#End function
}

#When the button is clicked, it will run the NetConnect function to map drives & printer + make changes to button + add confirmation whether or not drives/printers are connected. 
$Button1.Add_Click({
#Runs the NetConnect function - Network drive mapping + printer   
NetConnect

#This will run the testconnection function which will make sure S drive is connected and provide an immediate feedback (on display text) of connection status
testconnection
})

# This displays the Form GUI
[void]$Form.ShowDialog()