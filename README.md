# VMware-Community-Orchestration-Tool-VMCOT-
##### Developed by Mario Herrera under GNU General Public License terms.

VMware Community Orchestration Tool (aka VMCOT) is an open-source project that has been created for all those VMware infrastructure administrators which happen to need to query &amp; bulk configure multiple ESXi/vSphere environments in a centralized way. Feel free to contact me if any particular need, comment or contribution.


### 0. REQUIREMENTS & INSTALLATION

These are the ***Requirements*** that you need to meet in order to be able to use this tool:

1. Server that will be used to run the script needs to be Windows 2008R2 or later version.
1. PowerShell 5.x or later version.
1. PowerCLI 11.0.0 build 10380590 or later version
1. VMware.VimAutomation.Storage 11.0.0.103380343 or later version (module for vSAN PowerCLI operations).
1. VMware.VimAutomation.Core 11.0.0.10336080 or later version (module for PowerCLI/vSphere operations).
1. .Net Framework 3.5
1. .Net Framework 4.6
1. Network communication on 443/TCP/HTTPS to each vCenter instance.
1. This tool has been sucessfully tested against VMware ESXi 5.x/6.x platforms, plus vSAN 6.x environments.
1. Hopefully I will developed an updated release of this tool with features tested on 7.0 release and additional features.

This is the ***Instalation/Configuration*** process:

1. Download/Import all the ***5 modules*** that are part of this tool (each modules is composed by a .psm1 & .psd1 file):
   - ***VMCOT.Powershell.functions_gui:*** This module provides .Net Windows System Forms to the application.
   - ***VMCOT.Powershell.functions_guihelper:*** This module provides helper .Net Windows System Forms  to the application.
   - ***VMCOT.Powershell.functions_helper:*** This module is used to define functions related with basic adminstration operations (no actual configuration changes).
   - ***VMCOT.Powershell.functions_helperadmin:*** This module is used to define functions related with advanced administration operations (admin configuration changes).
   - ***VMCOT.VimAutomation.Core.runtime:*** This module is used a launcher for all application modules.

1. The 5 modules need to be placed on any of the following locations (on the server that you're planning to use to run the application):
   - **C:\Windows\System32\WindowsPowerShell\v1.0\Modules** (this is my personal prefered method, all users will be able to run the application).
   - **C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules**
   - **C:\Users\%USERNAME%\Documents\WindowsPowerShell\Modules**

1. Make sure to replace "vcenter01p.domain.local" with your vcenter hostname. This needs to be changed on the following files:
   - **VMCOT.Powershell.functions_helper.psm1** (Line 16 & Line 17)
   - **VMCOT.Powershell.functions_gui.psm1** (Line 31)

1. Important: If your vCenter uses a Self-Signed Certificate (which is usually the case), make sure to run the following command on your PowerCLI Session:
   - **Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false**

1. ***CAUTION WHILE USING THIS TOOL IS ADVICED***: Make sure to read all the instructions provided. If this tool is not used in an appropiate way, you might be at risk of impacting your infrastructure. Doing your own research is always adviced also.

If you're planning to start a project by also using source code provided for this tool, feel free to link you're Branch with mine, I'm expecting to continue adding new features to the tool with the time.

Feel free to contact me if you have Comments/Questions/Suggestions/Issues/Bugs to report.
- GitHub Reposotiry: https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
- LinkedIn: https://www.linkedin.com/in/majhe

### 1. STARTING/RUNNING THE APPLICATION: 
In order to start the application (as long as you installed and configured script files according to the instructions above), you'll only need to open a Windows PowerShell session and run the following command on a PowerShell line:
> VMCOTVMwareTool

### 2. GETTING FAMILIAR WITH THE GUI: 

![alt text](https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-/blob/master/Images/CMCOT-Main.png)

Here's the list and use for each one of the available buttons that are present on the main application console. 
 
1. **Connect/Change vCenter Instance:** You will be able to Connect/Disconnect to any of the vCenter instances that are part of the environment. 
1. **Select/Change Cluster:** For choosing Cluster depending on the vCenter Instance that you´re connected too. 
1. **Select/Change Host:** For choosing any of the ESXi Hosts that are part of the Cluster you previously selected. 
1. **Select/Change VM:** For choosing any of the VMs that are running on the selected Cluster/Host. 
1. **Active Alerts:** Display/Export the existing Alerts that are “active” for the selected vCenter Instance. 
1. **Clear Variables:** This will need to be run in order to refresh your session and erase all variables/connections. 
1. **Reports:** Access several reporting options that are available on a per vCenter Instance/Datacenter level. 
1. **SuperAdmin Mode:** Enables SuperAdmin Mode for the selected host. There are a lot of specific tasks that will not be enable unless you enable this feature (keep in mind that enabling SuperAdmin Mode allows you to do configuration changes on the environment. 
1. **Exit:** Closes the application session. 
1. **Cluster Operations:** Enabled if you have a valid Cluster selected, it has access to multiple operations. 
1. **Host Operations:** Enabled if you have a valid Host selected, it has access to multiple operations. 
1. **VM Operations:** Enabled if you have a valid VM selected, it has access to multiple operations. 
1. **Bulk Actions:** Enabled if you have at least 1 host added to the Bulk Operations mode. It has access to multiple options that can be executed in bulk on all the selected hosts (Selected for Bulk Operations). 
1. **Clear:** Clears the Bulk Operations Host selection, so you can start from scratch. 
1. **Add Host:** Adds a new Host to the Bulk Operations Collection. 
1. **Remove Host:** Removes host from the Bulk Operations Collection. 
1. **Maintenance Operations:** Operations that currently do not support Bulk Operations mode, will be executed only on the selected ESXi Host (requires SuperAdmin Mode). 
1. **vSAN:** Access multiple vSAN maintenance options like creating vSAN Disk Groups from CSV file. 
1. **ListBox with all the Hosts that are part of the Bulk Operations Collection**


### 3. HOW DOES THIS TOOL WORK? 
The tool presents different set of operations which are accessible/unlocked as long as you make the appropriate selections, keep in mind that some options are not enabled unless you have certain selection (like Cluster/Cluster/VMs). While some operations are only available once you start adding hosts on to the Bulk Host Collection, some other are not available on this mode and can be accessed through the “maintenance operations” option, which depends on a single host selection and running SuperAdmin Mode. 
This is the summary for this process:

***vCenter Selection > For vCenter operations***

***vCenter Selection > Cluster Selection > For Cluster operations***

***vCenter Selection > Cluster Selection > Host Selection > For Host level operations***

***vCenter Selection > Cluster Selection > Host Selection > VM Selection > For VM level operations***

***vCenter Selection > Cluster Selection > Host Selection > Maintenance operations (No Bulk)***

***vCenter Selection > Cluster Selection > Bulk Operations Mode > Bulk Actions***

### 4. WORKING WITH THE "SUPERADMIN" MODE: 
Certain tasks/options/configurations are not available by default, these aren´t able to be accessed unless the user/administrator explicitly enters “SuperAdmin Mode”. This mode needs to be activated on a PerHost level in order to perform any of the following operations: 

- Accessing Maintenance Operations (No Bulk) for that specific host.
- Adding/Removing/Clearing Host Collection/Selections for Bulk Operations Mode.
- Accessing Bulk Actions/Operations that can be executed in bulk.
- Any other change that implies a possible change of configuration.

### 5. IMPORTANT CONSIDERATIONS:

- In order to access all the SuperAdmin Advanced Tasks, you need to enable SuperAdmin Mode on your current Host selection.
- If you enable SuperAdmin mode on a specific host, this will only enable all the advanced tasks for that specific host. If you change Host selection, SuperAdmin Mode may not be enable for that host.
- Once you enter SuperAdmin mode, the user will be able to do configuration changes. Be sure of what you´re doing.
- All changes are logged at vCenter level.
- ***PLEASE, MAKE SURE YOU KNOW WHAT YOU´RE DOING.***

### 6. EXPORTING THE OUTPUTS 

Most of the Reports/Outputs that are generated by the Tool are able to be exported to CSV file, the export button is normally accessible on the bottom left corner of these report grids. 

### 7. CATALOG OF ADMINISTRATIVE TASKS 

- ***SESSION***
  - Connect/Change vCenter Instance
  - Select/Change Cluster
  - Select/Change Host
  - Select/Change VM
  
- ***CLUSTER OPERATIONS***
  - Obtain vCPU-pCPU Ratio
  - Obtain Memory Ratio
  - Obtain Host Statistics
  - Cluster Configuration
  - Obtain VMs Running on this Cluster
  - Cluster vPortGroup Inventory
  - Cluster VMkernel Inventory
  - Cluster Logging Report 
- ***HOST OPERATIONS*** 
  - Host VMs Memory/CPU Statistics
  - Host Storage Error Events
  - NMP Configuration: List Devices
  - NMP Configuration: List SATP
  - MP Configuration: List SATP Rules
  - Storage Core Device Configuration
  - Enabled/Disable SSH
  - Obtain Storage Adapters
  - Obtain Driver Module Information
  - Obtain Driver Module Parameters
  - Host Configuration
  - Advanced Settings
  - Host vPortGroup Inventory
  
- ***VM OPERATIONS*** 
  - Mount VMtools
  - Dismount VMtools 

- ***BULK Operations (ADMIN MODE)*** 
  - Create vSwitches & NIC Bindings (Bulk)
  - Create VLAN/PortGroups (Bulk)
  - Create NMP SATP Rules (Bulk)
  - Delete NMP SATP Rules (Bulk)
  - Create VLAN/PortGroups from CSV file (Bulk)
  - Create VMkernel Adapter from CSV file (Bulk)
  - Configure NTP Settings o Configure NTP Settings
  - Configure DNS, DomainName & SearchDomain
  - Join ESX Host to AD Domain
  - Disable ATS Heartbeat for VMFS5
  - Enable/Configure Software iSCSI Adapters(*) 
  
- ***Maintenance Operations (ADMIN MODE)*** 
  - Configure Syslog/ScratchLog Location
  - Upload VIB/ZIP file to Shared Storage
  - Install VIB/Bundle from Shared Storage
  - Update VIB/Bundle from Shared Storage
  - VIB Inventory List
  - Remove VIB/Bundle from Shared Storage
  - NMP PSP Device Config (VMW_SATP_ALUA)
  - Modify Storage Core Device Parameters
  - Change Host Advance Settings
  - Modify HBA Driver Module Parameters (*)
  - Enter Maintenance Mode (*)
  - Exit Maintenance Mode (*)
  
- ***vSAN Operations (ADMIN MODE)*** 
  - Configure vSAN Disk Groups from CSV
  - Display vSAN Disk Groups Information (*)
  - Remove Disk Group from vSAN Config (*)
  
- ***Other*** 
  - Active Alerts
  - Clean Variables
  - Reports
  - SuperAdmin Mode (ON|OFF)
  
  ***(*)*** These fetures are currently not supported, however are on my scope
  
 ### 8. OTHER IMPORTANT STUFF 
- If you´re creating VLANs/PortGroups with the CSV file option, you need to follow this CSV format: 

```
vSwitch,vPortGroup,vLANID,vPortGroupActiveNics,vPortGroupStandbyNics
vSwitch0,iSCSI,402,vmnic3,vmnic0
vSwitch0,vMotion,405,vmnic3,vmnic0
```

- If you´re creating VMkernel Adapter/vPortGroup with the CSV file option, you need to follow this CSV format: 

```
ESXiHost,vSwitch,VMkernelAdapterName,VMkernelAdapterIP,VMkernelAdapterNetworkMask,ManagementTraffic,vSANTraffic,vMotionTraffic
esx01p.us.local,vSwitch0,iSCSI-Network,10.1.139.41,255.255.255.0,N,N,N
esx01p.us.local,vSwitch0,vMotion-Network,10.1.227.21,255.255.255.0,N,N,Y 
```

 - If you´re creating vSAN Disk Group configuration from CSV file option, you need to follow this CSV format: 

```
VMHost,DiskGroup,SsdCanonicalName,DataDiskCanonicalName
esx01p.us.local, DiskGroup1, t10.NVMe____INTEL_SSDPE21K375GA_____________________PHKE7436__00000001, "t10.NVMe____INTEL_SSDPE2KX020T8_____________________BTLJ82N__00000001,t10.NVMe____INTE L_SSDPE2KX020T8_____________________BTLJ816GN__00000001,t10.NVMe____INTEL_SSDPE2KX020T8__ ___________________BTLJ80BGN__00000001"
esx01p.us.local, DiskGroup2, t10.NVMe____INTEL_SSDPE21K375GA_____________________PHKE5AGN__00000001, "t10.NVMe____INTEL_SSDPE2KX020T8_____________________BTLJBGN__00000001,t10.NVMe____INTE L_SSDPE2KX020T8_____________________BTLJ0BGN__00000001,t10.NVMe____INTEL_SSDPE2KX020T8__ ___________________BTLJ8GN__00000001" 
 ```
 
### 9. KNOWN ISSUES, BUGS & LIMITATIONS 
- ***Limitations:*** 
  - ***Bulk Removal Operations:*** We aware that VMCOT currently does not have any bulk removal feature/option, so if you happen to write a bad setting while doing bulk operations (like adding 50 vSwitches plus 100 vPortGroups to 16 ESXi hosts), you will then need to manually correct your mistake.
  - ***Adding NTP Server:*** You can only add one NTP server at a time.
  - ***SATP Rules:*** If you need to remove a previously customly created SATP rule, you will need to exactly type all properties to match the SATP Rule you're willing to remove.
  - ***Storage Core Devices Parameter Change:*** While changing parameters on any Storage Core Device (LUN/NMP Device), you will only be able to change the following parameters: maxqueuedepth, schednumreqoutstanding, QueueFullSampleSize, queuefullthreshold. Keep in mind that tool has been developed for dealing with 3PAR Storage and EMULEX Storage Adapters, recommended settings according to HPe/EMULEX/VMware (as of this day) is maxqueuedepth=32, schednumreqoutstanding=32, QueueFullSampleSize=32, queuefullthreshold=4). Configuring QueueDepth & schednumreqoutstanding is adviced. Regarding QueueFullSanokeSize & queuefullthreshold, this is only recommended if you want to enable Queue throttling and have a good reason to enable Adaptive Queue Algorithm. 

- ***Issues:*** 
  - ***Failure to authenticate to Active Directory while Bulk adding ESXi hosts to AD Domain:*** For some reason, sometimes some AD/vCenter environments will force you to type administrator credentials in username@domain.local format, as domain\username is not working in some scenarios. 

- ***Additional Information:***
  - ***UploadVIBFile:*** This option can be used to Upload VIB or ZIP files (bundles).
  - ***InstallVIBFile:*** This will proceed to install a VIB file.
  - ***UpdateVIBFile:*** This will proceed to install/update a .ZIP (bundle) package. Keep in mind that instalation is configured to be ran in "update mode" and will NOT forcefully reinstall any package/VIB that happens to be already installed (same version).
  - ***RemoveVIBFile:*** Removes any VIB package from ESXi instalation. This is very usefull if you want to remove a driver or VIB package from your ESXi server. 
 
  
