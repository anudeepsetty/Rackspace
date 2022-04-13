

function Get-CommonTimeZone 
{

    param(
            [validaterange(-12,+12)]
            [string]$offset,
            [string]$Value
         )
         if($offset.length -gt 0 -and $Value -gt 0)
         {
            Write-Error 'Input Parameters are not allowed to supply simulataneously'
         }
         else
         {
            $TimeZoneData= Invoke-RestMethod 'https://raw.githubusercontent.com/dmfilipenko/timezones.json/master/timezones.json'
            
            $offset


            if($Value.Length -gt 0)
            {
                Write-Host "value"

                if($TimeZoneData | Where value -Like *$value*)
                {
                    $TimeZoneData | Where value -Like *$value* | Format-Table
                }
                else
                {
                    Write-Host "The Specified Value $Value doesn't match with any value in GitHub TimeZone Data"
                }
            }
            elseif($offset.length -gt 0)
            {
                    $TimeZoneData | Where offset -eq $offset | Format-Table
            }
            else
            {
                $TimeZoneData |Format-Table
            }
          }
}
