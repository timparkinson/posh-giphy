$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "when calling Find-GiphyGIF on a common term" {

    It "should return a list of GIFs" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json -InputObject @"
{
    "data": [
        {
            type: "gif",
            id: "OzmIjVRDwM6as",
            url: "http://giphy.com/gifs/OzmIjVRDwM6as",
            bitly_gif_url: "http://gph.is/1oLbeor",
            bitly_url: "http://gph.is/1oLbeor",
            embed_url: "http://giphy.com/embed/OzmIjVRDwM6as",
            username: "",
            source: "http://www.tumblr.com",
            rating: "g",
            trending_datetime: "0000-00-00 00:00:00",
            images: {
                fixed_height: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/200.gif",
                    width: "360",
                    height: "200",
                    mp4: "http://media.giphy.com/media/OzmIjVRDwM6as/200.mp4"
                },
                fixed_height_still: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/200_s.gif",
                    width: "360",
                    height: "200"
                },
                fixed_height_downsampled: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/200_d.gif",
                    width: "360",
                    height: "200"
                },
                fixed_width: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/200w.gif",
                    width: "200",
                    height: "111",
                    mp4: "http://media.giphy.com/media/OzmIjVRDwM6as/200w.mp4"
                },
                fixed_width_still: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/200w_s.gif",
                    width: "200",
                    height: "111"
                },
                fixed_width_downsampled: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/200w_d.gif",
                    width: "200",
                    height: "111"
                },
                original: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/giphy.gif",
                    width: "400",
                    height: "222",
                    size: "807648",
                    frames: "23",
                    mp4: "http://media.giphy.com/media/OzmIjVRDwM6as/giphy.mp4"
                },
                original_still: {
                    url: "http://media4.giphy.com/media/OzmIjVRDwM6as/giphy_s.gif",
                    width: "400",
                    height: "222"
                }
            }
        }
    ],
    "meta": {
        "msg": "OK",
        "status": 200
    },
    "pagination": {
        "count": 1,
        "offset": "0",
        "total_count": 249
    }
}
"@
        }
        $result = Find-GiphyGIF -Query 'Funny Cat'
        $result | Should Not BeNullOrEmpty
    }
}

Describe "when calling Find-GiphyGIF and the endpoint cannot be reached" {

    It "should error" {
        Mock Invoke-RestMethod {throw "Error!"}
        {Find-GiphyGIF -Query 'Funny Cat'} | Should Throw
    }
}

Describe "when calling Find-GiphyGIF on a non-common term" {
    It "should return a 0 count when there is no result" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json @"
{"data":[],"pagination":{"total_count":0,"count":0,"offset":0},"meta":{"status":200,"msg":"OK"}}
"@
        }
       
        $result = Find-GiphyGIF -Query 'ghsjghsgsjgsjgj'
        $result.count | Should Be 0
    }
        
}

Describe "when calling Find-GiphyGIF with the translate switch" {
    It "should return a GIF" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json @"
{"data":{"type":"gif","id":"3avUsGhmckIYE","url":"http:\/\/giphy.com\/gifs\/3avUsGhmckIYE","bitly_gif_url":"http:\/\/gph.is\/XH7V6j","bitly_url":"http:\/\/gph.is\/XH7V6j","embed_url":"http:\/\/giphy.com\/embed\/3avUsGhmckIYE","username":"","source":"http:\/\/wonderwomanzombies.tumblr.com\/post\/35372021647","rating":"g","caption":"","content_url":"","trending_datetime":"2014-07-25 21:32:56","images":{"fixed_height":{"url":"http:\/\/media2.giphy.com\/media\/3avUsGhmckIYE\/200.gif","width":"289","height":"200","mp4":"http:\/\/media.giphy.com\/media\/3avUsGhmckIYE\/200.mp4"},"fixed_height_still":{"url":"http:\/\/media3.giphy.com\/media\/3avUsGhmckIYE\/200_s.gif","width":"289","height":"200"},"fixed_height_downsampled":{"url":"http:\/\/media1.giphy.com\/media\/3avUsGhmckIYE\/200_d.gif","width":"289","height":"200"},"fixed_width":{"url":"http:\/\/media0.giphy.com\/media\/3avUsGhmckIYE\/200w.gif","width":"200","height":"138","mp4":"http:\/\/media.giphy.com\/media\/3avUsGhmckIYE\/200w.mp4"},"fixed_width_still":{"url":"http:\/\/media3.giphy.com\/media\/3avUsGhmckIYE\/200w_s.gif","width":"200","height":"138"},"fixed_width_downsampled":{"url":"http:\/\/media0.giphy.com\/media\/3avUsGhmckIYE\/200w_d.gif","width":"200","height":"138"},"downsized":{"url":"http:\/\/media3.giphy.com\/media\/3avUsGhmckIYE\/giphy.gif","width":"500","height":"346","size":"279481"},"downsized_still":{"url":"http:\/\/media4.giphy.com\/media\/3avUsGhmckIYE\/giphy_s.gif","width":"500","height":"346"},"original":{"url":"http:\/\/media3.giphy.com\/media\/3avUsGhmckIYE\/giphy.gif","width":"500","height":"346","size":"279481","frames":"7","mp4":"http:\/\/media.giphy.com\/media\/3avUsGhmckIYE\/giphy.mp4"},"original_still":{"url":"http:\/\/media4.giphy.com\/media\/3avUsGhmckIYE\/giphy_s.gif","width":"500","height":"346"}}},"meta":{"status":200,"msg":"OK"}}
"@
        }

        $result = Find-GiphyGIF -Query 'Superman' -Translate
        $result.Count | Should Be 1
    }

}