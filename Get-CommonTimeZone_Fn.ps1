function Get-CommonTimeZone 
{
    
    <#

         .SYNOPSIS
            Function will list TimeZone 

         .DESCRIPTION  
            Function will list all commonly used time zones in JSON from GitHub and it will parse information and it will list all TimeZones

         
         .PARAMETER Path
            Offset - Function will list down timeZones with that offset 
            Name -  Function will list down timeZones that have the specified string in their name

         .EXAMPLE

            PS> Get-CommonTimeZone

            It will list all timezone information
         .EXAMPLE

            PS> Get-CommonTimeZone -offset -12

            value                  abbr offset isdst text                                     utc         
            -----                  ---- ------ ----- ----                                     ---         
            Dateline Standard Time DST     -12 False (UTC-12:00) International Date Line West {Etc/GMT+12}

          .EXAMPLE

            PS> Get-CommonTimeZone -value 'ASIA'

            value                         abbr  offset isdst text                                utc                                                              
            -----                         ----  ------ ----- ----                                ---                                                              
            West Asia Standard Time       WAST       5 False (UTC+05:00) Ashgabat, Tashkent      {Antarctica/Mawson, Asia/Aqtau, Asia/Aqtobe, Asia/Ashgabat...}   
            Central Asia Standard Time    CAST       6 False (UTC+06:00) Nur-Sultan (Astana)     {Antarctica/Vostok, Asia/Almaty, Asia/Bishkek, Asia/Qyzylorda...}
            SE Asia Standard Time         SAST       7 False (UTC+07:00) Bangkok, Hanoi, Jakarta {Antarctica/Davis, Asia/Bangkok, Asia/Hovd, Asia/Jakarta...}     
            N. Central Asia Standard Time NCAST      7 False (UTC+07:00) Novosibirsk             {Asia/Novokuznetsk, Asia/Novosibirsk, Asia/Omsk}                 
            North Asia Standard Time      NAST       8 False (UTC+08:00) Krasnoyarsk             {Asia/Krasnoyarsk}                                               
            North Asia East Standard Time NAEST      8 False (UTC+08:00) Irkutsk                 {Asia/Irkutsk}
         
    #>
   
    param(
            [validaterange(-12,+12)]
            [string]$offset,
            [string]$Value
         )


         if($offset.length -gt 0 -and $Value -gt 0)
         {
            Write-Error 'Input Parameters are not allowed simulataneously'
         }
         else
         {
            $TimeZoneData= Invoke-RestMethod 'https://raw.githubusercontent.com/dmfilipenko/timezones.json/master/timezones.json'
            

            if($Value.Length -gt 0)
            {

                if($TimeZoneData | Where value -Like *$value*)
                {
                    $TimeZoneData | Where value -Like *$value* 
                }
                else
                {
                    Write-Host "The Specified Value $Value doesn't match with any value in GitHub TimeZone Data"
                }
            }
            elseif($offset.length -gt 0)
            {
                    if($TimeZoneData | Where offset -eq $offset)
                    {
                        $TimeZoneData | Where offset -eq $offset 
                    }
                    else
                    {
                        Write-Host "The Specified Offset $offset doesn't match with any value in GitHub TimeZone Data"
                    }
            }
            else
            {
                $TimeZoneData 
            }
          }
}
