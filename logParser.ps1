

# Collect releated product KPI log in a new file.
$logFile = Get-Content C:\ps-text-analysis.txt -ReadCount 0
ForEach ($line in $logFile) 
{
  if ($line -like '*KPI-Name*')
  {
    $line | Out-File c:\KPI.txt -Append
  
  }  
}


# Analyze the log file.
$allValues = @()
foreach ($text in (Get-Content c:\KPI.txt))
{
   $array = $text.split("=")
   
   $logObj = [pscustomobject]@{
     text = $array[0]
     value = $array[1]
   }
   $allValues += $logObj
   
}

# Caculate the value.
$totalSum = @()
foreach ($obj in $allValues)
{
    $totalSum += $obj.value
}

($totalSum | Measure-Object -average).average
($totalSum | Measure-Object -Maximum).Maximum
($totalSum | Measure-Object -Minimum).Minimum



