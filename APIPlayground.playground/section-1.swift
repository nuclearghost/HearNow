// Playground - noun: a place where people can play

import UIKit
import Foundation

var rawURL = "http://api.songkick.com/api/3.0/metro_areas/26330/calendar.json?apikey=FdFuEuAG8tXwHfe9"

var url: NSURL = NSURL(string: rawURL)
var request: NSURLRequest = NSURLRequest(URL: url)
