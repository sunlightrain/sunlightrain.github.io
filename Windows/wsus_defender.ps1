# 更新完成后，可查看当前版本：
Get-MpComputerStatus | Select AntivirusSignatureVersion
# 更新后查看 Defender 状态：
Get-MpComputerStatus

usoclient StartScan
Update-MpSignature