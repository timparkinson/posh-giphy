$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "when calling Get-GiphyGIF with a single ID" {

    It "should return a  GIF" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json -InputObject @"
{"data":[{"type":"gif","id":"feqkVgjJpYtjy","url":"http:\/\/giphy.com\/gifs\/feqkVgjJpYtjy","bitly_gif_url":"http:\/\/gph.is\/XJ200y","bitly_url":"http:\/\/gph.is\/XJ200y","embed_url":"http:\/\/giphy.com\/embed\/feqkVgjJpYtjy","username":"","source":"http:\/\/littleanimalgifs.tumblr.com\/post\/17994517807","rating":"g","caption":"","content_url":"","trending_datetime":"2014-09-23 22:49:53","images":{"fixed_height":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/200.gif","width":"445","height":"200","mp4":"http:\/\/media.giphy.com\/media\/feqkVgjJpYtjy\/200.mp4"},"fixed_height_still":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/200_s.gif","width":"445","height":"200"},"fixed_height_downsampled":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/200_d.gif","width":"445","height":"200"},"fixed_width":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/200w.gif","width":"200","height":"90","mp4":"http:\/\/media.giphy.com\/media\/feqkVgjJpYtjy\/200w.mp4"},"fixed_width_still":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/200w_s.gif","width":"200","height":"90"},"fixed_width_downsampled":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/200w_d.gif","width":"200","height":"90"},"downsized":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/giphy.gif","width":"334","height":"150","size":"511581"},"downsized_still":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/giphy_s.gif","width":"334","height":"150"},"original":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/giphy.gif","width":"334","height":"150","size":"511581","frames":"27","mp4":"http:\/\/media.giphy.com\/media\/feqkVgjJpYtjy\/giphy.mp4"},"original_still":{"url":"http:\/\/media3.giphy.com\/media\/feqkVgjJpYtjy\/giphy_s.gif","width":"334","height":"150"}}}],"pagination":{"total_count":1,"count":1,"offset":0},"meta":{"status":200,"msg":"OK"}}

"@
        }
        $result = Get-GiphyGIF -ID 'feqkVgjJpYtjy'
        $result | Should Not BeNullOrEmpty
    }
}

Describe "when calling Get-GiphyGIF with multiple IDs" {

    It "should return a  GIF" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json -InputObject @"

{"data":[{"type":"gif","id":"feqkVgjJpYtjy","url":"http:\/\/giphy.com\/gifs\/feqkVgjJpYtjy","bitly_gif_url":"http:\/\/gph.is\/XJ200y","bitly_url":"http:\/\/gph.is\/XJ200y","embed_url":"http:\/\/giphy.com\/embed\/feqkVgjJpYtjy","username":"","source":"http:\/\/littleanimalgifs.tumblr.com\/post\/17994517807","rating":"g","caption":"","content_url":"","trending_datetime":"2014-09-23 22:49:53","images":{"fixed_height":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/200.gif","width":"445","height":"200","mp4":"http:\/\/media.giphy.com\/media\/feqkVgjJpYtjy\/200.mp4"},"fixed_height_still":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/200_s.gif","width":"445","height":"200"},"fixed_height_downsampled":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/200_d.gif","width":"445","height":"200"},"fixed_width":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/200w.gif","width":"200","height":"90","mp4":"http:\/\/media.giphy.com\/media\/feqkVgjJpYtjy\/200w.mp4"},"fixed_width_still":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/200w_s.gif","width":"200","height":"90"},"fixed_width_downsampled":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/200w_d.gif","width":"200","height":"90"},"downsized":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/giphy.gif","width":"334","height":"150","size":"511581"},"downsized_still":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/giphy_s.gif","width":"334","height":"150"},"original":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/giphy.gif","width":"334","height":"150","size":"511581","frames":"27","mp4":"http:\/\/media.giphy.com\/media\/feqkVgjJpYtjy\/giphy.mp4"},"original_still":{"url":"http:\/\/media2.giphy.com\/media\/feqkVgjJpYtjy\/giphy_s.gif","width":"334","height":"150"}}},{"type":"gif","id":"7rzbxdu0ZEXLy","url":"http:\/\/giphy.com\/gifs\/7rzbxdu0ZEXLy","bitly_gif_url":"http:\/\/gph.is\/13YkU2y","bitly_url":"http:\/\/gph.is\/13YkU2y","embed_url":"http:\/\/giphy.com\/embed\/7rzbxdu0ZEXLy","username":"mrdiv","source":"http:\/\/mrdiv.tumblr.com\/post\/48618427039\/disco-sphere","rating":"g","caption":"","content_url":"","trending_datetime":"1970-01-01 00:00:00","images":{"fixed_height":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/200.gif","width":"200","height":"200","mp4":"http:\/\/media.giphy.com\/media\/7rzbxdu0ZEXLy\/200.mp4"},"fixed_height_still":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/200_s.gif","width":"200","height":"200"},"fixed_height_downsampled":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/200_d.gif","width":"200","height":"200"},"fixed_width":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/200w.gif","width":"200","height":"200","mp4":"http:\/\/media.giphy.com\/media\/7rzbxdu0ZEXLy\/200w.mp4"},"fixed_width_still":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/200w_s.gif","width":"200","height":"200"},"fixed_width_downsampled":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/200w_d.gif","width":"200","height":"200"},"downsized":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/giphy.gif","width":"500","height":"500","size":"1012692"},"downsized_still":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/giphy_s.gif","width":"500","height":"500"},"original":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/giphy.gif","width":"500","height":"500","size":"1012692","frames":"9","mp4":"http:\/\/media.giphy.com\/media\/7rzbxdu0ZEXLy\/giphy.mp4"},"original_still":{"url":"http:\/\/media2.giphy.com\/media\/7rzbxdu0ZEXLy\/giphy_s.gif","width":"500","height":"500"}}}],"pagination":{"total_count":2,"count":2,"offset":0},"meta":{"status":200,"msg":"OK"}}
"@
        }
        $result = Get-GiphyGIF -ID 'feqkVgjJpYtjy','7rzbxdu0ZEXLy'
        $result | Should Not BeNullOrEmpty
    }
}

Describe "when calling Get-GiphyGIF and the endpoint cannot be reached" {

    It "should error" {
        Mock Invoke-RestMethod {throw "Error!"}
        {Get-GiphyGIF -ID 'Funny Cat'} | Should Throw
    }
}

Describe "when calling Get-GiphyGIF on a non-existant ID" {
    It "should return a 0 count when there is no result" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json @"
{"data":[],"pagination":{"total_count":0,"count":0,"offset":0},"meta":{"status":200,"msg":"OK"}}
"@
        }
       
        $result = Get-GiphyGIF -ID 'ghsjghsgsjgsjgj'
        $result.count | Should Be 0
    }
        
}
