# Google IPv6 Blocker

# AS15169 (Google) IPv6 prefixes list
$prefixes = @(
    '2001:4860::/32',
    '2001:4860:4820::/48',
    '2001:4860:4821::/48',
    '2001:4860:4822::/48',
    '2001:4860:4823::/48',
    '2001:4860:4824::/48',
    '2001:4860:4825::/48',
    '2001:4860:4826::/48',
    '2001:4860:4827::/48',
    '2001:4860:4828::/48',
    '2001:4860:4829::/48',
    '2001:4860:482a::/48',
    '2001:4860:482b::/48',
    '2001:4860:482c::/48',
    '2001:4860:482d::/48',
    '2001:4860:482e::/48',
    '2001:4860:482f::/48',
    '2001:4860:4830::/48',
    '2001:4860:4831::/48',
    '2001:4860:4832::/48',
    '2001:4860:4833::/48',
    '2001:4860:4864::/48',
    '2404:6800::/32',
    '2404:6800:4001::/48',
    '2404:6800:4002::/48',
    '2404:6800:4003::/48',
    '2404:6800:4004::/48',
    '2404:6800:4005::/48',
    '2404:6800:4006::/48',
    '2404:6800:4007::/48',
    '2404:6800:4008::/48',
    '2404:6800:4009::/48',
    '2404:6800:400a::/48',
    '2404:6800:480e::/48',
    '2404:f340::/32',
    '2605:ef80::/32',
    '2606:40::/32',
    '2607:f8b0::/32',
    '2607:f8b0:4000::/48',
    '2607:f8b0:4001::/48',
    '2607:f8b0:4002::/48',
    '2607:f8b0:4003::/48',
    '2607:f8b0:4004::/48',
    '2607:f8b0:4005::/48',
    '2607:f8b0:4006::/48',
    '2607:f8b0:4007::/48',
    '2607:f8b0:4008::/48',
    '2607:f8b0:4009::/48',
    '2607:f8b0:400a::/48',
    '2607:f8b0:400b::/48',
    '2607:f8b0:400c::/48',
    '2607:f8b0:400d::/48',
    '2607:f8b0:400e::/48',
    '2607:f8b0:400f::/48',
    '2607:f8b0:4010::/48',
    '2607:f8b0:4011::/48',
    '2607:f8b0:4012::/48',
    '2607:f8b0:4013::/48',
    '2607:f8b0:4014::/48',
    '2607:f8b0:4015::/48',
    '2607:f8b0:4016::/48',
    '2607:f8b0:480e::/48',
    '2607:f8b0:480f::/48',
    '2620:120:e000::/40',
    '2800:3f0::/32',
    '2800:3f0:4001::/48',
    '2800:3f0:4002::/48',
    '2800:3f0:4003::/48',
    '2800:3f0:4004::/48',
    '2800:3f0:4005::/48',
    '2a00:1450::/32',
    '2a00:1450:4001::/48',
    '2a00:1450:4002::/48',
    '2a00:1450:4003::/48',
    '2a00:1450:4004::/48',
    '2a00:1450:4005::/48',
    '2a00:1450:4006::/48',
    '2a00:1450:4007::/48',
    '2a00:1450:4008::/48',
    '2a00:1450:4009::/48',
    '2a00:1450:400a::/48',
    '2a00:1450:400b::/48',
    '2a00:1450:400c::/48',
    '2a00:1450:400d::/48',
    '2a00:1450:400e::/48',
    '2a00:1450:400f::/48',
    '2a00:1450:4010::/48',
    '2a00:1450:4011::/48',
    '2a00:1450:4012::/48',
    '2a00:1450:4013::/48',
    '2a00:1450:4014::/48',
    '2a00:1450:4015::/48',
    '2a00:1450:4016::/48',
    '2a00:1450:4017::/48',
    '2a00:1450:4018::/48',
    '2a00:1450:4019::/48',
    '2a00:1450:401a::/48',
    '2a00:1450:401b::/48',
    '2a00:1450:401c::/48',
    '2a00:1450:480e::/48',
    '2c0f:fb50::/32',
    '2c0f:fb50:4002::/48',
    '2c0f:fb50:4003::/48'
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
