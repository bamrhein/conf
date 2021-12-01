# Use Emacs-style keybindings like Bash
Set-PSReadLineOption -EditMode emacs

# Alias for an equivalent of the Unix "which" command
function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}

# Aliases to use Vim in PowerShell
New-Alias -Name vi -Value 'C:\Program Files (x86)\Vim\vim82\vim.exe'
New-Alias -Name vim -Value 'C:\Program Files (x86)\Vim\vim82\vim.exe'
