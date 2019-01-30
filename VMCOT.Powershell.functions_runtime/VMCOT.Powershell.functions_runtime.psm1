###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################

############## Running BEGIN
function VMCOTVMwareTool(){
############## Load Classes BEGIN
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")  
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void] [System.Windows.Forms.Application]::EnableVisualStyles()
############## Load Classes END

initialize_globalvariables
welcome
}
############## Running END

###########################################################
# VMware Community Orchestration Tool (VMCOT)
# Built by Mario Herrera - 2018/2019 (GNU General Public License v3.0)
# https://github.com/majhe/VMware-Community-Orchestration-Tool-VMCOT-
###########################################################