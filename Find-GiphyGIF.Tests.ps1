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

    It "should error when the endpoint cannot be reached" {
        Mock Invoke-RestMethod {throw "Error!"}
        {Find-GiphyGIF -Query 'Funny Cat'} | Should Throw
    }

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