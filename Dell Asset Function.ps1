Function Get-Warranty{
#Define Asset Tag
param(
[Parameter(Mandatory = $true,
ValueFromPipelineByPropertyName = $true,
ValueFromPipeline = $true,
Position = 0)]
[String] $AssetTag
)
#Connect to Dell API and establish a Script Proxy
$uri = 'http://xserv.dell.com/services/assetservice.asmx?WSDL'
$script:proxy = New-WebServiceProxy -uri 'http://xserv.dell.com/services/assetservice.asmx?WSDL' -Namespace WebServiceProxy
$pcInfo = $script:proxy.GetAssetInformation('12345678-1234-1234-1234-123456789012','dellwarrantycheck',$AssetTag)
#Create object for System with proper information to make object interactive
$Asset = New-Object PSObject -Property @{
ServiceTag = $pcInfo.AssetHeaderData.ServiceTag
SystemID = $pcInfo.AssetHeaderData.SystemID 
Build = $pcInfo.AssetHeaderData.Buid 
Region = $pcInfo.AssetHeaderData.Region
SystemType = $pcInfo.AssetHeaderData.SystemType
SystemModel = $pcInfo.AssetHeaderData.SystemModel
SystemShipDate = $pcInfo.AssetHeaderData.SystemShipDate
ServiceLevelCode = $pcInfo.Entitlements.ServiceLevelCode[0] 
ServiceLevelDescription = $pcInfo.Entitlements.ServiceLevelDescription[0]
Provider = $pcInfo.Entitlements.Provider[0]  
StartDate = $pcInfo.Entitlements.StartDate[0]  
EndDate = $pcInfo.Entitlements.EndDate[0] 
DaysLeft = $pcInfo.Entitlements.DaysLeft[0]
EntitlementType = $pcInfo.Entitlements.EntitlementType[0]
}
Return $Asset
}


