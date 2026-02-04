Step 3: Verify PowerCLI Version and Module Availability
Get-Module -Name VMware.PowerCLI -ListAvailable
To list submodules:

Get-Module -Name VMware.* -ListAvailable

Step 4: Update PowerCLI to the Latest Version
You can update PowerCLI anytime with:

Update-Module -Name VMware.PowerCLI
If you receive access errors, use:

Update-Module -Name VMware.PowerCLI -Scope CurrentUser -Force

Step 5: Configure Optional Settings
Avoid prompts on first-time module use:

Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Trust all certificates (for lab environments only):

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

Connect-VIServer -Server [server name] -Protocol [http] -User [user name] -Password [password]
# 对当前用户永久忽略无效证书
Set-PowerCLIConfiguration -Scope User -InvalidCertificateAction Ignore -Confirm:$false
# 连接到vCenter服务器
# prod
Connect-VIServer -Server "dlisnvcsa01.corp.hynix-dl.com" -Protocol "https" -User "administrator@vsphere.local" -Password "DL@infra12!@"
# dev
Connect-VIServer -Server "dldevvcsa01.corp.hynix-dl.com" -Protocol "https" -User "administrator@vsphere.local" -Password "DL@infra12!@"


get-vmhost
Get-VM -Name "dlwsus01" | Format-List

Get-VM                         # List all virtual machines
Get-VMHost                     # List ESXi hosts
Get-Datastore                  # Show storage
Get-Cluster                    # Show clusters
Get-VM | Where PowerState -eq "PoweredOff"



---------------
启动VM和停止VM：如何启动和停止VM

要在连接的vCenter上启动特定VM，请运行以下命令：

Start-VM ‑VM [vmname]

要关闭虚拟机的电源，请运行以下命令：

Stop-VM ‑VM [vmname]


-----------
新虚拟机：如何创建新虚拟机

New-VM-cmdlet用于在连接的服务器上创建新的VM。使用以下命令，您可以使用默认设置创建一个新的空白虚拟机，稍后需要部署操作系统：

New-VM -Name [vmname] -VMHost [hostname]

除了创建新的虚拟机，您还可以使用VMware vSphere PowerCLI命令创建新的数据中心或新的文件夹。

要创建新文件夹，基本语法为：

New-Folder -Name [folder name]

获取资源清册根文件夹并在其中创建一个新文件夹。

$folder = Get-Folder -NoRecursion | New-Folder -Name [folder name]

要在-Location参数指定的文件夹中创建新的数据中心，请执行以下操作：

New-Datacenter -Location $folder -Name [datacenter name]
----------
移动虚拟机：如何将虚拟机移动到另一个位置

移动虚拟机命令允许您将单个或多个虚拟机从一个主机或数据存储移动到另一个。

要将单个虚拟机实时迁移到另一台主机，请运行以下命令：

Move-VM -VM [vmname] -Destination [hostname]

要将单个虚拟机迁移到另一个数据存储，请运行以下命令：

Move-VM -VM [vmname] -Datastore [datastore name]

要将所有虚拟机从一台主机移动到另一台主机，请运行以下命令：

Get-VMHost [hostname] | Get-VM | Move-VM -Destination (Get-VMHost [hostname])
------------
新快照：如何拍摄虚拟机快照

虚拟机快照是虚拟机的一种方便快捷的故障保护措施。还有许多VMware PowerCLI命令可以帮助您快速创建和管理VMware快照。

要创建指定VM的新快照，基本语法为：

New-Snapshot -VM [vmname] -Name [snapshot name]

要创建已通电虚拟机的新快照并保留其内存状态，请执行以下操作：

New-Snapshot ‑VM [vmname] ‑Name [snapshot name] -Description [description] ‑Memory $true

要查看指定VM的所有快照，请执行以下操作：

Get-Snapshot -VM [vmname]

---------------
-ToTemplate：如何将VM转换为模板

从一个模板创建多个虚拟机是使用VMware PowerCLI命令的常见操作。在执行此操作之前，您需要一个可用的模板。您可以使用ToTemplate命令将VM转换为模板

要将虚拟机转换为模板，请运行以下命令：

Set-VM -ToTemplate -Confirm:$false

要检索指定数据中心中的所有VM模板，请执行以下操作：

Get-Template -Location [datacenter]
-----------------
 获取VICommand:如何查看所有可用的命令

此函数检索导入的VMware模块的所有命令，包括cmdlet、别名和函数。

如果您不确定应该使用什么VMware PowerCLI命令来完成您的工作，那么Get command是检索模块的所有相关命令（包括cmdlet、别名和函数）的一种方便方法：

要检索导入的VMware模块的所有可用命令，请执行以下操作：

Get-VICommand

要检索指定事物（例如快照）的所有相关命令，请执行以下操作：

Get-VICommand *snapshot*

-----------

获取帮助：如何访问官方帮助系统

如果您不熟悉VMware PowerCLI，还有一个内置的帮助系统，允许您快速检索针对VMware的PowerCLI命令的使用情况。

运行以下命令以显示命令的基本信息，例如概要、语法和说明：

Get-Help [command]

如果要查看有关该命令的所有帮助信息，包括参数和示例，请运行该命令：

Get-Help [command] -Full


New-VM -Name [vmname] -Template [template name] -Datastore [datastore name] -ResourcePool [resourcepool name] -Location [folder name] -OSCustomizationSpec [cust name]

