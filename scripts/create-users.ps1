# create-users.ps1
# Génère un fichier LDIF à partir d'un CSV RH
# Conforme aux principes RBAC, Moindre Privilège, et traçabilité (ISO 27001 A.9, NIST AC-2)

$InputFile = "../data/employees.csv"
$OutputFile = "../output/users.ldif"
$DomainDN = "DC=lab,DC=local"
$UserOU = "OU=Users"

if (-not (Test-Path $InputFile)) {
    Write-Error "Fichier source introuvable : $InputFile"
    exit 1
}

$Employees = Import-Csv -Path $InputFile
Set-Content -Path $OutputFile -Value "" -Encoding UTF8

foreach ($Emp in $Employees) {
    if ($Emp.Status -ne "Active") { continue }

    $GivenName = $Emp.FirstName
    $SurName = $Emp.LastName
    $SamAccountName = ($GivenName.Substring(0,1) + $SurName).ToLower()
    $SamAccountName = $SamAccountName -replace "[^a-z0-9]", ""

    $CN = "$GivenName $SurName"
    $UserDN = "CN=$CN,$UserOU,$DomainDN"

    $Dept = $Emp.Department.ToUpper()
    $GroupName = "GRP_${Dept}_USERS"
    $GroupDN = "CN=$GroupName,OU=Groups,$DomainDN"

    $LdifEntry = @"
dn: $UserDN
changetype: add
objectClass: user
cn: $CN
sn: $SurName
givenName: $GivenName
sAMAccountName: $SamAccountName
userPrincipalName: $SamAccountName@lab.local
department: $($Emp.Department)
title: $($Emp.JobTitle)
description: Compte provisionné automatiquement - Source RH

dn: $GroupDN
changetype: modify
add: member
member: $UserDN

---
"@

    Add-Content -Path $OutputFile -Value $LdifEntry -Encoding UTF8
}

Write-Host "✅ Fichier LDIF généré : $OutputFile" -ForegroundColor Green
