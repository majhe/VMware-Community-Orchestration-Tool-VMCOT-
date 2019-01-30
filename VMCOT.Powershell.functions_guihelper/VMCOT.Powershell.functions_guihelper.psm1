###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

##############################################################################################################################
#ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN
##############################################################################################################################

############## Confirmation Bulk BEGIN
function confirmationbulk_form([String] $msg, [System.Object] $object){
$confirmationbulk_form = New-Object system.Windows.Forms.Form 
$confirmationbulk_form.Width = 520 
$confirmationbulk_form.Height = 350 
$confirmationbulk_form.MaximizeBox = $false 
$confirmationbulk_form.StartPosition = "CenterScreen" 
$confirmationbulk_form.FormBorderStyle = 'Fixed3D' 
$confirmationbulk_form.Text = "Confirmation"
$confirmationbulk_form.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$confirmationbulk_form_label1 = New-Object System.Windows.Forms.Label 
$confirmationbulk_form_label1.Text = "Are you sure you want to make this change:"
$confirmationbulk_form_label1.Size = New-Object System.Drawing.Size(480,20)
$confirmationbulk_form_label1.Location = New-Object System.Drawing.Size(20,20) 
$confirmationbulk_form.Controls.Add($confirmationbulk_form_label1)

$confirmationbulk_form_label2 = New-Object System.Windows.Forms.Label 
$confirmationbulk_form_label2.Text = "$msg"
$confirmationbulk_form_label2.Size = New-Object System.Drawing.Size(480,60)
$confirmationbulk_form_label2.Location = New-Object System.Drawing.Size(20,40) 
$confirmationbulk_form.Controls.Add($confirmationbulk_form_label2)

$confirmationbulk_form_label3 = New-Object System.Windows.Forms.Label 
$confirmationbulk_form_label3.Text = "On the following objects:"
$confirmationbulk_form_label3.Size = New-Object System.Drawing.Size(480,20)
$confirmationbulk_form_label3.Location = New-Object System.Drawing.Size(20,105) 
$confirmationbulk_form.Controls.Add($confirmationbulk_form_label3)


$confirmationbulk_form_lb1 = New-Object System.Windows.Forms.Listbox 
$confirmationbulk_form_lb1.Size = New-Object System.Drawing.Size(300,100)
$confirmationbulk_form_lb1.Location = New-Object System.Drawing.Size(20,130)

$object | % {
$confirmationbulk_form_lb1.Items.Add("$($_.Name) ($($_.Cluster))")
}
$confirmationbulk_form.Controls.Add($confirmationbulk_form_lb1)


$confirmationbulk_form_label3 = New-Object System.Windows.Forms.Label 
$confirmationbulk_form_label3.Text = "Select an option:"
$confirmationbulk_form_label3.Size = New-Object System.Drawing.Size(450,20)
$confirmationbulk_form_label3.Location = New-Object System.Drawing.Size(20,235) 
$confirmationbulk_form.Controls.Add($confirmationbulk_form_label3)


$confirmationbulk_form_b1 = New-Object System.Windows.Forms.Button 
$confirmationbulk_form_b1.Size = New-Object System.Drawing.Size(100,30)
$confirmationbulk_form_b1.Location = New-Object System.Drawing.Size(150,270) 
$confirmationbulk_form_b1.Text = "OK" 
$confirmationbulk_form_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$confirmationbulk_form.AcceptButton = $confirmationbulk_form_b1
#$confirmationbulk_form_b1.Add_Click({$global:AdminMode=1; $global:AdminModeHost="$object"; f1_refresh})
#$confirmationbulk_form_b1.Add_Click({})
$confirmationbulk_form.Controls.Add($confirmationbulk_form_b1)

$confirmationbulk_form_b2 = New-Object System.Windows.Forms.Button 
$confirmationbulk_form_b2.Size = New-Object System.Drawing.Size(100,30)
$confirmationbulk_form_b2.Location = New-Object System.Drawing.Size(250,270)
$confirmationbulk_form_b2.Text = "Cancel"
$confirmationbulk_form_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$confirmationbulk_form.CancelButton = $confirmationbulk_form_b2
#$confirmationbulk_form_b2.Add_Click({$global:AdminMode=0; $global:AdminModeHost=""; f1_refresh})
#$confirmationbulk_form_b2.Add_Click({})
$confirmationbulk_form.Controls.Add($confirmationbulk_form_b2)

$confirmationbulk_form.ShowDialog()


}
############## Confirmation Bulk END

############## Confirmation Bulk NMP Device BEGIN
function confirmbulk_nmpdevice_form([String] $msg, [System.Object] $object){
$confirmbulk_nmpdevice_form = New-Object system.Windows.Forms.Form 
$confirmbulk_nmpdevice_form.Width = 600 
$confirmbulk_nmpdevice_form.Height = 350 
$confirmbulk_nmpdevice_form.MaximizeBox = $false 
$confirmbulk_nmpdevice_form.StartPosition = "CenterScreen" 
$confirmbulk_nmpdevice_form.FormBorderStyle = 'Fixed3D' 
$confirmbulk_nmpdevice_form.Text = "Confirmation"
$confirmbulk_nmpdevice_form.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$confirmbulk_nmpdevice_form_label1 = New-Object System.Windows.Forms.Label 
$confirmbulk_nmpdevice_form_label1.Text = "Are you sure you want to make this change:"
$confirmbulk_nmpdevice_form_label1.Size = New-Object System.Drawing.Size(560,20)
$confirmbulk_nmpdevice_form_label1.Location = New-Object System.Drawing.Size(20,20) 
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_label1)

$confirmbulk_nmpdevice_form_label2 = New-Object System.Windows.Forms.Label 
$confirmbulk_nmpdevice_form_label2.Text = "$msg"
$confirmbulk_nmpdevice_form_label2.Size = New-Object System.Drawing.Size(560,60)
$confirmbulk_nmpdevice_form_label2.Location = New-Object System.Drawing.Size(20,40) 
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_label2)

$confirmbulk_nmpdevice_form_label3 = New-Object System.Windows.Forms.Label 
$confirmbulk_nmpdevice_form_label3.Text = "On the following objects:"
$confirmbulk_nmpdevice_form_label3.Size = New-Object System.Drawing.Size(560,20)
$confirmbulk_nmpdevice_form_label3.Location = New-Object System.Drawing.Size(20,105) 
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_label3)


$confirmbulk_nmpdevice_form_lb1 = New-Object System.Windows.Forms.Listbox 
$confirmbulk_nmpdevice_form_lb1.Size = New-Object System.Drawing.Size(400,100)
$confirmbulk_nmpdevice_form_lb1.Location = New-Object System.Drawing.Size(20,130)

$object | % {
$confirmbulk_nmpdevice_form_lb1.Items.Add("$($_.Device) ($($_.VMHost))")
}
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_lb1)


$confirmbulk_nmpdevice_form_label3 = New-Object System.Windows.Forms.Label 
$confirmbulk_nmpdevice_form_label3.Text = "Select an option:"
$confirmbulk_nmpdevice_form_label3.Size = New-Object System.Drawing.Size(450,20)
$confirmbulk_nmpdevice_form_label3.Location = New-Object System.Drawing.Size(20,235) 
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_label3)


$confirmbulk_nmpdevice_form_b1 = New-Object System.Windows.Forms.Button 
$confirmbulk_nmpdevice_form_b1.Size = New-Object System.Drawing.Size(100,30)
$confirmbulk_nmpdevice_form_b1.Location = New-Object System.Drawing.Size(150,270) 
$confirmbulk_nmpdevice_form_b1.Text = "OK" 
$confirmbulk_nmpdevice_form_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$confirmbulk_nmpdevice_form.AcceptButton = $confirmbulk_nmpdevice_form_b1
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_b1)

$confirmbulk_nmpdevice_form_b2 = New-Object System.Windows.Forms.Button 
$confirmbulk_nmpdevice_form_b2.Size = New-Object System.Drawing.Size(100,30)
$confirmbulk_nmpdevice_form_b2.Location = New-Object System.Drawing.Size(250,270)
$confirmbulk_nmpdevice_form_b2.Text = "Cancel"
$confirmbulk_nmpdevice_form_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$confirmbulk_nmpdevice_form.CancelButton = $confirmbulk_nmpdevice_form_b2
$confirmbulk_nmpdevice_form.Controls.Add($confirmbulk_nmpdevice_form_b2)

$confirmbulk_nmpdevice_form.ShowDialog()


}
############## Confirmation Bulk NMP Device END

############## Confirmation - adminesxloggingsettings BEGIN
function confirmationlogging_form([String] $OldScratchConfig, [String] $OldSyslogDir, [String] $OldGlobalLogHosts, [String] $ScratchConfig, [String] $SyslogDir, [String] $GlobalLogHosts){

$confirmationlogging_form = New-Object system.Windows.Forms.Form 
$confirmationlogging_form.Width = 800 
$confirmationlogging_form.Height = 300 
$confirmationlogging_form.MaximizeBox = $false 
$confirmationlogging_form.StartPosition = "CenterScreen" 
$confirmationlogging_form.FormBorderStyle = 'Fixed3D' 
$confirmationlogging_form.Text = "Confirmation"
$confirmationlogging_form.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$confirmationlogging_form_label1 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label1.Text = "Are you sure you want to make this change on $global:shost :"
$confirmationlogging_form_label1.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label1.Location = New-Object System.Drawing.Size(20,20) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label1)

$confirmationlogging_form_label2 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label2.Text = "Old ScratchConfig: $OldScratchConfig"
$confirmationlogging_form_label2.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label2.Location = New-Object System.Drawing.Size(20,40) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label2)

$confirmationlogging_form_label3 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label3.Text = "New ScratchConfig: $ScratchConfig"
$confirmationlogging_form_label3.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label3.Location = New-Object System.Drawing.Size(20,60) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label3)

$confirmationlogging_form_label4 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label4.Text = "Old SyslogDir: $OldSyslogDir"
$confirmationlogging_form_label4.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label4.Location = New-Object System.Drawing.Size(20,90) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label4)

$confirmationlogging_form_label5 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label5.Text = "New SyslogDir: $SyslogDir"
$confirmationlogging_form_label5.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label5.Location = New-Object System.Drawing.Size(20,110) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label5)

$confirmationlogging_form_label6 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label6.Text = "Old GlobalLogHosts: $OldGlobalLogHosts"
$confirmationlogging_form_label6.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label6.Location = New-Object System.Drawing.Size(20,140) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label6)

$confirmationlogging_form_label7 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label7.Text = "New GlobalLogHosts: $GlobalLogHosts"
$confirmationlogging_form_label7.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label7.Location = New-Object System.Drawing.Size(20,160) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label7)

$confirmationlogging_form_label8 = New-Object System.Windows.Forms.Label 
$confirmationlogging_form_label8.Text = "Select an option:"
$confirmationlogging_form_label8.Size = New-Object System.Drawing.Size(800,20)
$confirmationlogging_form_label8.Location = New-Object System.Drawing.Size(20,200) 
$confirmationlogging_form.Controls.Add($confirmationlogging_form_label8)


$confirmationlogging_form_b1 = New-Object System.Windows.Forms.Button 
$confirmationlogging_form_b1.Size = New-Object System.Drawing.Size(100,30)
$confirmationlogging_form_b1.Location = New-Object System.Drawing.Size(20,225) 
$confirmationlogging_form_b1.Text = "OK" 
$confirmationlogging_form_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$confirmationlogging_form.AcceptButton = $confirmationlogging_form_b1
#$confirmationlogging_form_b1.Add_Click({$global:AdminMode=1; $global:AdminModeHost="$object"; f1_refresh})
#$confirmationlogging_form_b1.Add_Click({})
$confirmationlogging_form.Controls.Add($confirmationlogging_form_b1)

$confirmationlogging_form_b2 = New-Object System.Windows.Forms.Button 
$confirmationlogging_form_b2.Size = New-Object System.Drawing.Size(100,30)
$confirmationlogging_form_b2.Location = New-Object System.Drawing.Size(125,225)
$confirmationlogging_form_b2.Text = "Cancel"
$confirmationlogging_form_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$confirmationlogging_form.CancelButton = $confirmationlogging_form_b2
#$confirmationlogging_form_b2.Add_Click({$global:AdminMode=0; $global:AdminModeHost=""; f1_refresh})
#$confirmationlogging_form_b2.Add_Click({})
$confirmationlogging_form.Controls.Add($confirmationlogging_form_b2)

$confirmationlogging_form.ShowDialog()


}
############## Confirmation - adminesxloggingsettings END

############## Confirmation BEGIN
function confirmation_form([String] $object){
$confirmation_form = New-Object system.Windows.Forms.Form 
$confirmation_form.Width = 500 
$confirmation_form.Height = 180 
$confirmation_form.MaximizeBox = $false 
$confirmation_form.StartPosition = "CenterScreen" 
$confirmation_form.FormBorderStyle = 'Fixed3D' 
$confirmation_form.Text = "Confirmation"
$confirmation_form.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$confirmation_form_label1 = New-Object System.Windows.Forms.Label 
$confirmation_form_label1.Text = "Are you sure you want to make this change on the following object:"
$confirmation_form_label1.Size = New-Object System.Drawing.Size(450,20)
$confirmation_form_label1.Location = New-Object System.Drawing.Size(20,20) 
$confirmation_form.Controls.Add($confirmation_form_label1)

$confirmation_form_label2 = New-Object System.Windows.Forms.Label 
$confirmation_form_label2.Text = "$object"
$confirmation_form_label2.Size = New-Object System.Drawing.Size(450,20)
$confirmation_form_label2.Location = New-Object System.Drawing.Size(20,40) 
$confirmation_form.Controls.Add($confirmation_form_label2)

$confirmation_form_label3 = New-Object System.Windows.Forms.Label 
$confirmation_form_label3.Text = "Select an option:"
$confirmation_form_label3.Size = New-Object System.Drawing.Size(450,20)
$confirmation_form_label3.Location = New-Object System.Drawing.Size(20,60) 
$confirmation_form.Controls.Add($confirmation_form_label3)


$confirmation_form_b1 = New-Object System.Windows.Forms.Button 
$confirmation_form_b1.Size = New-Object System.Drawing.Size(100,30)
$confirmation_form_b1.Location = New-Object System.Drawing.Size(150,90) 
$confirmation_form_b1.Text = "OK" 
$confirmation_form_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$confirmation_form.AcceptButton = $confirmation_form_b1
#$confirmation_form_b1.Add_Click({$global:AdminMode=1; $global:AdminModeHost="$object"; f1_refresh})
#$confirmation_form_b1.Add_Click({})
$confirmation_form.Controls.Add($confirmation_form_b1)

$confirmation_form_b2 = New-Object System.Windows.Forms.Button 
$confirmation_form_b2.Size = New-Object System.Drawing.Size(100,30)
$confirmation_form_b2.Location = New-Object System.Drawing.Size(250,90)
$confirmation_form_b2.Text = "Cancel"
$confirmation_form_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$confirmation_form.CancelButton = $confirmation_form_b2
#$confirmation_form_b2.Add_Click({$global:AdminMode=0; $global:AdminModeHost=""; f1_refresh})
#$confirmation_form_b2.Add_Click({})
$confirmation_form.Controls.Add($confirmation_form_b2)

$confirmation_form.ShowDialog()


}
############## Confirmation END

############## Welcome Screen BEGIN
function welcome(){
$welcome_form = New-Object system.Windows.Forms.Form 
$welcome_form.Width = 500 
$welcome_form.Height = 180 
$welcome_form.MaximizeBox = $false 
$welcome_form.StartPosition = "CenterScreen" 
$welcome_form.FormBorderStyle = 'Fixed3D' 
$welcome_form.Text = "VMCOT VMware Community Orchestration Tool"
$welcome_form.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$welcome_form_label1 = New-Object System.Windows.Forms.Label 
$welcome_form_label1.Text = "- AUTHORIZED USE ONLY - All changes are logged into vCenter"
$welcome_form_label1.Size = New-Object System.Drawing.Size(450,20)
$welcome_form_label1.Location = New-Object System.Drawing.Size(20,20) 
$welcome_form.Controls.Add($welcome_form_label1)

$welcome_form_label2 = New-Object System.Windows.Forms.Label 
$welcome_form_label2.Text = "VMCOT VMware Community Orchestration Tool"
$welcome_form_label2.Size = New-Object System.Drawing.Size(450,20)
$welcome_form_label2.Location = New-Object System.Drawing.Size(20,40) 
$welcome_form.Controls.Add($welcome_form_label2)

$welcome_form_label3 = New-Object System.Windows.Forms.Label 
$welcome_form_label3.Text = "2018/2019 (GNU General Public License v3.0)"
$welcome_form_label3.Size = New-Object System.Drawing.Size(450,20)
$welcome_form_label3.Location = New-Object System.Drawing.Size(20,60) 
$welcome_form.Controls.Add($welcome_form_label3)


$welcome_form_b1 = New-Object System.Windows.Forms.Button 
$welcome_form_b1.Size = New-Object System.Drawing.Size(100,30)
$welcome_form_b1.Location = New-Object System.Drawing.Size(150,90) 
$welcome_form_b1.Text = "Proceed" 
$welcome_form_b1.Add_Click({$welcome_form.Close(); $welcome_form.Dispose(); f1_create})
$welcome_form.Controls.Add($welcome_form_b1)

$welcome_form_b2 = New-Object System.Windows.Forms.Button 
$welcome_form_b2.Size = New-Object System.Drawing.Size(100,30)
$welcome_form_b2.Location = New-Object System.Drawing.Size(250,90)
$welcome_form_b2.Text = "Cancel" 
$welcome_form_b2.Add_Click({$welcome_form.Close();$welcome_form.Dispose()})
$welcome_form.Controls.Add($welcome_form_b2)

$welcome_Form.ShowDialog()
}
############## Welcome Screen END

###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################