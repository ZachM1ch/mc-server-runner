############################
# Minecraft Server Runner
# Version 1.0
# Author: Zachary Michniewz
# Date: 10/07/2023
############################

# get name of the jar
$filename = Get-ChildItem -Path .\ -Name | ? {$_ -match 'jar'}

# run the jar
java -Xmx1024M -Xms1024M -jar $filename nogui

# if post setup file does not exist, do setup
if(!(Test-Path -Path .\whitelist.json -PathType Leaf))
{
	# wait for files to populate
	Start-Sleep -Seconds 10

	# sign eula
	(Get-Content -Path .\eula.txt) |
		ForEach-Object {$_ -Replace 'false', 'true'} |
			Set-Content -Path .\eula.txt

	#run the jar again
	java -Xmx1024M -Xms1024M -jar $filename nogui
}