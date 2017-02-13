<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.135
	 Posted by : 	https://learn-powershell.net/2012/10/14/powershell-and-wpf-writing-data-to-a-ui-from-a-different-runspace/
	 Created on:   	2/12/2017 11:21 AM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	WPF_GUI.ps1
	===========================================================================
	.DESCRIPTION
		Explaination of WPF and managing GUI from https://learn-powershell.net/2012/10/14/powershell-and-wpf-writing-data-to-a-ui-from-a-different-runspace/
#>
#Add-Type -AssemblyName presentationframework # This line is not necessary when running from ISE as it is pre-loaded by the ISE

$syncHash = [hashtable]::Synchronized(@{
	})
$newRunspace = [runspacefactory]::CreateRunspace()
$newRunspace.ApartmentState = 'STA'
$newRunspace.ThreadOptions = 'ReuseThread'
$newRunspace.Open()
$newRunspace.SessionStateProxy.SetVariable('syncHash', $syncHash)
$psCmd = [PowerShell]::Create().AddScript({
		[xml]$xaml = @"
    <Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        x:Name="Window" Title="Initial Window" WindowStartupLocation = "CenterScreen"
        Width = "600" Height = "800" ShowInTaskbar = "True">
        <TextBox x:Name = "textbox" Height = "400" Width = "600"/>
    </Window>
"@
		
		$reader = (New-Object System.Xml.XmlNodeReader $xaml)
		$syncHash.Window = [Windows.Markup.XamlReader]::Load($reader)
		$syncHash.TextBox = $syncHash.window.FindName('textbox')
		$syncHash.Window.ShowDialog() | Out-Null
		$syncHash.Error = $Error
	})
$psCmd.Runspace = $newRunspace
$data = $psCmd.BeginInvoke()