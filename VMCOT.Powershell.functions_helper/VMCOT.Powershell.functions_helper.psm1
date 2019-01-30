###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

############## vCenter Connection BEGIN
function vcenterconnection(){

$private:Ivcenter = $global:vcenter
write-host "Selection: $private:Ivcenter"

# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - BEGIN ************************************************************
# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - BEGIN ************************************************************

if ($private:Ivcenter -match "vcenter01p.domain.local"){ # CHANGE this to the FQDN of your first vCenter Instance
$global:vcenter = "vcenter01p.domain.local" # CHANGE this to the FQDN of your first vCenter Instance
$global:vcconnection=Disconnect-VIServer * -force -Confirm:$false -ErrorAction Continue
$global:vcconnection=connect-viserver $global:vcenter -ErrorAction Continue
}

#elseif ($private:Ivcenter -match "vcenter02p.domain.local"){ # CHANGE this to the FQDN of your second vCenter Instance - OPTIONAL / Only uncomment if needed
#$global:vcenter = "vcenter02p.domain.local" # CHANGE this to the FQDN of your second vCenter Instance - OPTIONAL / Only uncomment if needed
#$global:vcconnection=Disconnect-VIServer * -force -Confirm:$false -ErrorAction Continue / Only uncomment if needed
#$global:vcconnection=connect-viserver $global:vcenter -ErrorAction Continue / Only uncomment if needed
#}

#elseif ($private:Ivcenter -match "vcenter03p.domain.local"){ # CHANGE this to the FQDN of your third vCenter Instance - OPTIONAL / Only uncomment if needed
#$global:vcenter = "vcenter03p.domain.local" # CHANGE this to the FQDN of your third vCenter Instance - OPTIONAL / Only uncomment if needed
#$global:vcconnection=Disconnect-VIServer * -force -Confirm:$false -ErrorAction Continue / Only uncomment if needed
#$global:vcconnection=connect-viserver $global:vcenter -ErrorAction Continue / Only uncomment if needed
#}

# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - END ************************************************************
# *********************************************** CHANGE THIS TO YOUR VCENTER INSTANCE FQDN - END ************************************************************

else{
$global:vcenter = "Disconnect from all vCenter instances"
$global:vcconnection=Disconnect-VIServer * -force -Confirm:$false -ErrorAction Continue
}

}
############## vCenter Connection END

############## Initialize Variables BEGIN
function initialize_globalvariables(){
$global:Date = Get-Date | Sort-Object -Property Name
$global:vcenter=""
$global:scluster=""
$global:shost=""
$global:svm=""
$global:AdminMode="0"
$global:AdminModeHost=""
#$global:SNMPDevice=""
$global:bulkcollection=@{}
#$global:ErrorActionPreference="SilentlyContinue"
$global:ErrorActionPreference="Continue"
$global:vcconnection=""

Clear-Variable -Name vcenter
Clear-Variable -Name scluster
Clear-Variable -Name shost
Clear-Variable -Name svm
Clear-Variable -Name AdminMode
Clear-Variable -Name AdminModeHost
#Clear-Variable -Name SNMPDevice
Clear-Variable -Name bulkcollection
}
############## Initialize Variables END

############## vCenter Active Alerts BEGIN
function vCenterActiveAlerts([String] $global:vcenter){
$rootFolder = Get-Folder -Server $vcenter "Datacenters"
$alarms= @()
foreach ($ta in $rootFolder.ExtensionData.TriggeredAlarmState) {

$AlarmName = (Get-View -Server $vc $ta.Alarm).Info.Name
$Entity = Get-View -Server $vc $ta.Entity
$EntityName = (Get-View -Server $vc $ta.Entity).Name
$EntityType = (Get-View -Server $vc $ta.Entity).GetType().Name	
$Status = $ta.OverallStatus
$AlarmTime = $ta.Time
$Acknowledged = $ta.Acknowledged
$AckBy = $ta.AcknowledgedByUser
$AckTime = $ta.AcknowledgedTime		
	
$alarm = new-object System.Object
$alarm | Add-Member -Type NoteProperty -Name vCenter -Value $vCenter
$alarm | Add-Member -Type NoteProperty -Name EntityType -Value $EntityType
$alarm | Add-Member -Type NoteProperty -Name Alarm -Value $AlarmName
$alarm | Add-Member -Type NoteProperty -Name Entity -Value $EntityName
$alarm | Add-Member -Type NoteProperty -Name Status -Value $Status
$alarm | Add-Member -Type NoteProperty -Name Time -Value $AlarmTime
$alarm | Add-Member -Type NoteProperty -Name Acknowledged -Value $Acknowledged
$alarm | Add-Member -Type NoteProperty -Name AckBy -Value $AckBy
$alarm | Add-Member -Type NoteProperty -Name AckTime -Value $AckTime

$alarms+=$alarm
	}
return $alarms
}
############## vCenter Active Alerts END

############## Export-CSV BEGIN
function ExportCSV([System.Object]$data){
$private:SaveLoc = New-Object -TypeName System.Windows.Forms.SaveFileDialog
$private:SaveLoc.InitialDirectory = [System.IO.Directory]::GetCurrentDirectory()
$private:SaveLoc.ShowHelp = $True  
$private:SaveLoc.filter = "*.csv|*.*"
$private:SaveLoc.Title = "Save File to Disk"  
$private:result=$SaveLoc.ShowDialog()
if($result -eq "OK"){
$private:filename=$SaveLoc.filename
$data | export-csv $filename -append
}
}
############## Export-CSV END

############## Import-CSV BEGIN
function ImportCSV(){
$private:FileLoc = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$private:FileLoc.InitialDirectory = [System.IO.Directory]::GetCurrentDirectory()
$private:FileLoc.ShowHelp = $True  
$private:FileLoc.filter = "*.csv|*.*"
$private:FileLoc.Title = "Import CSV File"  
$private:result=$FileLoc.ShowDialog()
if($private:result -eq "OK"){
$private:filename=$FileLoc.filename
$private:object=import-csv $filename
return $object
}
}
############## Import-CSV END

############## Import-VIB BEGIN
function ImportVIB(){
$private:FileLoc = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$private:FileLoc.InitialDirectory = [System.IO.Directory]::GetCurrentDirectory()
$private:FileLoc.ShowHelp = $True  
$private:FileLoc.filter = "*.zip|*.*"
$private:FileLoc.Title = "Import VIB File"  
$private:result=$FileLoc.ShowDialog()
if($private:result -eq "OK"){
$private:filename=$FileLoc.filename
return $filename
}
}
############## Import-VIB END

############## Reports BEGIN
function GenerateReports ([String] $selecteddatacenter, [String] $selectedreport){

#HBA/Driver Report
if($selectedreport -eq "HBA/FC/Driver Report"){
$hbaitems=@()
$datacenter=get-datacenter | where {$_.Name -eq "$selecteddatacenter"}
$clusters=$datacenter | get-cluster
foreach($Cluster in $clusters){
$hosts= get-cluster $cluster | get-vmhost
foreach($esx in $hosts){
$hbas=get-vmhosthba -vmhost $esx -type FibreChannel
$esxcli = Get-EsxCli -VMHost $esx
foreach($hba in $hbas){
foreach($dev in $esxcli.storage.core.adapter.list()){
    if(($dev.Driver -eq $hba.Driver) -and ($dev.HBAName -eq $hba.Device)){
        $esxcli.system.module.get($dev.Driver) | % {
	$hbaitem = new-object System.Object
	$hbaitem | Add-Member -Type NoteProperty -Name Cluster -Value $Cluster
	$hbaitem | Add-Member -Type NoteProperty -Name VMHost -Value $esx.Name
	$hbaitem | Add-Member -Type NoteProperty -Name Model -Value $esx.Model
	$hbaitem | Add-Member -Type NoteProperty -Name ESXVersion -Value $esx.Version
	$hbaitem | Add-Member -Type NoteProperty -Name ESXBuild -Value $esx.Build
	$hbaitem | Add-Member -Type NoteProperty -Name HBADevice -Value $hba.Device
	$hbaitem | Add-Member -Type NoteProperty -Name Status -Value $hba.Status
	$hbaitem | Add-Member -Type NoteProperty -Name Driver -Value $dev.driver
	$hbaitem | Add-Member -Type NoteProperty -Name Description -Value $hba.Model
	$hbaitem | Add-Member -Type NoteProperty -Name DeviceType -Value $hba.Type
	$hbaitem | Add-Member -Type NoteProperty -Name Module -Value $_.Module
	$hbaitem | Add-Member -Type NoteProperty -Name Version -Value $_.Version
	
	$hbaitems+=$hbaitem
	}
	}
}
}
}
}

return $hbaitems
}

#NMP/PSP/IOPS Configuration Report
if($selectedreport -eq "NMP/PSP/IOPS Configuration Report"){
$NMPDeviceItems=@()
$datacenter=get-datacenter | where {$_.Name -eq "$selecteddatacenter"}
$clusters=$datacenter | get-cluster

foreach($Cluster in $clusters){
$hosts= get-cluster $cluster | get-vmhost
foreach($esx in $hosts){
$esxcli = Get-EsxCli -VMHost $esx

$NMPDevices=$esxcli.storage.nmp.device.list() | select Device,DeviceDisplayName,PathSelectionPolicy,PathSelectionPolicyDeviceConfig,StorageArrayType,WorkingPaths | where {$_.PathSelectionPolicy -ne "VMW_PSP_FIXED"}| Sort-object DeviceDisplayName
$NMPDevices | % {
	$NMPDeviceItem = new-object System.Object
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name VMHost -Value $esx.Name
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name Device -Value $_.Device
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name DeviceDisplayName -Value $_.DeviceDisplayName
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name PathSelectionPolicy -Value $_.PathSelectionPolicy
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name PathSelectionPolicyDeviceConfig -Value $_.PathSelectionPolicyDeviceConfig
	$NMPDeviceItem | Add-Member -Type NoteProperty -Name StorageArrayType -Value $_.StorageArrayType
	
	$NMPDeviceItems+=$NMPDeviceItem
}
}
}
return $NMPDeviceItems
}

#Device/LUN Parameters Report
if($selectedreport -eq "Device/LUN Parameters Report"){
$NMPDeviceCoreItems=@()
$datacenter=get-datacenter | where {$_.Name -eq "$selecteddatacenter"}
$clusters=$datacenter | get-cluster

foreach($Cluster in $clusters){
$hosts= get-cluster $cluster | get-vmhost
foreach($esx in $hosts){
$esxcli = Get-EsxCli -VMHost $esx

$NMPDeviceCore=$esxcli.storage.core.device.list() | where {$_.IsOffline -eq $FALSE}|select -property * | sort-object DisplayName
$NMPDeviceCore | % {
	$NMPDeviceCoreItem = new-object System.Object
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name Cluster -Value $Cluster
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name VMHost -Value $esx.Name
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name DisplayName -Value $_.DisplayName
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name Device -Value $_.Device
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name DevfsPath -Value $_.DevfsPath
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name Vendor -Value $_.Vendor
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name Model -Value $_.Model
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name MultiPathPlugin -Value $_.MultiPathPlugin
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name VAAIStatus -Value $_.VAAIStatus
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name DeviceMaxQueueDepth -Value $_.DeviceMaxQueueDepth
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name NoofoutstandingIOswithcompetingworlds -Value $_.NoofoutstandingIOswithcompetingworlds
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name QueueFullSampleSize -Value $_.QueueFullSampleSize
	$NMPDeviceCoreItem | Add-Member -Type NoteProperty -Name QueueFullThreshold -Value $_.QueueFullThreshold
	$NMPDeviceCoreItems+=$NMPDeviceCoreItem
}
}
}
return $NMPDeviceCoreItems
}

#vPortGroup Datacenter Report
if($selectedreport -eq "vPortGroup Datacenter Report"){

$private:vPortGroupItems=@()
#$private:queryClusterHosts=get-datacenter | where {$_.Name -eq "$selecteddatacenter"} | Get-Cluster | get-vmhost | select name
$private:queryClusters=get-datacenter | where {$_.Name -eq "$selecteddatacenter"} | Get-Cluster
$private:queryClusters | % {
$private:ClusterName = $_.Name
$private:queryClusterHosts=get-datacenter | where {$_.Name -eq "$selecteddatacenter"} | Get-Cluster | where {$_.Name -eq "$ClusterName"} | get-vmhost | select name
$queryClusterHosts | %{
$private:queryvPortGroup=Get-VirtualPortGroup -VMHost $_.Name | select Name, VirtualSwitch, VLanId
$Host=$_.Name
$queryvPortGroup | % {
	$vPortGroupItem = new-object System.Object
	$vPortGroupItem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VirtualSwitch -Value $_.VirtualSwitch
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VLanId -Value $_.VLanId
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VMHost -Value $Host
	$vPortGroupItem | Add-Member -Type NoteProperty -Name Cluster -Value $ClusterName
	
		$vPortGroupItems+=$vPortGroupItem
}
}
}


return $vPortGroupItems

}

}

############## Reports END

############## AdminMode BEGIN
function AdminMode([String] $global:shost){
$private:proceed=confirmation_form $global:shost
if(($private:proceed -eq "OK") -And ($global:shost -ne "")){
$global:AdminMode=1
$global:AdminModeHost=$global:shost
write-host "Enabling AdminMode: $global:AdminMode $global:AdminModeHost "
}
else{
$global:AdminMode=0
$global:AdminModeHost=""
write-host "Enabling AdminMode: $global:AdminMode $global:AdminModeHost "
}
}
############## AdminMode END

############## ClusterHostStatus BEGIN
function ClusterHostStatus ([String] $global:scluster){
$esxitems=@()
ForEach ($esx in (get-cluster $SCLUSTER | Get-VMHost)) {
$noVM= Get-VM -Location $esx | where {$_.PowerState -match "on"}
$esx | % {

	$esxitem = new-object System.Object
	$esxitem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$esxitem | Add-Member -Type NoteProperty -Name ConnectionState -Value $_.ConnectionState
	$esxitem | Add-Member -Type NoteProperty -Name PowerState -Value $_.PowerState
	$esxitem | Add-Member -Type NoteProperty -Name NumCpu -Value $_.NumCpu
	$esxitem | Add-Member -Type NoteProperty -Name CpuUsageMhz -Value ([math]::Round($_.CpuUsageMhz,2))
	$esxitem | Add-Member -Type NoteProperty -Name CpuTotalMhz -Value ([math]::Round($_.CpuTotalMhz,2))
	$esxitem | Add-Member -Type NoteProperty -Name MemoryUsageGB -Value ([math]::Round($_.MemoryUsageGB,2))
	$esxitem | Add-Member -Type NoteProperty -Name MemoryTotalGB -Value ([math]::Round($_.MemoryTotalGB,2))
	$esxitem | Add-Member -Type NoteProperty -Name CpuUsage -Value ([math]::Round(100*($_.CpuUsageMhz/$_.CpuTotalMhz),2))
	$esxitem | Add-Member -Type NoteProperty -Name MemoryUsage -Value ([math]::Round(100*($_.MemoryUsageGB/$_.MemoryTotalGB),2))
	$esxitem | Add-Member -Type NoteProperty -Name Version -Value $_.Version
	$esxitem | Add-Member -Type NoteProperty -Name VMsRunning -Value $noVM.count

	$esxitems+=$esxitem
	}
}

return $esxitems

}
############## ClusterHostStatus END

############## ListVMsCluster BEGIN
function ListVMsCluster([String] $global:scluster){
$VMItems=@()
$VMs=get-cluster $SCLUSTER | get-VM | select Name,PowerState,VMHost ,NumCPU, CoresPerSocket,MemoryGB,Guest, Notes, version | sort-object VMHost,Name
$VMs | % {
	$VMItem = new-object System.Object
	$VMItem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$VMItem | Add-Member -Type NoteProperty -Name PowerState -Value $_.PowerState
	$VMItem | Add-Member -Type NoteProperty -Name VMHost -Value $_.VMHost
	$VMItem | Add-Member -Type NoteProperty -Name NumCPU -Value $_.NumCPU
	$VMItem | Add-Member -Type NoteProperty -Name CoresPerSocket -Value $_.CoresPerSocket
	$VMItem | Add-Member -Type NoteProperty -Name MemoryGB -Value $_.MemoryGB
	$VMItem | Add-Member -Type NoteProperty -Name Guest -Value $_.Guest.OSFullName
	$VMItem | Add-Member -Type NoteProperty -Name IPAddresses -Value ($_.Guest.IPAddress -join ',')
	$VMItem | Add-Member -Type NoteProperty -Name Notes -Value $_.Notes
	$VMItem | Add-Member -Type NoteProperty -Name Version -Value $_.Version
	
$VMItems+=$VMItem
}

return $VMItems
}
############## ListVMsCluster END

############## HostCpuRatio BEGIN
function HostCpuRatio([String] $global:SCLUSTER){
$esxitems=@()
ForEach ($esx in (get-cluster $SCLUSTER | Get-VMHost)) {
$vCPU = Get-VM -Location $esx | where {$_.PowerState -match "on"} | Measure-Object -Property NumCpu -Sum | select -ExpandProperty Sum
$noVM= Get-VM -Location $esx | where {$_.PowerState -match "on"}

$esx | % {

	$esxitem = new-object System.Object
	$esxitem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$esxitem | Add-Member -Type NoteProperty -Name pCPUAvailable -Value $_.NumCpu
	$esxitem | Add-Member -Type NoteProperty -Name vCPUAssigned -Value $vCPU
	$esxitem | Add-Member -Type NoteProperty -Name VMsRunning -Value $noVM.count
	$esxitem | Add-Member -Type NoteProperty -Name Ratio -Value ([math]::Round($vCPU/$_.NumCpu,1))
	$esxitem | Add-Member -Type NoteProperty -Name CPUOvercommit -Value ([Math]::Round(100*(($vCPU - $_.NumCpu) / $_.NumCpu), 1))
	
	$esxitems+=$esxitem
}
}

return $esxitems
}
############## HostCpuRatio END

############## HostMemoryRatio BEGIN
function HostMemoryRatio([String] $global:SCLUSTER){
$esxitems=@()
ForEach ($esx in (get-cluster $SCLUSTER | Get-VMHost)) {
$vMem = get-vm -location $esx | where {$_.PowerState -match "on"} | measure-object -property MemoryGB -SUM | Select -Expandproperty Sum
$noVM= Get-VM -Location $esx | where {$_.PowerState -match "on"}

$esx | % {

	$esxitem = new-object System.Object
	$esxitem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$esxitem | Add-Member -Type NoteProperty -Name MemoryAvailable -Value ([Math]::Round($($_.MemoryTotalGB),1))
	$esxitem | Add-Member -Type NoteProperty -Name MemoryAssigned -Value $vMem
	$esxitem | Add-Member -Type NoteProperty -Name VMsRunning -Value $noVM.count
	$esxitem | Add-Member -Type NoteProperty -Name Ratio -Value ([math]::Round(($vMem / $_.MemoryTotalGB), 1))
	$esxitem | Add-Member -Type NoteProperty -Name MemoryOvercommit -Value ([Math]::Round(100*(($vMem - $_.MemoryTotalGB) / $_.MemoryTotalGB), 1))
	
	$esxitems+=$esxitem
}
}

return $esxitems
}
############## HostMemoryRatio END

############## Cluster Configuration BEGIN
function ClusterConfiguration([String] $global:SCLUSTER){
$clusteritems=@()
$clusteritems = get-cluster $global:scluster | select *
return $clusteritems
}
############## Cluster Configuration END

############## Host VMs Memory/CPU Statistics
function HostVMsStatistics([String] $global:SHOST){
$VMItems=@()
$VMs=get-cluster $global:SCLUSTER | get-VMHost $global:SHOST | get-VM | where {$_.PowerState -match "on"} | sort-object MemoryMB -Descending
foreach($VM in $VMs){
$memavg=Get-Stat -Entity $VM.Name -Stat mem.usage.average -maxsamples 1 -RealTime | where {$_.Instance -eq ""} | select -expandproperty Value
$cpuavg=Get-Stat -Entity $VM.Name -Stat cpu.usage.average -maxsamples 1 -RealTime | where {$_.Instance -eq ""} | select -expandproperty Value
$cpuavgmhz=Get-Stat -Entity $VM.Name -Stat cpu.usagemhz.average -maxsamples 1 -RealTime | where {$_.Instance -eq ""} | select -expandproperty Value

	$VMItem = new-object System.Object
	$VMItem | Add-Member -Type NoteProperty -Name Name -Value $VM.Name
	$VMItem | Add-Member -Type NoteProperty -Name PowerState -Value $VM.PowerState
	$VMItem | Add-Member -Type NoteProperty -Name NumCPU -Value $VM.NumCPU
	$VMItem | Add-Member -Type NoteProperty -Name CoresPerSocket -Value $VM.CoresPerSocket
	$VMItem | Add-Member -Type NoteProperty -Name MemoryMB -Value $VM.MemoryMB
	$VMItem | Add-Member -Type NoteProperty -Name CPUAverageMHZ -Value ([math]::Round(($cpuavgmhz),2))
	$VMItem | Add-Member -Type NoteProperty -Name MemoryAverage -Value ([math]::Round(($memavg),2))
	$VMItem | Add-Member -Type NoteProperty -Name CPUAverage -Value ([math]::Round(($cpuavg),2))
	
		$VMItems+=$VMItem
}
return $VMItems
}
############## Host VMs Memory/CPU Statistics

############## Host Storage Error Events - BEGIN
function HostStorageEvents([String] $global:SHOST){
$EventItems=@()
$startdate=(get-date).AddDays(-3)
$enddate=get-date

$queryevent=get-vievent -entity (get-cluster $global:SCLUSTER | get-vmhost $global:SHOST) -Start $startdate -Finish $enddate| where {($_.EventTypeId -like "esx.problem.scsi.device.io.*") -or ($_.EventTypeId -like "esx.problem.vmfs.heartbeat.*") -or ($_.EventTypeId -like "esx.clear.scsi.device.io.*") -or ($_.EventTypeId -like "esx.clear.vmfs.heartbeat.*")} | sort-object -property createdTime -Descending | select createdtime, objectname,eventtypeid,fullformattedmessage -first 100

$queryevent | % {
	$EventItem = new-object System.Object
	$EventItem | Add-Member -Type NoteProperty -Name CreatedTime -Value $_.CreatedTime
	$EventItem | Add-Member -Type NoteProperty -Name ObjectName -Value $_.ObjectName
	$EventItem | Add-Member -Type NoteProperty -Name EventTypeId -Value $_.EventTypeId
	$EventItem | Add-Member -Type NoteProperty -Name FullFormattedMessage -Value $_.FullFormattedMessage
	
		$EventItems+=$EventItem
}
return $EventItems
}
############## Host Storage Error Events - END

############## NMP List SATP - BEGIN
function NMPSATPList([String] $global:SHOST){
$SATPItems=@()
$private:esxcli = Get-EsxCli -VMHost $SHOST
$NMPSATP=$esxcli.storage.nmp.satp.list()

$NMPSATP | % {
	$SATPItem = new-object System.Object
	$SATPItem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$SATPItem | Add-Member -Type NoteProperty -Name DefaultPSP -Value $_.DefaultPSP
	$SATPItem | Add-Member -Type NoteProperty -Name Description -Value $_.Description
	
	$SATPItems+=$SATPItem
}
return $SATPItems
}
############## NMP List SATP - END

############## NMP Rule List SATP - BEGIN
function NMPSATPRuleList([String] $global:SHOST){
$SATPRules=@()
$private:esxcli = Get-EsxCli -VMHost $SHOST
$NMPSATPRule=$esxcli.storage.nmp.satp.rule.list() | where {$_.Name -eq "VMW_SATP_ALUA"}

$NMPSATPRule | % {
	$SATPRule = new-object System.Object
	$SATPRule | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$SATPRule | Add-Member -Type NoteProperty -Name DefaultPSP -Value $_.DefaultPSP
	$SATPRule | Add-Member -Type NoteProperty -Name ClaimOptions -Value $_.ClaimOptions
	$SATPRule | Add-Member -Type NoteProperty -Name Description -Value $_.Description
	$SATPRule | Add-Member -Type NoteProperty -Name Device -Value $_.Device
	$SATPRule | Add-Member -Type NoteProperty -Name Driver -Value $_.Driver
	$SATPRule | Add-Member -Type NoteProperty -Name Model -Value $_.Model
	$SATPRule | Add-Member -Type NoteProperty -Name Options -Value $_.Options
	$SATPRule | Add-Member -Type NoteProperty -Name PSPOptions -Value $_.PSPOptions
	$SATPRule | Add-Member -Type NoteProperty -Name RuleGroup -Value $_.RuleGroup
	$SATPRule | Add-Member -Type NoteProperty -Name Transport -Value $_.Transport
	$SATPRule | Add-Member -Type NoteProperty -Name Vendor -Value $_.Vendor

	
	$SATPRules+=$SATPRule
}
return $SATPRules
}
############## NMP Rule List SATP - END

############## SSH Enable/Disable - BEGIN
function HostSSH([String] $global:SHOST){
if((Get-VMHostService -VMHost $global:SHOST | Where-Object {$_.Key -eq "TSM-SSH" } | select Running).Running -eq $TRUE){
$message="Stopping SSHService on $($global:SHOST) "
$private:proceed=confirmation_form $message
if($private:proceed -eq "OK"){Get-VMHostService -VMHost $global:SHOST | Where-Object {$_.Key -eq "TSM-SSH" } | Stop-VMHostService -Confirm:$false}
}
else{
$message="Starting SSHService on $($global:SHOST) "
$private:proceed=confirmation_form $message
if($private:proceed -eq "OK"){Get-VMHostService -VMHost $global:SHOST | Where-Object {$_.Key -eq "TSM-SSH" } | Start-VMHostService -Confirm:$false}
}

}
############## SSH Enable/Disable - END

###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

############## NMP List Devices - BEGIN
function NMPDeviceFullList([String] $global:SHOST){
$NMPDeviceItems=@()
$private:esxcli = Get-EsxCli -VMHost $global:SHOST
$NMPDevices=$esxcli.storage.nmp.device.list() | select -property * | sort-object Device
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
############## NMP List Devices - END

############## StorageCoreDevices - BEGIN
function StorageCoreDevices([String] $global:SHOST){
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
############## StorageCoreDevices - END

############## Storage Adapters - BEGIN
function storagecoreadapters([String] $global:SHOST){
$storagecoreadapters=@()
$private:esxcli = Get-EsxCli -VMHost $global:SHOST
$storageadapters=$esxcli.storage.core.adapter.list()
$storageadapters | % {
	$storagecoreadapter = new-object System.Object
	$storagecoreadapter | Add-Member -Type NoteProperty -Name HBAName -Value $_.HBAName
	$storagecoreadapter | Add-Member -Type NoteProperty -Name Description -Value $_.Description
	$storagecoreadapter | Add-Member -Type NoteProperty -Name Driver -Value $_.Driver
	$storagecoreadapter | Add-Member -Type NoteProperty -Name LinkState -Value $_.LinkState
	$storagecoreadapter | Add-Member -Type NoteProperty -Name UID -Value $_.UID
	$storagecoreadapters+=$storagecoreadapter
}
return $storagecoreadapters
}
############## Storage Adapters - BEGIN

############## Host Configuration BEGIN
function HostConfiguration([String] $global:SCLUSTER, [String] $global:SHOST){
$hostitems=@()
$hostitems = get-cluster $global:scluster | get-vmhost $global:shost | select *
return $hostitems
}
############## Host Configuration END

############## Host Advanced Settings BEGIN
function HostAdvancedSettings([String] $global:SCLUSTER, [String] $global:SHOST){
$settingitems=@()
$settingitems = get-advancedsetting -entity $global:SHOST | select -property Name, Value, Type, Summary | sort-object name
return $settingitems
}
############## Host Advanced Settings END

############## Mount VMTools - BEGIN
function MountVMTools([String] $global:SVM){
$message="Mounting VMTools on $($global:SVM) "
$private:proceed=confirmation_form $message
if($private:proceed -eq "OK"){get-vmguest $global:svm | mount-tools}
}
############## Mount VMTools - END

############## Dismount VMTools - BEGIN
function DismountVMTools([String] $global:SVM){
$message="Dismounting VMTools on $($global:SVM) "
$private:proceed=confirmation_form $message
if($private:proceed -eq "OK"){get-vmguest $global:svm | dismount-tools}
}
############## Dismount VMTools - END

############## Driver Module Information - BEGIN
function DriverModuleInformation([String] $global:SHOST, [String] $settingfilter){
if($settingfilter -ne ""){
$private:esxcli = Get-EsxCli -VMHost $global:SHOST
$systemmoduleinfo=@()
$systemmoduleinfo=$esxcli.system.module.get("$settingfilter") | select *

return $systemmoduleinfo
}
}
############## Driver Module Information - END

############## Driver Module Parameters - BEGIN
function DriverModuleParameters([String] $global:SHOST, [String] $settingfilter){
if($settingfilter -ne ""){
$private:esxcli = Get-EsxCli -VMHost $global:SHOST
$systemmoduleparams=@()
$systemmoduleparams=$esxcli.system.module.parameters.list("$settingfilter") | select Name, Value, Description

return $systemmoduleparams
}
}
############## Driver Module Parameters - END

############## Software VIB List - BEGIN
function SoftwareVIBList([String] $global:shost){
$VIBItems=@()
$private:esxcliv2 = Get-EsxCli -VMHost $shost -V2
$VIBQuery=$esxcliv2.software.vib.list.invoke() | select -property * | sort-object Device
$VIBQuery | % {

	$VIBItem = new-object System.Object
	$VIBItem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$VIBItem | Add-Member -Type NoteProperty -Name AcceptanceLevel -Value $_.AcceptanceLevel
	$VIBItem | Add-Member -Type NoteProperty -Name CreationDate -Value $_.CreationDate
	$VIBItem | Add-Member -Type NoteProperty -Name ID -Value $_.ID
	$VIBItem | Add-Member -Type NoteProperty -Name InstallDate -Value $_.InstallDate
	$VIBItem | Add-Member -Type NoteProperty -Name Status -Value $_.Status
	$VIBItem | Add-Member -Type NoteProperty -Name Vendor -Value $_.Vendor
	$VIBItem | Add-Member -Type NoteProperty -Name Version -Value $_.Version

	$VIBItems+=$VIBItem
}
return $VIBItems
}
############## Software VIB List - END

############## Host vPortGroup Inventory - BEGIN
function HostvPortGroupInventory([String] $global:SHOST){
$private:vPortGroupItems=@()
$private:queryvPortGroup=Get-VirtualPortGroup -VMHost $shost | select Name, VirtualSwitch, VLanId

$queryvPortGroup | % {
	$vPortGroupItem = new-object System.Object
	$vPortGroupItem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VirtualSwitch -Value $_.VirtualSwitch
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VLanId -Value $_.VLanId
	
		$vPortGroupItems+=$vPortGroupItem
}
return $vPortGroupItems
}
############## Host vPortGroup Inventory - END

############## Cluster vPortGroup Inventory - BEGIN
function ClustervPortGroupInventory([String] $global:SCLUSTER){
$private:vPortGroupItems=@()
$private:queryClusterHosts=Get-Cluster $scluster | get-vmhost | select name

$queryClusterHosts | %{
$private:queryvPortGroup=Get-VirtualPortGroup -VMHost $_.Name | select Name, VirtualSwitch, VLanId
$Host=$_.Name
$queryvPortGroup | % {
	$vPortGroupItem = new-object System.Object
	$vPortGroupItem | Add-Member -Type NoteProperty -Name Name -Value $_.Name
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VirtualSwitch -Value $_.VirtualSwitch
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VLanId -Value $_.VLanId
	$vPortGroupItem | Add-Member -Type NoteProperty -Name VMHost -Value $Host
	$vPortGroupItem | Add-Member -Type NoteProperty -Name Cluster -Value $scluster
#new
$private:teaming=Get-VirtualPortGroup -VMHost $Host -Name $_.Name | get-nicteamingpolicy | select VirtualPortGroup, ActiveNic, StandbyNic
$teaming | % {
$vPortGroupItem | Add-Member -Type NoteProperty -Name ActiveNic -Value (@($_.ActiveNic) -join ',').ToString()
$vPortGroupItem | Add-Member -Type NoteProperty -Name StandbyNic -Value (@($_.StandbyNic) -join ',').ToString()
}
#new
		$vPortGroupItems+=$vPortGroupItem
}
}
return $vPortGroupItems
}
############## Cluster vPortGroup Inventory - END

############## Cluster VMkernel Inventory - BEGIN
function ClusterVMkernelInventory([String] $global:SCLUSTER){
$private:VMkernelItems=@()
$private:queryVMkernel=get-cluster $scluster | get-vmhost | get-vmhostnetworkadapter | where {$_.DeviceName -like "vmk*"} | select PortGroupName, VMHost, IP, SubnetMask, vMotionEnabled, ManagementTrafficEnabled, vSANTrafficEnabled, mac, devicename
$queryVMkernel | % {
	$VMkernelItem = new-object System.Object
	$VMkernelItem | Add-Member -Type NoteProperty -Name PortGroupName -Value $_.PortGroupName
	$VMkernelItem | Add-Member -Type NoteProperty -Name VMHost -Value $_.VMHost
	$VMkernelItem | Add-Member -Type NoteProperty -Name Cluster -Value $scluster
	$VMkernelItem | Add-Member -Type NoteProperty -Name IP -Value $_.IP
	$VMkernelItem | Add-Member -Type NoteProperty -Name SubnetMask -Value $_.SubnetMask
	$VMkernelItem | Add-Member -Type NoteProperty -Name vMotionEnabled -Value $_.vMotionEnabled
	$VMkernelItem | Add-Member -Type NoteProperty -Name ManagementTrafficEnabled -Value $_.ManagementTrafficEnabled
	$VMkernelItem | Add-Member -Type NoteProperty -Name vSANTrafficEnabled -Value $_.vSANTrafficEnabled
	$VMkernelItem | Add-Member -Type NoteProperty -Name mac -Value $_.mac
	$VMkernelItem | Add-Member -Type NoteProperty -Name devicename -Value $_.devicename
	
		$VMkernelItems+=$VMkernelItem
}
return $VMkernelItems
}
############## Cluster VMkernel Inventory - END

############## Cluster Logging Report - BEGIN
function ClusterLoggingReport([String] $global:SCLUSTER){
$private:LoggingItems=@()
$private:queryHosts=get-cluster $scluster | get-vmhost | select name
$queryHosts | % {
$private:CurrentScratchConfig=(Get-VMhost $_.Name | Get-AdvancedSetting -Name "ScratchConfig.CurrentScratchLocation").Value
$private:ConfiguredScratchConfig=(Get-VMhost $_.Name | Get-AdvancedSetting -Name "ScratchConfig.ConfiguredScratchLocation").Value
$private:SyslogDir=(Get-VMhost $_.Name | Get-AdvancedSetting -Name "Syslog.global.logDir").Value
$private:GlobalLogHosts=(Get-VMhost $_.Name | Get-AdvancedSetting -Name "Syslog.global.logHost").Value

	$LoggingItem = new-object System.Object
	$LoggingItem | Add-Member -Type NoteProperty -Name Host -Value $_.Name
	$LoggingItem | Add-Member -Type NoteProperty -Name Cluster -Value $scluster
	$LoggingItem | Add-Member -Type NoteProperty -Name CurrentScratchConfig -Value $CurrentScratchConfig
	$LoggingItem | Add-Member -Type NoteProperty -Name ConfiguredScratchConfig -Value $ConfiguredScratchConfig
	$LoggingItem | Add-Member -Type NoteProperty -Name SyslogDir -Value $SyslogDir
	$LoggingItem | Add-Member -Type NoteProperty -Name GlobalLogHosts -Value $GlobalLogHosts
	
		$LoggingItems+=$LoggingItem
}
return $LoggingItems
}
############## Cluster Logging Report - END


###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################