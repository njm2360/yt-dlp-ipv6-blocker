# Google IPv6 Blocker

# AS15169 (Google) IPv6 prefixes list
$prefixes = @(
    '2001:4860::/32',
    '2404:6800::/32',
    '2404:f340::/32',
    '2605:ef80::/32',
    '2606:40::/32',
    '2607:f8b0::/32',
    '2620:120:e000::/40',
    '2800:3f0::/32',
    '2a00:1450::/32',
    '2c0f:fb50::/32',
)

# Firewall apply program list
$firewallRules = @{
    "yt-dlp" = Join-Path $env:USERPROFILE 'AppData\LocalLow\VRChat\VRChat\Tools\yt-dlp.exe'
    "VRChat" = 'C:\Program Files (x86)\Steam\steamapps\common\VRChat\VRChat.exe'
}

# Firewall rule name prefix
$ruleNamePrefix = 'Block-Google-IPv6-for-'

foreach ($key in $firewallRules.Keys) {
    $programPath = $firewallRules[$key]
    $ruleName = "$ruleNamePrefix$key"

    # Check for existing rule
    $rule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

    if (-not $rule) {
        # Create and enable new rule
        New-NetFirewallRule -DisplayName $ruleName `
            -Direction Outbound `
            -Action Block `
            -Protocol Any `
            -RemoteAddress $prefixes `
            -Profile Any `
            -Program $programPath
        Write-Host "Firewall rule '$ruleName' created and Enabled."
    } else {
        # Toggle state
        $current = ($rule).Enabled -eq 'True'
        if ($current) {
            Disable-NetFirewallRule -DisplayName $ruleName
            Write-Host "Firewall rule '$ruleName' is now Disabled."
        } else {
            Enable-NetFirewallRule -DisplayName $ruleName
            Write-Host "Firewall rule '$ruleName' is now Enabled."
        }
    }
}

# Pause to let user read output
Read-Host -Prompt "Press Enter to exit"
