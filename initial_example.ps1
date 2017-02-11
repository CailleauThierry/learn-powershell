<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.135
	 Posted by : 	https://learn-powershell.net/2012/09/13/powershell-and-wpf-introduction-and-building-your-first-window/
	 Created on:   	2/11/2017 1:13 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	initial_example.ps1
	===========================================================================
	.DESCRIPTION
		Learing WPF from https://learn-powershell.net/2012/09/13/powershell-and-wpf-introduction-and-building-your-first-window/
		initial_example.ps1 demonstrates the very first building block
#>
Add-Type -AssemblyName presentationframework # This line is not necessary when running from ISE as it is pre-loaded by the ISE
#Build the GUI
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="Initial Window" WindowStartupLocation = "CenterScreen" 
    Width = "800" Height = "600" ShowInTaskbar = "True">
</Window>
"@
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$Window = [Windows.Markup.XamlReader]::Load($reader)
$window.ToolTip = "This demonstrate .ToolTip cool, ins't it?"
$Window.ShowDialog() # This makes the windows pop-up

