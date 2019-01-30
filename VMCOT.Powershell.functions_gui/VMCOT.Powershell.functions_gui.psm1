###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

############## vCenter Selection - BEGIN
function f2_create(){
$f2 = New-Object system.Windows.Forms.Form 
$f2.Width = 350 
$f2.Height = 300 
$f2.MaximizeBox = $false 
$f2.StartPosition = "CenterScreen" 
$f2.FormBorderStyle = 'Fixed3D' 
$f2.Text = "vCenter Instance Menu"
$f2.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f2_l1 = New-Object System.Windows.Forms.Label 
$f2_l1.Text = "Select vCenter Instance:"
$f2_l1.Size = New-Object System.Drawing.Size(300,20)
$f2_l1.Location = New-Object System.Drawing.Size(20,20) 
$f2.Controls.Add($f2_l1)

$f2_lb1 = New-Object System.Windows.Forms.Listbox 
$f2_lb1.Size = New-Object System.Drawing.Size(300,145)
$f2_lb1.Location = New-Object System.Drawing.Size(20,50) 

# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - BEGIN ************************************************************
# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - BEGIN ************************************************************

$f2_lb1.Items.Add('vcenter01p.domain.local') #FQDN of your first vCenter Instance
#$f2_lb1.Items.Add('vcenter02p.domain.local') #FQDN of your second vCenter Instance (if exists) - OPTIONAL / Only uncomment if needed
#$f2_lb1.Items.Add('vcenter03p.domain.local') #FQDN of your third vCenter Instance (if exists) - OPTIONAL / Only uncomment if needed

# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - END **************************************************************
# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - END **************************************************************

$f2_lb1.Items.Add('Disconnect from all vCenter instances')
$f2.Controls.Add($f2_lb1)

$f2_b1 = New-Object System.Windows.Forms.Button 
$f2_b1.Text = "Confirm"
$f2_b1.Size = New-Object System.Drawing.Size(100,25)
$f2_b1.Location = New-Object System.Drawing.Size(20,200) 
$f2_b1.Add_Click({initialize_globalvariables; $global:vcenter=$f2_lb1.selecteditem; vcenterconnection; f1_refresh;})
$f2_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f2.AcceptButton = $f2_b1
$f2.Controls.Add($f2_b1)

$f2_b2 = New-Object System.Windows.Forms.Button 
$f2_b2.Text = "Cancel"
$f2_b2.Size = New-Object System.Drawing.Size(100,25)
$f2_b2.Location = New-Object System.Drawing.Size(125,200) 
$f2_b2.Add_Click({initialize_globalvariables; f1_refresh;})
$f2_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f2.CancelButton = $f2_b2
$f2.Controls.Add($f2_b2)

$f2.ShowDialog()
}
############## vCenter Selection - END

############## Control Panel Refresh - BEGIN
function f1_refresh(){
$f1.close()
$f1.Dispose()
f1_create
}
############## Control Panel Refresh - END

############## Control Panel - BEGIN
function f1_create(){

$f1 = New-Object system.Windows.Forms.Form 
$f1.Width = 1150
$f1.Height = 450 
$f1.MaximizeBox = $false 
$f1.StartPosition = "CenterScreen" 
$f1.FormBorderStyle = 'Fixed3D' 
$f1.Text = "VMCOT VMware Community Orchestration Tool"
$f1.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

#LOGO
#$file = (get-item 'C:\temp\logo1.png')
#$img = [System.Drawing.Image]::Fromfile($file);
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width =  $img.Size.Width
$pictureBox.Height =  $img.Size.Height
$pictureBox.Location = New-Object System.Drawing.Size(1000,40)
$pictureBox.Image = $img
$f1.controls.add($pictureBox)
#LOGO

#LOGO
#$fileb = (get-item 'C:\temp\logo2.png')
#$imgb = [System.Drawing.Image]::Fromfile($fileb);
$pictureBoxb = new-object Windows.Forms.PictureBox
$pictureBoxb.Width =  $imgb.Size.Width
$pictureBoxb.Height =  $imgb.Size.Height
$pictureBoxb.Location = New-Object System.Drawing.Size(835,40)
$pictureBoxb.Image = $imgb
$f1.controls.add($pictureBoxb)
#LOGO

#SESSION BLOCK
$f1_l1 = New-Object System.Windows.Forms.Label 
$f1_l1.Text = ">>> SESSION >>> Current Selection: >>> $global:vcenter >>> $global:scluster >>> $global:shost >>> $global:svm"
$f1_l1.Size = New-Object System.Drawing.Size(1100,20)
$f1_l1.Location = New-Object System.Drawing.Size(20,20) 
$f1.Controls.Add($f1_l1)

$f1_b1 = New-Object System.Windows.Forms.Button 
$f1_b1.Text = "Connect/Change vCenter Instance "
$f1_b1.Size = New-Object System.Drawing.Size(350,25)
$f1_b1.Location = New-Object System.Drawing.Size(20,40) 
$f1_b1.Add_Click({f2_create})
$f1.Controls.Add($f1_b1)

$f1_b2 = New-Object System.Windows.Forms.Button 
$f1_b2.Text = "Select/Change Cluster "
$f1_b2.Size = New-Object System.Drawing.Size(350,25)
$f1_b2.Location = New-Object System.Drawing.Size(20,70) 
$f1_b2.Add_Click({f3_create})
$f1.Controls.Add($f1_b2)

$f1_b3 = New-Object System.Windows.Forms.Button 
$f1_b3.Text = "Select/Change Host "
$f1_b3.Size = New-Object System.Drawing.Size(350,25)
$f1_b3.Location = New-Object System.Drawing.Size(20,100) 
$f1_b3.Add_Click({f4_create})
$f1.Controls.Add($f1_b3)

$f1_b4 = New-Object System.Windows.Forms.Button 
$f1_b4.Text = "Select/Change VM "
$f1_b4.Size = New-Object System.Drawing.Size(350,25)
$f1_b4.Location = New-Object System.Drawing.Size(20,130) 
$f1_b4.Add_Click({f5_create})
$f1.Controls.Add($f1_b4)

#MISC BLOCK
$f1_l2 = New-Object System.Windows.Forms.Label 
$f1_l2.Text = ">>> MISC. >>> "
$f1_l2.Size = New-Object System.Drawing.Size(350,20)
$f1_l2.Location = New-Object System.Drawing.Size(20,175) 
$f1.Controls.Add($f1_l2)

$f1_b5 = New-Object System.Windows.Forms.Button 
$f1_b5.Text = "Active Alerts "
$f1_b5.Size = New-Object System.Drawing.Size(350,25)
$f1_b5.Location = New-Object System.Drawing.Size(20,195)
$f1_b5.Add_Click({f6_create})  
$f1.Controls.Add($f1_b5)

$f1_b6 = New-Object System.Windows.Forms.Button 
$f1_b6.Text = "Clean Variables "
$f1_b6.Size = New-Object System.Drawing.Size(350,25)
$f1_b6.Location = New-Object System.Drawing.Size(20,225)
$f1_b6.Add_Click({initialize_globalvariables; f1_refresh})
$f1.Controls.Add($f1_b6)

$f1_b7 = New-Object System.Windows.Forms.Button 
$f1_b7.Text = "Reports "
$f1_b7.Size = New-Object System.Drawing.Size(350,25)
$f1_b7.Location = New-Object System.Drawing.Size(20,255)
$f1_b7.Add_Click({f7_create}) 
$f1.Controls.Add($f1_b7)

$f1_b8 = New-Object System.Windows.Forms.Button 
$f1_b8.Text = "SupeAdmin Mode (ON|OFF)"
$f1_b8.Size = New-Object System.Drawing.Size(350,25)
$f1_b8.Location = New-Object System.Drawing.Size(20,285) 
$f1_b8.Add_Click({AdminMode $global:shost; f1_refresh;}) 
$f1.Controls.Add($f1_b8)

$f1_b9 = New-Object System.Windows.Forms.Button 
$f1_b9.Text = "Exit "
$f1_b9.Size = New-Object System.Drawing.Size(350,25)
$f1_b9.Location = New-Object System.Drawing.Size(20,315)
$f1_b9.Add_Click({initialize_globalvariables; $f1.Close(); $f1.Dispose()}) 
$f1.Controls.Add($f1_b9)

#Note
$f1_l3 = New-Object System.Windows.Forms.Label 
$f1_l3.Text = "Developed by MH | GNU General Public License | Version 1.0 (08/2018)"
$f1_l3.Size = New-Object System.Drawing.Size(600,20)
$f1_l3.Location = New-Object System.Drawing.Size(20,380) 
$f1.Controls.Add($f1_l3)

$f1_l4 = New-Object System.Windows.Forms.Label 
$f1_l4.Text = '"If you want to go fast, go alone. If you want to go far, go together"'
$f1_l4.Size = New-Object System.Drawing.Size(600,20)
$f1_l4.Location = New-Object System.Drawing.Size(20,360) 
$f1.Controls.Add($f1_l4)

#Operations Buttons

$global:f1_b10 = New-Object System.Windows.Forms.Button 
$f1_b10.Text = "Cluster Operations"
$f1_b10.Size = New-Object System.Drawing.Size(140,140)
$f1_b10.Location = New-Object System.Drawing.Size(380,40) 
$f1_b10.Add_Click({f11_create})
if($global:scluster -ne ""){$f1_b10.Enabled = $true}
else{$f1_b10.Enabled = $false}

$f1.Controls.Add($f1_b10)

$f1_b11 = New-Object System.Windows.Forms.Button 
$f1_b11.Text = "Host Operations"
$f1_b11.Size = New-Object System.Drawing.Size(140,140)
$f1_b11.Location = New-Object System.Drawing.Size(525,40) 
$f1_b11.Add_Click({f12_create})
if($global:shost -ne ""){$f1_b11.Enabled = $true}
else{$f1_b11.Enabled = $false}
$f1.Controls.Add($f1_b11)

$f1_b12 = New-Object System.Windows.Forms.Button 
$f1_b12.Text = "VM Operations"
$f1_b12.Size = New-Object System.Drawing.Size(140,140)
$f1_b12.Location = New-Object System.Drawing.Size(670,40) 
$f1_b12.Add_Click({f13_create})
if($global:svm -ne ""){$f1_b12.Enabled = $true}
else{$f1_b12.Enabled = $false}
$f1.Controls.Add($f1_b12)

$f1_b13 = New-Object System.Windows.Forms.Button 
$f1_b13.Text = "Bulk Ops"
$f1_b13.Size = New-Object System.Drawing.Size(70,70)
$f1_b13.Location = New-Object System.Drawing.Size(380,200) 
$f1_b13.Add_Click({f28_create})
if(!($global:bulkcollection.count -lt 1)){$f1_b13.Enabled = $true}
else{$f1_b13.Enabled = $false}
$f1.Controls.Add($f1_b13)

$f1_b13b = New-Object System.Windows.Forms.Button 
$f1_b13b.Text = "Clear"
$f1_b13b.Size = New-Object System.Drawing.Size(70,70)
$f1_b13b.Location = New-Object System.Drawing.Size(450,200) 
$f1_b13b.Add_Click({clearhostbulkoperations $global:vcenter $global:scluster $global:shost; f1_refresh})
if(!($global:bulkcollection.count -lt 1)){$f1_b13b.Enabled = $true}
else{$f1_b13b.Enabled = $false}
$f1.Controls.Add($f1_b13b)

$f1_b14 = New-Object System.Windows.Forms.Button 
$f1_b14.Text = "Add Host"
$f1_b14.Size = New-Object System.Drawing.Size(70,70)
$f1_b14.Location = New-Object System.Drawing.Size(380,270) 
$f1_b14.Add_Click({addhostbulkoperations $global:vcenter $global:scluster $global:shost $global:adminmodehost $global:adminmode; f1_refresh})
if(($global:AdminMode -eq 1) -And ($global:AdminModeHost -eq $global:shost)){$f1_b14.Enabled = $true}
else{$f1_b14.Enabled = $false}
$f1.Controls.Add($f1_b14)

$f1_b15 = New-Object System.Windows.Forms.Button 
$f1_b15.Text = "Remove Host"
$f1_b15.Size = New-Object System.Drawing.Size(70,70)
$f1_b15.Location = New-Object System.Drawing.Size(450,270) 
$f1_b15.Add_Click({removehostbulkoperations $global:vcenter $global:scluster $global:shost $global:adminmodehost $global:adminmode; f1_refresh})
if(($global:AdminMode -eq 1) -And ($global:AdminModeHost -eq $global:shost) -And (!($global:bulkcollection.count -lt 1))){$f1_b15.Enabled = $true}
else{$f1_b15.Enabled = $false}
$f1.Controls.Add($f1_b15)

$f1_b16 = New-Object System.Windows.Forms.Button 
$f1_b16.Text = "Single Host Maintenance Operations"
$f1_b16.Size = New-Object System.Drawing.Size(140,140)
$f1_b16.Location = New-Object System.Drawing.Size(525,200) 
$f1_b16.Add_Click({f29_create})
if(($global:AdminMode -eq 1) -And ($global:AdminModeHost -eq $global:shost)){$f1_b16.Enabled = $true}
else{$f1_b16.Enabled = $false}
$f1.Controls.Add($f1_b16)

$f1_b17 = New-Object System.Windows.Forms.Button 
$f1_b17.Text = "vSAN - Bulk Ops"
$f1_b17.Size = New-Object System.Drawing.Size(140,140)
$f1_b17.Location = New-Object System.Drawing.Size(670,200) 
$f1_b17.Add_Click({f57_create})
if(!($global:bulkcollection.count -lt 1)){$f1_b17.Enabled = $true}
else{$f1_b17.Enabled = $false}
$f1.Controls.Add($f1_b17)

#Selected for Bulk Operations
$f1_l4 = New-Object System.Windows.Forms.Label 
$f1_l4.Text = "Selected for Bulk Operations (Bulk Ops):"
$f1_l4.Size = New-Object System.Drawing.Size(310,20)
$f1_l4.Location = New-Object System.Drawing.Size(815,180) 
$f1.Controls.Add($f1_l4)

$f1_lb1 = New-Object System.Windows.Forms.Listbox 
$f1_lb1.Size = New-Object System.Drawing.Size(310,150)
$f1_lb1.Location = New-Object System.Drawing.Size(815,200) 

$private:bulkhost = ""
$private:bulkselection=$global:bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $global:vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))} | sort-object Name
foreach ($private:bulkhost in $bulkselection)
{
$f1_lb1.Items.Add("$($bulkhost.Name) ($($bulkhost.Cluster))")
}
$f1.Controls.Add($f1_lb1)


$f1.ShowDialog()
}
############## Control Panel - END

############## Cluster Selection - BEGIN
function f3_create(){
$f3 = New-Object system.Windows.Forms.Form 
$f3.Width = 350 
$f3.Height = 300 
$f3.MaximizeBox = $false 
$f3.StartPosition = "CenterScreen" 
$f3.FormBorderStyle = 'Fixed3D' 
$f3.Text = "Cluster Menu"
$f3.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f3_l1 = New-Object System.Windows.Forms.Label 
$f3_l1.Text = "Select Cluster Instance:"
$f3_l1.Size = New-Object System.Drawing.Size(300,20)
$f3_l1.Location = New-Object System.Drawing.Size(20,20) 
$f3.Controls.Add($f3_l1)

$f3_lb1 = New-Object System.Windows.Forms.Listbox 
$f3_lb1.Size = New-Object System.Drawing.Size(300,145)
$f3_lb1.Location = New-Object System.Drawing.Size(20,50) 

#
$private:ICLUSTER = get-cluster  | Select Name | Sort-object Name
$private:ICLUSTER | %{
$f3_lb1.Items.Add($_.Name)
}
#
$f3.Controls.Add($f3_lb1)

$f3_b1 = New-Object System.Windows.Forms.Button 
$f3_b1.Text = "Confirm"
$f3_b1.Size = New-Object System.Drawing.Size(100,25)
$f3_b1.Location = New-Object System.Drawing.Size(20,200) 
$f3_b1.Add_Click({$global:svm=""; $global:shost=""; $global:scluster=$f3_lb1.selecteditem; f1_refresh})
$f3_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f3.AcceptButton = $f3_b1
$f3.Controls.Add($f3_b1)

$f3_b2 = New-Object System.Windows.Forms.Button 
$f3_b2.Text = "Cancel"
$f3_b2.Size = New-Object System.Drawing.Size(100,25)
$f3_b2.Location = New-Object System.Drawing.Size(125,200) 
$f3_b2.Add_Click({$global:svm=""; $global:shost=""; $global:scluster=""; f1_refresh})
$f3_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f3.CancelButton = $f3_b2
$f3.Controls.Add($f3_b2)

$f3.ShowDialog()
}
############## Cluster Selection - END

############## Host Selection - BEGIN
function f4_create(){
$f4 = New-Object system.Windows.Forms.Form 
$f4.Width = 350 
$f4.Height = 300 
$f4.MaximizeBox = $false 
$f4.StartPosition = "CenterScreen" 
$f4.FormBorderStyle = 'Fixed3D' 
$f4.Text = "Cluster Menu"
$f4.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f4_l1 = New-Object System.Windows.Forms.Label 
$f4_l1.Text = "Select Host Instance:"
$f4_l1.Size = New-Object System.Drawing.Size(300,20)
$f4_l1.Location = New-Object System.Drawing.Size(20,20) 
$f4.Controls.Add($f4_l1)

$f4_lb1 = New-Object System.Windows.Forms.Listbox 
$f4_lb1.Size = New-Object System.Drawing.Size(300,145)
$f4_lb1.Location = New-Object System.Drawing.Size(20,50) 

#
$private:IHOST = get-cluster $global:SCLUSTER | get-VMHost | Select Name | Sort-object Name
$private:IHOST | %{
$f4_lb1.Items.Add($_.Name)
}
#
$f4.Controls.Add($f4_lb1)

$f4_b1 = New-Object System.Windows.Forms.Button 
$f4_b1.Text = "Confirm"
$f4_b1.Size = New-Object System.Drawing.Size(100,25)
$f4_b1.Location = New-Object System.Drawing.Size(20,200) 
$f4_b1.Add_Click({$global:svm=""; $global:shost=$f4_lb1.selecteditem; f1_refresh})
$f4_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f4.AcceptButton = $f4_b1
$f4.Controls.Add($f4_b1)

$f4_b2 = New-Object System.Windows.Forms.Button 
$f4_b2.Text = "Cancel"
$f4_b2.Size = New-Object System.Drawing.Size(100,25)
$f4_b2.Location = New-Object System.Drawing.Size(125,200) 
$f4_b2.Add_Click({$global:svm=""; $global:shost=""; f1_refresh})
$f4_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f4.CancelButton = $f4_b2
$f4.Controls.Add($f4_b2)

$f4.ShowDialog()
}
############## Host Selection - END

############## VM Selection - BEGIN
function f5_create(){
$f5 = New-Object system.Windows.Forms.Form 
$f5.Width = 350 
$f5.Height = 300 
$f5.MaximizeBox = $false 
$f5.StartPosition = "CenterScreen" 
$f5.FormBorderStyle = 'Fixed3D' 
$f5.Text = "VM Menu"
$f5.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f5_l1 = New-Object System.Windows.Forms.Label 
$f5_l1.Text = "Select VM Instance:"
$f5_l1.Size = New-Object System.Drawing.Size(300,20)
$f5_l1.Location = New-Object System.Drawing.Size(20,20) 
$f5.Controls.Add($f5_l1)

$f5_lb1 = New-Object System.Windows.Forms.Listbox 
$f5_lb1.Size = New-Object System.Drawing.Size(300,145)
$f5_lb1.Location = New-Object System.Drawing.Size(20,50) 

#
$private:IVM = get-cluster $global:SCLUSTER | get-VM | Select Name | Sort-object Name
$private:IVM | %{
$f5_lb1.Items.Add($_.Name)
}
#
$f5.Controls.Add($f5_lb1)

$f5_b1 = New-Object System.Windows.Forms.Button 
$f5_b1.Text = "Confirm"
$f5_b1.Size = New-Object System.Drawing.Size(100,25)
$f5_b1.Location = New-Object System.Drawing.Size(20,200) 
$f5_b1.Add_Click({$global:svm=$f5_lb1.selecteditem; f1_refresh})
$f5_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f5.AcceptButton = $f5_b1
$f5.Controls.Add($f5_b1)

$f5_b2 = New-Object System.Windows.Forms.Button 
$f5_b2.Text = "Cancel"
$f5_b2.Size = New-Object System.Drawing.Size(100,25)
$f5_b2.Location = New-Object System.Drawing.Size(125,200) 
$f5_b2.Add_Click({$global:svm=""; f1_refresh})
$f5_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f5.CancelButton = $f5_b2
$f5.Controls.Add($f5_b2)

$f5.ShowDialog()
}
############## VM Selection - END

############## vCenter Active Alerts Form - BEGIN
function f6_create(){

$f6 = New-Object system.Windows.Forms.Form 
$f6.Width = 1150
$f6.Height = 700 
$f6.MaximizeBox = $false 
$f6.StartPosition = "CenterScreen" 
$f6.FormBorderStyle = 'Fixed3D' 
$f6.Text = "vCenter Active Alerts"
$f6.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f6_l1 = New-Object System.Windows.Forms.Label 
$f6_l1.Text = ">>> vCenter Active Alerts >>> Current Selection: >>> $global:vcenter "
$f6_l1.Size = New-Object System.Drawing.Size(900,20)
$f6_l1.Location = New-Object System.Drawing.Size(20,20) 
$f6.Controls.Add($f6_l1)

$f6_dg1 = New-Object System.Windows.Forms.DataGridView
$f6_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f6_dg1.Location = New-Object System.Drawing.Size(20,50)
$f6_dg1.ColumnCount = 9
$f6_dg1.ColumnHeadersVisible = $true
$f6_dg1.Columns[0].Name = "vCenter Instance"
$f6_dg1.Columns[1].Name = "Entity Type"
$f6_dg1.Columns[2].Name = "Alarm"
$f6_dg1.Columns[3].Name = "Entity Name"
$f6_dg1.Columns[4].Name = "Status"
$f6_dg1.Columns[5].Name = "Alarm DateTime"
$f6_dg1.Columns[6].Name = "Acknowledged"
$f6_dg1.Columns[7].Name = "AckBy"
$f6_dg1.Columns[8].Name = "AckDateTime"

$alerts=vcenteractivealerts $global:vcenter
$alerts | % {
$f6_dg1.Rows.Add($_.vCenter, $_.EntityType, $_.Alarm, $_.Entity, $_.Status, $_.Time, $_.Acknowledged, $_.AckBy, $_.AckTime)
}
$f6.Controls.Add($f6_dg1)

$f6_b1 = New-Object System.Windows.Forms.Button 
$f6_b1.Size = New-Object System.Drawing.Size(100,30)
$f6_b1.Location = New-Object System.Drawing.Size(20,605) 
$f6_b1.Text = "Close" 
$f6_b1.Add_Click({$f6.Close(); $f6.Dispose()})
$f6.Controls.Add($f6_b1)

$f6_b2 = New-Object System.Windows.Forms.Button 
$f6_b2.Size = New-Object System.Drawing.Size(100,30)
$f6_b2.Location = New-Object System.Drawing.Size(125,605) 
$f6_b2.Text = "Export-CSV" 
$f6_b2.Add_Click({ExportCSV $alerts})
$f6.Controls.Add($f6_b2)

$f6.ShowDialog()
}
############## vCenter Active Alerts Form - END

############## Reports Form - BEGIN
function f7_create(){
$f7 = New-Object system.Windows.Forms.Form 
$f7.Width = 650 
$f7.Height = 300 
$f7.MaximizeBox = $false 
$f7.StartPosition = "CenterScreen" 
$f7.FormBorderStyle = 'Fixed3D' 
$f7.Text = "Datacenter/Report Selection"
$f7.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f7_l1 = New-Object System.Windows.Forms.Label 
$f7_l1.Text = "Select a Datacenter:"
$f7_l1.Size = New-Object System.Drawing.Size(300,20)
$f7_l1.Location = New-Object System.Drawing.Size(20,20) 
$f7.Controls.Add($f7_l1)

$f7_lb1 = New-Object System.Windows.Forms.Listbox 
$f7_lb1.Size = New-Object System.Drawing.Size(300,145)
$f7_lb1.Location = New-Object System.Drawing.Size(20,50) 
#
$private:datacenters = get-datacenter | Select Name | Sort-object Name
$private:datacenters | %{
$f7_lb1.Items.Add($_.Name)
}
#
$f7.Controls.Add($f7_lb1)

$f7_l2 = New-Object System.Windows.Forms.Label 
$f7_l2.Text = "Select a Report:"
$f7_l2.Size = New-Object System.Drawing.Size(300,20)
$f7_l2.Location = New-Object System.Drawing.Size(325,20) 
$f7.Controls.Add($f7_l2)

$f7_lb2 = New-Object System.Windows.Forms.Listbox 
$f7_lb2.Size = New-Object System.Drawing.Size(300,145)
$f7_lb2.Location = New-Object System.Drawing.Size(325,50) 
$f7_lb2.Items.Add('HBA/FC/Driver Report')
$f7_lb2.Items.Add('NMP/PSP/IOPS Configuration Report')
$f7_lb2.Items.Add('Device/LUN Parameters Report')
$f7_lb2.Items.Add('vPortGroup Datacenter Report')

$f7.Controls.Add($f7_lb2)


$f7_b1 = New-Object System.Windows.Forms.Button 
$f7_b1.Text = "Confirm"
$f7_b1.Size = New-Object System.Drawing.Size(100,25)
$f7_b1.Location = New-Object System.Drawing.Size(20,200) 
$f7_b1.Add_Click({
if($f7_lb2.SelectedItem -eq "HBA/FC/Driver Report"){f8_create $f7_lb1.SelectedItem $f7_lb2.SelectedItem;}
if($f7_lb2.SelectedItem -eq "NMP/PSP/IOPS Configuration Report"){f9_create $f7_lb1.SelectedItem $f7_lb2.SelectedItem;}
if($f7_lb2.SelectedItem -eq "Device/LUN Parameters Report"){f10_create $f7_lb1.SelectedItem $f7_lb2.SelectedItem;}
if($f7_lb2.SelectedItem -eq "vPortGroup Datacenter Report"){f53_create $f7_lb1.SelectedItem $f7_lb2.SelectedItem;}
})
$f7_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f7.AcceptButton = $f7_b1
$f7.Controls.Add($f7_b1)

$f7_b2 = New-Object System.Windows.Forms.Button 
$f7_b2.Text = "Cancel"
$f7_b2.Size = New-Object System.Drawing.Size(100,25)
$f7_b2.Location = New-Object System.Drawing.Size(125,200) 
$f7_b2.Add_Click({})
$f7_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f7.CancelButton = $f7_b2
$f7.Controls.Add($f7_b2)

$f7.ShowDialog()
}
############## Reports Form - END

############## HBA/Driver Report - BEGIN
function f8_create([String] $selecteddatacenter, [String] $selectedreport){

$f8 = New-Object system.Windows.Forms.Form 
$f8.Width = 1150
$f8.Height = 700 
$f8.MaximizeBox = $false 
$f8.StartPosition = "CenterScreen" 
$f8.FormBorderStyle = 'Fixed3D' 
$f8.Text = "HBA/Driver Report"
$f8.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f8_l1 = New-Object System.Windows.Forms.Label 
$f8_l1.Text = ">>> HBA/Driver Report >>> Current Selection: >>> $global:vcenter "
$f8_l1.Size = New-Object System.Drawing.Size(900,20)
$f8_l1.Location = New-Object System.Drawing.Size(20,20) 
$f8.Controls.Add($f8_l1)

$f8_dg1 = New-Object System.Windows.Forms.DataGridView
$f8_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f8_dg1.Location = New-Object System.Drawing.Size(20,50)
$f8_dg1.ColumnCount = 12
$f8_dg1.ColumnHeadersVisible = $true
$f8_dg1.Columns[0].Name = "Cluster"
$f8_dg1.Columns[1].Name = "VMHost"
$f8_dg1.Columns[2].Name = "Model"
$f8_dg1.Columns[3].Name = "ESXVersion"
$f8_dg1.Columns[4].Name = "ESXBuild"
$f8_dg1.Columns[5].Name = "HBADevice"
$f8_dg1.Columns[6].Name = "Status"
$f8_dg1.Columns[7].Name = "Driver"
$f8_dg1.Columns[8].Name = "Description"
$f8_dg1.Columns[9].Name = "DeviceType"
$f8_dg1.Columns[10].Name = "Module"
$f8_dg1.Columns[11].Name = "Version"

$actualreport=GenerateReports $selecteddatacenter $selectedreport
$actualreport | % {
$f8_dg1.Rows.Add($_.Cluster, $_.VMHost, $_.Model, $_.ESXVersion, $_.ESXBuild, $_.HBADevice, $_.Status, $_.Driver, $_.Description, $_.DeviceType, $_.Module, $_.Version)
}
$f8.Controls.Add($f8_dg1)

$f8_b1 = New-Object System.Windows.Forms.Button 
$f8_b1.Size = New-Object System.Drawing.Size(100,30)
$f8_b1.Location = New-Object System.Drawing.Size(20,605) 
$f8_b1.Text = "Close" 
$f8_b1.Add_Click({$f8.Close(); $f8.Dispose()})
$f8.Controls.Add($f8_b1)

$f8_b2 = New-Object System.Windows.Forms.Button 
$f8_b2.Size = New-Object System.Drawing.Size(100,30)
$f8_b2.Location = New-Object System.Drawing.Size(125,605) 
$f8_b2.Text = "Export-CSV" 
$f8_b2.Add_Click({ExportCSV $actualreport})
$f8.Controls.Add($f8_b2)

$f8.ShowDialog()
}
############## HBA/Driver Report - END

############## NMP/PSP/IOPS Configuration Report - BEGIN
function f9_create([String] $selecteddatacenter, [String] $selectedreport){

$f9 = New-Object system.Windows.Forms.Form 
$f9.Width = 1150
$f9.Height = 700 
$f9.MaximizeBox = $false 
$f9.StartPosition = "CenterScreen" 
$f9.FormBorderStyle = 'Fixed3D' 
$f9.Text = "NMP/PSP/IOPS Configuration Report"
$f9.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f9_l1 = New-Object System.Windows.Forms.Label 
$f9_l1.Text = ">>> NMP/PSP/IOPS Configuration Report >>> Current Selection: >>> $global:vcenter "
$f9_l1.Size = New-Object System.Drawing.Size(900,20)
$f9_l1.Location = New-Object System.Drawing.Size(20,20) 
$f9.Controls.Add($f9_l1)

$f9_dg1 = New-Object System.Windows.Forms.DataGridView
$f9_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f9_dg1.Location = New-Object System.Drawing.Size(20,50)
$f9_dg1.ColumnCount = 6
$f9_dg1.ColumnHeadersVisible = $true
$f9_dg1.Columns[0].Name = "VMHost"
$f9_dg1.Columns[1].Name = "Device"
$f9_dg1.Columns[2].Name = "DeviceDisplayName"
$f9_dg1.Columns[3].Name = "PathSelectionPolicy"
$f9_dg1.Columns[4].Name = "PathSelectionPolicyDeviceConfig"
$f9_dg1.Columns[5].Name = "StorageArrayType"

$actualreport=GenerateReports $selecteddatacenter $selectedreport
$actualreport | % {
$f9_dg1.Rows.Add($_.VMHost, $_.Device, $_.DeviceDisplayName, $_.PathSelectionPolicy, $_.PathSelectionPolicyDeviceConfig, $_.StorageArrayType)
}
$f9.Controls.Add($f9_dg1)

$f9_b1 = New-Object System.Windows.Forms.Button 
$f9_b1.Size = New-Object System.Drawing.Size(100,30)
$f9_b1.Location = New-Object System.Drawing.Size(20,605) 
$f9_b1.Text = "Close" 
$f9_b1.Add_Click({$f9.Close(); $f9.Dispose()})
$f9.Controls.Add($f9_b1)

$f9_b2 = New-Object System.Windows.Forms.Button 
$f9_b2.Size = New-Object System.Drawing.Size(100,30)
$f9_b2.Location = New-Object System.Drawing.Size(125,605) 
$f9_b2.Text = "Export-CSV" 
$f9_b2.Add_Click({ExportCSV $actualreport})
$f9.Controls.Add($f9_b2)

$f9.ShowDialog()
}
############## NMP/PSP/IOPS Configuration Report - END

############## Device/LUN Parameters Report - BEGIN
function f10_create([String] $selecteddatacenter, [String] $selectedreport){

$f10 = New-Object system.Windows.Forms.Form 
$f10.Width = 1150
$f10.Height = 700 
$f10.MaximizeBox = $false 
$f10.StartPosition = "CenterScreen" 
$f10.FormBorderStyle = 'Fixed3D' 
$f10.Text = "Device/LUN Parameters Report"
$f10.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f10_l1 = New-Object System.Windows.Forms.Label 
$f10_l1.Text = ">>> Device/LUN Parameters Report >>> Current Selection: >>> $global:vcenter "
$f10_l1.Size = New-Object System.Drawing.Size(900,20)
$f10_l1.Location = New-Object System.Drawing.Size(20,20) 
$f10.Controls.Add($f10_l1)

$f10_dg1 = New-Object System.Windows.Forms.DataGridView
$f10_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f10_dg1.Location = New-Object System.Drawing.Size(20,50)
$f10_dg1.ColumnCount = 13
$f10_dg1.ColumnHeadersVisible = $true
$f10_dg1.Columns[0].Name = "Cluster"
$f10_dg1.Columns[1].Name = "VMHost"
$f10_dg1.Columns[2].Name = "DisplayName"
$f10_dg1.Columns[3].Name = "Device"
$f10_dg1.Columns[4].Name = "DevfsPath"
$f10_dg1.Columns[5].Name = "Vendor"
$f10_dg1.Columns[6].Name = "Model"
$f10_dg1.Columns[7].Name = "MultiPathPlugin"
$f10_dg1.Columns[8].Name = "VAAIStatus"
$f10_dg1.Columns[9].Name = "DeviceMaxQueueDepth"
$f10_dg1.Columns[10].Name = "NoofoutstandingIOswithcompetingworlds"
$f10_dg1.Columns[11].Name = "QueueFullSampleSize"
$f10_dg1.Columns[12].Name = "QueueFullThreshold"

$actualreport=GenerateReports $selecteddatacenter $selectedreport
$actualreport | % {
$f10_dg1.Rows.Add($_.Cluster, $_.VMHost, $_.DisplayName, $_.Device, $_.DevfsPath, $_.Vendor, $_.Model, $_.MultiPathPlugin, $_.VAAIStatus, $_.DeviceMaxQueueDepth, $_.NoofoutstandingIOswithcompetingworlds, $_.QueueFullSampleSize, $_.QueueFullThreshold)
}
$f10.Controls.Add($f10_dg1)

$f10_b1 = New-Object System.Windows.Forms.Button 
$f10_b1.Size = New-Object System.Drawing.Size(100,30)
$f10_b1.Location = New-Object System.Drawing.Size(20,605) 
$f10_b1.Text = "Close" 
$f10_b1.Add_Click({$f10.Close(); $f10.Dispose()})
$f10.Controls.Add($f10_b1)

$f10_b2 = New-Object System.Windows.Forms.Button 
$f10_b2.Size = New-Object System.Drawing.Size(100,30)
$f10_b2.Location = New-Object System.Drawing.Size(125,605) 
$f10_b2.Text = "Export-CSV" 
$f10_b2.Add_Click({ExportCSV $actualreport})
$f10.Controls.Add($f10_b2)

$f10.ShowDialog()
}
############## Device/LUN Parameters Report - END

############## vPortGroup Report - BEGIN
function f53_create([String] $selecteddatacenter, [String] $selectedreport){

$f53 = New-Object system.Windows.Forms.Form 
$f53.Width = 1150
$f53.Height = 700 
$f53.MaximizeBox = $false 
$f53.StartPosition = "CenterScreen" 
$f53.FormBorderStyle = 'Fixed3D' 
$f53.Text = "vPortGroup Datacenter Report"
$f53.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f53_l1 = New-Object System.Windows.Forms.Label 
$f53_l1.Text = ">>> vPortGroup Datacenter Report >>> Current Selection: >>> $global:vcenter "
$f53_l1.Size = New-Object System.Drawing.Size(900,20)
$f53_l1.Location = New-Object System.Drawing.Size(20,20) 
$f53.Controls.Add($f53_l1)

$f53_dg1 = New-Object System.Windows.Forms.DataGridView
$f53_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f53_dg1.Location = New-Object System.Drawing.Size(20,50)
$f53_dg1.ColumnCount = 5
$f53_dg1.ColumnHeadersVisible = $true
$f53_dg1.Columns[0].Name = "Name"
$f53_dg1.Columns[1].Name = "VirtualSwitch"
$f53_dg1.Columns[2].Name = "VLanId"
$f53_dg1.Columns[3].Name = "VMHost"
$f53_dg1.Columns[4].Name = "Cluster"

$actualreport=GenerateReports $selecteddatacenter $selectedreport
$actualreport | % {
$f53_dg1.Rows.Add($_.Name, $_.VirtualSwitch, $_.VLanId, $_.VMHost, $_.Cluster)
}
$f53.Controls.Add($f53_dg1)

$f53_b1 = New-Object System.Windows.Forms.Button 
$f53_b1.Size = New-Object System.Drawing.Size(100,30)
$f53_b1.Location = New-Object System.Drawing.Size(20,605) 
$f53_b1.Text = "Close" 
$f53_b1.Add_Click({$f53.Close(); $f53.Dispose()})
$f53.Controls.Add($f53_b1)

$f53_b2 = New-Object System.Windows.Forms.Button 
$f53_b2.Size = New-Object System.Drawing.Size(100,30)
$f53_b2.Location = New-Object System.Drawing.Size(125,605) 
$f53_b2.Text = "Export-CSV" 
$f53_b2.Add_Click({ExportCSV $actualreport})
$f53.Controls.Add($f53_b2)

$f53.ShowDialog()
}
############## vPortGroup Report - END

############## Cluster Operations Form - BEGIN
function f11_create(){

$f11 = New-Object system.Windows.Forms.Form 
$f11.Width = 400
$f11.Height = 350 
$f11.MaximizeBox = $false 
$f11.StartPosition = "CenterScreen" 
$f11.FormBorderStyle = 'Fixed3D' 
$f11.Text = "Cluster Operations"
$f11.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f11_l1 = New-Object System.Windows.Forms.Label 
$f11_l1.Text = "$global:scluster | Select an option:"
$f11_l1.Size = New-Object System.Drawing.Size(1100,20)
$f11_l1.Location = New-Object System.Drawing.Size(20,20) 
$f11.Controls.Add($f11_l1)

$f11_lb1 = New-Object System.Windows.Forms.Listbox 
$f11_lb1.Size = New-Object System.Drawing.Size(300,170)
$f11_lb1.Location = New-Object System.Drawing.Size(20,50) 
$f11_lb1.Items.Add('Obtain Host Statistics')
$f11_lb1.Items.Add('Obtain VMs Running on this Cluster')
$f11_lb1.Items.Add('Obtain Host vCPU-pCPU Ratio')
$f11_lb1.Items.Add('Obtain Host Memory Ratio')
$f11_lb1.Items.Add('Cluster Configuration')
$f11_lb1.Items.Add('Cluster vPortGroup Inventory')
$f11_lb1.Items.Add('Cluster VMkernel Inventory')
$f11_lb1.Items.Add('Cluster Logging Report')
$f11.Controls.Add($f11_lb1)

$f11_b1 = New-Object System.Windows.Forms.Button 
$f11_b1.Text = "Confirm"
$f11_b1.Size = New-Object System.Drawing.Size(100,25)
$f11_b1.Location = New-Object System.Drawing.Size(20,225) 
$f11_b1.Add_Click({

if($f11_lb1.SelectedItem -eq "Obtain Host Statistics"){f14_create $global:scluster}
if($f11_lb1.SelectedItem -eq "Obtain VMs Running on this Cluster"){f15_create $global:scluster}
if($f11_lb1.SelectedItem -eq "Obtain Host vCPU-pCPU Ratio"){f16_create $global:scluster}
if($f11_lb1.SelectedItem -eq "Obtain Host Memory Ratio"){f17_create $global:scluster}
if($f11_lb1.SelectedItem -eq "Cluster Configuration"){f18_create $global:scluster}
if($f11_lb1.SelectedItem -eq "Cluster vPortGroup Inventory"){f47_create}
if($f11_lb1.SelectedItem -eq "Cluster VMkernel Inventory"){f55_create}
if($f11_lb1.SelectedItem -eq "Cluster Logging Report"){f56_create}

})
$f11_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f11.AcceptButton = $f11_b1
$f11.Controls.Add($f11_b1)

$f11_b2 = New-Object System.Windows.Forms.Button 
$f11_b2.Text = "Cancel"
$f11_b2.Size = New-Object System.Drawing.Size(100,25)
$f11_b2.Location = New-Object System.Drawing.Size(125,225) 
$f11_b2.Add_Click({})
$f11_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f11.CancelButton = $f11_b2
$f11.Controls.Add($f11_b2)

$f11.ShowDialog()
}
############## Cluster Operations Form - END

############## Host Operations Form - BEGIN
function f12_create(){

$f12 = New-Object system.Windows.Forms.Form 
$f12.Width = 400
$f12.Height = 350 
$f12.MaximizeBox = $false 
$f12.StartPosition = "CenterScreen" 
$f12.FormBorderStyle = 'Fixed3D' 
$f12.Text = "Host Operations"
$f12.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f12_l1 = New-Object System.Windows.Forms.Label 
$f12_l1.Text = "$global:shost | Select an option:"
$f12_l1.Size = New-Object System.Drawing.Size(1100,20)
$f12_l1.Location = New-Object System.Drawing.Size(20,20) 
$f12.Controls.Add($f12_l1)

$f12_lb1 = New-Object System.Windows.Forms.Listbox 
$f12_lb1.Size = New-Object System.Drawing.Size(300,170)
$f12_lb1.Location = New-Object System.Drawing.Size(20,50) 
$f12_lb1.Items.Add('Host VMs Memory/CPU Statistics')
$f12_lb1.Items.Add('Host Storage Error Events')
$f12_lb1.Items.Add('NMP Configuration: List Devices')
$f12_lb1.Items.Add('NMP Configuration: List SATP')
$f12_lb1.Items.Add('NMP Configuration: List SATP Rules')
$f12_lb1.Items.Add('Storage Core Device Configuration')
$f12_lb1.Items.Add('Enable/Disable SSH')
$f12_lb1.Items.Add('Obtain Storage Adapters')
$f12_lb1.Items.Add('Obtain Driver Module Information')
$f12_lb1.Items.Add('Obtain Driver Module Parameters')
$f12_lb1.Items.Add('Host Configuration')
$f12_lb1.Items.Add('Advanced Settings')
$f12_lb1.Items.Add('Host vPortGroup Inventory')

$f12.Controls.Add($f12_lb1)

$f12_b1 = New-Object System.Windows.Forms.Button 
$f12_b1.Text = "Confirm"
$f12_b1.Size = New-Object System.Drawing.Size(100,25)
$f12_b1.Location = New-Object System.Drawing.Size(20,225) 
$f12_b1.Add_Click({

if($f12_lb1.SelectedItem -eq "Host VMs Memory/CPU Statistics"){f19_create $global:shost}
if($f12_lb1.SelectedItem -eq "Host Storage Error Events"){f20_create $global:shost}
if($f12_lb1.SelectedItem -eq "NMP Configuration: List SATP"){f21_create $global:shost}
if($f12_lb1.SelectedItem -eq "NMP Configuration: List SATP Rules"){f22_create $global:shost}
if($f12_lb1.SelectedItem -eq "Enable/Disable SSH"){HostSSH $global:shost}
if($f12_lb1.SelectedItem -eq "NMP Configuration: List Devices"){f23_create $global:shost}
if($f12_lb1.SelectedItem -eq "Storage Core Device Configuration"){f24_create $global:shost}
if($f12_lb1.SelectedItem -eq "Obtain Storage Adapters"){f25_create $global:shost}
if($f12_lb1.SelectedItem -eq "Host Configuration"){f26_create $global:scluster $global:shost}
if($f12_lb1.SelectedItem -eq "Advanced Settings"){f27_create $global:scluster $global:shost}
if($f12_lb1.SelectedItem -eq "Obtain Driver Module Information"){f30_create $global:scluster $global:shost}
if($f12_lb1.SelectedItem -eq "Obtain Driver Module Parameters"){f31_create $global:scluster $global:shost}
if($f12_lb1.SelectedItem -eq "Host vPortGroup Inventory"){f46_create}

})
$f12_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f12.AcceptButton = $f12_b1
$f12.Controls.Add($f12_b1)

$f12_b2 = New-Object System.Windows.Forms.Button 
$f12_b2.Text = "Cancel"
$f12_b2.Size = New-Object System.Drawing.Size(100,25)
$f12_b2.Location = New-Object System.Drawing.Size(125,225) 
$f12_b2.Add_Click({})
$f12_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f12.CancelButton = $f12_b2
$f12.Controls.Add($f12_b2)

$f12.ShowDialog()
}
############## Host Operations Form - END

###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT- 
###########################################################

############## VM Operations Form - BEGIN
function f13_create(){

$f13 = New-Object system.Windows.Forms.Form 
$f13.Width = 400
$f13.Height = 350 
$f13.MaximizeBox = $false 
$f13.StartPosition = "CenterScreen" 
$f13.FormBorderStyle = 'Fixed3D' 
$f13.Text = "VM Operations"
$f13.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f13_l1 = New-Object System.Windows.Forms.Label 
$f13_l1.Text = "$global:svm | Select an option:"
$f13_l1.Size = New-Object System.Drawing.Size(1100,20)
$f13_l1.Location = New-Object System.Drawing.Size(20,20) 
$f13.Controls.Add($f13_l1)

$f13_lb1 = New-Object System.Windows.Forms.Listbox 
$f13_lb1.Size = New-Object System.Drawing.Size(300,170)
$f13_lb1.Location = New-Object System.Drawing.Size(20,50) 
$f13_lb1.Items.Add('Mount VMTools')
$f13_lb1.Items.Add('Dismount VMTools')

$f13.Controls.Add($f13_lb1)

$f13_b1 = New-Object System.Windows.Forms.Button 
$f13_b1.Text = "Confirm"
$f13_b1.Size = New-Object System.Drawing.Size(100,25)
$f13_b1.Location = New-Object System.Drawing.Size(20,225) 
$f13_b1.Add_Click({

if($f13_lb1.SelectedItem -eq "Mount VMTools"){MountVMTools $global:svm}
if($f13_lb1.SelectedItem -eq "Dismount VMTools"){DismountVMTools $global:svm}

})
$f13_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f13.AcceptButton = $f13_b1
$f13.Controls.Add($f13_b1)

$f13_b2 = New-Object System.Windows.Forms.Button 
$f13_b2.Text = "Cancel"
$f13_b2.Size = New-Object System.Drawing.Size(100,25)
$f13_b2.Location = New-Object System.Drawing.Size(125,225) 
$f13_b2.Add_Click({})
$f13_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f13.CancelButton = $f13_b2
$f13.Controls.Add($f13_b2)

$f13.ShowDialog()
}
############## VM Operations Form - END

############## Cluster | Obtain Host Statistics - BEGIN
function f14_create([String] $global:scluster){

$f14 = New-Object system.Windows.Forms.Form 
$f14.Width = 1150
$f14.Height = 700 
$f14.MaximizeBox = $false 
$f14.StartPosition = "CenterScreen" 
$f14.FormBorderStyle = 'Fixed3D' 
$f14.Text = "$global:scluster | Obtain Host Statistics"
$f14.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f14_l1 = New-Object System.Windows.Forms.Label 
$f14_l1.Text = ">>> Obtain Host Statistics >>> Current Selection: >>> $global:scluster "
$f14_l1.Size = New-Object System.Drawing.Size(900,20)
$f14_l1.Location = New-Object System.Drawing.Size(20,20) 
$f14.Controls.Add($f14_l1)

$f14_dg1 = New-Object System.Windows.Forms.DataGridView
$f14_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f14_dg1.Location = New-Object System.Drawing.Size(20,50)
$f14_dg1.ColumnCount = 12
$f14_dg1.ColumnHeadersVisible = $true
$f14_dg1.Columns[0].Name = "Name"
$f14_dg1.Columns[1].Name = "ConnectionState"
$f14_dg1.Columns[2].Name = "PowerState"
$f14_dg1.Columns[3].Name = "NumCpu"
$f14_dg1.Columns[4].Name = "CpuUsageMhz"
$f14_dg1.Columns[5].Name = "CpuTotalMhz"
$f14_dg1.Columns[6].Name = "MemoryUsageGB"
$f14_dg1.Columns[7].Name = "MemoryTotalGB"
$f14_dg1.Columns[8].Name = "CpuUsage"
$f14_dg1.Columns[9].Name = "MemoryUsage"
$f14_dg1.Columns[10].Name = "Version"
$f14_dg1.Columns[11].Name = "VMsRunning"

$actualreport=ClusterHostStatus $global:scluster
$actualreport | % {
$f14_dg1.Rows.Add($_.Name, $_.ConnectionState, $_.PowerState, $_.NumCpu, $_.CpuUsageMhz, $_.CpuTotalMhz, $_.MemoryUsageGB, $_.MemoryTotalGB, $_.CpuUsage, $_.MemoryUsage, $_.Version, $_.VMsRunning)
}
$f14.Controls.Add($f14_dg1)

$f14_b1 = New-Object System.Windows.Forms.Button 
$f14_b1.Size = New-Object System.Drawing.Size(100,30)
$f14_b1.Location = New-Object System.Drawing.Size(20,605) 
$f14_b1.Text = "Close" 
$f14_b1.Add_Click({$f14.Close(); $f14.Dispose()})
$f14.Controls.Add($f14_b1)

$f14_b2 = New-Object System.Windows.Forms.Button 
$f14_b2.Size = New-Object System.Drawing.Size(100,30)
$f14_b2.Location = New-Object System.Drawing.Size(125,605) 
$f14_b2.Text = "Export-CSV" 
$f14_b2.Add_Click({ExportCSV $actualreport})
$f14.Controls.Add($f14_b2)

$f14.ShowDialog()
}
############## Cluster | Obtain Host Statistics - END

############## Cluster | Obtain VMs Running on this Cluster - BEGIN
function f15_create([String] $global:scluster){

$f15 = New-Object system.Windows.Forms.Form 
$f15.Width = 1150
$f15.Height = 700 
$f15.MaximizeBox = $false 
$f15.StartPosition = "CenterScreen" 
$f15.FormBorderStyle = 'Fixed3D' 
$f15.Text = "$global:scluster | Obtain VMs Running on this Cluster"
$f15.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f15_l1 = New-Object System.Windows.Forms.Label 
$f15_l1.Text = ">>> Obtain VMs Running on this Cluster >>> Current Selection: >>> $global:scluster "
$f15_l1.Size = New-Object System.Drawing.Size(900,20)
$f15_l1.Location = New-Object System.Drawing.Size(20,20) 
$f15.Controls.Add($f15_l1)

$f15_dg1 = New-Object System.Windows.Forms.DataGridView
$f15_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f15_dg1.Location = New-Object System.Drawing.Size(20,50)
$f15_dg1.ColumnCount = 10
$f15_dg1.ColumnHeadersVisible = $true
$f15_dg1.Columns[0].Name = "Name"
$f15_dg1.Columns[1].Name = "PowerState"
$f15_dg1.Columns[2].Name = "VMHost"
$f15_dg1.Columns[3].Name = "NumCpu"
$f15_dg1.Columns[4].Name = "CoresPerSocket"
$f15_dg1.Columns[5].Name = "MemoryGB"
$f15_dg1.Columns[6].Name = "Guest"
$f15_dg1.Columns[7].Name = "IPAddresses"
$f15_dg1.Columns[8].Name = "Notes"
$f15_dg1.Columns[9].Name = "Version"

$actualreport=ListVMsCluster $global:scluster
$actualreport | % {
$f15_dg1.Rows.Add($_.Name, $_.PowerState, $_.VMHost, $_.NumCpu, $_.CoresPerSocket, $_.MemoryGB, $_.Guest, $_.IPAddresses, $_.Notes, $_.Version)
}
$f15.Controls.Add($f15_dg1)

$f15_b1 = New-Object System.Windows.Forms.Button 
$f15_b1.Size = New-Object System.Drawing.Size(100,30)
$f15_b1.Location = New-Object System.Drawing.Size(20,605) 
$f15_b1.Text = "Close" 
$f15_b1.Add_Click({$f15.Close(); $f15.Dispose()})
$f15.Controls.Add($f15_b1)

$f15_b2 = New-Object System.Windows.Forms.Button 
$f15_b2.Size = New-Object System.Drawing.Size(100,30)
$f15_b2.Location = New-Object System.Drawing.Size(125,605) 
$f15_b2.Text = "Export-CSV" 
$f15_b2.Add_Click({ExportCSV $actualreport})
$f15.Controls.Add($f15_b2)

$f15.ShowDialog()
}
############## Cluster | Obtain VMs Running on this Cluster - END

############## Cluster | Obtain Host vCPU-pCPU Ratio - BEGIN
function f16_create([String] $global:scluster){

$f16 = New-Object system.Windows.Forms.Form 
$f16.Width = 1150
$f16.Height = 700 
$f16.MaximizeBox = $false 
$f16.StartPosition = "CenterScreen" 
$f16.FormBorderStyle = 'Fixed3D' 
$f16.Text = "$global:scluster | Obtain Host vCPU-pCPU Ratio"
$f16.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f16_l1 = New-Object System.Windows.Forms.Label 
$f16_l1.Text = ">>> Obtain Host vCPU-pCPU Ratio >>> Current Selection: >>> $global:scluster "
$f16_l1.Size = New-Object System.Drawing.Size(900,20)
$f16_l1.Location = New-Object System.Drawing.Size(20,20) 
$f16.Controls.Add($f16_l1)

$f16_dg1 = New-Object System.Windows.Forms.DataGridView
$f16_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f16_dg1.Location = New-Object System.Drawing.Size(20,50)
$f16_dg1.ColumnCount = 6
$f16_dg1.ColumnHeadersVisible = $true
$f16_dg1.Columns[0].Name = "Name"
$f16_dg1.Columns[1].Name = "pCPUAvailable"
$f16_dg1.Columns[2].Name = "vCPUAssigned"
$f16_dg1.Columns[3].Name = "VMsRunning"
$f16_dg1.Columns[4].Name = "Ratio"
$f16_dg1.Columns[5].Name = "CPUOvercommit"


$actualreport=HostCPURatio $global:scluster
$actualreport | % {
$f16_dg1.Rows.Add($_.Name, $_.pCPUAvailable, $_.vCPUAssigned, $_.VMsRunning, $_.Ratio, $_.CPUOvercommit)
}
$f16.Controls.Add($f16_dg1)

$f16_b1 = New-Object System.Windows.Forms.Button 
$f16_b1.Size = New-Object System.Drawing.Size(100,30)
$f16_b1.Location = New-Object System.Drawing.Size(20,605) 
$f16_b1.Text = "Close" 
$f16_b1.Add_Click({$f16.Close(); $f16.Dispose()})
$f16.Controls.Add($f16_b1)

$f16_b2 = New-Object System.Windows.Forms.Button 
$f16_b2.Size = New-Object System.Drawing.Size(100,30)
$f16_b2.Location = New-Object System.Drawing.Size(125,605) 
$f16_b2.Text = "Export-CSV" 
$f16_b2.Add_Click({ExportCSV $actualreport})
$f16.Controls.Add($f16_b2)

$f16.ShowDialog()
}
############## Cluster | Obtain Host vCPU-pCPU Ratio - END

############## Cluster | Obtain HostMemoryRatio - BEGIN
function f17_create([String] $global:scluster){

$f17 = New-Object system.Windows.Forms.Form 
$f17.Width = 1150
$f17.Height = 700 
$f17.MaximizeBox = $false 
$f17.StartPosition = "CenterScreen" 
$f17.FormBorderStyle = 'Fixed3D' 
$f17.Text = "$global:scluster | Obtain HostMemoryRatio"
$f17.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f17_l1 = New-Object System.Windows.Forms.Label 
$f17_l1.Text = ">>> Obtain HostMemoryRatio >>> Current Selection: >>> $global:scluster "
$f17_l1.Size = New-Object System.Drawing.Size(900,20)
$f17_l1.Location = New-Object System.Drawing.Size(20,20) 
$f17.Controls.Add($f17_l1)

$f17_dg1 = New-Object System.Windows.Forms.DataGridView
$f17_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f17_dg1.Location = New-Object System.Drawing.Size(20,50)
$f17_dg1.ColumnCount = 6
$f17_dg1.ColumnHeadersVisible = $true
$f17_dg1.Columns[0].Name = "Name"
$f17_dg1.Columns[1].Name = "MemoryAvailable"
$f17_dg1.Columns[2].Name = "MemoryAssigned"
$f17_dg1.Columns[3].Name = "VMsRunning"
$f17_dg1.Columns[4].Name = "Ratio"
$f17_dg1.Columns[5].Name = "MemoryOvercommit"


$actualreport=HostMemoryRatio $global:scluster
$actualreport | % {
$f17_dg1.Rows.Add($_.Name, $_.MemoryAvailable, $_.MemoryAssigned, $_.VMsRunning, $_.Ratio, $_.MemoryOvercommit)
}
$f17.Controls.Add($f17_dg1)

$f17_b1 = New-Object System.Windows.Forms.Button 
$f17_b1.Size = New-Object System.Drawing.Size(100,30)
$f17_b1.Location = New-Object System.Drawing.Size(20,605) 
$f17_b1.Text = "Close" 
$f17_b1.Add_Click({$f17.Close(); $f17.Dispose()})
$f17.Controls.Add($f17_b1)

$f17_b2 = New-Object System.Windows.Forms.Button 
$f17_b2.Size = New-Object System.Drawing.Size(100,30)
$f17_b2.Location = New-Object System.Drawing.Size(125,605) 
$f17_b2.Text = "Export-CSV" 
$f17_b2.Add_Click({ExportCSV $actualreport})
$f17.Controls.Add($f17_b2)

$f17.ShowDialog()
}
############## Cluster | Obtain HostMemoryRatio - END

############## Output ClusterConfiguration 2-Column - BEGIN
function f18_create([String] $global:scluster){

$f18 = New-Object system.Windows.Forms.Form 
$f18.Width = 1150
$f18.Height = 700 
$f18.MaximizeBox = $false 
$f18.StartPosition = "CenterScreen" 
$f18.FormBorderStyle = 'Fixed3D' 
$f18.Text = "$global:scluster | Cluster Configuration "
$f18.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f18_l1 = New-Object System.Windows.Forms.Label 
$f18_l1.Text = ">>> Cluster Configuration >>> Current Selection: >>> $global:scluster "
$f18_l1.Size = New-Object System.Drawing.Size(900,20)
$f18_l1.Location = New-Object System.Drawing.Size(20,20) 
$f18.Controls.Add($f18_l1)

$f18_dg1 = New-Object System.Windows.Forms.DataGridView
$f18_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f18_dg1.Location = New-Object System.Drawing.Size(20,50)
$f18_dg1.ColumnCount = 2
$f18_dg1.ColumnHeadersVisible = $true
$f18_dg1.Columns[0].Name = "Description"
$f18_dg1.Columns[1].Name = "Current Value"

$actualreport=ClusterConfiguration $global:scluster
$properties= Get-Member -InputObject $actualreport -MemberType NoteProperty

$properties | % {
$propertyvalue = $actualreport | select-object -expandproperty $_.Name
$f18_dg1.Rows.Add($_.Name, $propertyvalue)
}


$f18.Controls.Add($f18_dg1)

$f18_b1 = New-Object System.Windows.Forms.Button 
$f18_b1.Size = New-Object System.Drawing.Size(100,30)
$f18_b1.Location = New-Object System.Drawing.Size(20,605) 
$f18_b1.Text = "Close" 
$f18_b1.Add_Click({$f18.Close(); $f18.Dispose()})
$f18.Controls.Add($f18_b1)

$f18_b2 = New-Object System.Windows.Forms.Button 
$f18_b2.Size = New-Object System.Drawing.Size(100,30)
$f18_b2.Location = New-Object System.Drawing.Size(125,605) 
$f18_b2.Text = "Export-CSV" 
$f18_b2.Add_Click({ExportCSV $actualreport})
$f18.Controls.Add($f18_b2)

$f18.ShowDialog()
}
############## Output ClusterConfiguration 2-Column - END

############## Host | Obtain Host VMs Memory/CPU Statistics - BEGIN
function f19_create([String] $global:shost){

$f19 = New-Object system.Windows.Forms.Form 
$f19.Width = 1150
$f19.Height = 700 
$f19.MaximizeBox = $false 
$f19.StartPosition = "CenterScreen" 
$f19.FormBorderStyle = 'Fixed3D' 
$f19.Text = "$global:shost | Obtain Host VMs Memory/CPU Statistics"
$f19.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f19_l1 = New-Object System.Windows.Forms.Label 
$f19_l1.Text = ">>> Obtain Host VMs Memory/CPU Statistics >>> Current Selection: >>> $global:shost "
$f19_l1.Size = New-Object System.Drawing.Size(900,20)
$f19_l1.Location = New-Object System.Drawing.Size(20,20) 
$f19.Controls.Add($f19_l1)

$f19_dg1 = New-Object System.Windows.Forms.DataGridView
$f19_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f19_dg1.Location = New-Object System.Drawing.Size(20,50)
$f19_dg1.ColumnCount = 8
$f19_dg1.ColumnHeadersVisible = $true
$f19_dg1.Columns[0].Name = "Name"
$f19_dg1.Columns[1].Name = "PowerState"
$f19_dg1.Columns[2].Name = "NumCpu"
$f19_dg1.Columns[3].Name = "CoresPerSocket"
$f19_dg1.Columns[4].Name = "MemoryMB"
$f19_dg1.Columns[5].Name = "CPUAverageMHZ"
$f19_dg1.Columns[6].Name = "MemoryAverage"
$f19_dg1.Columns[7].Name = "CPUAverage"


$actualreport=HostVMsStatistics $global:shost
$actualreport | % {
$f19_dg1.Rows.Add($_.Name, $_.PowerState, $_.NumCpu, $_.CoresPerSocket, $_.MemoryMB, $_.CPUAverageMHZ, $_.MemoryAverage, $_.CPUAverage)
}
$f19.Controls.Add($f19_dg1)

$f19_b1 = New-Object System.Windows.Forms.Button 
$f19_b1.Size = New-Object System.Drawing.Size(100,30)
$f19_b1.Location = New-Object System.Drawing.Size(20,605) 
$f19_b1.Text = "Close" 
$f19_b1.Add_Click({$f19.Close(); $f19.Dispose()})
$f19.Controls.Add($f19_b1)

$f19_b2 = New-Object System.Windows.Forms.Button 
$f19_b2.Size = New-Object System.Drawing.Size(100,30)
$f19_b2.Location = New-Object System.Drawing.Size(125,605) 
$f19_b2.Text = "Export-CSV" 
$f19_b2.Add_Click({ExportCSV $actualreport})
$f19.Controls.Add($f19_b2)

$f19.ShowDialog()
}
############## Host | Obtain Host VMs Memory/CPU Statistics - BEGIN

############## Host Storage Error Events - BEGIN
function f20_create([String] $global:shost){

$f20 = New-Object system.Windows.Forms.Form 
$f20.Width = 1150
$f20.Height = 700 
$f20.MaximizeBox = $false 
$f20.StartPosition = "CenterScreen" 
$f20.FormBorderStyle = 'Fixed3D' 
$f20.Text = "$global:shost | Host Storage Error Events"
$f20.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f20_l1 = New-Object System.Windows.Forms.Label 
$f20_l1.Text = ">>> Host Storage Error Events >>> Current Selection: >>> $global:shost "
$f20_l1.Size = New-Object System.Drawing.Size(900,20)
$f20_l1.Location = New-Object System.Drawing.Size(20,20) 
$f20.Controls.Add($f20_l1)

$f20_dg1 = New-Object System.Windows.Forms.DataGridView
$f20_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f20_dg1.Location = New-Object System.Drawing.Size(20,50)
$f20_dg1.ColumnCount = 4
$f20_dg1.ColumnHeadersVisible = $true
$f20_dg1.Columns[0].Name = "CreatedTime"
$f20_dg1.Columns[1].Name = "ObjectName"
$f20_dg1.Columns[2].Name = "EventTypeID"
$f20_dg1.Columns[3].Name = "FullFormattedMessage"

$actualreport=HostStorageEvents $global:shost
$actualreport | % {
$f20_dg1.Rows.Add($_.CreatedTime, $_.ObjectName, $_.EventTypeID, $_.FullFormattedMessage)
}
$f20.Controls.Add($f20_dg1)

$f20_b1 = New-Object System.Windows.Forms.Button 
$f20_b1.Size = New-Object System.Drawing.Size(100,30)
$f20_b1.Location = New-Object System.Drawing.Size(20,605) 
$f20_b1.Text = "Close" 
$f20_b1.Add_Click({$f20.Close(); $f20.Dispose()})
$f20.Controls.Add($f20_b1)

$f20_b2 = New-Object System.Windows.Forms.Button 
$f20_b2.Size = New-Object System.Drawing.Size(100,30)
$f20_b2.Location = New-Object System.Drawing.Size(125,605) 
$f20_b2.Text = "Export-CSV" 
$f20_b2.Add_Click({ExportCSV $actualreport})
$f20.Controls.Add($f20_b2)

$f20.ShowDialog()
}
############## Host Storage Error Events - END

############## NMP Configuration: List SATP - BEGIN
function f21_create([String] $global:shost){

$f21 = New-Object system.Windows.Forms.Form 
$f21.Width = 1150
$f21.Height = 700 
$f21.MaximizeBox = $false 
$f21.StartPosition = "CenterScreen" 
$f21.FormBorderStyle = 'Fixed3D' 
$f21.Text = "$global:shost | NMP Configuration: List SATP"
$f21.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f21_l1 = New-Object System.Windows.Forms.Label 
$f21_l1.Text = ">>> NMP Configuration: List SATP >>> Current Selection: >>> $global:shost "
$f21_l1.Size = New-Object System.Drawing.Size(900,20)
$f21_l1.Location = New-Object System.Drawing.Size(20,20) 
$f21.Controls.Add($f21_l1)

$f21_dg1 = New-Object System.Windows.Forms.DataGridView
$f21_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f21_dg1.Location = New-Object System.Drawing.Size(20,50)
$f21_dg1.ColumnCount = 3
$f21_dg1.ColumnHeadersVisible = $true
$f21_dg1.Columns[0].Name = "Name"
$f21_dg1.Columns[1].Name = "DefaultPSP"
$f21_dg1.Columns[2].Name = "Description"

$actualreport=NMPSATPList $global:shost
$actualreport | % {
$f21_dg1.Rows.Add($_.Name, $_.DefaultPSP, $_.Description)
}
$f21.Controls.Add($f21_dg1)

$f21_b1 = New-Object System.Windows.Forms.Button 
$f21_b1.Size = New-Object System.Drawing.Size(100,30)
$f21_b1.Location = New-Object System.Drawing.Size(20,605) 
$f21_b1.Text = "Close" 
$f21_b1.Add_Click({$f21.Close(); $f21.Dispose()})
$f21.Controls.Add($f21_b1)

$f21_b2 = New-Object System.Windows.Forms.Button 
$f21_b2.Size = New-Object System.Drawing.Size(100,30)
$f21_b2.Location = New-Object System.Drawing.Size(125,605) 
$f21_b2.Text = "Export-CSV" 
$f21_b2.Add_Click({ExportCSV $actualreport})
$f21.Controls.Add($f21_b2)

$f21.ShowDialog()
}
############## NMP Configuration: List SATP - END

############## NMP Configuration: List Rules SATP - BEGIN
function f22_create([String] $global:shost){

$f22 = New-Object system.Windows.Forms.Form 
$f22.Width = 1150
$f22.Height = 700 
$f22.MaximizeBox = $false 
$f22.StartPosition = "CenterScreen" 
$f22.FormBorderStyle = 'Fixed3D' 
$f22.Text = "$global:shost | NMP Configuration: List SATP Rules"
$f22.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f22_l1 = New-Object System.Windows.Forms.Label 
$f22_l1.Text = ">>> NMP Configuration: List SATP Rules >>> Current Selection: >>> $global:shost "
$f22_l1.Size = New-Object System.Drawing.Size(900,20)
$f22_l1.Location = New-Object System.Drawing.Size(20,20) 
$f22.Controls.Add($f22_l1)

$f22_dg1 = New-Object System.Windows.Forms.DataGridView
$f22_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f22_dg1.Location = New-Object System.Drawing.Size(20,50)
$f22_dg1.ColumnCount = 12
$f22_dg1.ColumnHeadersVisible = $true
$f22_dg1.Columns[0].Name = "Name"
$f22_dg1.Columns[1].Name = "DefaultPSP"
$f22_dg1.Columns[2].Name = "ClaimOptions"
$f22_dg1.Columns[3].Name = "Description"
$f22_dg1.Columns[4].Name = "Device"
$f22_dg1.Columns[5].Name = "Driver"
$f22_dg1.Columns[6].Name = "Model"
$f22_dg1.Columns[7].Name = "Options"
$f22_dg1.Columns[8].Name = "PSPOptions"
$f22_dg1.Columns[9].Name = "RuleGroup"
$f22_dg1.Columns[10].Name = "Transport"
$f22_dg1.Columns[11].Name = "Vendor"

$actualreport=NMPSATPRuleList $global:shost
$actualreport | % {
$f22_dg1.Rows.Add($_.Name, $_.DefaultPSP, $_.ClaimOptions, $_.Description, $_.Device, $_.Driver, $_.Model, $_.Options, $_.PSPOptions, $_.RuleGroup, $_.Transport, $_.Vendor)
}
$f22.Controls.Add($f22_dg1)

$f22_b1 = New-Object System.Windows.Forms.Button 
$f22_b1.Size = New-Object System.Drawing.Size(100,30)
$f22_b1.Location = New-Object System.Drawing.Size(20,605) 
$f22_b1.Text = "Close" 
$f22_b1.Add_Click({$f22.Close(); $f22.Dispose()})
$f22.Controls.Add($f22_b1)

$f22_b2 = New-Object System.Windows.Forms.Button 
$f22_b2.Size = New-Object System.Drawing.Size(100,30)
$f22_b2.Location = New-Object System.Drawing.Size(125,605) 
$f22_b2.Text = "Export-CSV" 
$f22_b2.Add_Click({ExportCSV $actualreport})
$f22.Controls.Add($f22_b2)

$f22.ShowDialog()
}
############## NMP Configuration: List Rules SATP - END

############## NMP Configuration: List Devices - BEGIN
function f23_create([String] $global:shost){

$f23 = New-Object system.Windows.Forms.Form 
$f23.Width = 1150
$f23.Height = 700 
$f23.MaximizeBox = $false 
$f23.StartPosition = "CenterScreen" 
$f23.FormBorderStyle = 'Fixed3D' 
$f23.Text = "$global:shost | NMP Configuration: List Devices"
$f23.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f23_l1 = New-Object System.Windows.Forms.Label 
$f23_l1.Text = ">>> NMP Configuration: List Devices >>> Current Selection: >>> $global:shost "
$f23_l1.Size = New-Object System.Drawing.Size(900,20)
$f23_l1.Location = New-Object System.Drawing.Size(20,20) 
$f23.Controls.Add($f23_l1)

$f23_dg1 = New-Object System.Windows.Forms.DataGridView
$f23_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f23_dg1.Location = New-Object System.Drawing.Size(20,50)
$f23_dg1.ColumnCount = 11
$f23_dg1.ColumnHeadersVisible = $true
$f23_dg1.Columns[0].Name = "Device"
$f23_dg1.Columns[1].Name = "DeviceDisplayName"
$f23_dg1.Columns[2].Name = "IsBootUSBDevice"
$f23_dg1.Columns[3].Name = "IsLocalSASDevice"
$f23_dg1.Columns[4].Name = "IsUSB"
$f23_dg1.Columns[5].Name = "PathSelectionPolicy"
$f23_dg1.Columns[6].Name = "PathSelectionPolicyDeviceConfig"
$f23_dg1.Columns[7].Name = "PathSelectionPolicyDeviceCustomConfig"
$f23_dg1.Columns[8].Name = "StorageArrayType"
$f23_dg1.Columns[9].Name = "StorageArrayTypeDeviceConfig"
$f23_dg1.Columns[10].Name = "WorkingPaths"

$actualreport=NMPDeviceFullList $global:shost
$actualreport | % {
$f23_dg1.Rows.Add($_.Device, $_.DeviceDisplayName, $_.IsBootUSBDevice, $_.IsLocalSASDevice, $_.IsUSB, $_.PathSelectionPolicy, $_.PathSelectionPolicyDeviceConfig, $_.PathSelectionPolicyDeviceCustomConfig, $_.StorageArrayType, $_.StorageArrayTypeDeviceConfig, $_.WorkingPaths)
}
$f23.Controls.Add($f23_dg1)

$f23_b1 = New-Object System.Windows.Forms.Button 
$f23_b1.Size = New-Object System.Drawing.Size(100,30)
$f23_b1.Location = New-Object System.Drawing.Size(20,605) 
$f23_b1.Text = "Close" 
$f23_b1.Add_Click({$f23.Close(); $f23.Dispose()})
$f23.Controls.Add($f23_b1)

$f23_b2 = New-Object System.Windows.Forms.Button 
$f23_b2.Size = New-Object System.Drawing.Size(100,30)
$f23_b2.Location = New-Object System.Drawing.Size(125,605) 
$f23_b2.Text = "Export-CSV" 
$f23_b2.Add_Click({ExportCSV $actualreport})
$f23.Controls.Add($f23_b2)

$f23.ShowDialog()
}
############## NMP Configuration: List Devices - END

############## StorageCoreDevices - BEGIN
function f24_create([String] $global:shost){

$f24 = New-Object system.Windows.Forms.Form 
$f24.Width = 1150
$f24.Height = 700 
$f24.MaximizeBox = $false 
$f24.StartPosition = "CenterScreen" 
$f24.FormBorderStyle = 'Fixed3D' 
$f24.Text = "$global:shost | Storage Core Device Configuration "
$f24.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f24_l1 = New-Object System.Windows.Forms.Label 
$f24_l1.Text = ">>> Storage Core Device Configuration >>> Current Selection: >>> $global:shost "
$f24_l1.Size = New-Object System.Drawing.Size(900,20)
$f24_l1.Location = New-Object System.Drawing.Size(20,20) 
$f24.Controls.Add($f24_l1)

$f24_dg1 = New-Object System.Windows.Forms.DataGridView
$f24_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f24_dg1.Location = New-Object System.Drawing.Size(20,50)
$f24_dg1.ColumnCount = 32
$f24_dg1.ColumnHeadersVisible = $true
$f24_dg1.Columns[0].Name = "Device"
$f24_dg1.Columns[1].Name = "DisplayName"
$f24_dg1.Columns[2].Name = "DeviceMaxQueueDepth"
$f24_dg1.Columns[3].Name = "DeviceType"
$f24_dg1.Columns[4].Name = "DevfsPath"
$f24_dg1.Columns[5].Name = "HasSettableDisplayName"
$f24_dg1.Columns[6].Name = "IsBootDevice"
$f24_dg1.Columns[7].Name = "IsBootUSBDevice"
$f24_dg1.Columns[8].Name = "IsLocal"
$f24_dg1.Columns[9].Name = "IsLocalSASDevice"
$f24_dg1.Columns[10].Name = "IsOffline"
$f24_dg1.Columns[11].Name = "IsPerenniallyReserved "
$f24_dg1.Columns[12].Name = "IsPseudo"
$f24_dg1.Columns[13].Name = "IsRDMCapable"
$f24_dg1.Columns[14].Name = "IsRemovable"
$f24_dg1.Columns[15].Name = "IsSAS"
$f24_dg1.Columns[16].Name = "IsSSD"
$f24_dg1.Columns[17].Name = "IsSharedClusterwide"
$f24_dg1.Columns[18].Name = "IsUSB"
$f24_dg1.Columns[19].Name = "Model"
$f24_dg1.Columns[20].Name = "MultiPathPlugin"
$f24_dg1.Columns[21].Name = "NoofoutstandingIOswithcompetingworlds"
$f24_dg1.Columns[22].Name = "OtherUIDs"
$f24_dg1.Columns[23].Name = "QueueFullSampleSize"
$f24_dg1.Columns[24].Name = "QueueFullThreshold"
$f24_dg1.Columns[25].Name = "Revision"
$f24_dg1.Columns[26].Name = "SCSILevel"
$f24_dg1.Columns[27].Name = "Size"
$f24_dg1.Columns[28].Name = "Status"
$f24_dg1.Columns[29].Name = "ThinProvisioningStatus"
$f24_dg1.Columns[30].Name = "VAAIStatus"
$f24_dg1.Columns[31].Name = "Vendor"

$actualreport=StorageCoreDevices $global:shost
$actualreport | % {
$f24_dg1.Rows.Add($_.Device, $_.DisplayName, $_.DeviceMaxQueueDepth, $_.DeviceType, $_.DevfsPath, $_.HasSettableDisplayName, $_.IsBootDevice, $_.IsBootUSBDevice, $_.IsLocal, $_.IsLocalSASDevice, $_.IsOffline, $_.IsPerenniallyReserved, $_.IsPseudo, $_.IsRDMCapable, $_.IsRemovable, $_.IsSAS, $_.IsSSD, $_.IsSharedClusterwide, $_.IsUSB, $_.Model, $_.MultiPathPlugin, $_.NoofoutstandingIOswithcompetingworlds, $_.OtherUIDs, $_.QueueFullSampleSize, $_.QueueFullThreshold, $_.Revision, $_.SCSILevel, $_.Size, $_.Status, $_.ThinProvisioningStatus, $_.VAAIStatus, $_.Vendor)
}
$f24.Controls.Add($f24_dg1)

$f24_b1 = New-Object System.Windows.Forms.Button 
$f24_b1.Size = New-Object System.Drawing.Size(100,30)
$f24_b1.Location = New-Object System.Drawing.Size(20,605) 
$f24_b1.Text = "Close" 
$f24_b1.Add_Click({$f24.Close(); $f24.Dispose()})
$f24.Controls.Add($f24_b1)

$f24_b2 = New-Object System.Windows.Forms.Button 
$f24_b2.Size = New-Object System.Drawing.Size(100,30)
$f24_b2.Location = New-Object System.Drawing.Size(125,605) 
$f24_b2.Text = "Export-CSV" 
$f24_b2.Add_Click({ExportCSV $actualreport})
$f24.Controls.Add($f24_b2)

$f24.ShowDialog()
}
############## StorageCoreDevices - END

############## Obtain Storage Adapters - BEGIN
function f25_create([String] $global:shost){

$f25 = New-Object system.Windows.Forms.Form 
$f25.Width = 1150
$f25.Height = 700 
$f25.MaximizeBox = $false 
$f25.StartPosition = "CenterScreen" 
$f25.FormBorderStyle = 'Fixed3D' 
$f25.Text = "$global:shost | Obtain Storage Adapters "
$f25.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f25_l1 = New-Object System.Windows.Forms.Label 
$f25_l1.Text = ">>> Obtain Storage Adapters >>> Current Selection: >>> $global:shost "
$f25_l1.Size = New-Object System.Drawing.Size(900,20)
$f25_l1.Location = New-Object System.Drawing.Size(20,20) 
$f25.Controls.Add($f25_l1)

$f25_dg1 = New-Object System.Windows.Forms.DataGridView
$f25_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f25_dg1.Location = New-Object System.Drawing.Size(20,50)
$f25_dg1.ColumnCount = 5
$f25_dg1.ColumnHeadersVisible = $true
$f25_dg1.Columns[0].Name = "HBAName"
$f25_dg1.Columns[1].Name = "Description"
$f25_dg1.Columns[2].Name = "Driver"
$f25_dg1.Columns[3].Name = "LinkState"
$f25_dg1.Columns[4].Name = "UID"

$actualreport=storagecoreadapters $global:shost
$actualreport | % {
$f25_dg1.Rows.Add($_.HBAName, $_.Description, $_.Driver, $_.LinkState, $_.UID)
}
$f25.Controls.Add($f25_dg1)

$f25_b1 = New-Object System.Windows.Forms.Button 
$f25_b1.Size = New-Object System.Drawing.Size(100,30)
$f25_b1.Location = New-Object System.Drawing.Size(20,605) 
$f25_b1.Text = "Close" 
$f25_b1.Add_Click({$f25.Close(); $f25.Dispose()})
$f25.Controls.Add($f25_b1)

$f25_b2 = New-Object System.Windows.Forms.Button 
$f25_b2.Size = New-Object System.Drawing.Size(100,30)
$f25_b2.Location = New-Object System.Drawing.Size(125,605) 
$f25_b2.Text = "Export-CSV" 
$f25_b2.Add_Click({ExportCSV $actualreport})
$f25.Controls.Add($f25_b2)

$f25.ShowDialog()
}
############## Obtain Storage Adapters - END

############## Output HostConfiguration 2-Column - BEGIN
function f26_create([String] $global:scluster, [String] $global:shost){

$f26 = New-Object system.Windows.Forms.Form 
$f26.Width = 1150
$f26.Height = 700 
$f26.MaximizeBox = $false 
$f26.StartPosition = "CenterScreen" 
$f26.FormBorderStyle = 'Fixed3D' 
$f26.Text = "$global:scluster | $global:shost | Host Configuration "
$f26.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f26_l1 = New-Object System.Windows.Forms.Label 
$f26_l1.Text = ">>> Host Configuration >>> Current Selection: >>> $global:scluster >> $global:shost "
$f26_l1.Size = New-Object System.Drawing.Size(900,20)
$f26_l1.Location = New-Object System.Drawing.Size(20,20) 
$f26.Controls.Add($f26_l1)

$f26_dg1 = New-Object System.Windows.Forms.DataGridView
$f26_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f26_dg1.Location = New-Object System.Drawing.Size(20,50)
$f26_dg1.ColumnCount = 2
$f26_dg1.ColumnHeadersVisible = $true
$f26_dg1.Columns[0].Name = "Description"
$f26_dg1.Columns[1].Name = "Current Value"

$actualreport=HostConfiguration $global:scluster $global:shost
$properties= Get-Member -InputObject $actualreport -MemberType NoteProperty

$properties | % {
$propertyvalue = $actualreport | select-object -expandproperty $_.Name
$f26_dg1.Rows.Add($_.Name, $propertyvalue)
}


$f26.Controls.Add($f26_dg1)

$f26_b1 = New-Object System.Windows.Forms.Button 
$f26_b1.Size = New-Object System.Drawing.Size(100,30)
$f26_b1.Location = New-Object System.Drawing.Size(20,605) 
$f26_b1.Text = "Close" 
$f26_b1.Add_Click({$f26.Close(); $f26.Dispose()})
$f26.Controls.Add($f26_b1)

$f26_b2 = New-Object System.Windows.Forms.Button 
$f26_b2.Size = New-Object System.Drawing.Size(100,30)
$f26_b2.Location = New-Object System.Drawing.Size(125,605) 
$f26_b2.Text = "Export-CSV" 
$f26_b2.Add_Click({ExportCSV $actualreport})
$f26.Controls.Add($f26_b2)

$f26.ShowDialog()
}
############## Output ClusterConfiguration 2-Column - END

############## Output Advanced Settings 2-Column - BEGIN
function f27_create([String] $global:scluster, [String] $global:shost){

$f27 = New-Object system.Windows.Forms.Form 
$f27.Width = 1150
$f27.Height = 700 
$f27.MaximizeBox = $false 
$f27.StartPosition = "CenterScreen" 
$f27.FormBorderStyle = 'Fixed3D' 
$f27.Text = "$global:scluster | $global:shost | Advanced Settings "
$f27.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f27_l1 = New-Object System.Windows.Forms.Label 
$f27_l1.Text = ">>> Advanced Settings >>> Current Selection: >>> $global:scluster >> $global:shost "
$f27_l1.Size = New-Object System.Drawing.Size(900,20)
$f27_l1.Location = New-Object System.Drawing.Size(20,20) 
$f27.Controls.Add($f27_l1)

$f27_dg1 = New-Object System.Windows.Forms.DataGridView
$f27_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f27_dg1.Location = New-Object System.Drawing.Size(20,50)
$f27_dg1.ColumnCount = 2
$f27_dg1.ColumnHeadersVisible = $true
$f27_dg1.Columns[0].Name = "Name"
$f27_dg1.Columns[1].Name = "Value"

$actualreport=HostAdvancedSettings $global:scluster $global:shost

$actualreport | % {
$f27_dg1.Rows.Add($_.Name, $_.Value)
}


$f27.Controls.Add($f27_dg1)

$f27_b1 = New-Object System.Windows.Forms.Button 
$f27_b1.Size = New-Object System.Drawing.Size(100,30)
$f27_b1.Location = New-Object System.Drawing.Size(20,605) 
$f27_b1.Text = "Close" 
$f27_b1.Add_Click({$f27.Close(); $f27.Dispose()})
$f27.Controls.Add($f27_b1)

$f27_b2 = New-Object System.Windows.Forms.Button 
$f27_b2.Size = New-Object System.Drawing.Size(100,30)
$f27_b2.Location = New-Object System.Drawing.Size(125,605) 
$f27_b2.Text = "Export-CSV" 
$f27_b2.Add_Click({ExportCSV $actualreport})
$f27.Controls.Add($f27_b2)

$f27.ShowDialog()
}
############## Output Advanced Settings 2-Column - END

############## Bulk Operations Form - BEGIN
function f28_create(){

$F28 = New-Object system.Windows.Forms.Form 
$F28.Width = 400
$F28.Height = 350 
$F28.MaximizeBox = $false 
$F28.StartPosition = "CenterScreen" 
$F28.FormBorderStyle = 'Fixed3D' 
$F28.Text = "Bulk Operations"
$F28.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$F28_l1 = New-Object System.Windows.Forms.Label 
$F28_l1.Text = "Bulk Operations | Select an option:"
$F28_l1.Size = New-Object System.Drawing.Size(1100,20)
$F28_l1.Location = New-Object System.Drawing.Size(20,20) 
$F28.Controls.Add($F28_l1)

$F28_lb1 = New-Object System.Windows.Forms.Listbox 
$F28_lb1.Size = New-Object System.Drawing.Size(300,200)
$F28_lb1.Location = New-Object System.Drawing.Size(20,50) 
$F28_lb1.Items.Add('Create vSwitches & NIC Bindings (Bulk)')
$F28_lb1.Items.Add('Create VLAN/PortGroups (Bulk)')
$F28_lb1.Items.Add('Create NMP SATP Rules (Bulk)')
$F28_lb1.Items.Add('Delete NMP SATP Rules (Bulk)')
$F28_lb1.Items.Add('Create VLAN/PortGroups from CSV file (Bulk)')
$F28_lb1.Items.Add('Create VMKernel Adapter from CSV file (Bulk)')
$F28_lb1.Items.Add('Configure NTP Settings')
$F28_lb1.Items.Add('Configure DNS, DomainName & SearchDomain')
$F28_lb1.Items.Add('Join ESX Host to AD Domain')
$F28_lb1.Items.Add('Disable ATS Heartbeat for VMFS5')
$F28_lb1.Items.Add('Enable/Configure Software iSCSI Adapters(*)')

$F28.Controls.Add($F28_lb1)

$F28_b1 = New-Object System.Windows.Forms.Button 
$F28_b1.Text = "Confirm"
$F28_b1.Size = New-Object System.Drawing.Size(100,25)
$F28_b1.Location = New-Object System.Drawing.Size(20,255) 
$F28_b1.Add_Click({

if($F28_lb1.SelectedItem -eq "Create vSwitches & NIC Bindings (Bulk)"){f32_create}
if($F28_lb1.SelectedItem -eq "Create VLAN/PortGroups (Bulk)"){f33_create}
if($F28_lb1.SelectedItem -eq "Create NMP SATP Rules (Bulk)"){f34_create}
if($F28_lb1.SelectedItem -eq "Delete NMP SATP Rules (Bulk)"){f35_create}
if($F28_lb1.SelectedItem -eq "Create VLAN/PortGroups from CSV file (Bulk)"){AddvPortGroupbulkoperationsCSV $global:vcenter $global:scluster $global:bulkcollection}
if($F28_lb1.SelectedItem -eq "Create VMKernel Adapter from CSV file (Bulk)"){AddVMkernelbulkoperationsCSV $global:vcenter $global:scluster $global:bulkcollection}
if($F28_lb1.SelectedItem -eq "Join ESX Host to AD Domain"){f38_create}
if($F28_lb1.SelectedItem -eq "Configure NTP Settings"){f39_create}
if($F28_lb1.SelectedItem -eq "Configure DNS, DomainName & SearchDomain"){f40_create}
if($F28_lb1.SelectedItem -eq "Disable ATS Heartbeat for VMFS5"){adminesxdisableatsheartbeat $global:vcenter $global:scluster $global:bulkcollection}
if($F28_lb1.SelectedItem -eq "Enable/Configure Software iSCSI Adapters"){adminesxiscsiadapter $global:vcenter $global:scluster $global:bulkcollection}

})
$F28_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$F28.AcceptButton = $F28_b1
$F28.Controls.Add($F28_b1)

$F28_b2 = New-Object System.Windows.Forms.Button 
$F28_b2.Text = "Cancel"
$F28_b2.Size = New-Object System.Drawing.Size(100,25)
$F28_b2.Location = New-Object System.Drawing.Size(125,255) 
$F28_b2.Add_Click({})
$F28_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$F28.CancelButton = $F28_b2
$F28.Controls.Add($F28_b2)

$F28.ShowDialog()
}
############## Bulk Operations Form - END

############## Maintenance Operations Form - BEGIN
function f29_create(){

$f29 = New-Object system.Windows.Forms.Form 
$f29.Width = 400
$f29.Height = 350 
$f29.MaximizeBox = $false 
$f29.StartPosition = "CenterScreen" 
$f29.FormBorderStyle = 'Fixed3D' 
$f29.Text = "Maintenance Operations"
$f29.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f29_l1 = New-Object System.Windows.Forms.Label 
$f29_l1.Text = "Maintenance Operations | Select an option:"
$f29_l1.Size = New-Object System.Drawing.Size(1100,20)
$f29_l1.Location = New-Object System.Drawing.Size(20,20) 
$f29.Controls.Add($f29_l1)

$f29_lb1 = New-Object System.Windows.Forms.Listbox 
$f29_lb1.Size = New-Object System.Drawing.Size(300,200)
$f29_lb1.Location = New-Object System.Drawing.Size(20,50)
$f29_lb1.Items.Add('Configure Syslog/ScratchLog Locations')
$F29_lb1.Items.Add('Upload VIB/ZIP file to Shared Storage')
$F29_lb1.Items.Add('Install VIB from Shared Storage')
$F29_lb1.Items.Add('Update Bundle from Shared Storage')
$F29_lb1.Items.Add('Remove VIB from ESXi')
$F29_lb1.Items.Add('VIB Inventory List')
$f29_lb1.Items.Add('Modify Storage Core Device Parameters')
$f29_lb1.Items.Add('NMP PSP Device Config (VMW_SATP_ALUA)')
$f29_lb1.Items.Add('Change Host Advance Settings')
$f29_lb1.Items.Add('Modify HBA Driver Module Parameters(*)')
$F29_lb1.Items.Add('Enter Maintenance Mode(*)')
$F29_lb1.Items.Add('Exit Maintenance Mode(*)')

$f29.Controls.Add($f29_lb1)

$f29_b1 = New-Object System.Windows.Forms.Button 
$f29_b1.Text = "Confirm"
$f29_b1.Size = New-Object System.Drawing.Size(100,25)
$f29_b1.Location = New-Object System.Drawing.Size(20,255) 
$f29_b1.Add_Click({

if($f29_lb1.SelectedItem -eq "Configure Syslog/ScratchLog Locations"){f41_create}
if($f29_lb1.SelectedItem -eq "Upload VIB/ZIP file to Shared Storage"){f42_create}
if($f29_lb1.SelectedItem -eq "Install VIB from Shared Storage"){f43_create}
if($f29_lb1.SelectedItem -eq "Update Bundle from Shared Storage"){f44_create}
if($f29_lb1.SelectedItem -eq "Remove VIB from ESXi"){f58_create}
if($f29_lb1.SelectedItem -eq "VIB Inventory List"){f45_create}
if($f29_lb1.SelectedItem -eq "NMP PSP Device Config (VMW_SATP_ALUA)"){f50_create}
if($f29_lb1.SelectedItem -eq "Modify Storage Core Device Parameters"){f48_create}
if($f29_lb1.SelectedItem -eq "Change Host Advance Settings"){f51_create}
if($f29_lb1.SelectedItem -eq "Modify HBA Driver Module Parameters"){}

})
$f29_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f29.AcceptButton = $f29_b1
$f29.Controls.Add($f29_b1)

$f29_b2 = New-Object System.Windows.Forms.Button 
$f29_b2.Text = "Cancel"
$f29_b2.Size = New-Object System.Drawing.Size(100,25)
$f29_b2.Location = New-Object System.Drawing.Size(125,255) 
$f29_b2.Add_Click({})
$f29_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f29.CancelButton = $f29_b2
$f29.Controls.Add($f29_b2)

$f29.ShowDialog()
}
############## Maintenance Operations Form - END

############## Output Driver Module Information 2-Column - BEGIN
function f30_create([String] $global:scluster, [String] $global:shost){

$f30 = New-Object system.Windows.Forms.Form 
$f30.Width = 1150
$f30.Height = 700 
$f30.MaximizeBox = $false 
$f30.StartPosition = "CenterScreen" 
$f30.FormBorderStyle = 'Fixed3D' 
$f30.Text = "$global:scluster | $global:shost | Driver Module Information "
$f30.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f30_l1 = New-Object System.Windows.Forms.Label 
$f30_l1.Text = ">>> Driver Module Information >>> Current Selection: >>> $global:scluster >> $global:shost "
$f30_l1.Size = New-Object System.Drawing.Size(900,20)
$f30_l1.Location = New-Object System.Drawing.Size(20,20) 
$f30.Controls.Add($f30_l1)


$f30_b1 = New-Object System.Windows.Forms.Button 
$f30_b1.Size = New-Object System.Drawing.Size(100,30)
$f30_b1.Location = New-Object System.Drawing.Size(20,605) 
$f30_b1.Text = "Close" 
$f30_b1.Add_Click({$f30.Close(); $f30.Dispose()})
$f30.Controls.Add($f30_b1)

$f30_b2 = New-Object System.Windows.Forms.Button 
$f30_b2.Size = New-Object System.Drawing.Size(100,30)
$f30_b2.Location = New-Object System.Drawing.Size(125,605) 
$f30_b2.Text = "Export-CSV" 
$f30_b2.Add_Click({ExportCSV $actualreport})
$f30.Controls.Add($f30_b2)

$f30_tb1 = New-Object System.Windows.Forms.Textbox 
$f30_tb1.Size = New-Object System.Drawing.Size(200,30)
$f30_tb1.Location = New-Object System.Drawing.Size(400,608) 
$f30.Controls.Add($f30_tb1)

$f30_b3 = New-Object System.Windows.Forms.Button 
$f30_b3.Size = New-Object System.Drawing.Size(100,30)
$f30_b3.Location = New-Object System.Drawing.Size(605,605) 
$f30_b3.Text = "Lookup" 
$f30_b3.Add_Click({

$f30_dg1 = New-Object System.Windows.Forms.DataGridView
$f30_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f30_dg1.Location = New-Object System.Drawing.Size(20,50)
$f30_dg1.ColumnCount = 2
$f30_dg1.ColumnHeadersVisible = $true
$f30_dg1.Columns[0].Name = "Name"
$f30_dg1.Columns[1].Name = "Value"

$actualreport=DriverModuleInformation $global:shost $f30_tb1.Text
$properties= Get-Member -InputObject $actualreport -MemberType NoteProperty

$properties | % {
$propertyvalue = $actualreport | select-object -expandproperty $_.Name
$f30_dg1.Rows.Add($_.Name, $propertyvalue)
}

$f30.Controls.Add($f30_dg1)

})

$f30.Controls.Add($f30_b3)


$f30.ShowDialog()
}
############## Output Driver Module Information 2-Column - END

############## Output Driver Module Parameters 2-Column - BEGIN
function f31_create([String] $global:scluster, [String] $global:shost){

$f31 = New-Object system.Windows.Forms.Form 
$f31.Width = 1150
$f31.Height = 700 
$f31.MaximizeBox = $false 
$f31.StartPosition = "CenterScreen" 
$f31.FormBorderStyle = 'Fixed3D' 
$f31.Text = "$global:scluster | $global:shost | Driver Module Parameters "
$f31.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f31_l1 = New-Object System.Windows.Forms.Label 
$f31_l1.Text = ">>> Driver Module Parameters >>> Current Selection: >>> $global:scluster >> $global:shost "
$f31_l1.Size = New-Object System.Drawing.Size(900,20)
$f31_l1.Location = New-Object System.Drawing.Size(20,20) 
$f31.Controls.Add($f31_l1)


$f31_b1 = New-Object System.Windows.Forms.Button 
$f31_b1.Size = New-Object System.Drawing.Size(100,30)
$f31_b1.Location = New-Object System.Drawing.Size(20,605) 
$f31_b1.Text = "Close" 
$f31_b1.Add_Click({$f31.Close(); $f31.Dispose()})
$f31.Controls.Add($f31_b1)

$f31_b2 = New-Object System.Windows.Forms.Button 
$f31_b2.Size = New-Object System.Drawing.Size(100,30)
$f31_b2.Location = New-Object System.Drawing.Size(125,605) 
$f31_b2.Text = "Export-CSV" 
$f31_b2.Add_Click({ExportCSV $actualreport})
$f31.Controls.Add($f31_b2)

$f31_tb1 = New-Object System.Windows.Forms.Textbox 
$f31_tb1.Size = New-Object System.Drawing.Size(200,30)
$f31_tb1.Location = New-Object System.Drawing.Size(400,608) 
$f31.Controls.Add($f31_tb1)

$f31_b3 = New-Object System.Windows.Forms.Button 
$f31_b3.Size = New-Object System.Drawing.Size(100,30)
$f31_b3.Location = New-Object System.Drawing.Size(605,605) 
$f31_b3.Text = "Lookup" 
$f31_b3.Add_Click({

$f31_dg1 = New-Object System.Windows.Forms.DataGridView
$f31_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f31_dg1.Location = New-Object System.Drawing.Size(20,50)
$f31_dg1.ColumnCount = 3
$f31_dg1.ColumnHeadersVisible = $true
$f31_dg1.Columns[0].Name = "Name"
$f31_dg1.Columns[1].Name = "Value"
$f31_dg1.Columns[2].Name = "Description"

$actualreport=DriverModuleParameters $global:shost $f31_tb1.Text

$actualreport | % {
$f31_dg1.Rows.Add($_.Name, $_.Value, $_.Description)
}

$f31.Controls.Add($f31_dg1)

})

$f31.Controls.Add($f31_b3)


$f31.ShowDialog()
}
############## Output Driver Module Parameters 2-Column - END

############## AddvSwitchbulkoperations Form - BEGIN
function f32_create(){

$f32 = New-Object system.Windows.Forms.Form 
$f32.Width = 400
$f32.Height = 350 
$f32.MaximizeBox = $false 
$f32.StartPosition = "CenterScreen" 
$f32.FormBorderStyle = 'Fixed3D' 
$f32.Text = "Create vSwitches & NIC Bindings (Bulk)"
$f32.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f32_l1 = New-Object System.Windows.Forms.Label 
$f32_l1.Text = "Enter the name of the Virtual Switch (ex. vSwitchX):"
$f32_l1.Size = New-Object System.Drawing.Size(1100,20)
$f32_l1.Location = New-Object System.Drawing.Size(20,20) 
$f32.Controls.Add($f32_l1)

$f32_tb1 = New-Object System.Windows.Forms.Textbox 
$f32_tb1.Size = New-Object System.Drawing.Size(200,30)
$f32_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f32.Controls.Add($f32_tb1)

$f32_l2 = New-Object System.Windows.Forms.Label 
$f32_l2.Text = "Type ACTIVE vmnicx (separate with comma):"
$f32_l2.Size = New-Object System.Drawing.Size(1100,20)
$f32_l2.Location = New-Object System.Drawing.Size(20,70) 
$f32.Controls.Add($f32_l2)

$f32_tb2 = New-Object System.Windows.Forms.Textbox 
$f32_tb2.Size = New-Object System.Drawing.Size(200,30)
$f32_tb2.Location = New-Object System.Drawing.Size(20,90) 
$f32.Controls.Add($f32_tb2)

$f32_l3 = New-Object System.Windows.Forms.Label 
$f32_l3.Text = "Type STANDBY vmnicx (separate with comma):"
$f32_l3.Size = New-Object System.Drawing.Size(1100,20)
$f32_l3.Location = New-Object System.Drawing.Size(20,120) 
$f32.Controls.Add($f32_l3)

$f32_tb3 = New-Object System.Windows.Forms.Textbox 
$f32_tb3.Size = New-Object System.Drawing.Size(200,30)
$f32_tb3.Location = New-Object System.Drawing.Size(20,140) 
$f32.Controls.Add($f32_tb3)


$f32_b1 = New-Object System.Windows.Forms.Button 
$f32_b1.Text = "Confirm"
$f32_b1.Size = New-Object System.Drawing.Size(100,25)
$f32_b1.Location = New-Object System.Drawing.Size(20,255) 
$f32_b1.Add_Click({AddvSwitchbulkoperations $global:vcenter $global:scluster $global:bulkcollection $f32_tb1.Text $f32_tb2.Text $f32_tb3.Text})
$f32_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f32.AcceptButton = $f32_b1
$f32.Controls.Add($f32_b1)

$f32_b2 = New-Object System.Windows.Forms.Button 
$f32_b2.Text = "Cancel"
$f32_b2.Size = New-Object System.Drawing.Size(100,25)
$f32_b2.Location = New-Object System.Drawing.Size(125,255) 
$f32_b2.Add_Click({})
$f32_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f32.CancelButton = $f32_b2
$f32.Controls.Add($f32_b2)

$f32.ShowDialog()
}
############## AddvSwitchbulkoperations Form - END

############## AddvPortGroupbulkoperations Form - BEGIN
function f33_create(){

$f33 = New-Object system.Windows.Forms.Form 
$f33.Width = 400
$f33.Height = 350
$f33.MaximizeBox = $false 
$f33.StartPosition = "CenterScreen" 
$f33.FormBorderStyle = 'Fixed3D' 
$f33.Text = "Create VLAN/PortGroups (Bulk)"
$f33.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f33_l1 = New-Object System.Windows.Forms.Label 
$f33_l1.Text = "Enter the name of the Virtual Switch (ex. vSwitchX): "
$f33_l1.Size = New-Object System.Drawing.Size(1100,20)
$f33_l1.Location = New-Object System.Drawing.Size(20,20) 
$f33.Controls.Add($f33_l1)

$f33_tb1 = New-Object System.Windows.Forms.Textbox 
$f33_tb1.Size = New-Object System.Drawing.Size(200,30)
$f33_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f33.Controls.Add($f33_tb1)

$f33_l2 = New-Object System.Windows.Forms.Label 
$f33_l2.Text = "Enter the name of the vPortGroup (ex. 0304-VM-Servers): "
$f33_l2.Size = New-Object System.Drawing.Size(1100,20)
$f33_l2.Location = New-Object System.Drawing.Size(20,70) 
$f33.Controls.Add($f33_l2)

$f33_tb2 = New-Object System.Windows.Forms.Textbox 
$f33_tb2.Size = New-Object System.Drawing.Size(200,30)
$f33_tb2.Location = New-Object System.Drawing.Size(20,90) 
$f33.Controls.Add($f33_tb2)

$f33_l3 = New-Object System.Windows.Forms.Label 
$f33_l3.Text = "Enter the VLAN ID (ex. 304): "
$f33_l3.Size = New-Object System.Drawing.Size(1100,20)
$f33_l3.Location = New-Object System.Drawing.Size(20,120) 
$f33.Controls.Add($f33_l3)

$f33_tb3 = New-Object System.Windows.Forms.Textbox 
$f33_tb3.Size = New-Object System.Drawing.Size(200,30)
$f33_tb3.Location = New-Object System.Drawing.Size(20,140) 
$f33.Controls.Add($f33_tb3)

$f33_l4 = New-Object System.Windows.Forms.Label 
$f33_l4.Text = "Type ACTIVE vmnicx (separate with comma): "
$f33_l4.Size = New-Object System.Drawing.Size(1100,20)
$f33_l4.Location = New-Object System.Drawing.Size(20,170) 
$f33.Controls.Add($f33_l4)

$f33_tb4 = New-Object System.Windows.Forms.Textbox 
$f33_tb4.Size = New-Object System.Drawing.Size(200,30)
$f33_tb4.Location = New-Object System.Drawing.Size(20,190) 
$f33.Controls.Add($f33_tb4)

$f33_l5 = New-Object System.Windows.Forms.Label 
$f33_l5.Text = "Type STANDBY vmnicx (separate with comma): "
$f33_l5.Size = New-Object System.Drawing.Size(1100,20)
$f33_l5.Location = New-Object System.Drawing.Size(20,220) 
$f33.Controls.Add($f33_l5)

$f33_tb5 = New-Object System.Windows.Forms.Textbox 
$f33_tb5.Size = New-Object System.Drawing.Size(200,30)
$f33_tb5.Location = New-Object System.Drawing.Size(20,240) 
$f33.Controls.Add($f33_tb5)

$f33_b1 = New-Object System.Windows.Forms.Button 
$f33_b1.Text = "Confirm"
$f33_b1.Size = New-Object System.Drawing.Size(100,25)
$f33_b1.Location = New-Object System.Drawing.Size(20,275) 
$f33_b1.Add_Click({AddvPortGroupbulkoperations $global:vcenter $global:scluster $global:bulkcollection $f33_tb1.Text $f33_tb2.Text $f33_tb3.Text $f33_tb4.Text $f33_tb5.Text})
$f33_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f33.AcceptButton = $f33_b1
$f33.Controls.Add($f33_b1)

$f33_b2 = New-Object System.Windows.Forms.Button 
$f33_b2.Text = "Cancel"
$f33_b2.Size = New-Object System.Drawing.Size(100,25)
$f33_b2.Location = New-Object System.Drawing.Size(125,275) 
$f33_b2.Add_Click({})
$f33_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f33.CancelButton = $f33_b2
$f33.Controls.Add($f33_b2)

$f33.ShowDialog()
}
############## AddvPortGroupbulkoperations Form - END

############## AdminAddSATPRulesBulkOperations Form - BEGIN
function f34_create(){

$f34 = New-Object system.Windows.Forms.Form 
$f34.Width = 400
$f34.Height = 450
$f34.MaximizeBox = $false 
$f34.StartPosition = "CenterScreen" 
$f34.FormBorderStyle = 'Fixed3D' 
$f34.Text = "Create NMP SATP Rule (Bulk)"
$f34.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f34_l1 = New-Object System.Windows.Forms.Label 
$f34_l1.Text = "SATP Rule Name (Ex. VMW_SATP_ALUA):"
$f34_l1.Size = New-Object System.Drawing.Size(1100,20)
$f34_l1.Location = New-Object System.Drawing.Size(20,20) 
$f34.Controls.Add($f34_l1)

$f34_tb1 = New-Object System.Windows.Forms.Textbox 
$f34_tb1.Size = New-Object System.Drawing.Size(200,30)
$f34_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f34.Controls.Add($f34_tb1)

$f34_l2 = New-Object System.Windows.Forms.Label 
$f34_l2.Text = "Vendor (Ex. 3PARdata):"
$f34_l2.Size = New-Object System.Drawing.Size(1100,20)
$f34_l2.Location = New-Object System.Drawing.Size(20,70) 
$f34.Controls.Add($f34_l2)

$f34_tb2 = New-Object System.Windows.Forms.Textbox 
$f34_tb2.Size = New-Object System.Drawing.Size(200,30)
$f34_tb2.Location = New-Object System.Drawing.Size(20,90) 
$f34.Controls.Add($f34_tb2)

$f34_l3 = New-Object System.Windows.Forms.Label 
$f34_l3.Text = "ClaimOptions (Ex. tpgs_on):"
$f34_l3.Size = New-Object System.Drawing.Size(1100,20)
$f34_l3.Location = New-Object System.Drawing.Size(20,120) 
$f34.Controls.Add($f34_l3)

$f34_tb3 = New-Object System.Windows.Forms.Textbox 
$f34_tb3.Size = New-Object System.Drawing.Size(200,30)
$f34_tb3.Location = New-Object System.Drawing.Size(20,140) 
$f34.Controls.Add($f34_tb3)

$f34_l4 = New-Object System.Windows.Forms.Label 
$f34_l4.Text = "DefaultPSP (Ex. VMW_PSP_RR):"
$f34_l4.Size = New-Object System.Drawing.Size(1100,20)
$f34_l4.Location = New-Object System.Drawing.Size(20,170) 
$f34.Controls.Add($f34_l4)

$f34_tb4 = New-Object System.Windows.Forms.Textbox 
$f34_tb4.Size = New-Object System.Drawing.Size(200,30)
$f34_tb4.Location = New-Object System.Drawing.Size(20,190) 
$f34.Controls.Add($f34_tb4)

$f34_l5 = New-Object System.Windows.Forms.Label 
$f34_l5.Text = "PSPOptions (Ex. iops=1):"
$f34_l5.Size = New-Object System.Drawing.Size(1100,20)
$f34_l5.Location = New-Object System.Drawing.Size(20,220) 
$f34.Controls.Add($f34_l5)

$f34_tb5 = New-Object System.Windows.Forms.Textbox 
$f34_tb5.Size = New-Object System.Drawing.Size(200,30)
$f34_tb5.Location = New-Object System.Drawing.Size(20,240) 
$f34.Controls.Add($f34_tb5)

$f34_l6 = New-Object System.Windows.Forms.Label 
$f34_l6.Text = "Model (Ex. VV):"
$f34_l6.Size = New-Object System.Drawing.Size(1100,20)
$f34_l6.Location = New-Object System.Drawing.Size(20,270) 
$f34.Controls.Add($f34_l6)

$f34_tb6 = New-Object System.Windows.Forms.Textbox 
$f34_tb6.Size = New-Object System.Drawing.Size(200,30)
$f34_tb6.Location = New-Object System.Drawing.Size(20,290) 
$f34.Controls.Add($f34_tb6)

$f34_l7 = New-Object System.Windows.Forms.Label 
$f34_l7.Text = "Description (Ex. HPE 3PAR custom IOPS-RR Rule):"
$f34_l7.Size = New-Object System.Drawing.Size(1100,20)
$f34_l7.Location = New-Object System.Drawing.Size(20,320) 
$f34.Controls.Add($f34_l7)

$f34_tb7 = New-Object System.Windows.Forms.Textbox 
$f34_tb7.Size = New-Object System.Drawing.Size(200,30)
$f34_tb7.Location = New-Object System.Drawing.Size(20,340) 
$f34.Controls.Add($f34_tb7)

$f34_b1 = New-Object System.Windows.Forms.Button 
$f34_b1.Text = "Confirm"
$f34_b1.Size = New-Object System.Drawing.Size(100,25)
$f34_b1.Location = New-Object System.Drawing.Size(20,375) 
$f34_b1.Add_Click({AdminAddSATPRulesBulkOperations $global:vcenter $global:scluster $global:bulkcollection $f34_tb1.Text $f34_tb2.Text $f34_tb3.Text $f34_tb4.Text $f34_tb5.Text $f34_tb6.Text $f34_tb7.Text})
$f34_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f34.AcceptButton = $f34_b1
$f34.Controls.Add($f34_b1)

$f34_b2 = New-Object System.Windows.Forms.Button 
$f34_b2.Text = "Cancel"
$f34_b2.Size = New-Object System.Drawing.Size(100,25)
$f34_b2.Location = New-Object System.Drawing.Size(125,375) 
$f34_b2.Add_Click({})
$f34_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f34.CancelButton = $f34_b2
$f34.Controls.Add($f34_b2)

$f34.ShowDialog()
}
############## AdminAddSATPRulesBulkOperations Form - END

############## AdminDelSATPRulesBulkOperations Form - BEGIN
function f35_create(){

$f35 = New-Object system.Windows.Forms.Form 
$f35.Width = 400
$f35.Height = 450
$f35.MaximizeBox = $false 
$f35.StartPosition = "CenterScreen" 
$f35.FormBorderStyle = 'Fixed3D' 
$f35.Text = "Delete NMP SATP Rule (Bulk)"
$f35.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f35_l1 = New-Object System.Windows.Forms.Label 
$f35_l1.Text = "SATP Rule Name (Ex. VMW_SATP_ALUA):"
$f35_l1.Size = New-Object System.Drawing.Size(1100,20)
$f35_l1.Location = New-Object System.Drawing.Size(20,20) 
$f35.Controls.Add($f35_l1)

$f35_tb1 = New-Object System.Windows.Forms.Textbox 
$f35_tb1.Size = New-Object System.Drawing.Size(200,30)
$f35_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f35.Controls.Add($f35_tb1)

$f35_l2 = New-Object System.Windows.Forms.Label 
$f35_l2.Text = "Vendor (Ex. 3PARdata):"
$f35_l2.Size = New-Object System.Drawing.Size(1100,20)
$f35_l2.Location = New-Object System.Drawing.Size(20,70) 
$f35.Controls.Add($f35_l2)

$f35_tb2 = New-Object System.Windows.Forms.Textbox 
$f35_tb2.Size = New-Object System.Drawing.Size(200,30)
$f35_tb2.Location = New-Object System.Drawing.Size(20,90) 
$f35.Controls.Add($f35_tb2)

$f35_l3 = New-Object System.Windows.Forms.Label 
$f35_l3.Text = "ClaimOptions (Ex. tpgs_on):"
$f35_l3.Size = New-Object System.Drawing.Size(1100,20)
$f35_l3.Location = New-Object System.Drawing.Size(20,120) 
$f35.Controls.Add($f35_l3)

$f35_tb3 = New-Object System.Windows.Forms.Textbox 
$f35_tb3.Size = New-Object System.Drawing.Size(200,30)
$f35_tb3.Location = New-Object System.Drawing.Size(20,140) 
$f35.Controls.Add($f35_tb3)

$f35_l4 = New-Object System.Windows.Forms.Label 
$f35_l4.Text = "DefaultPSP (Ex. VMW_PSP_RR):"
$f35_l4.Size = New-Object System.Drawing.Size(1100,20)
$f35_l4.Location = New-Object System.Drawing.Size(20,170) 
$f35.Controls.Add($f35_l4)

$f35_tb4 = New-Object System.Windows.Forms.Textbox 
$f35_tb4.Size = New-Object System.Drawing.Size(200,30)
$f35_tb4.Location = New-Object System.Drawing.Size(20,190) 
$f35.Controls.Add($f35_tb4)

$f35_l5 = New-Object System.Windows.Forms.Label 
$f35_l5.Text = "PSPOptions (Ex. iops=1):"
$f35_l5.Size = New-Object System.Drawing.Size(1100,20)
$f35_l5.Location = New-Object System.Drawing.Size(20,220) 
$f35.Controls.Add($f35_l5)

$f35_tb5 = New-Object System.Windows.Forms.Textbox 
$f35_tb5.Size = New-Object System.Drawing.Size(200,30)
$f35_tb5.Location = New-Object System.Drawing.Size(20,240) 
$f35.Controls.Add($f35_tb5)

$f35_l6 = New-Object System.Windows.Forms.Label 
$f35_l6.Text = "Model (Ex. VV):"
$f35_l6.Size = New-Object System.Drawing.Size(1100,20)
$f35_l6.Location = New-Object System.Drawing.Size(20,270) 
$f35.Controls.Add($f35_l6)

$f35_tb6 = New-Object System.Windows.Forms.Textbox 
$f35_tb6.Size = New-Object System.Drawing.Size(200,30)
$f35_tb6.Location = New-Object System.Drawing.Size(20,290) 
$f35.Controls.Add($f35_tb6)

$f35_l7 = New-Object System.Windows.Forms.Label 
$f35_l7.Text = "Description (Ex. HPE 3PAR custom IOPS-RR Rule):"
$f35_l7.Size = New-Object System.Drawing.Size(1100,20)
$f35_l7.Location = New-Object System.Drawing.Size(20,320) 
$f35.Controls.Add($f35_l7)

$f35_tb7 = New-Object System.Windows.Forms.Textbox 
$f35_tb7.Size = New-Object System.Drawing.Size(200,30)
$f35_tb7.Location = New-Object System.Drawing.Size(20,340) 
$f35.Controls.Add($f35_tb7)

$f35_b1 = New-Object System.Windows.Forms.Button 
$f35_b1.Text = "Confirm"
$f35_b1.Size = New-Object System.Drawing.Size(100,25)
$f35_b1.Location = New-Object System.Drawing.Size(20,375) 
$f35_b1.Add_Click({AdminDelSATPRulesBulkOperations $global:vcenter $global:scluster $global:bulkcollection $f35_tb1.Text $f35_tb2.Text $f35_tb3.Text $f35_tb4.Text $f35_tb5.Text $f35_tb6.Text $f35_tb7.Text})
$f35_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f35.AcceptButton = $f35_b1
$f35.Controls.Add($f35_b1)

$f35_b2 = New-Object System.Windows.Forms.Button 
$f35_b2.Text = "Cancel"
$f35_b2.Size = New-Object System.Drawing.Size(100,25)
$f35_b2.Location = New-Object System.Drawing.Size(125,375) 
$f35_b2.Add_Click({})
$f35_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f35.CancelButton = $f35_b2
$f35.Controls.Add($f35_b2)

$f35.ShowDialog()
}
############## AdminDelSATPRulesBulkOperations Form - END

############## vPortGroup ImportedCSV Confirmation - BEGIN
function f36_create([System.Object] $actualreport, [System.Object] $object){

$f36 = New-Object system.Windows.Forms.Form 
$f36.Width = 1150
$f36.Height = 700 
$f36.MaximizeBox = $false 
$f36.StartPosition = "CenterScreen" 
$f36.FormBorderStyle = 'Fixed3D' 
$f36.Text = "vPortGroup ImportedCSV"
$f36.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f36_l1 = New-Object System.Windows.Forms.Label 
$f36_l1.Text = ">>> vPortGroup ImportedCSV >>> "
$f36_l1.Size = New-Object System.Drawing.Size(700,20)
$f36_l1.Location = New-Object System.Drawing.Size(20,20) 
$f36.Controls.Add($f36_l1)

$f36_dg1 = New-Object System.Windows.Forms.DataGridView
$f36_dg1.Size = New-Object System.Drawing.Size(800,500)
$f36_dg1.Location = New-Object System.Drawing.Size(20,50)
$f36_dg1.ColumnCount = 5
$f36_dg1.ColumnHeadersVisible = $true
$f36_dg1.Columns[0].Name = "vSwitch"
$f36_dg1.Columns[1].Name = "vPortGroup"
$f36_dg1.Columns[2].Name = "vLANID"
$f36_dg1.Columns[3].Name = "vPortGroupActiveNics"
$f36_dg1.Columns[4].Name = "vPortGroupStandbyNics"

$actualreport | % {
$f36_dg1.Rows.Add($_.vSwitch, $_.vPortGroup, $_.vLANID, $_.vPortGroupActiveNics, $_.vPortGroupStandbyNics)
}
$f36.Controls.Add($f36_dg1)

$f36_l3 = New-Object System.Windows.Forms.Label 
$f36_l3.Text = "On the following objects:"
$f36_l3.Size = New-Object System.Drawing.Size(480,20)
$f36_l3.Location = New-Object System.Drawing.Size(840,155) 
$f36.Controls.Add($f36_l3)

$f36_lb1 = New-Object System.Windows.Forms.Listbox 
$f36_lb1.Size = New-Object System.Drawing.Size(275,200)
$f36_lb1.Location = New-Object System.Drawing.Size(840,180)

$object | % {
$f36_lb1.Items.Add("$($_.Name) ($($_.Cluster))")
}
$f36.Controls.Add($f36_lb1)


$f36_l2 = New-Object System.Windows.Forms.Label 
$f36_l2.Text = "Do you want to proceed with the change? "
$f36_l2.Size = New-Object System.Drawing.Size(700,20)
$f36_l2.Location = New-Object System.Drawing.Size(20,570) 
$f36.Controls.Add($f36_l2)

$f36_b1 = New-Object System.Windows.Forms.Button 
$f36_b1.Text = "Confirm"
$f36_b1.Size = New-Object System.Drawing.Size(100,25)
$f36_b1.Location = New-Object System.Drawing.Size(20,605) 
$f36_b1.Add_Click({})
$f36_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f36.AcceptButton = $f36_b1
$f36.Controls.Add($f36_b1)

$f36_b2 = New-Object System.Windows.Forms.Button 
$f36_b2.Text = "Cancel"
$f36_b2.Size = New-Object System.Drawing.Size(100,25)
$f36_b2.Location = New-Object System.Drawing.Size(125,605) 
$f36_b2.Add_Click({})
$f36_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f36.CancelButton = $f36_b2
$f36.Controls.Add($f36_b2)

$f36.ShowDialog()
}
############## vPortGroup ImportedCSV Confirmation - END

############## VMkernel Adapter ImportedCSV Confirmation - BEGIN
function f37_create([System.Object] $actualreport, [System.Object] $object){

$f37 = New-Object system.Windows.Forms.Form 
$f37.Width = 1150
$f37.Height = 700 
$f37.MaximizeBox = $false 
$f37.StartPosition = "CenterScreen" 
$f37.FormBorderStyle = 'Fixed3D' 
$f37.Text = "VMkernel Adapter ImportedCSV"
$f37.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f37_l1 = New-Object System.Windows.Forms.Label 
$f37_l1.Text = ">>> VMkernel Adapter ImportedCSV >>> "
$f37_l1.Size = New-Object System.Drawing.Size(700,20)
$f37_l1.Location = New-Object System.Drawing.Size(20,20) 
$f37.Controls.Add($f37_l1)

$f37_dg1 = New-Object System.Windows.Forms.DataGridView
$f37_dg1.Size = New-Object System.Drawing.Size(800,500)
$f37_dg1.Location = New-Object System.Drawing.Size(20,50)
$f37_dg1.ColumnCount = 8
$f37_dg1.ColumnHeadersVisible = $true
$f37_dg1.Columns[0].Name = "ESXiHost"
$f37_dg1.Columns[1].Name = "vSwitch"
$f37_dg1.Columns[2].Name = "VMkernelAdapterName"
$f37_dg1.Columns[3].Name = "VMkernelAdapterIP"
$f37_dg1.Columns[4].Name = "VMkernelAdapterNetworkMask"
$f37_dg1.Columns[5].Name = "ManagementTraffic"
$f37_dg1.Columns[6].Name = "vSANTraffic"
$f37_dg1.Columns[7].Name = "vMotionTraffic"

$actualreport | % {
$f37_dg1.Rows.Add($_.ESXiHost, $_.vSwitch, $_.VMkernelAdapterName, $_.VMkernelAdapterIP, $_.VMkernelAdapterNetworkMask, $_.ManagementTraffic, $_.vSANTraffic, $_.vMotionTraffic)
}
$f37.Controls.Add($f37_dg1)

$f37_l3 = New-Object System.Windows.Forms.Label 
$f37_l3.Text = "On the following objects:"
$f37_l3.Size = New-Object System.Drawing.Size(480,20)
$f37_l3.Location = New-Object System.Drawing.Size(840,155) 
$f37.Controls.Add($f37_l3)

$f37_lb1 = New-Object System.Windows.Forms.Listbox 
$f37_lb1.Size = New-Object System.Drawing.Size(275,200)
$f37_lb1.Location = New-Object System.Drawing.Size(840,180)

$object | % {
$f37_lb1.Items.Add("$($_.Name) ($($_.Cluster))")
}
$f37.Controls.Add($f37_lb1)


$f37_l2 = New-Object System.Windows.Forms.Label 
$f37_l2.Text = "Do you want to proceed with the change? "
$f37_l2.Size = New-Object System.Drawing.Size(700,20)
$f37_l2.Location = New-Object System.Drawing.Size(20,570) 
$f37.Controls.Add($f37_l2)

$f37_b1 = New-Object System.Windows.Forms.Button 
$f37_b1.Text = "Confirm"
$f37_b1.Size = New-Object System.Drawing.Size(100,25)
$f37_b1.Location = New-Object System.Drawing.Size(20,605) 
$f37_b1.Add_Click({})
$f37_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f37.AcceptButton = $f37_b1
$f37.Controls.Add($f37_b1)

$f37_b2 = New-Object System.Windows.Forms.Button 
$f37_b2.Text = "Cancel"
$f37_b2.Size = New-Object System.Drawing.Size(100,25)
$f37_b2.Location = New-Object System.Drawing.Size(125,605) 
$f37_b2.Add_Click({})
$f37_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f37.CancelButton = $f37_b2
$f37.Controls.Add($f37_b2)

$f37.ShowDialog()
}
############## VMkernel Adapter ImportedCSV Confirmation - END

############## adminesxjoindomain Form - BEGIN
function f38_create(){

$f38 = New-Object system.Windows.Forms.Form 
$f38.Width = 400
$f38.Height = 350 
$f38.MaximizeBox = $false 
$f38.StartPosition = "CenterScreen" 
$f38.FormBorderStyle = 'Fixed3D' 
$f38.Text = "Join ESX Host to AD Domain"
$f38.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f38_l1 = New-Object System.Windows.Forms.Label 
$f38_l1.Text = "Type AD Domain FQDN (ex. domain.local):"
$f38_l1.Size = New-Object System.Drawing.Size(1100,20)
$f38_l1.Location = New-Object System.Drawing.Size(20,20) 
$f38.Controls.Add($f38_l1)

$f38_tb1 = New-Object System.Windows.Forms.Textbox 
$f38_tb1.Size = New-Object System.Drawing.Size(200,30)
$f38_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f38.Controls.Add($f38_tb1)

$f38_l2 = New-Object System.Windows.Forms.Label 
$f38_l2.Text = "Privileged Service Account (domain.local\cnorris):"
$f38_l2.Size = New-Object System.Drawing.Size(1100,20)
$f38_l2.Location = New-Object System.Drawing.Size(20,70) 
$f38.Controls.Add($f38_l2)

$f38_tb2 = New-Object System.Windows.Forms.Textbox 
$f38_tb2.Size = New-Object System.Drawing.Size(200,30)
$f38_tb2.Location = New-Object System.Drawing.Size(20,90) 
$f38.Controls.Add($f38_tb2)

$f38_b1 = New-Object System.Windows.Forms.Button 
$f38_b1.Text = "Confirm"
$f38_b1.Size = New-Object System.Drawing.Size(100,25)
$f38_b1.Location = New-Object System.Drawing.Size(20,255) 
$f38_b1.Add_Click({adminesxjoindomain $global:vcenter $global:scluster $global:bulkcollection $f38_tb1.Text $f38_tb2.Text})
$f38_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f38.AcceptButton = $f38_b1
$f38.Controls.Add($f38_b1)

$f38_b2 = New-Object System.Windows.Forms.Button 
$f38_b2.Text = "Cancel"
$f38_b2.Size = New-Object System.Drawing.Size(100,25)
$f38_b2.Location = New-Object System.Drawing.Size(125,255) 
$f38_b2.Add_Click({})
$f38_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f38.CancelButton = $f38_b2
$f38.Controls.Add($f38_b2)

$f38.ShowDialog()
}
############## adminesxjoindomain Form - END

############## adminesxntpserver Form - BEGIN
function f39_create(){

$f39 = New-Object system.Windows.Forms.Form 
$f39.Width = 400
$f39.Height = 350 
$f39.MaximizeBox = $false 
$f39.StartPosition = "CenterScreen" 
$f39.FormBorderStyle = 'Fixed3D' 
$f39.Text = "Configure NTP Settings"
$f39.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f39_l1 = New-Object System.Windows.Forms.Label 
$f39_l1.Text = "NTP Server IP Address to add (ex. 10.10.64.210):"
$f39_l1.Size = New-Object System.Drawing.Size(1100,20)
$f39_l1.Location = New-Object System.Drawing.Size(20,20) 
$f39.Controls.Add($f39_l1)

$f39_tb1 = New-Object System.Windows.Forms.Textbox 
$f39_tb1.Size = New-Object System.Drawing.Size(200,30)
$f39_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f39.Controls.Add($f39_tb1)

$f39_b1 = New-Object System.Windows.Forms.Button 
$f39_b1.Text = "Confirm"
$f39_b1.Size = New-Object System.Drawing.Size(100,25)
$f39_b1.Location = New-Object System.Drawing.Size(20,255) 
$f39_b1.Add_Click({adminesxntpserver $global:vcenter $global:scluster $global:bulkcollection $f39_tb1.Text})
$f39_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f39.AcceptButton = $f39_b1
$f39.Controls.Add($f39_b1)

$f39_b2 = New-Object System.Windows.Forms.Button 
$f39_b2.Text = "Cancel"
$f39_b2.Size = New-Object System.Drawing.Size(100,25)
$f39_b2.Location = New-Object System.Drawing.Size(125,255) 
$f39_b2.Add_Click({})
$f39_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f39.CancelButton = $f39_b2
$f39.Controls.Add($f39_b2)

$f39.ShowDialog()
}
############## adminesxntpserver Form - END

############## adminesxdnsstuff Form - BEGIN
function f40_create(){

$f40 = New-Object system.Windows.Forms.Form 
$f40.Width = 400
$f40.Height = 350
$f40.MaximizeBox = $false 
$f40.StartPosition = "CenterScreen" 
$f40.FormBorderStyle = 'Fixed3D' 
$f40.Text = "Configure DNS Servers"
$f40.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f40_l1 = New-Object System.Windows.Forms.Label 
$f40_l1.Text = "Type DomainName (ex. domain.local): "
$f40_l1.Size = New-Object System.Drawing.Size(1100,20)
$f40_l1.Location = New-Object System.Drawing.Size(20,20) 
$f40.Controls.Add($f40_l1)

$f40_tb1 = New-Object System.Windows.Forms.Textbox 
$f40_tb1.Size = New-Object System.Drawing.Size(200,30)
$f40_tb1.Location = New-Object System.Drawing.Size(20,40) 
$f40.Controls.Add($f40_tb1)

$f40_l2 = New-Object System.Windows.Forms.Label 
$f40_l2.Text = "Type DNS Servers (separate with comma): "
$f40_l2.Size = New-Object System.Drawing.Size(1100,20)
$f40_l2.Location = New-Object System.Drawing.Size(20,70) 
$f40.Controls.Add($f40_l2)

$f40_tb2 = New-Object System.Windows.Forms.Textbox 
$f40_tb2.Size = New-Object System.Drawing.Size(200,30)
$f40_tb2.Location = New-Object System.Drawing.Size(20,90) 
$f40.Controls.Add($f40_tb2)

$f40_l3 = New-Object System.Windows.Forms.Label 
$f40_l3.Text = "Type SearchDomain(separate with comma): "
$f40_l3.Size = New-Object System.Drawing.Size(1100,20)
$f40_l3.Location = New-Object System.Drawing.Size(20,120) 
$f40.Controls.Add($f40_l3)

$f40_tb3 = New-Object System.Windows.Forms.Textbox 
$f40_tb3.Size = New-Object System.Drawing.Size(200,30)
$f40_tb3.Location = New-Object System.Drawing.Size(20,140) 
$f40.Controls.Add($f40_tb3)

$f40_b1 = New-Object System.Windows.Forms.Button 
$f40_b1.Text = "Confirm"
$f40_b1.Size = New-Object System.Drawing.Size(100,25)
$f40_b1.Location = New-Object System.Drawing.Size(20,275) 
$f40_b1.Add_Click({adminesxdnsstuff $global:vcenter $global:scluster $global:bulkcollection $f40_tb1.Text $f40_tb2.Text $f40_tb3.Text})
$f40_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f40.AcceptButton = $f40_b1
$f40.Controls.Add($f40_b1)

$f40_b2 = New-Object System.Windows.Forms.Button 
$f40_b2.Text = "Cancel"
$f40_b2.Size = New-Object System.Drawing.Size(100,25)
$f40_b2.Location = New-Object System.Drawing.Size(125,275) 
$f40_b2.Add_Click({})
$f40_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f40.CancelButton = $f40_b2
$f40.Controls.Add($f40_b2)

$f40.ShowDialog()
}
############## adminesxdnsstuff Form - END

############## adminesxloggingsettings Form - BEGIN
function f41_create(){

$f41 = New-Object system.Windows.Forms.Form 
$f41.Width = 400
$f41.Height = 450
$f41.MaximizeBox = $false 
$f41.StartPosition = "CenterScreen" 
$f41.FormBorderStyle = 'Fixed3D' 
$f41.Text = "ESXi Logging Configuration"
$f41.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f41_l1 = New-Object System.Windows.Forms.Label 
$f41_l1.Text = "Datastore for ScratchConfig and Syslog (NO vSAN):"
$f41_l1.Size = New-Object System.Drawing.Size(400,20)
$f41_l1.Location = New-Object System.Drawing.Size(20,20) 
$f41.Controls.Add($f41_l1)

$f41_lb1 = New-Object System.Windows.Forms.Listbox 
$f41_lb1.Size = New-Object System.Drawing.Size(300,200)
$f41_lb1.Location = New-Object System.Drawing.Size(20,50) 

$private:hostdatastores=Get-VMHost $global:shost | Get-Datastore | where {(($_.Accessible -eq $True) -AND ($_.Type -ne "vsan"))}
$private:hostdatastores | %{
$f41_lb1.Items.Add($_.Name)
}
$f41.Controls.Add($f41_lb1)

$f41_l6 = New-Object System.Windows.Forms.Label 
$f41_l6.Text = "Remote Logging Host for $shost "
$f41_l6.Size = New-Object System.Drawing.Size(400,20)
$f41_l6.Location = New-Object System.Drawing.Size(20,270) 
$f41.Controls.Add($f41_l6)

$f41_tb6 = New-Object System.Windows.Forms.Textbox 
$f41_tb6.Size = New-Object System.Drawing.Size(250,30)
$f41_tb6.Location = New-Object System.Drawing.Size(20,290) 
$f41.Controls.Add($f41_tb6)

$f41_l7 = New-Object System.Windows.Forms.Label 
$f41_l7.Text = "(Ex: udp://hostname:514,ssl://hostname:1514)"
$f41_l7.Size = New-Object System.Drawing.Size(400,20)
$f41_l7.Location = New-Object System.Drawing.Size(20,320) 
$f41.Controls.Add($f41_l7)

$f41_b1 = New-Object System.Windows.Forms.Button 
$f41_b1.Text = "Confirm"
$f41_b1.Size = New-Object System.Drawing.Size(100,25)
$f41_b1.Location = New-Object System.Drawing.Size(20,375) 
$f41_b1.Add_Click({adminesxloggingsettings $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $f41_lb1.SelectedItem $f41_tb6.Text})
$f41_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f41.AcceptButton = $f41_b1
$f41.Controls.Add($f41_b1)

$f41_b2 = New-Object System.Windows.Forms.Button 
$f41_b2.Text = "Cancel"
$f41_b2.Size = New-Object System.Drawing.Size(100,25)
$f41_b2.Location = New-Object System.Drawing.Size(125,375) 
$f41_b2.Add_Click({})
$f41_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f41.CancelButton = $f41_b2
$f41.Controls.Add($f41_b2)

$f41.ShowDialog()
}
############## adminesxloggingsettings Form - END

############## UploadVIBFile Form - BEGIN
function f42_create(){

$f42 = New-Object system.Windows.Forms.Form 
$f42.Width = 400
$f42.Height = 350
$f42.MaximizeBox = $false 
$f42.StartPosition = "CenterScreen" 
$f42.FormBorderStyle = 'Fixed3D' 
$f42.Text = "Upload VIB/ZIP File"
$f42.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)


$f42_l1 = New-Object System.Windows.Forms.Label 
$f42_l1.Text = "Uploading VIB/VIB file to the following datastore:"
$f42_l1.Size = New-Object System.Drawing.Size(400,20)
$f42_l1.Location = New-Object System.Drawing.Size(20,20) 
$f42.Controls.Add($f42_l1)

$f42_lb1 = New-Object System.Windows.Forms.Listbox 
$f42_lb1.Size = New-Object System.Drawing.Size(300,200)
$f42_lb1.Location = New-Object System.Drawing.Size(20,50) 

$private:hostdatastores=Get-VMHost $global:shost | Get-Datastore | where {($_.Accessible -eq $True)}
$private:hostdatastores | %{
$f42_lb1.Items.Add($_.Name)
}
$f42.Controls.Add($f42_lb1)

$f42_l7 = New-Object System.Windows.Forms.Label 
$f42_l7.Text = "(Ex: Subfolder will be automatically created)"
$f42_l7.Size = New-Object System.Drawing.Size(400,20)
$f42_l7.Location = New-Object System.Drawing.Size(20,255) 
$f42.Controls.Add($f42_l7)

$f42_b1 = New-Object System.Windows.Forms.Button 
$f42_b1.Text = "Confirm"
$f42_b1.Size = New-Object System.Drawing.Size(100,25)
$f42_b1.Location = New-Object System.Drawing.Size(20,280) 
$f42_b1.Add_Click({uploadingvibfile $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $f42_lb1.SelectedItem})
$f42_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f42.AcceptButton = $f42_b1
$f42.Controls.Add($f42_b1)

$f42_b2 = New-Object System.Windows.Forms.Button 
$f42_b2.Text = "Cancel"
$f42_b2.Size = New-Object System.Drawing.Size(100,25)
$f42_b2.Location = New-Object System.Drawing.Size(125,280) 
$f42_b2.Add_Click({})
$f42_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f42.CancelButton = $f42_b2
$f42.Controls.Add($f42_b2)

$f42.ShowDialog()
}
############## UploadVIBFile Form - END

############## InstallVIBFile Form - BEGIN
function f43_create(){

$f43 = New-Object system.Windows.Forms.Form 
$f43.Width = 400
$f43.Height = 450
$f43.MaximizeBox = $false 
$f43.StartPosition = "CenterScreen" 
$f43.FormBorderStyle = 'Fixed3D' 
$f43.Text = "Installing VIB File"
$f43.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)


$f43_l1 = New-Object System.Windows.Forms.Label 
$f43_l1.Text = "Install Offline VIB from this location:"
$f43_l1.Size = New-Object System.Drawing.Size(400,20)
$f43_l1.Location = New-Object System.Drawing.Size(20,20) 
$f43.Controls.Add($f43_l1)

$f43_lb1 = New-Object System.Windows.Forms.Listbox 
$f43_lb1.Size = New-Object System.Drawing.Size(300,200)
$f43_lb1.Location = New-Object System.Drawing.Size(20,50) 

$private:hostdatastores=Get-VMHost $global:shost | Get-Datastore | where {($_.Accessible -eq $True)}
$private:hostdatastores | %{
$f43_lb1.Items.Add($_.Name)
}
$f43.Controls.Add($f43_lb1)

$f43_l7 = New-Object System.Windows.Forms.Label 
$f43_l7.Text = "(Ex: Subfolder will be automatically included)"
$f43_l7.Size = New-Object System.Drawing.Size(400,20)
$f43_l7.Location = New-Object System.Drawing.Size(20,255) 
$f43.Controls.Add($f43_l7)

$f43_l8 = New-Object System.Windows.Forms.Label 
$f43_l8.Text = "Offline VIB .vib filename:"
$f43_l8.Size = New-Object System.Drawing.Size(400,20)
$f43_l8.Location = New-Object System.Drawing.Size(20,285) 
$f43.Controls.Add($f43_l8)

$f43_tb1 = New-Object System.Windows.Forms.Textbox 
$f43_tb1.Size = New-Object System.Drawing.Size(200,30)
$f43_tb1.Location = New-Object System.Drawing.Size(20,310) 
$f43.Controls.Add($f43_tb1)

$f43_b1 = New-Object System.Windows.Forms.Button 
$f43_b1.Text = "Confirm"
$f43_b1.Size = New-Object System.Drawing.Size(100,25)
$f43_b1.Location = New-Object System.Drawing.Size(20,345) 
$f43_b1.Add_Click({installingvibfile $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $f43_lb1.SelectedItem $f43_tb1.Text})
$f43_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f43.AcceptButton = $f43_b1
$f43.Controls.Add($f43_b1)

$f43_b2 = New-Object System.Windows.Forms.Button 
$f43_b2.Text = "Cancel"
$f43_b2.Size = New-Object System.Drawing.Size(100,25)
$f43_b2.Location = New-Object System.Drawing.Size(125,345) 
$f43_b2.Add_Click({})
$f43_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f43.CancelButton = $f43_b2
$f43.Controls.Add($f43_b2)

$f43.ShowDialog()
}
############## InstallVIBFile Form - END

############## UpdateVIBFile Form - BEGIN
function f44_create(){

$f44 = New-Object system.Windows.Forms.Form 
$f44.Width = 400
$f44.Height = 450
$f44.MaximizeBox = $false 
$f44.StartPosition = "CenterScreen" 
$f44.FormBorderStyle = 'Fixed3D' 
$f44.Text = "Updating Bundle File"
$f44.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)


$f44_l1 = New-Object System.Windows.Forms.Label 
$f44_l1.Text = "Update Offline Bundle from this location:"
$f44_l1.Size = New-Object System.Drawing.Size(400,20)
$f44_l1.Location = New-Object System.Drawing.Size(20,20) 
$f44.Controls.Add($f44_l1)

$f44_lb1 = New-Object System.Windows.Forms.Listbox 
$f44_lb1.Size = New-Object System.Drawing.Size(300,200)
$f44_lb1.Location = New-Object System.Drawing.Size(20,50) 

$private:hostdatastores=Get-VMHost $global:shost | Get-Datastore | where {($_.Accessible -eq $True)}
$private:hostdatastores | %{
$f44_lb1.Items.Add($_.Name)
}
$f44.Controls.Add($f44_lb1)

$f44_l7 = New-Object System.Windows.Forms.Label 
$f44_l7.Text = "(Ex: Subfolder will be automatically included)"
$f44_l7.Size = New-Object System.Drawing.Size(400,20)
$f44_l7.Location = New-Object System.Drawing.Size(20,255) 
$f44.Controls.Add($f44_l7)

$f44_l8 = New-Object System.Windows.Forms.Label 
$f44_l8.Text = "Offline Bundle .zip filename:"
$f44_l8.Size = New-Object System.Drawing.Size(400,20)
$f44_l8.Location = New-Object System.Drawing.Size(20,285) 
$f44.Controls.Add($f44_l8)

$f44_tb1 = New-Object System.Windows.Forms.Textbox 
$f44_tb1.Size = New-Object System.Drawing.Size(200,30)
$f44_tb1.Location = New-Object System.Drawing.Size(20,310) 
$f44.Controls.Add($f44_tb1)

$f44_b1 = New-Object System.Windows.Forms.Button 
$f44_b1.Text = "Confirm"
$f44_b1.Size = New-Object System.Drawing.Size(100,25)
$f44_b1.Location = New-Object System.Drawing.Size(20,345) 
$f44_b1.Add_Click({updatingvibfile $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $f44_lb1.SelectedItem $f44_tb1.Text})
$f44_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f44.AcceptButton = $f44_b1
$f44.Controls.Add($f44_b1)

$f44_b2 = New-Object System.Windows.Forms.Button 
$f44_b2.Text = "Cancel"
$f44_b2.Size = New-Object System.Drawing.Size(100,25)
$f44_b2.Location = New-Object System.Drawing.Size(125,345) 
$f44_b2.Add_Click({})
$f44_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f44.CancelButton = $f44_b2
$f44.Controls.Add($f44_b2)

$f44.ShowDialog()
}
############## UpdateVIBFile Form - END

############## Software VIB List - BEGIN
function f45_create(){

$f45 = New-Object system.Windows.Forms.Form 
$f45.Width = 1150
$f45.Height = 700 
$f45.MaximizeBox = $false 
$f45.StartPosition = "CenterScreen" 
$f45.FormBorderStyle = 'Fixed3D' 
$f45.Text = "$global:shost | Software VIB List"
$f45.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f45_l1 = New-Object System.Windows.Forms.Label 
$f45_l1.Text = ">>> Software VIB List >>> Current Selection: >>> $global:shost "
$f45_l1.Size = New-Object System.Drawing.Size(900,20)
$f45_l1.Location = New-Object System.Drawing.Size(20,20) 
$f45.Controls.Add($f45_l1)

$f45_dg1 = New-Object System.Windows.Forms.DataGridView
$f45_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f45_dg1.Location = New-Object System.Drawing.Size(20,50)
$f45_dg1.ColumnCount = 8
$f45_dg1.ColumnHeadersVisible = $true
$f45_dg1.Columns[0].Name = "Name"
$f45_dg1.Columns[1].Name = "AcceptanceLevel"
$f45_dg1.Columns[2].Name = "CreationDate"
$f45_dg1.Columns[3].Name = "ID"
$f45_dg1.Columns[4].Name = "InstallDate"
$f45_dg1.Columns[5].Name = "Status"
$f45_dg1.Columns[6].Name = "Vendor"
$f45_dg1.Columns[7].Name = "Version"

$actualreport=SoftwareVIBList $global:shost
$actualreport | % {
$f45_dg1.Rows.Add($_.Name, $_.AcceptanceLevel, $_.CreationDate, $_.ID, $_.InstallDate, $_.Status, $_.Vendor, $_.Version)
}
$f45.Controls.Add($f45_dg1)

$f45_b1 = New-Object System.Windows.Forms.Button 
$f45_b1.Size = New-Object System.Drawing.Size(100,30)
$f45_b1.Location = New-Object System.Drawing.Size(20,605) 
$f45_b1.Text = "Close" 
$f45_b1.Add_Click({$f45.Close(); $f45.Dispose()})
$f45.Controls.Add($f45_b1)

$f45_b2 = New-Object System.Windows.Forms.Button 
$f45_b2.Size = New-Object System.Drawing.Size(100,30)
$f45_b2.Location = New-Object System.Drawing.Size(125,605) 
$f45_b2.Text = "Export-CSV" 
$f45_b2.Add_Click({ExportCSV $actualreport})
$f45.Controls.Add($f45_b2)

$f45.ShowDialog()
}
############## Software VIB List - END

############## Host vPortGroup Inventory - BEGIN
function f46_create(){

$f46 = New-Object system.Windows.Forms.Form 
$f46.Width = 1150
$f46.Height = 700 
$f46.MaximizeBox = $false 
$f46.StartPosition = "CenterScreen" 
$f46.FormBorderStyle = 'Fixed3D' 
$f46.Text = "$global:shost | vPortGroup Inventory"
$f46.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f46_l1 = New-Object System.Windows.Forms.Label 
$f46_l1.Text = ">>> vPortGroup Inventory >>> Current Selection: >>> $global:shost "
$f46_l1.Size = New-Object System.Drawing.Size(900,20)
$f46_l1.Location = New-Object System.Drawing.Size(20,20) 
$f46.Controls.Add($f46_l1)

$f46_dg1 = New-Object System.Windows.Forms.DataGridView
$f46_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f46_dg1.Location = New-Object System.Drawing.Size(20,50)
$f46_dg1.ColumnCount = 3
$f46_dg1.ColumnHeadersVisible = $true
$f46_dg1.Columns[0].Name = "Name"
$f46_dg1.Columns[1].Name = "VirtualSwitch"
$f46_dg1.Columns[2].Name = "vLANID"

$actualreport=HostvPortGroupInventory $global:shost
$actualreport | % {
$f46_dg1.Rows.Add($_.Name, $_.VirtualSwitch, $_.vLANID)
}
$f46.Controls.Add($f46_dg1)

$f46_b1 = New-Object System.Windows.Forms.Button 
$f46_b1.Size = New-Object System.Drawing.Size(100,30)
$f46_b1.Location = New-Object System.Drawing.Size(20,605) 
$f46_b1.Text = "Close" 
$f46_b1.Add_Click({$f46.Close(); $f46.Dispose()})
$f46.Controls.Add($f46_b1)

$f46_b2 = New-Object System.Windows.Forms.Button 
$f46_b2.Size = New-Object System.Drawing.Size(100,30)
$f46_b2.Location = New-Object System.Drawing.Size(125,605) 
$f46_b2.Text = "Export-CSV" 
$f46_b2.Add_Click({ExportCSV $actualreport})
$f46.Controls.Add($f46_b2)

$f46.ShowDialog()
}
############## Host vPortGroup Inventory - END

############## Cluster vPortGroup Inventory - BEGIN
function f47_create(){

$f47 = New-Object system.Windows.Forms.Form 
$f47.Width = 1150
$f47.Height = 700 
$f47.MaximizeBox = $false 
$f47.StartPosition = "CenterScreen" 
$f47.FormBorderStyle = 'Fixed3D' 
$f47.Text = "$global:scluster | vPortGroup Inventory"
$f47.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f47_l1 = New-Object System.Windows.Forms.Label 
$f47_l1.Text = ">>> vPortGroup Inventory >>> Current Selection: >>> $global:scluster "
$f47_l1.Size = New-Object System.Drawing.Size(900,20)
$f47_l1.Location = New-Object System.Drawing.Size(20,20) 
$f47.Controls.Add($f47_l1)

$f47_dg1 = New-Object System.Windows.Forms.DataGridView
$f47_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f47_dg1.Location = New-Object System.Drawing.Size(20,50)
$f47_dg1.ColumnCount = 7
$f47_dg1.ColumnHeadersVisible = $true
$f47_dg1.Columns[0].Name = "Name"
$f47_dg1.Columns[1].Name = "VirtualSwitch"
$f47_dg1.Columns[2].Name = "vLANID"
$f47_dg1.Columns[3].Name = "VMHost"
$f47_dg1.Columns[4].Name = "Cluster"
$f47_dg1.Columns[5].Name = "ActiveNic"
$f47_dg1.Columns[6].Name = "StandbyNic"

$actualreport=ClustervPortGroupInventory $global:scluster
$actualreport | % {
$f47_dg1.Rows.Add($_.Name, $_.VirtualSwitch, $_.vLANID, $_.VMHost, $_.Cluster, $_.ActiveNic, $_.StandbyNic)
}
$f47.Controls.Add($f47_dg1)

$f47_b1 = New-Object System.Windows.Forms.Button 
$f47_b1.Size = New-Object System.Drawing.Size(100,30)
$f47_b1.Location = New-Object System.Drawing.Size(20,605) 
$f47_b1.Text = "Close" 
$f47_b1.Add_Click({$f47.Close(); $f47.Dispose()})
$f47.Controls.Add($f47_b1)

$f47_b2 = New-Object System.Windows.Forms.Button 
$f47_b2.Size = New-Object System.Drawing.Size(100,30)
$f47_b2.Location = New-Object System.Drawing.Size(125,605) 
$f47_b2.Text = "Export-CSV" 
$f47_b2.Add_Click({ExportCSV $actualreport})
$f47.Controls.Add($f47_b2)

$f47.ShowDialog()
}
############## Cluster vPortGroup Inventory - END

###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0) 
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

############## StorageCoreDevicesParam Form - BEGIN
function f48_create(){

$f48 = New-Object system.Windows.Forms.Form 
$f48.Width = 1150
$f48.Height = 700 
$f48.MaximizeBox = $false 
$f48.StartPosition = "CenterScreen" 
$f48.FormBorderStyle = 'Fixed3D' 
$f48.Text = "$global:shost | Storage Core Device Configuration "
$f48.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f48_l1 = New-Object System.Windows.Forms.Label 
$f48_l1.Text = ">>> Storage Core Device Configuration >>> Current Selection: >>> $global:shost "
$f48_l1.Size = New-Object System.Drawing.Size(900,20)
$f48_l1.Location = New-Object System.Drawing.Size(20,20) 
$f48.Controls.Add($f48_l1)

$f48_dg1 = New-Object System.Windows.Forms.DataGridView
$f48_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f48_dg1.Location = New-Object System.Drawing.Size(20,50)
$f48_dg1.SelectionMode = "FullRowSelect"
$f48_dg1.ColumnCount = 32
$f48_dg1.ColumnHeadersVisible = $true
$f48_dg1.Columns[0].Name = "Device"
$f48_dg1.Columns[1].Name = "DisplayName"
$f48_dg1.Columns[2].Name = "DeviceMaxQueueDepth"
$f48_dg1.Columns[3].Name = "DeviceType"
$f48_dg1.Columns[4].Name = "DevfsPath"
$f48_dg1.Columns[5].Name = "HasSettableDisplayName"
$f48_dg1.Columns[6].Name = "IsBootDevice"
$f48_dg1.Columns[7].Name = "IsBootUSBDevice"
$f48_dg1.Columns[8].Name = "IsLocal"
$f48_dg1.Columns[9].Name = "IsLocalSASDevice"
$f48_dg1.Columns[10].Name = "IsOffline"
$f48_dg1.Columns[11].Name = "IsPerenniallyReserved "
$f48_dg1.Columns[12].Name = "IsPseudo"
$f48_dg1.Columns[13].Name = "IsRDMCapable"
$f48_dg1.Columns[14].Name = "IsRemovable"
$f48_dg1.Columns[15].Name = "IsSAS"
$f48_dg1.Columns[16].Name = "IsSSD"
$f48_dg1.Columns[17].Name = "IsSharedClusterwide"
$f48_dg1.Columns[18].Name = "IsUSB"
$f48_dg1.Columns[19].Name = "Model"
$f48_dg1.Columns[20].Name = "MultiPathPlugin"
$f48_dg1.Columns[21].Name = "NoofoutstandingIOswithcompetingworlds"
$f48_dg1.Columns[22].Name = "OtherUIDs"
$f48_dg1.Columns[23].Name = "QueueFullSampleSize"
$f48_dg1.Columns[24].Name = "QueueFullThreshold"
$f48_dg1.Columns[25].Name = "Revision"
$f48_dg1.Columns[26].Name = "SCSILevel"
$f48_dg1.Columns[27].Name = "Size"
$f48_dg1.Columns[28].Name = "Status"
$f48_dg1.Columns[29].Name = "ThinProvisioningStatus"
$f48_dg1.Columns[30].Name = "VAAIStatus"
$f48_dg1.Columns[31].Name = "Vendor"

$actualreport=StorageCoreDevicesParam $global:shost
$actualreport | % {
$f48_dg1.Rows.Add($_.Device, $_.DisplayName, $_.DeviceMaxQueueDepth, $_.DeviceType, $_.DevfsPath, $_.HasSettableDisplayName, $_.IsBootDevice, $_.IsBootUSBDevice, $_.IsLocal, $_.IsLocalSASDevice, $_.IsOffline, $_.IsPerenniallyReserved, $_.IsPseudo, $_.IsRDMCapable, $_.IsRemovable, $_.IsSAS, $_.IsSSD, $_.IsSharedClusterwide, $_.IsUSB, $_.Model, $_.MultiPathPlugin, $_.NoofoutstandingIOswithcompetingworlds, $_.OtherUIDs, $_.QueueFullSampleSize, $_.QueueFullThreshold, $_.Revision, $_.SCSILevel, $_.Size, $_.Status, $_.ThinProvisioningStatus, $_.VAAIStatus, $_.Vendor)
}
$f48.Controls.Add($f48_dg1)

$f48_dg1.Add_Click({})

$f48_b1 = New-Object System.Windows.Forms.Button 
$f48_b1.Size = New-Object System.Drawing.Size(100,30)
$f48_b1.Location = New-Object System.Drawing.Size(20,605) 
$f48_b1.Text = "Close" 
$f48_b1.Add_Click({$f48.Close(); $f48.Dispose()})
$f48.Controls.Add($f48_b1)

$f48_b2 = New-Object System.Windows.Forms.Button 
$f48_b2.Size = New-Object System.Drawing.Size(100,30)
$f48_b2.Location = New-Object System.Drawing.Size(125,605) 
$f48_b2.Text = "Export-CSV" 
$f48_b2.Add_Click({ExportCSV $actualreport})
$f48.Controls.Add($f48_b2)

$f48_b3 = New-Object System.Windows.Forms.Button 
$f48_b3.Size = New-Object System.Drawing.Size(100,30)
$f48_b3.Location = New-Object System.Drawing.Size(230,605) 
$f48_b3.Text = "Modify"
 
$f48_b3.Add_Click({
$private:NMPDevices=@{}
$private:selecteddevices = $f48_dg1.selectedRows
$selecteddevices | %{
$private:NMPDevice = New-Object System.Object
$private:Device = $f48_dg1.Rows[$_.Index].Cells["Device"].Value
$private:DeviceMaxQueueDepth = $f48_dg1.Rows[$_.Index].Cells["DeviceMaxQueueDepth"].Value
$private:schednumreqoutstanding = $f48_dg1.Rows[$_.Index].Cells["schednumreqoutstanding"].Value
$private:NMPDevice | Add-Member -type NoteProperty -name Device -Value "$Device"
$private:NMPDevice | Add-Member -type NoteProperty -name DeviceMaxQueueDepth -Value "$DeviceMaxQueueDepth"
$private:NMPDevice | Add-Member -type NoteProperty -name schednumreqoutstanding -Value "$schednumreqoutstanding"
$private:NMPDevice | Add-Member -type NoteProperty -name VMHost -Value "$global:shost"
$private:NMPDevices.Add("$Device",$NMPDevice)
}

f49_create $NMPDevices

})
$f48.Controls.Add($f48_b3)

$f48.ShowDialog()
}
############## StorageCoreDevicesParam Form - END

############## StorageCoreDevicesParamMenu Form - BEGIN
function f49_create([System.Object] $NMPDevices){

$f49 = New-Object system.Windows.Forms.Form 
$f49.Width = 400
$f49.Height = 450
$f49.MaximizeBox = $false 
$f49.StartPosition = "CenterScreen" 
$f49.FormBorderStyle = 'Fixed3D' 
$f49.Text = "Storage Core Devices Param Menu"
$f49.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f49_l1 = New-Object System.Windows.Forms.Label 
$f49_l1.Text = "Select a parameter to change:"
$f49_l1.Size = New-Object System.Drawing.Size(400,20)
$f49_l1.Location = New-Object System.Drawing.Size(20,20) 
$f49.Controls.Add($f49_l1)

$f49_lb1 = New-Object System.Windows.Forms.Listbox 
$f49_lb1.Size = New-Object System.Drawing.Size(300,200)
$f49_lb1.Location = New-Object System.Drawing.Size(20,50) 

$private:parammenu=""
$private:esxcliv2 = Get-EsxCli -VMHost $global:shost -v2
$private:parammenu=$esxcliv2.storage.core.device.set.createargs()
$parammenu.keys | %{
$f49_lb1.Items.Add($_)
}

$f49.Controls.Add($f49_lb1)

$f49_l6 = New-Object System.Windows.Forms.Label 
$f49_l6.Text = "Type new value: "
$f49_l6.Size = New-Object System.Drawing.Size(400,20)
$f49_l6.Location = New-Object System.Drawing.Size(20,270) 
$f49.Controls.Add($f49_l6)

$f49_tb6 = New-Object System.Windows.Forms.Textbox 
$f49_tb6.Size = New-Object System.Drawing.Size(250,30)
$f49_tb6.Location = New-Object System.Drawing.Size(20,290) 
$f49.Controls.Add($f49_tb6)

$f49_l7 = New-Object System.Windows.Forms.Label 
$f49_l7.Text = "(To be applied on $global:shost )"
$f49_l7.Size = New-Object System.Drawing.Size(400,20)
$f49_l7.Location = New-Object System.Drawing.Size(20,320) 
$f49.Controls.Add($f49_l7)

$f49_b1 = New-Object System.Windows.Forms.Button 
$f49_b1.Text = "Confirm"
$f49_b1.Size = New-Object System.Drawing.Size(100,25)
$f49_b1.Location = New-Object System.Drawing.Size(20,375) 
$f49_b1.Add_Click({StorageCoreDevicesParamChange $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $f49_lb1.SelectedItem $f49_tb6.Text $NMPDevices})
$f49_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f49.AcceptButton = $f49_b1
$f49.Controls.Add($f49_b1)

$f49_b2 = New-Object System.Windows.Forms.Button 
$f49_b2.Text = "Cancel"
$f49_b2.Size = New-Object System.Drawing.Size(100,25)
$f49_b2.Location = New-Object System.Drawing.Size(125,375) 
$f49_b2.Add_Click({})
$f49_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f49.CancelButton = $f49_b2
$f49.Controls.Add($f49_b2)

$f49.ShowDialog()
}
############## StorageCoreDevicesParamMenu Form - END

############## NMPConfigurationListDevicesConfig Form - BEGIN
function f50_create(){

$f50 = New-Object system.Windows.Forms.Form 
$f50.Width = 1150
$f50.Height = 700 
$f50.MaximizeBox = $false 
$f50.StartPosition = "CenterScreen" 
$f50.FormBorderStyle = 'Fixed3D' 
$f50.Text = "$global:shost | NMP Configuration: List Devices"
$f50.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f50_l1 = New-Object System.Windows.Forms.Label 
$f50_l1.Text = ">>> NMP Configuration: List Devices >>> Current Selection: >>> $global:shost "
$f50_l1.Size = New-Object System.Drawing.Size(900,20)
$f50_l1.Location = New-Object System.Drawing.Size(20,20) 
$f50.Controls.Add($f50_l1)

$f50_dg1 = New-Object System.Windows.Forms.DataGridView
$f50_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f50_dg1.Location = New-Object System.Drawing.Size(20,50)
$f50_dg1.SelectionMode = "FullRowSelect"
$f50_dg1.ColumnCount = 11
$f50_dg1.ColumnHeadersVisible = $true
$f50_dg1.Columns[0].Name = "Device"
$f50_dg1.Columns[1].Name = "DeviceDisplayName"
$f50_dg1.Columns[2].Name = "IsBootUSBDevice"
$f50_dg1.Columns[3].Name = "IsLocalSASDevice"
$f50_dg1.Columns[4].Name = "IsUSB"
$f50_dg1.Columns[5].Name = "PathSelectionPolicy"
$f50_dg1.Columns[6].Name = "PathSelectionPolicyDeviceConfig"
$f50_dg1.Columns[7].Name = "PathSelectionPolicyDeviceCustomConfig"
$f50_dg1.Columns[8].Name = "StorageArrayType"
$f50_dg1.Columns[9].Name = "StorageArrayTypeDeviceConfig"
$f50_dg1.Columns[10].Name = "WorkingPaths"

$global:actualreport=NMPDeviceFullListConfig $global:shost
$actualreport | % {
$f50_dg1.Rows.Add($_.Device, $_.DeviceDisplayName, $_.IsBootUSBDevice, $_.IsLocalSASDevice, $_.IsUSB, $_.PathSelectionPolicy, $_.PathSelectionPolicyDeviceConfig, $_.PathSelectionPolicyDeviceCustomConfig, $_.StorageArrayType, $_.StorageArrayTypeDeviceConfig, $_.WorkingPaths)
}
$f50.Controls.Add($f50_dg1)

$f50_b1 = New-Object System.Windows.Forms.Button 
$f50_b1.Size = New-Object System.Drawing.Size(100,30)
$f50_b1.Location = New-Object System.Drawing.Size(20,605) 
$f50_b1.Text = "Close" 
$f50_b1.Add_Click({$f50.Close(); $f50.Dispose()})
$f50.Controls.Add($f50_b1)

$f50_b2 = New-Object System.Windows.Forms.Button 
$f50_b2.Size = New-Object System.Drawing.Size(100,30)
$f50_b2.Location = New-Object System.Drawing.Size(125,605) 
$f50_b2.Text = "Export-CSV" 
$f50_b2.Add_Click({ExportCSV $actualreport})
$f50.Controls.Add($f50_b2)

$f50_b3 = New-Object System.Windows.Forms.Button 
$f50_b3.Size = New-Object System.Drawing.Size(100,30)
$f50_b3.Location = New-Object System.Drawing.Size(230,605) 
$f50_b3.Text = "Change"
 
$f50_b3.Add_Click({
$private:NMPDevices=@{}
$private:selecteddevices = $f50_dg1.selectedRows
$selecteddevices | %{
$private:NMPDevice = New-Object System.Object
$private:Device = $f50_dg1.Rows[$_.Index].Cells["Device"].Value
$private:NMPDevice | Add-Member -type NoteProperty -name Device -Value "$Device"
$private:NMPDevice | Add-Member -type NoteProperty -name VMHost -Value "$global:shost"
$private:NMPDevices.Add("$Device",$NMPDevice)
}
NMPDeviceFullListConfigChange $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $NMPDevices

})
$f50.Controls.Add($f50_b3)

$f50.ShowDialog()
}
############## NMPConfigurationListDevicesConfig Form - END

############## AdvancedSettings2-ColumnConfig Form - BEGIN
function f51_create(){

$f51 = New-Object system.Windows.Forms.Form 
$f51.Width = 1150
$f51.Height = 700 
$f51.MaximizeBox = $false 
$f51.StartPosition = "CenterScreen" 
$f51.FormBorderStyle = 'Fixed3D' 
$f51.Text = "$global:scluster | $global:shost | Change Advanced Settings "
$f51.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f51_l1 = New-Object System.Windows.Forms.Label 
$f51_l1.Text = ">>> Change Advanced Settings >>> Current Selection: >>> $global:scluster >> $global:shost "
$f51_l1.Size = New-Object System.Drawing.Size(900,20)
$f51_l1.Location = New-Object System.Drawing.Size(20,20) 
$f51.Controls.Add($f51_l1)

$f51_dg1 = New-Object System.Windows.Forms.DataGridView
$f51_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f51_dg1.Location = New-Object System.Drawing.Size(20,50)
$f51_dg1.ColumnCount = 2
$f51_dg1.SelectionMode = "FullRowSelect"
$f51_dg1.MultiSelect = $false
$f51_dg1.ColumnHeadersVisible = $true
$f51_dg1.Columns[0].Name = "Name"
$f51_dg1.Columns[1].Name = "Value"

$actualreport=HostAdvancedSettings $global:scluster $global:shost

$actualreport | % {
$f51_dg1.Rows.Add($_.Name, $_.Value)
}

$f51.Controls.Add($f51_dg1)

$f51_b1 = New-Object System.Windows.Forms.Button 
$f51_b1.Size = New-Object System.Drawing.Size(100,30)
$f51_b1.Location = New-Object System.Drawing.Size(20,605) 
$f51_b1.Text = "Close" 
$f51_b1.Add_Click({$f51.Close(); $f51.Dispose()})
$f51.Controls.Add($f51_b1)

$f51_b2 = New-Object System.Windows.Forms.Button 
$f51_b2.Size = New-Object System.Drawing.Size(100,30)
$f51_b2.Location = New-Object System.Drawing.Size(125,605) 
$f51_b2.Text = "Export-CSV" 
$f51_b2.Add_Click({ExportCSV $actualreport})
$f51.Controls.Add($f51_b2)

$f51_b3 = New-Object System.Windows.Forms.Button 
$f51_b3.Size = New-Object System.Drawing.Size(100,30)
$f51_b3.Location = New-Object System.Drawing.Size(230,605) 
$f51_b3.Text = "Change"
 
$f51_b3.Add_Click({

$private:AdvancedSettingName = $f51_dg1.CurrentRow.Cells["Name"].Value
$private:AdvancedSettingValue = $f51_dg1.CurrentRow.Cells["Value"].Value

f52_create $AdvancedSettingName $AdvancedSettingValue

})
$f51.Controls.Add($f51_b3)

$f51.ShowDialog()
}
############## AdvancedSettings2-ColumnConfig Form - END

############## AdvancedSettings2-ColumnConfigChange Form - BEGIN
function f52_create([String] $AdvancedSettingName, $AdvancedSettingValue){

$f52 = New-Object system.Windows.Forms.Form 
$f52.Width = 400
$f52.Height = 450
$f52.MaximizeBox = $false 
$f52.StartPosition = "CenterScreen" 
$f52.FormBorderStyle = 'Fixed3D' 
$f52.Text = "Change AdvancedSettings on $global:shost "
$f52.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f52_l1 = New-Object System.Windows.Forms.Label 
$f52_l1.Text = "The following AdvancedSettings parameter has been selected:"
$f52_l1.Size = New-Object System.Drawing.Size(400,20)
$f52_l1.Location = New-Object System.Drawing.Size(20,20) 
$f52.Controls.Add($f52_l1)

$f52_lb1 = New-Object System.Windows.Forms.Listbox 
$f52_lb1.Size = New-Object System.Drawing.Size(300,200)
$f52_lb1.Location = New-Object System.Drawing.Size(20,50) 

$f52_lb1.Items.Add($AdvancedSettingName)

$f52.Controls.Add($f52_lb1)

$f52_l6 = New-Object System.Windows.Forms.Label 
$f52_l6.Text = "Type new value: "
$f52_l6.Size = New-Object System.Drawing.Size(400,20)
$f52_l6.Location = New-Object System.Drawing.Size(20,270) 
$f52.Controls.Add($f52_l6)

$f52_tb6 = New-Object System.Windows.Forms.Textbox 
$f52_tb6.Size = New-Object System.Drawing.Size(250,30)
$f52_tb6.Location = New-Object System.Drawing.Size(20,290) 
$f52.Controls.Add($f52_tb6)

$f52_l7 = New-Object System.Windows.Forms.Label 
$f52_l7.Text = "(To be applied on $global:shost )"
$f52_l7.Size = New-Object System.Drawing.Size(400,20)
$f52_l7.Location = New-Object System.Drawing.Size(20,320) 
$f52.Controls.Add($f52_l7)

$f52_b1 = New-Object System.Windows.Forms.Button 
$f52_b1.Text = "Confirm"
$f52_b1.Size = New-Object System.Drawing.Size(100,25)
$f52_b1.Location = New-Object System.Drawing.Size(20,375) 
$f52_b1.Add_Click({HostAdvancedSettingsChange $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $AdvancedSettingName $f52_tb6.Text})
$f52_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f52.AcceptButton = $f52_b1
$f52.Controls.Add($f52_b1)

$f52_b2 = New-Object System.Windows.Forms.Button 
$f52_b2.Text = "Cancel"
$f52_b2.Size = New-Object System.Drawing.Size(100,25)
$f52_b2.Location = New-Object System.Drawing.Size(125,375) 
$f52_b2.Add_Click({})
$f52_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f52.CancelButton = $f52_b2
$f52.Controls.Add($f52_b2)

$f52.ShowDialog()
}
############## AdvancedSettings2-ColumnConfigChange Form - END

############## vDiskGroup ImportedCSV Confirmation - BEGIN
function f54_create([System.Object] $actualreport, [System.Object] $object){

$f54 = New-Object system.Windows.Forms.Form 
$f54.Width = 1150
$f54.Height = 700 
$f54.MaximizeBox = $false 
$f54.StartPosition = "CenterScreen" 
$f54.FormBorderStyle = 'Fixed3D' 
$f54.Text = "vSANDiskGroup ImportedCSV"
$f54.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f54_l1 = New-Object System.Windows.Forms.Label 
$f54_l1.Text = ">>> vSANDiskGroup ImportedCSV >>> "
$f54_l1.Size = New-Object System.Drawing.Size(700,20)
$f54_l1.Location = New-Object System.Drawing.Size(20,20) 
$f54.Controls.Add($f54_l1)

$f54_dg1 = New-Object System.Windows.Forms.DataGridView
$f54_dg1.Size = New-Object System.Drawing.Size(800,500)
$f54_dg1.Location = New-Object System.Drawing.Size(20,50)
$f54_dg1.ColumnCount = 4
$f54_dg1.ColumnHeadersVisible = $true
$f54_dg1.Columns[0].Name = "VMHost"
$f54_dg1.Columns[1].Name = "DiskGroup"
$f54_dg1.Columns[2].Name = "SsdCanonicalName"
$f54_dg1.Columns[3].Name = "DataDiskCanonicalName"

$actualreport | % {
$f54_dg1.Rows.Add($_.VMHost, $_.DiskGroup, $_.SsdCanonicalName, $_.DataDiskCanonicalName)
}
$f54.Controls.Add($f54_dg1)

$f54_l3 = New-Object System.Windows.Forms.Label 
$f54_l3.Text = "On the following objects:"
$f54_l3.Size = New-Object System.Drawing.Size(480,20)
$f54_l3.Location = New-Object System.Drawing.Size(840,155) 
$f54.Controls.Add($f54_l3)

$f54_lb1 = New-Object System.Windows.Forms.Listbox 
$f54_lb1.Size = New-Object System.Drawing.Size(275,200)
$f54_lb1.Location = New-Object System.Drawing.Size(840,180)

$object | % {
$f54_lb1.Items.Add("$($_.Name) ($($_.Cluster))")
}
$f54.Controls.Add($f54_lb1)


$f54_l2 = New-Object System.Windows.Forms.Label 
$f54_l2.Text = "Do you want to proceed with the change? "
$f54_l2.Size = New-Object System.Drawing.Size(700,20)
$f54_l2.Location = New-Object System.Drawing.Size(20,570) 
$f54.Controls.Add($f54_l2)

$f54_b1 = New-Object System.Windows.Forms.Button 
$f54_b1.Text = "Confirm"
$f54_b1.Size = New-Object System.Drawing.Size(100,25)
$f54_b1.Location = New-Object System.Drawing.Size(20,605) 
$f54_b1.Add_Click({})
$f54_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f54.AcceptButton = $f54_b1
$f54.Controls.Add($f54_b1)

$f54_b2 = New-Object System.Windows.Forms.Button 
$f54_b2.Text = "Cancel"
$f54_b2.Size = New-Object System.Drawing.Size(100,25)
$f54_b2.Location = New-Object System.Drawing.Size(125,605) 
$f54_b2.Add_Click({})
$f54_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f54.CancelButton = $f54_b2
$f54.Controls.Add($f54_b2)

$f54.ShowDialog()
}
############## vDiskGroup ImportedCSV Confirmation - END

############## Cluster VMkernel Inventory - BEGIN
function f55_create(){

$f55 = New-Object system.Windows.Forms.Form 
$f55.Width = 1150
$f55.Height = 700 
$f55.MaximizeBox = $false 
$f55.StartPosition = "CenterScreen" 
$f55.FormBorderStyle = 'Fixed3D' 
$f55.Text = "$global:scluster | VMkernel Inventory"
$f55.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f55_l1 = New-Object System.Windows.Forms.Label 
$f55_l1.Text = ">>> VMkernel Inventory >>> Current Selection: >>> $global:scluster "
$f55_l1.Size = New-Object System.Drawing.Size(900,20)
$f55_l1.Location = New-Object System.Drawing.Size(20,20) 
$f55.Controls.Add($f55_l1)

$f55_dg1 = New-Object System.Windows.Forms.DataGridView
$f55_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f55_dg1.Location = New-Object System.Drawing.Size(20,50)
$f55_dg1.ColumnCount = 10
$f55_dg1.ColumnHeadersVisible = $true
$f55_dg1.Columns[0].Name = "PortGroupName"
$f55_dg1.Columns[1].Name = "VMHost"
$f55_dg1.Columns[2].Name = "Cluster"
$f55_dg1.Columns[3].Name = "IP"
$f55_dg1.Columns[4].Name = "SubnetMask"
$f55_dg1.Columns[5].Name = "vMotionEnabled"
$f55_dg1.Columns[6].Name = "ManagementTrafficEnabled"
$f55_dg1.Columns[7].Name = "vSANTrafficEnabled"
$f55_dg1.Columns[8].Name = "mac"
$f55_dg1.Columns[9].Name = "devicename"

$actualreport=ClusterVMkernelInventory $global:scluster
$actualreport | % {
$f55_dg1.Rows.Add($_.PortGroupName, $_.VMHost, $_.Cluster, $_.IP, $_.SubnetMask, $_.vMotionEnabled, $_.ManagementTrafficEnabled, $_.vSANTrafficEnabled, $_.mac, $_.devicename)
}
$f55.Controls.Add($f55_dg1)

$f55_b1 = New-Object System.Windows.Forms.Button 
$f55_b1.Size = New-Object System.Drawing.Size(100,30)
$f55_b1.Location = New-Object System.Drawing.Size(20,605) 
$f55_b1.Text = "Close" 
$f55_b1.Add_Click({$f55.Close(); $f55.Dispose()})
$f55.Controls.Add($f55_b1)

$f55_b2 = New-Object System.Windows.Forms.Button 
$f55_b2.Size = New-Object System.Drawing.Size(100,30)
$f55_b2.Location = New-Object System.Drawing.Size(125,605) 
$f55_b2.Text = "Export-CSV" 
$f55_b2.Add_Click({ExportCSV $actualreport})
$f55.Controls.Add($f55_b2)

$f55.ShowDialog()
}
############## Cluster VMkernel Inventory - END

############## Cluster Logging Report - BEGIN
function f56_create(){

$f56 = New-Object system.Windows.Forms.Form 
$f56.Width = 1150
$f56.Height = 700 
$f56.MaximizeBox = $false 
$f56.StartPosition = "CenterScreen" 
$f56.FormBorderStyle = 'Fixed3D' 
$f56.Text = "$global:scluster | Cluster Logging Report"
$f56.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f56_l1 = New-Object System.Windows.Forms.Label 
$f56_l1.Text = ">>> Cluster Logging Report >>> Current Selection: >>> $global:scluster "
$f56_l1.Size = New-Object System.Drawing.Size(900,20)
$f56_l1.Location = New-Object System.Drawing.Size(20,20) 
$f56.Controls.Add($f56_l1)

$f56_dg1 = New-Object System.Windows.Forms.DataGridView
$f56_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f56_dg1.Location = New-Object System.Drawing.Size(20,50)
$f56_dg1.ColumnCount = 6
$f56_dg1.ColumnHeadersVisible = $true
$f56_dg1.Columns[0].Name = "Host"
$f56_dg1.Columns[1].Name = "Cluster"
$f56_dg1.Columns[2].Name = "CurrentScratchConfig"
$f56_dg1.Columns[3].Name = "ConfiguredScratchConfig"
$f56_dg1.Columns[4].Name = "SyslogDir"
$f56_dg1.Columns[5].Name = "GlobalLogHosts"

$actualreport=ClusterLoggingReport $global:scluster
$actualreport | % {
$f56_dg1.Rows.Add($_.Host, $_.Cluster, $_.CurrentScratchConfig, $_.ConfiguredScratchConfig ,$_.SyslogDir, $_.GlobalLogHosts)
}
$f56.Controls.Add($f56_dg1)

$f56_b1 = New-Object System.Windows.Forms.Button 
$f56_b1.Size = New-Object System.Drawing.Size(100,30)
$f56_b1.Location = New-Object System.Drawing.Size(20,605) 
$f56_b1.Text = "Close" 
$f56_b1.Add_Click({$f56.Close(); $f56.Dispose()})
$f56.Controls.Add($f56_b1)

$f56_b2 = New-Object System.Windows.Forms.Button 
$f56_b2.Size = New-Object System.Drawing.Size(100,30)
$f56_b2.Location = New-Object System.Drawing.Size(125,605) 
$f56_b2.Text = "Export-CSV" 
$f56_b2.Add_Click({ExportCSV $actualreport})
$f56.Controls.Add($f56_b2)

$f56.ShowDialog()
}
############## Cluster Logging Inventory - END

############## vSAN Operations Form - BEGIN
function f57_create(){

$f57 = New-Object system.Windows.Forms.Form 
$f57.Width = 400
$f57.Height = 350 
$f57.MaximizeBox = $false 
$f57.StartPosition = "CenterScreen" 
$f57.FormBorderStyle = 'Fixed3D' 
$f57.Text = "vSAN Operations"
$f57.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f57_l1 = New-Object System.Windows.Forms.Label 
$f57_l1.Text = "vSAN Operations | Select an option:"
$f57_l1.Size = New-Object System.Drawing.Size(1100,20)
$f57_l1.Location = New-Object System.Drawing.Size(20,20) 
$f57.Controls.Add($f57_l1)

$f57_lb1 = New-Object System.Windows.Forms.Listbox 
$f57_lb1.Size = New-Object System.Drawing.Size(300,200)
$f57_lb1.Location = New-Object System.Drawing.Size(20,50) 
$f57_lb1.Items.Add('Configure vSAN Disk Groups from CSV')
$f57_lb1.Items.Add('Display vSAN Disk Groups Information(*)')
$f57_lb1.Items.Add('Remove vSAN DiskGroups(*)')

$f57.Controls.Add($f57_lb1)

$f57_b1 = New-Object System.Windows.Forms.Button 
$f57_b1.Text = "Confirm"
$f57_b1.Size = New-Object System.Drawing.Size(100,25)
$f57_b1.Location = New-Object System.Drawing.Size(20,255) 
$f57_b1.Add_Click({
if($f57_lb1.SelectedItem -eq "Configure vSAN Disk Groups from CSV"){vsanDiskGroup $global:vcenter $global:scluster $global:bulkcollection}
})
$f57_b1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$f57.AcceptButton = $f57_b1
$f57.Controls.Add($f57_b1)

$f57_b2 = New-Object System.Windows.Forms.Button 
$f57_b2.Text = "Cancel"
$f57_b2.Size = New-Object System.Drawing.Size(100,25)
$f57_b2.Location = New-Object System.Drawing.Size(125,255) 
$f57_b2.Add_Click({})
$f57_b2.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$f57.CancelButton = $f57_b2
$f57.Controls.Add($f57_b2)

$f57.ShowDialog()
}
############## Bulk Operations Form - END

############## Remove Software VIB List - BEGIN
function f58_create(){

$f58 = New-Object system.Windows.Forms.Form 
$f58.Width = 1150
$f58.Height = 700 
$f58.MaximizeBox = $false 
$f58.StartPosition = "CenterScreen" 
$f58.FormBorderStyle = 'Fixed3D' 
$f58.Text = "$global:shost | Remove Software VIB"
$f58.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::regular)

$f58_l1 = New-Object System.Windows.Forms.Label 
$f58_l1.Text = ">>> Software VIB List >>> Current Selection: >>> $global:shost "
$f58_l1.Size = New-Object System.Drawing.Size(900,20)
$f58_l1.Location = New-Object System.Drawing.Size(20,20) 
$f58.Controls.Add($f58_l1)

$f58_dg1 = New-Object System.Windows.Forms.DataGridView
$f58_dg1.Size = New-Object System.Drawing.Size(1100,550)
$f58_dg1.Location = New-Object System.Drawing.Size(20,50)
$f58_dg1.ColumnCount = 8
$f58_dg1.ColumnHeadersVisible = $true
$f58_dg1.MultiSelect = $false
$f58_dg1.SelectionMode = "FullRowSelect"
$f58_dg1.Columns[0].Name = "Name"
$f58_dg1.Columns[1].Name = "AcceptanceLevel"
$f58_dg1.Columns[2].Name = "CreationDate"
$f58_dg1.Columns[3].Name = "ID"
$f58_dg1.Columns[4].Name = "InstallDate"
$f58_dg1.Columns[5].Name = "Status"
$f58_dg1.Columns[6].Name = "Vendor"
$f58_dg1.Columns[7].Name = "Version"

$actualreport=SoftwareVIBList $global:shost
$actualreport | % {
$f58_dg1.Rows.Add($_.Name, $_.AcceptanceLevel, $_.CreationDate, $_.ID, $_.InstallDate, $_.Status, $_.Vendor, $_.Version)
}
$f58.Controls.Add($f58_dg1)

$f58_b1 = New-Object System.Windows.Forms.Button 
$f58_b1.Size = New-Object System.Drawing.Size(100,30)
$f58_b1.Location = New-Object System.Drawing.Size(20,605) 
$f58_b1.Text = "Close" 
$f58_b1.Add_Click({$f58.Close(); $f58.Dispose()})
$f58.Controls.Add($f58_b1)

$f58_b2 = New-Object System.Windows.Forms.Button 
$f58_b2.Size = New-Object System.Drawing.Size(100,30)
$f58_b2.Location = New-Object System.Drawing.Size(125,605) 
$f58_b2.Text = "Export-CSV" 
$f58_b2.Add_Click({ExportCSV $actualreport})
$f58.Controls.Add($f58_b2)

$f58_b3 = New-Object System.Windows.Forms.Button 
$f58_b3.Size = New-Object System.Drawing.Size(100,30)
$f58_b3.Location = New-Object System.Drawing.Size(230,605) 
$f58_b3.Text = "Remove" 
$f58_b3.Add_Click({
$private:VIBName = $f58_dg1.SelectedRows[0].Cells["Name"].Value
removingvibfile $global:vcenter $global:scluster $global:shost $global:adminmode $global:adminmodehost $VIBName
})
$f58.Controls.Add($f58_b3)

$f58.ShowDialog()
}
############## Software VIB List - END

###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0) 
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

