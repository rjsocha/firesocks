Function _r {
  Param($text)
  Write-Host -ForegroundColor Red -NoNewline $text
}
Function _g {
  Param($text)
  Write-Host -ForegroundColor Green -NoNewline $text
}
Function _w {
  Param($text)
  Write-Host -ForegroundColor White -NoNewline $text
}

Function _prepareTools {
  foreach ($tool in "doctl","terraform") {
    if(!(Test-Path (".\tools\windows\{0}.zip" -f $tool)))  {
      _r "Required tool "
      _g "$tool"
      _r " is missing!`n"
      exit
     }
    if(!(Test-Path (".\tools\windows\{0}.exe" -f $tool))) {
        _w "Extracting: "
        _g "$tool`n"
        Expand-Archive (".\tools\windows\{0}.zip" -f $tool) -Force -DestinationPath ".\tools\windows\"
    }
  }
}

Function isCommand {
    Param ($command)
    $oldAP = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    $found=0
    try {
        if(Get-Command $command) {
            $found=1
        }
     } catch {
        $found=0
     }
     $ErrorActionPreference = $oldAP
     return $found
}

Function _check_ssh {
    $c1=isCommand("ssh")
    $c2=isCommand("ssh-keygen")
    if($c1 -eq 0 -or $c2 -eq 0) {
        _r "Missing ssh toolset!`n"
        _g "Please install Microsfot OpenSSH client!`n"
        $a=Read-Host "Do you want to open instructions (y/n)? "
        if($a -eq 'y') {
            start "https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse"
        }
        _r "Terminating script!`n"
        exit
    }
}

Function ensureState {
    if(!(Test-Path -PathType Container ".\state")) {
        New-Item -ItemType Directory -Force -Path ".\state" | Out-Null
     }
}

Function VM {
Param($_args)
    $cmd,$_args=$_args
    ensureState
    switch ($cmd) {
        'create' {
            Write-Host "create-vm"
        }
    }
}

_g "Firesocks for Windows"; _r " (ALPHA VERSION)`n"

_check_ssh
_prepareTools



if($args.count -lt 1) {
    _w "Supported commands: "
    _g "firesocks vm|vpn|start|stop`n"
    exit
}

$cmd,$args=$args
switch ($cmd) {
    'vm'
     { VM $args $cmd}
   'vpn'
    { VPN $args }
}