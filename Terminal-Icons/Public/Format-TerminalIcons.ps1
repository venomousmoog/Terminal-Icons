function Format-TerminalIcons {
    <#
    .SYNOPSIS
        Prepend a custom icon (with color) to the provided file or folder object when displayed.
    .DESCRIPTION
        Take the provided file or folder object and look up the appropriate icon and color to display.
    .PARAMETER FileInfo
        The file or folder to display
    .EXAMPLE
        Get-ChildItem

        List a directory. Terminal-Icons will be invoked automatically for display.
    .EXAMPLE
        Get-Item ./README.md | Format-TerminalIcons

        Get a file object and pass directly to Format-TerminalIcons.
    .INPUTS
        System.IO.FileSystemInfo

        You can pipe an objects that derive from System.IO.FileSystemInfo (System.IO.DIrectoryInfo and System.IO.FileInfo) to 'Format-TerminalIcons'.
    .OUTPUTS
        System.String

        Outputs a colorized string with an icon prepended.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [IO.FileSystemInfo]$FileInfo
    )

    process {
        $displayInfo = Resolve-Icon $FileInfo
        $tag = ""
        if ($FileInfo.PSIsContainer) {
            $tag = "/"
        }
        if ($displayInfo.Icon) {
            "$($displayInfo.Color)$($displayInfo.Icon) $($FileInfo.Name)$($tag)$($displayInfo.Target)$($script:colorReset)"
        } else {
            "$($displayInfo.Color)$($FileInfo.Name)$($tag)$($displayInfo.Target)$($script:colorReset)"
        }
    }
}
