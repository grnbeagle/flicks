flicks
======
Rotten Tomates app

This is an iOS 7 demo app displaying box office movies and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON). It is created as part of [CodePath](http://codepath.com/) course work. (June 10, 2014)

Time spent: approximately 15 hours

Features
---------
#### Required
- [x] User can view a list of movies. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [x] User can pull to refresh the movie list.

#### Optional
- [x] All images fade in.
- [x] For the larger poster, load the low-res first and switch to high-res when complete.
- [x] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `NSURLRequestReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Add a tab bar for Box Office and DVD.
- [x] Add a search bar: pretty simple implementation of searching against the existing table view data.

Walkthrough
------------
![Video Walkthrough](flicks-walkthrough.gif)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [MBProgressHUD](https://github.com/matej/MBProgressHUD) for loading indicator
* Icons from [IconFinder](https://www.iconfinder.com/)
* Yellow/dark gray theme is a tribute to [Vdio](http://www.vdio.com/news/).

