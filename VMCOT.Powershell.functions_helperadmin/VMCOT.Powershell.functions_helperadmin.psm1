###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

##############################################################################################################################
#ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN ADMIN
##############################################################################################################################

#addhostbulkoperations
function addhostbulkoperations([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmodehost, [String] $adminmode){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){

$hostobject = New-Object System.Object
$hostobject | Add-Member -type NoteProperty -name Name -Value "$shost"
$hostobject | Add-Member -type NoteProperty -name Cluster -Value "$scluster"
$hostobject | Add-Member -type NoteProperty -name vCenter -Value "$vcenter"
$hostobject | Add-Member -type NoteProperty -name BulkAdminSelected -Value "1"
$hostobject | Add-Member -type NoteProperty -name AdminMode -Value "$AdminMode"
$hostobject | Add-Member -type NoteProperty -name AdminModeHost -Value "$AdminModeHost"
$global:bulkcollection.Add("$shost",$hostobject)
write-host ""
Write-host "$shost was added for Bulk Operations" -foregroundcolor yellow
write-host ""
}
#AdminMode Validator - FALSE
else
{
write-host ""
Write-host "Invalid Operation - Make sure you are running Admin Mode correctly"
write-host ""
}
}

#removehostbulkoperations
function removehostbulkoperations([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmodehost, [String] $adminmode){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){

$global:bulkcollection.Remove("$shost")
write-host ""
Write-host "$shost was removed for Bulk Operations" -foregroundcolor yellow
write-host ""
}
#AdminMode Validator - FALSE
else
{
write-host ""
Write-host "Invalid Operation - Make sure you are running Admin Mode correctly"
write-host ""
}
}

#clearhostbulkoperations
function clearhostbulkoperations([String] $vcenter, [String] $scluster, [String] $shost){
write-host ""
write-host "Selections have been cleared for Bulk Operations." -foregroundcolor yellow
write-host ""
$global:bulkcollection=@{}
Clear-Variable -Name bulkcollection
}

#AddvSwitchbulkoperations
function AddvSwitchbulkoperations([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $vswitchname, $vswitchactivenics, $vswitchstandbynics){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding vSwitch for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End

$private:vswitchname = $vswitchname
$Private:vswitchactivenics = @(($vswitchactivenics).split(',') | ForEach-Object {$_.trim()})
$Private:vswitchstandbynics = @(($vswitchstandbynics).split(',') | ForEach-Object {$_.trim()})
$private:vswitchnics = $vswitchactivenics + $vswitchstandbynics
start-sleep -s 3

write-host ""
write-host "vSwitch Name: $vswitchname " -foregroundcolor yellow
write-host "ACTIVE NICs: $vswitchactivenics " -foregroundcolor yellow
write-host "STANDBY NICs: $vswitchstandbynics " -foregroundcolor yellow
write-host ""

$private:message="vSwitch: $vswitchname | ACTIVE: $vswitchactivenics | STANDBY: $vswitchstandbynics"
$Private:confirm = confirmationbulk_form $message $bulkselection
if($private:confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
try{
New-VirtualSwitch -VMHost $bulkhost.Name -Name $vswitchname -Nic $vswitchnics
start-sleep -s 3
if($vswitchstandbynics -ne $NULL){
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicActive $vswitchactivenics -MakeNicStandby $vswitchstandbynics
}
else{
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicActive $vswitchactivenics
}
start-sleep -s 3
}
catch{
$error[0]
}
}
}

}

#AddvPortGroupbulkoperations
function AddvPortGroupbulkoperations([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $vswitchname, $vportgroup, $vlanid, $vportgroupactivenics, $vportgroupstandbynics){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding vPortGroup for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End

$private:vswitchname = $vswitchname
$private:vportgroup = $vportgroup
$private:vlanid = $vlanid
$Private:vportgroupactivenics = @(($vportgroupactivenics).split(',') | ForEach-Object {$_.trim()})
$Private:vportgroupstandbynics = @(($vportgroupstandbynics).split(',') | ForEach-Object {$_.trim()})
$private:vportgroupnics = $vportgroupactivenics + $vportgroupstandbynics
start-sleep -s 3

write-host ""
write-host "vSwitch Name: $vswitchname " -foregroundcolor yellow
write-host "vPortGroup: $vportgroup " -foregroundcolor yellow
write-host "VLANID: $vlanid " -foregroundcolor yellow
write-host "ACTIVE NICs: $vportgroupactivenics " -foregroundcolor yellow
write-host "STANDBY NICs: $vportgroupstandbynics " -foregroundcolor yellow
write-host ""

$private:message="vSwitch: $vswitchname | vPortGroup: $vportgroup | vlanid: $vlanid | Active: $vportgroupactivenics | StandBy: $vportgroupstandbynics"
$Private:confirm = confirmationbulk_form $message $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
try{
$private:vswitch=Get-VirtualSwitch -VMHost $bulkhost.Name -Name $vswitchname
$private:vportgroupcheck=Get-VirtualPortGroup -VirtualSwitch $vswitch -Name $vPortGroup -ErrorAction SilentlyContinue
start-sleep -s 3
if($vswitch -ne $NULL){
if(!$vportgroupcheck){
New-VirtualPortGroup -VirtualSwitch $vswitch -Name $vPortGroup -VLANID $vlanid
start-sleep -s 3
}
else{
write-host ""
write-host "VirtualPortGroup $vportgroup already exists (skipping creation, only teaming configuration will be updated. " -foregroundcolor yellow
write-host ""
}
#
if(($vportgroupactivenics)-AND($vportgroupstandbynics)){
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -InheritFailoverOrder $false
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicUnused $vswitch.nic
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicActive $vportgroupactivenics -MakeNicStandby $vportgroupstandbynics
}
if((!$vportgroupactivenics)-AND($vportgroupstandbynics)){
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -InheritFailoverOrder $false
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicUnused $vswitch.nic
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicStandby $vportgroupstandbynics
}
if(($vportgroupactivenics)-AND(!$vportgroupstandbynics)){
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -InheritFailoverOrder $false
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicUnused $vswitch.nic
Get-virtualswitch -VMHost $bulkhost.Name -Name $vswitchname | get-virtualportgroup -Name $vportgroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicActive $vportgroupactivenics
}
#
}
else{
write-host ""
write-host "$bulkhost.Name does not have a vSwitch named $vswitchname " -foregroundcolor red
write-host ""
}
start-sleep -s 3
}
catch{
$error[0]
}
}
}
}

#AdminAddSATPRulesBulkOperations
function AdminAddSATPRulesBulkOperations([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $adminsatprule_name, $adminsatprule_vendor, $adminsatprule_claimoptions, $adminsatprule_defaultpsp, $adminsatprule_pspoptions, $adminsatprule_model, $adminsatprule_description ){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding SATP Rule for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End

write-host ""
$private:adminsatprule_name = $adminsatprule_name
$private:adminsatprule_vendor = $adminsatprule_vendor
$private:adminsatprule_claimoptions = $adminsatprule_claimoptions
$private:adminsatprule_defaultpsp = $adminsatprule_defaultpsp
$private:adminsatprule_pspoptions = $adminsatprule_pspoptions
$private:adminsatprule_model = $adminsatprule_model
$private:adminsatprule_description = $adminsatprule_description
write-host ""
write-host "Summary for new SATP rule: "
write-host ""
write-host "$adminsatprule_name"
write-host "$adminsatprule_vendor"
write-host "$adminsatprule_claimoptions"
write-host "$adminsatprule_defaultpsp"
write-host "$adminsatprule_pspoptions"
write-host "$adminsatprule_model"
write-host "$adminsatprule_description"
write-host ""
$message="Name: $adminsatprule_name | Vendor: $adminsatprule_vendor | Claimoptions: $adminsatprule_claimoptions | DefaultPSP: $adminsatprule_defaultpsp | PSPOptions: $adminsatprule_pspoptions | Model: $adminsatprule_model | Description: $adminsatprule_description "
$private:adminsatpruleaddconfirm = confirmationbulk_form $message $bulkselection
if($adminsatpruleaddconfirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
$private:esxcliv2 = Get-EsxCli -VMHost $bulkhost.Name -V2
start-sleep -s 3
$private:adminsatprulehashtable=$esxcliv2.storage.nmp.satp.rule.add.createargs()
start-sleep -s 3
$private:adminsatprulehashtable.satp=$adminsatprule_name
$private:adminsatprulehashtable.vendor=$adminsatprule_vendor
$private:adminsatprulehashtable.claimoption=$adminsatprule_claimoptions
$private:adminsatprulehashtable.psp=$adminsatprule_defaultpsp
$private:adminsatprulehashtable.pspoption=$adminsatprule_pspoptions
$private:adminsatprulehashtable.model=$adminsatprule_model
$private:adminsatprulehashtable.description=$adminsatprule_description

try{
$esxcliv2.storage.nmp.satp.rule.add.invoke($adminsatprulehashtable)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to create SATP rule on $($bulkhost.Name)"
write-host ""
}
write-host ""
Write-host "SATP was created on $$(bulkhost.Name)"
write-host ""
}

}
else{
write-host ""
Write-host "Operation was canceled"
write-host ""
}
}

#AdminDelSATPRulesBulkOperations
function AdminDelSATPRulesBulkOperations([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $adminsatprule_name, $adminsatprule_vendor, $adminsatprule_claimoptions, $adminsatprule_defaultpsp, $adminsatprule_pspoptions, $adminsatprule_model, $adminsatprule_description ){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Removing SATP Rule for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End

write-host ""
$private:adminsatprule_name = $adminsatprule_name
$private:adminsatprule_vendor = $adminsatprule_vendor
$private:adminsatprule_claimoptions = $adminsatprule_claimoptions
$private:adminsatprule_defaultpsp = $adminsatprule_defaultpsp
$private:adminsatprule_pspoptions = $adminsatprule_pspoptions
$private:adminsatprule_model = $adminsatprule_model
$private:adminsatprule_description = $adminsatprule_description
write-host ""
write-host "Summary for Removal of SATP rule: "
write-host ""
write-host "$adminsatprule_name"
write-host "$adminsatprule_vendor"
write-host "$adminsatprule_claimoptions"
write-host "$adminsatprule_defaultpsp"
write-host "$adminsatprule_pspoptions"
write-host "$adminsatprule_model"
write-host "$adminsatprule_description"
write-host ""
$message="DELETING | Name: $adminsatprule_name | Vendor: $adminsatprule_vendor | Claimoptions: $adminsatprule_claimoptions | DefaultPSP: $adminsatprule_defaultpsp | PSPOptions: $adminsatprule_pspoptions | Model: $adminsatprule_model | Description: $adminsatprule_description "
$private:adminsatpruledelconfirm = confirmationbulk_form $message $bulkselection
if($adminsatpruledelconfirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
$private:esxcliv2 = Get-EsxCli -VMHost $bulkhost.Name -V2
start-sleep -s 3
$private:adminsatprulehashtable=$esxcliv2.storage.nmp.satp.rule.remove.createargs()
start-sleep -s 3
$private:adminsatprulehashtable.satp=$adminsatprule_name
$private:adminsatprulehashtable.vendor=$adminsatprule_vendor
$private:adminsatprulehashtable.claimoption=$adminsatprule_claimoptions
$private:adminsatprulehashtable.psp=$adminsatprule_defaultpsp
$private:adminsatprulehashtable.pspoption=$adminsatprule_pspoptions
$private:adminsatprulehashtable.model=$adminsatprule_model
$private:adminsatprulehashtable.description=$adminsatprule_description

try{
$esxcliv2.storage.nmp.satp.rule.remove.invoke($adminsatprulehashtable)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to remove SATP rule on $($bulkhost.Name)"
write-host ""
}
write-host ""
Write-host "SATP was removed on $$(bulkhost.Name)"
write-host ""
}

}
else{
write-host ""
Write-host "Operation was canceled"
write-host ""
}
}

#AddvPortGroupbulkoperationsCSV
function AddvPortGroupbulkoperationsCSV([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding vPortGroup for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End

$private:csvdetail=ImportCSV

start-sleep -s 3
write-host ""

$Private:confirm = f36_create $csvdetail $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
$csvdetail | ForEach-Object{

try{
$private:vswitch=Get-VirtualSwitch -VMHost $bulkhost.Name -Name $_.vSwitch
$private:vportgroupcheck=Get-VirtualPortGroup -VirtualSwitch $vswitch -Name $_.vPortGroup -ErrorAction SilentlyContinue
start-sleep -s 3
if($vswitch -ne $NULL){
if(!$vportgroupcheck){
New-VirtualPortGroup -VirtualSwitch $vswitch -Name $_.vPortGroup -VLANID $_.vLANID
start-sleep -s 3
}
else{
write-host ""
write-host "VirtualPortGroup $_.vportgroup already exists (skipping creation, only teaming configuration will be updated. " -foregroundcolor yellow
write-host ""
}
#
if(($_.vportgroupactivenics)-AND($_.vportgroupstandbynics)){
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -InheritFailoverOrder $false
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicUnused $vswitch.nic
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicActive $_.vportgroupactivenics -MakeNicStandby $_.vportgroupstandbynics
}
if((!$_.vportgroupactivenics)-AND($_.vportgroupstandbynics)){
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -InheritFailoverOrder $false
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicUnused $vswitch.nic
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicStandby $_.vportgroupstandbynics
}
if(($_.vportgroupactivenics)-AND(!$_.vportgroupstandbynics)){
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -InheritFailoverOrder $false
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicUnused $vswitch.nic
Get-virtualswitch -VMHost $bulkhost.Name -Name $_.vSwitch | get-virtualportgroup -Name $_.vPortGroup | get-nicteamingpolicy | set-nicteamingpolicy -MakeNicActive $_.vportgroupactivenics
}
#

}
else{
write-host ""
write-host "$bulkhost.Name does not have a vSwitch named $_.vSwitch " -foregroundcolor red
write-host ""
}
}
catch{
$error[0]
}
}
}
}
}

#AddVMkernelbulkoperationsCSV
function AddVMkernelbulkoperationsCSV([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding VMkernel for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End

$private:csvdetail=ImportCSV

start-sleep -s 3
write-host ""

$Private:confirm = f37_create $csvdetail $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{

$csvdetail | where {$_.ESXiHost -eq $bulkhost.Name}| ForEach-object {

if($_.ManagementTraffic  -eq "Y")
{
$private:ManagementTraffic = $TRUE
}
else
{
$private:ManagementTraffic = $FALSE
}

if($_.vSANTraffic -eq "Y")
{
$private:vSANTraffic = $TRUE
}
else
{
$private:vSANTraffic = $FALSE
}

if($_.vMotionTraffic -eq "Y")
{
$private:vMotionTraffic = $TRUE
}
else
{
$private:vMotionTraffic = $FALSE
}

try{
$private:vswitch=Get-VirtualSwitch -VMHost $bulkhost.Name -Name $_.vSwitch
start-sleep -s 3
if($vswitch -ne $NULL){
$bulkhostname=$bulkhost.Name
New-VMHostNetworkAdapter -VMHost $bulkhost.Name -VirtualSwitch $vswitch -PortGroup $_.VMkernelAdapterName -IP $_.VMkernelAdapterIP -SubnetMask $_.VMkernelAdapterNetworkMask -ManagementTrafficEnabled $ManagementTraffic -VMotionEnabled $vMotionTraffic -VsanTrafficEnabled $vSANTraffic
}
else{
write-host ""
write-host "$bulkhost.Name does not have a vSwitch named $_.vSwitch " -foregroundcolor red
write-host ""
}
start-sleep -s 3
}
catch{
$error[0]
}
}
}
}
}

#adminesxjoindomain
function adminesxjoindomain([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $domain, $domainprivilegedaccount){
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding AD Domain for the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""

$Private:domain = $domain
$Private:domainprivilegedaccount = $domainprivilegedaccount
write-host ""
$message="Joining ESX Servers to domain $domain (by using $domainprivilegedaccount account)."
$Private:confirm = confirmationbulk_form $message $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{

try{
Get-VMHostAuthentication -VMHost $bulkhost.Name | Set-VMHostAuthentication -JoinDomain -Domain $domain -User $domainprivilegedaccount -Confirm:$false
}
catch{
$error[0]
}
}
}
else{
write-host "The operation was canceled."
}
}

#adminesxntpserver
function adminesxntpserver([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $ntpserver){
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding NTP Server for the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""

$Private:ntpserver = $ntpserver
write-host ""
$message="Adding NTP Server $ntpserver to ESX Servers."
$Private:confirm = confirmationbulk_form $message $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
try{
Add-VmHostNtpServer -NtpServer $ntpserver -VMHost $bulkhost.name
if((Get-VMHostService -VMHost $bulkhost.name | Where-Object {$_.Key -eq "ntpd" } | select Running).Running -eq $FALSE){
Get-VMHostService -VMHost $bulkhost.name | Where-Object {$_.Key -eq "ntpd" } | Start-VMHostService -Confirm:$false
}
}
catch{
$error[0]
}
}
}
else{
write-host "The operation was canceled."
}
}

#adminesxdnsstuff
function adminesxdnsstuff([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection, $DomainName, $DNSAddress, $SearchDomain){
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Adding DNS Configuration for the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""

$Private:DomainName = $DomainName
$Private:DnsAddress = ($DNSAddress).split(',') | ForEach-Object {$_.trim()}
$Private:SearchDomain = ($SearchDomain).split(',') | ForEach-Object {$_.trim()}

write-host ""
$message="Adding DNS Configuration: DomainName: $DomainName | DnsAddress: $DnsAddress | SearchDomain: $SearchDomain"
$Private:confirm = confirmationbulk_form $message $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
try{
$hostname=($bulkhost.name).Split(".")[0]
Get-VMHostNetwork -VMHost $bulkhost.name | Set-VMHostNetwork -Hostname $hostname -DomainName $domainname -DNSAddress $DnsAddress -SearchDomain $SearchDomain -Confirm:$false
}
catch{
$error[0]
}
}
}
else{
write-host "The operation was canceled."
}
}

#adminesxdisableatsheartbeat
function adminesxdisableatsheartbeat([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection){
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Disabling ATS Heartbeat for VMFS5 on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""

$private:message="Disabling ATS Heartbeat for VMFS5"

$Private:confirm = confirmationbulk_form $message $bulkselection
if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
$private:esxcliv2 = Get-EsxCli -VMHost $bulkhost.name -V2
start-sleep -s 3
$Private:advancedparameters=$esxcliv2.system.settings.advanced.set.createargs()
start-sleep -s 3
$Private:advancedparameters.intvalue=0
$Private:advancedparameters.option="/VMFS3/UseATSForHBOnVMFS5"
try{
$esxcliv2.system.settings.advanced.set.invoke($advancedparameters)
start-sleep -s 3
}
catch{
$error[0]
}
}
}
else{
write-host "The operation was canceled."
}
}

#adminesxloggingsettings
function adminesxloggingsettings([String] $vcenter, [String] $scluster,[String] $shost, [String] $adminmode, [String] $adminmodehost, $datastoreselectname, $GlobalLogHosts){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){

$private:newfoldername = ".locker-" + $shost
$private:OldScratchConfig=(Get-VMhost $shost | Get-AdvancedSetting -Name "ScratchConfig.CurrentScratchLocation").Value
$private:OldSyslogDir=(Get-VMhost $shost | Get-AdvancedSetting -Name "Syslog.global.logDir").Value
$private:OldGlobalLogHosts=(Get-VMhost $shost | Get-AdvancedSetting -Name "Syslog.global.logHost").Value
$private:ScratchConfig = "/vmfs/volumes/"+$datastoreselectname+"/"+$newfoldername
$private:SyslogDir= "[" + "$datastoreselectname" + "]" + " " + "LOGS/" + $shost
$private:GlobalLogHosts = $GlobalLogHosts


$Private:confirm = confirmationlogging_form $OldScratchConfig $OldSyslogDir $OldGlobalLogHosts $ScratchConfig $SyslogDir $GlobalLogHosts
if($confirm -eq "OK"){
try{
New-PSDrive -Name "mounteddatastore" -Root \ -PSProvider VimDatastore -Datastore (Get-VMHost $shost | Get-Datastore "$datastoreselectname")
Set-Location mounteddatastore:\
New-Item "$newfoldername" -ItemType directory
New-Item "LOGS" -ItemType directory
Set-Location mounteddatastore:\LOGS\
New-Item "$shost" -ItemType directory
cd $home
Remove-PSDrive -Name "mounteddatastore"
start-sleep -s 3
Get-VMhost $shost | Get-AdvancedSetting -Name "ScratchConfig.ConfiguredScratchLocation" | Set-AdvancedSetting -Value $ScratchConfig -Confirm:$false
start-sleep -s 3
Get-VMhost $shost | Get-AdvancedSetting -Name "Syslog.global.logDir" | Set-AdvancedSetting -Value $SyslogDir -Confirm:$false
start-sleep -s 3
Get-VMhost $shost | Get-AdvancedSetting -Name "Syslog.global.logHost" | Set-AdvancedSetting -Value $GlobalLogHosts -Confirm:$false
}
catch{
$error[0]
}
}
else{
write-host "The operation was canceled."
}
}
}

#UploadVIBFile
function uploadingvibfile([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, $datastoreselectname){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){
$private:datastorename=$datastoreselectname
$private:VIBFile = ImportVIB

$private:message="Upload VIB File to $shost "
$Private:confirm = confirmation_form $message
if($confirm -eq "OK"){

New-PSDrive -Name "mounteddatastore" -Root \ -PSProvider VimDatastore -Datastore (Get-VMHost $shost | Get-Datastore "$datastorename")
Set-Location mounteddatastore:\
New-Item "ShareVMwareTool-UploadedVIBFiles" -ItemType directory
Set-Location mounteddatastore:\ShareVMwareTool-UploadedVIBFiles\
Copy-DatastoreItem -item $VibFile -Destination mounteddatastore:\ShareVMwareTool-UploadedVIBFiles\
cd $home
Remove-PSDrive -Name "mounteddatastore"

}
else{
write-host "The operation was canceled."
}
}
}

#InstallVIBFile
function installingvibfile([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, $datastoreselectname, $VIBFile){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){
$private:datastorename=$datastoreselectname
$private:VIBFileName = $VIBFile

$private:message="Installing Bundle $($VIBFile) on $shost "
$Private:confirm = confirmation_form $message
if($confirm -eq "OK"){
$datastore=get-vmhost $shost | get-datastore "$datastorename"
$filelocation=$Datastore.ExtensionData.Info.Url.remove(0,5) + "ShareVMwareTool-UploadedVIBFiles/" + $VIBFileName
$private:esxcliv2 = Get-EsxCli -VMHost $shost -V2
$private:vibargs=$esxcliv2.software.vib.install.createargs()
#$vibargs.depot=$filelocation
$vibargs.viburl=$filelocation
$vibargs.dryrun=$False
try{
$private:result=$esxcliv2.software.vib.install.invoke($vibargs)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to install VIB"
write-host ""
}
}
else{
write-host "The operation was canceled."
}
}
}

#UpdateVIBFile
function updatingvibfile([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, $datastoreselectname, $VIBFile){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){
$private:datastorename=$datastoreselectname
$private:VIBFileName = $VIBFile

$private:message="Updating Bundle $($VIBFile) on $shost "
$Private:confirm = confirmation_form $message
if($confirm -eq "OK"){
$datastore=get-vmhost $shost | get-datastore "$datastorename"
$filelocation=$Datastore.ExtensionData.Info.Url.remove(0,5) + "ShareVMwareTool-UploadedVIBFiles/" + $VIBFileName
$private:esxcliv2 = Get-EsxCli -VMHost $shost -V2
$private:vibargs=$esxcliv2.software.vib.update.createargs()
$vibargs.depot=$filelocation
#$vibargs.viburl=$filelocation
$vibargs.dryrun=$False
try{
$private:result=$esxcliv2.software.vib.update.invoke($vibargs)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to Update VIB"
write-host ""
}
}
else{
write-host "The operation was canceled."
}
}
}

#RemoveVIBFile
function removingvibfile([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, $VIBFile){
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){
$private:VIBFileName = $VIBFile

$private:message="Removing Bundle $($VIBFile) from $shost "
$Private:confirm = confirmation_form $message
if($confirm -eq "OK"){
$private:esxcliv2 = Get-EsxCli -VMHost $shost -V2
$private:vibargs=$esxcliv2.software.vib.remove.createargs()
$vibargs.vibname=$VIBFileName
$vibargs.dryrun=$False
try{
$private:result=$esxcliv2.software.vib.remove.invoke($vibargs)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to install VIB"
write-host ""
}
}
else{
write-host "The operation was canceled."
}
}
}


############## StorageCoreDevicesParam - BEGIN
function StorageCoreDevicesParam([String] $shost){
$private:StorageCoreDevices=@()
$private:esxcliv2 = Get-EsxCli -VMHost $global:SHOST -V2
$private:CoreDevices=$esxcliv2.storage.core.device.list.invoke() | select -property * | sort-object Device
$CoreDevices | % {

	$StorageCoreDevice = new-object System.Object
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name Device -Value $_.Device
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name DisplayName -Value $_.DisplayName
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name DeviceMaxQueueDepth -Value $_.DeviceMaxQueueDepth
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name DeviceType -Value $_.DeviceType
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name DevfsPath -Value $_.DevfsPath
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name HasSettableDisplayName -Value $_.HasSettableDisplayName
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsBootDevice -Value $_.IsBootDevice
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsBootUSBDevice -Value $_.IsBootUSBDevice
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsLocal -Value $_.IsLocal
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsLocalSASDevice -Value $_.IsLocalSASDevice
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsOffline -Value $_.IsOffline
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsPerenniallyReserved -Value $_.IsPerenniallyReserved
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsPseudo -Value $_.IsPseudo
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsRDMCapable -Value $_.IsRDMCapable
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsRemovable -Value $_.IsRemovable
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsSAS -Value $_.IsSAS
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsSSD -Value $_.IsSSD
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsSharedClusterwide -Value $_.IsSharedClusterwide
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name IsUSB -Value $_.IsUSB
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name Model -Value $_.Model
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name MultiPathPlugin -Value $_.MultiPathPlugin
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name NoofoutstandingIOswithcompetingworlds -Value $_.NoofoutstandingIOswithcompetingworlds
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name OtherUIDs -Value ($_.OtherUIDs -join ',')
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name QueueFullSampleSize -Value $_.QueueFullSampleSize
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name QueueFullThreshold -Value $_.QueueFullThreshold
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name Revision -Value $_.Revision
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name SCSILevel -Value $_.SCSILevel
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name Size -Value $_.Size
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name Status -Value $_.Status
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name ThinProvisioningStatus -Value $_.ThinProvisioningStatus
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name VAAIStatus -Value $_.VAAIStatus
	$StorageCoreDevice | Add-Member -Type NoteProperty -Name Vendor -Value $_.Vendor
	


	$StorageCoreDevices+=$StorageCoreDevice
}
return $StorageCoreDevices
}
############## StorageCoreDevicesParam - END

############## StorageCoreDevicesParamChange - BEGIN
function StorageCoreDevicesParamChange([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, $parameter, $parametervalue, [System.Object] $NMPDevices){
#AdminMode Validator - TRUE
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){

$private:NMPSelections = $NMPDevices.values | select Device, DeviceMaxQueueDepth, VMHost | Sort-object Device

$private:message="Changing value for parameter $parameter to $parametervalue"
$private:confirm=confirmbulk_nmpdevice_form $message $NMPSelections
if($confirm -eq "OK"){



##
if(($parameter -eq "maxqueuedepth") -AND ($parametervalue -ne "")){
$private:esxcliv2 = Get-EsxCli -VMHost $SHOST -v2
$NMPSelections | %{
$private:parammenu=""
$private:parammenu=$esxcliv2.storage.core.device.set.createargs()
$private:parammenu.device=$_.Device
$private:parammenu.maxqueuedepth=$parametervalue
try{
$esxcliv2.storage.core.device.set.Invoke($parammenu)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to modify parameter on $shost | $($parammenu.device) "
write-host ""
}
}
}
##

##
if(($parameter -eq "schednumreqoutstanding") -AND ($parametervalue -ne "")){
$private:esxcliv2 = Get-EsxCli -VMHost $SHOST -v2
$NMPSelections | %{
$private:parammenu=""
$private:parammenu=$esxcliv2.storage.core.device.set.createargs()
$private:parammenu.device=$_.Device
$private:parammenu.schednumreqoutstanding=$parametervalue
try{
$esxcliv2.storage.core.device.set.Invoke($parammenu)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to modify parameter on $shost | $($parammenu.device) "
write-host ""
}
}
}
##

##
if(($parameter -eq "QueueFullSampleSize") -AND ($parametervalue -ne "")){
$private:esxcliv2 = Get-EsxCli -VMHost $SHOST -v2
$NMPSelections | %{
$private:parammenu=""
$private:parammenu=$esxcliv2.storage.core.device.set.createargs()
$private:parammenu.device=$_.Device
$private:parammenu.queuefullsamplesize=$parametervalue
$private:parammenu.queuefullthreshold=4
try{
$esxcliv2.storage.core.device.set.Invoke($parammenu)
start-sleep -s 3
}
catch{
$Error[0]
write-host ""
Write-host "Failed to modify parameter on $shost | $($parammenu.device) "
write-host ""
}
}
}
##

}
else
{
write-host "Operations was canceled"
}
}
#AdminMode Validator - FALSE
else
{
write-host ""
Write-host "Invalid Operation - Make sure you are running Admin Mode correctly"
write-host ""
}
}
############## StorageCoreDevicesParamChange - END

############## NMPListDevicesConfig - BEGIN
function NMPDeviceFullListConfig([String] $shost){
$private:NMPDeviceItems=@()
$private:esxcliv2 = Get-EsxCli -VMHost $global:SHOST -V2
$private:NMPDevices=$esxcliv2.storage.nmp.device.list.invoke() | select -property * | sort-object Device
$NMPDevices | % {

	$NMPDeviceItem = new-object System.Object
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name Device -Value $_.Device
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name DeviceDisplayName -Value $_.DeviceDisplayName
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name IsBootUSBDevice -Value $_.IsBootUSBDevice
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name IsLocalSASDevice -Value $_.IsLocalSASDevice
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name IsUSB -Value $_.IsUSB
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name PathSelectionPolicy -Value $_.PathSelectionPolicy
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name PathSelectionPolicyDeviceConfig -Value $_.PathSelectionPolicyDeviceConfig
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name PathSelectionPolicyDeviceCustomConfig -Value $_.PathSelectionPolicyDeviceCustomConfig
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name StorageArrayType -Value $_.StorageArrayType
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name StorageArrayTypeDeviceConfig -Value $_.StorageArrayTypeDeviceConfig
	#$NMPDeviceItem | Add-Member -Type NoteProperty -Name WorkingPaths -Value (($_.WorkingPaths | Out-String).Trim())
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name WorkingPaths -Value ($_.WorkingPaths -join ',')

	$NMPDeviceItems+=$NMPDeviceItem
}
return $NMPDeviceItems
}
############## NMPListDevicesConfig - END

############## NMPDeviceFullListConfigChange - BEGIN
function NMPDeviceFullListConfigChange([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, [System.Object] $NMPDevices){
#AdminMode Validator - TRUE
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){

$private:NMPSelections = $NMPDevices.values | select Device, VMHost | Sort-object Device
$private:message="Changing PSP Policy to IOPS=1"
$private:confirm=confirmbulk_nmpdevice_form $message $NMPSelections
if($confirm -eq "OK"){
$private:esxcliv2 = Get-EsxCli -VMHost $global:SHOST -V2
$NMPSelections | %{
$DeviceRoundRobinArgs=""
$DeviceRoundRobinArgs=$esxcliv2.storage.nmp.psp.roundrobin.deviceconfig.set.createargs()
$DeviceRoundRobinArgs.device=$_.Device
$DeviceRoundRobinArgs.type = "iops"
$DeviceRoundRobinArgs.iops = 1
start-sleep -s 3
try{
$esxcliv2.storage.nmp.psp.roundrobin.deviceconfig.set.invoke($DeviceRoundRobinArgs)
}
catch
{
$Error[0]
write-host ""
Write-host "Failed to modify parameter on $shost | $SNMPDeviceName"
write-host ""
}
}
}
}
#AdminMode Validator - FALSE
else
{
write-host ""
Write-host "Invalid Operation - Make sure you are running Admin Mode correctly"
write-host ""
}
}
############## NMPDeviceFullListConfigChange - END

############## HostAdvancedSettingsChange - BEGIN
function HostAdvancedSettingsChange([String] $vcenter, [String] $scluster, [String] $shost, [String] $adminmode, [String] $adminmodehost, [String] $AdvancedSettingName, $AdvancedSettingValue){
#AdminMode Validator - TRUE
if(($adminmode -eq 1)-and($adminmodehost -eq $shost)){
$private:message="Changing AdvancedSetting on $shost"
$private:confirm=confirmation_form $message
if($confirm -eq "OK"){
try{
Get-AdvancedSetting -Entity $shost | where {$_.Name -eq $AdvancedSettingName} | Set-AdvancedSetting -Value $AdvancedSettingValue -Confirm:$false
}
catch{
$Error[0]
write-host ""
Write-host "Failed to modify advanced setting on $shost | $AdvancedSettingName"
write-host ""
}
}
}
#AdminMode Validator - FALSE
else
{
write-host ""
Write-host "Invalid Operation - Make sure you are running Admin Mode correctly"
write-host ""
}
}
############## HostAdvancedSettingsChange - END

############## vSANDiskGroup - BEGIN
function vsanDiskGroup([String] $vcenter, [String] $scluster, [System.Object] $bulkcollection){
#Bulk selection definition Beginning
$private:bulkhost = ""
$private:bulkselection=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -eq $vcenter) -and ($_.BulkAdminSelected -eq 1) -and ($_.AdminMode -eq 1))}
$private:bulkexclusion=$bulkcollection.values | select Name, Cluster, vCenter, BulkAdminSelected, AdminMode | where {(($_.vCenter -ne $vcenter) -or ($_.BulkAdminSelected -ne 1) -or ($_.AdminMode -ne 1))}
write-host ""
write-host "Creating vSAN DiskGroups for on the following hosts:" -foregroundcolor yellow
write-host ""
write-host "$($bulkselection.Name)"
write-host ""
write-host "The following hosts will be excluded as they do not meet requirements:" -foregroundcolor yellow
write-host ""
write-host "$($bulkexclusion.Name)"
write-host ""
#Bulk selection definition End
$private:csvdetail=ImportCSV
$Private:confirm = f54_create $csvdetail $bulkselection


if($confirm -eq "OK"){

foreach ($bulkhost in $bulkselection)
{
$csvdetail | ForEach-Object{
$Private:DataDisks = @(($_.DataDiskCanonicalName).split(',') | ForEach-Object {$_.trim()})
if($_.VMHost -eq $bulkhost.name){
try{
New-VsanDiskGroup -VMHost $bulkhost.name -SsdCanonicalName $_.SsdCanonicalName -DataDiskCanonicalName $DataDisks
}
catch{
$error[0]
}
}
}
}
}
}
############## vSANDiskGroup - END


###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################