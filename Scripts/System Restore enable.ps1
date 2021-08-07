Function SystemRestore {
    $return = Checkpoint-Computer "System-Restore Enabled"
    return $true
}

Function OnlyTrue {
    if (SystemRestore -eq $true) {
        ((Get-ComputerRestorePoint).Description)[-1]
    } else {
        Write-Host "Failed to enable system restore"
    }
}

OnlyTrue