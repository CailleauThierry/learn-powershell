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
$Window.ToolTip = "This demonstrate .ToolTip cool, ins't it?"
$Window.AllowsTransparency = $True
$Window.Opacity = .5
$window.WindowStyle = 'None'
$Window.Background = 'Green'
$Window.FontSize = 24
$Window.FontStyle = 'Italic' #"Normal", "Italic", or "Oblique
$Window.FontWeight = 'Bold' #http://msdn.microsoft.com/en-us/library/system.windows.fontweights
$Window.Foreground = 'Red'
$Window.Content = "This is a test!"
#Click To Close
#As seen in my demo of  a transparent window, there will be a time when you might need an alternate way to close the window. Luckily, that can be done with your mouse just by clicking on the window with either your left or right mouse button and using the $Window object's Close() method. In this case, I am going to close the Window using the Right mouse button.
$Window.Add_MouseRightButtonDown({
    $Window.close()
})
#Click To Drag
#Same issues with using transparency means that you have no real way to move your window around. We get around that by once again using the MouseRight/LeftButton event and then using the DragMove() method.
$Window.Add_MouseLeftButtonDown({
		$Window.DragMove()
})

$Window.ShowDialog() # This makes the windows pop-up
