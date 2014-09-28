function Get-GiphyRandomGIF {
    [CmdletBinding()]

    param(
        [Parameter()]
        [String]$Tag,
        [Parameter()]
        [String]$APIKey = 'dc6zaTOxFJmzC',
        [Parameter()]
        [String]$Endpoint = 'http://api.giphy.com/v1/gifs/random'
    )

    begin {}

    process {
        
        $url = "$Endpoint`?api_key=$APIKey"
        if ($Tag) {
            $url += "&tag=$Tag"
        }

        Write-Verbose "Attempting to query $url"
        try {
            $result = Invoke-RestMethod -Uri $url -ErrorAction Stop
        }
        catch {
            Write-Error "Could not retrieve result from endpoint" -ErrorAction Stop
        }
        if ($result) {

            if ($result.data.count -eq 0) {
               $output = @{
                    'Count' = 0
                    'Total Count' = 0
                    'Offset' = 0
                    'Items' = @()
                }
            } else {
                $output = @{
                    'Count' = 1
                    'Total Count' = 1
                    'Offset' = 0
                    'Items' = @()
                }
            }
            
            foreach ($item in $result.data) {
                $output.Items += $item
            }
        }

        $output
    }

    end {}
}
