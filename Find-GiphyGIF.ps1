function Find-GiphyGIF {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true)]
        [String]$Query,
        [Parameter()]
        [String]$APIKey = 'dc6zaTOxFJmzC',
        [Parameter()]
        [String]$Endpoint = 'http://api.giphy.com/v1/gifs/search?',
        [Parameter()]
        [Int]$Limit,
        [Parameter()]
        [Int]$Offset,
        [Parameter()]
        [Switch]$Translate
    )

    begin {}

    process {
        if ($Translate) {
            $api = 's'
            $Endpoint = 'http://api.giphy.com/v1/gifs/translate?'
        } else {
            $api = 'q'
        }
        $url = "$Endpoint$api=$Query&api_key=$APIKey"

        if (-not $Translate) {
            if ($Limit) {
                $url += "limit=$Limit"
            }
            if ($Offset) {
                $url += "offset=$Offset"
            }
        }

        Write-Verbose "Attempting to query $url"
        try {
            $result = Invoke-RestMethod -Uri $url -ErrorAction Stop
        }
        catch {
            Write-Error "Could not retrieve result from endpoint" -ErrorAction Stop
        }
        if ($result) {

            if ($Translate) {
                if ($result.data.count -eq 0 ) {
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
            } else {
                $output = @{
                    'Count' = $result.Pagination.Count
                    'Total Count' = $result.Pagination.total_count
                    'Offset' = $result.Pagination.offset
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