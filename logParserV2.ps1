
# Find all KPI related lines and then output to a new file.
#$logFile = Get-Content C:\ps-text-analysis.txt -ReadCount 0
$logFile = Get-Content C:\KPI.txt -ReadCount 0
$logParseStartTime = Get-Date -format HH:MM:ss
ForEach ($line in $logFile) 
{
  if (($line -like '*KPI*') -and ($line.split(" ")[1] -gt "$logParseStartTime") )
  {
    #$line | Out-File c:\KPI.txt -Append
    Write-Host "$line"
  
  }  
}


# Analyze the new generated log file according to specific KPI value.
$KPIValue1 = @()
$KPIValue2 = @()
foreach ($text in (Get-Content c:\KPI.txt))
{
   if ($text -match 'KPI-Name1')
   {
       $array = $text -split "=="
       $KPIValue1 += $array[1]
   
   }
   if ($text -match 'KPI-Name2')
   {
       $array = $text -split "=="
       $KPIValue2 += $array[1]
   }   
}

# Caculate every KPI value.

($KPIValue1 | Measure-Object -average).average
($KPIValue1 | Measure-Object -Maximum).Maximum
($KPIValue1 | Measure-Object -Minimum).Minimum

($KPIValue2 | Measure-Object -average).average
($KPIValue2 | Measure-Object -Maximum).Maximum
($KPIValue2 | Measure-Object -Minimum).Minimum

