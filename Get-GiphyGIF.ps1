function Get-GiphyGIF {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory=$true)]
        [String[]]$ID,
        [Parameter()]
        [String]$APIKey = 'dc6zaTOxFJmzC',
        [Parameter()]
        [String]$Endpoint = 'http://api.giphy.com/v1/gifs/'
    )

    begin {}

    process {
        $joined_ids = $ID -join ','
        $url = "$Endpoint$joined_ids`?api_key=$APIKey"

        Write-Verbose "Attempting to query $url"
        try {
            $result = Invoke-RestMethod -Uri $url -ErrorAction Stop
        }
        catch {
            Write-Error "Could not retrieve result from endpoint" -ErrorAction Stop
        }
        if ($result) {
            $output = @{
                'Count' = $result.Pagination.Count
                'Total Count' = $result.Pagination.total_count
                'Offset' = $result.Pagination.offset
                'Items' = @()
            }
            
            foreach ($item in $result.data) {
                $output.Items += $item
            }
        }

        $output
    }

    end {}
}
