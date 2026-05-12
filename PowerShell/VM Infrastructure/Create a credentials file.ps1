# Create encrypted file
# Create a PSCredential object
$Username = "<Your_vCenter_Username>"
$Password = Read-Host -AsSecureString "Enter your vCenter password"

$Credential = New-Object System.Management.Automation.PSCredential($Username, $Password)

# Save the encrypted credentials to a file
$Credential | Export-CliXml -Path "C:\vCenterCredentials.xml"

Write-Host "Credentials saved to C:\vCenterCredentials.xml"

# -------
# Load credentials from the encrypted file
$CredentialFilePath = "C:\vCenterCredentials.xml"

if (Test-Path $CredentialFilePath) {
    $Credential = Import-CliXml -Path $CredentialFilePath
    $Username = $Credential.UserName
    $Password = $Credential.GetNetworkCredential().Password

    # Connect to vCenter using the credentials
    Connect-VIServer -Server "<vCenter_Server_Name>" -User $Username -Password $Password
    Write-Host "Connected to vCenter successfully."
} else {
    Write-Host "Credential file not found at $CredentialFilePath. Please create the file first."
}