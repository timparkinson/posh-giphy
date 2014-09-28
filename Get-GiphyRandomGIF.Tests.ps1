$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "when calling Get-GiphyRandomGIF" {

    It "should return a  GIF" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json -InputObject @"
{"data":{"type":"gif","id":"o2KaExZyq60p2","url":"http:\/\/giphy.com\/gifs\/wtf-meme-o2KaExZyq60p2","image_original_url":"http:\/\/s3.amazonaws.com\/giphymedia\/media\/o2KaExZyq60p2\/giphy.gif","image_url":"http:\/\/s3.amazonaws.com\/giphymedia\/media\/o2KaExZyq60p2\/giphy.gif","image_mp4_url":"http:\/\/s3.amazonaws.com\/giphymedia\/media\/o2KaExZyq60p2\/giphy.mp4","image_frames":"35","image_width":"300","image_height":"169","rating":"g","username":"","caption":"","tags":["weird","meme","eating","drinking","dogs"]}}
"@
        }
        $result = Get-GiphyRandomGIF 
        $result | Should Not BeNullOrEmpty
    }
}

Describe "when calling Get-GiphyRandomGIF with a tag" {

    It "should return a  GIF" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json -InputObject @"

{"data":{"type":"gif","id":"J7NlEsjBmfrzi","url":"http:\/\/giphy.com\/gifs\/J7NlEsjBmfrzi","image_original_url":"http:\/\/s3.amazonaws.com\/giphymedia\/media\/J7NlEsjBmfrzi\/giphy.gif","image_url":"http:\/\/s3.amazonaws.com\/giphymedia\/media\/J7NlEsjBmfrzi\/giphy.gif","image_mp4_url":"http:\/\/s3.amazonaws.com\/giphymedia\/media\/J7NlEsjBmfrzi\/giphy.mp4","image_frames":"23","image_width":"500","image_height":"212","rating":"r","username":"hoppip","caption":"","tags":["tv","art","film","hoppip","imt"]}}
"@
        }
        $result = Get-GiphyRandomGIF -Tag 'american psycho'
        $result | Should Not BeNullOrEmpty
    }
}

Describe "when calling Get-GiphyRandomGIF and the endpoint cannot be reached" {

    It "should error" {
        Mock Invoke-RestMethod {throw "Error!"}
        {Get-GiphyRandomGIF } | Should Throw
    }
}

Describe "when calling Get-GiphyRandomGIF on a non-existant tag" {
    It "should return a 0 count when there is no result" {
        Mock Invoke-RestMethod {
            ConvertFrom-Json @"
{"data":[],"pagination":{"total_count":0,"count":0,"offset":0},"meta":{"status":200,"msg":"OK"}}
"@
        }
       
        $result = Get-GiphyRandomGIF -Tag 'ghsjghsgsjgsjgj'
        $result.count | Should Be 0
    }
        
}
