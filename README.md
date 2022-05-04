
# HelloSign downloader

## Prerequisites

You should have an envrionment variable named `HELLOSIGN_API_KEY`

## To download all hellosign documents, first download the metadata

    $ bundle exec ruby 3_script.rb

## Then go on to download the documents

    $ bundle exec ruby 4_script.rb

This script is fast, I was able to do about $3k in about 3 hours.


<hr>

This is based on a gist by [frobichaud](https://gist.github.com/frobichaud)<br>
https://gist.github.com/frobichaud/2357b52c564459e4ea57e95c0474fa42