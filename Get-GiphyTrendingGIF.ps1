function Get-GiphyTrendingGIF {
    [CmdletBinding()]

    param(
        [Parameter()]
        [Int]$Limit,
        [Parameter()]
        [String]$APIKey = 'dc6zaTOxFJmzC',
        [Parameter()]
        [String]$Endpoint = 'http://api.giphy.com/v1/trending?'
    )

    begin {}

    process {
        
        $url = "$Endpoint`api_key=$APIKey"
        if ($Limit) {
            $url += "&limit=$Limit"
        }

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
                'Total Count' = 25
                'Offset' =$result.Pagination.Offset
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
