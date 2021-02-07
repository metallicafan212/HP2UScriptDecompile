# Metallicafan212: Get all the files in the classes folder
#Get-ChildItem -Path "Classes" -Recurse |

# Metallicafan212: Now loop through them and set their modified date to the current date
#Foreach-Object
#{
#	$_.lastwritetime=$(Get-Date)
#}

foreach($file in Get-ChildItem -Path "Classes" -Recurse)
{
	$file.lastwritetime=$(Get-Date)
}