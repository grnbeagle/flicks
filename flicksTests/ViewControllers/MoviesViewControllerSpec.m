#import "MoviesViewController.h"

#import "Kiwi.h"
#import "Kiwi+Helpers.h"
#import "OHHTTPStubs.h"
#import "Movie.h"


@interface MoviesViewController ()

@property (strong, nonatomic) NSString *apiUrl;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)fetchData;

@end


SPEC_BEGIN(MoviesViewControllerSpec)

describe(@"MoviesViewController", ^{
    __block MoviesViewController *controller;

    beforeEach(^{
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return YES;
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [Fixtures responseForPath:@"top_rentals" statusCode:200];
        }];

        controller = [[MoviesViewController alloc] initWithMode:movieView];
        [controller.view shouldNotBeNil];       // Used to invoke viewDidLoad
    });

    afterEach(^{
        [OHHTTPStubs removeAllStubs];
    });


    describe(@"initWithMode:", ^{
        context(@"when init'ed for movies", ^{
            it(@"should set the api appropriately", ^{
                [[controller.apiUrl should] equal:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs&limit=20&country=us"];
            });

            it(@"should set the title to 'Movies'", ^{
                [[controller.title should] equal:@"Movies"];
            });
        });

        context(@"when init'ed for DVDs", ^{
            beforeEach(^{
                controller = [[MoviesViewController alloc] initWithMode:dvdView];
                [controller.view shouldNotBeNil];
            });

            it(@"should set the api appropriately", ^{
                [[controller.apiUrl should] equal:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us"];
            });

            it(@"should set the title to 'DVD'", ^{
                [[controller.title should] equal:@"DVD"];
            });
        });
    });

    describe(@"UITableViewDataSource", ^{
        describe(@"tableView:numberOfRowsInSection:", ^{
            beforeEach(^{
                NSArray *movies = @[[Movie new], [Movie new], [Movie new]];
                controller.movies = movies;
            });

            it(@"should return the number of movies", ^{
                [[theValue([controller tableView:nil numberOfRowsInSection:0]) should] equal:theValue(3)];
            });
        });

        describe(@"tableView:cellForRowAtIndex:", ^{
            context(@"if the user is currently searching", ^{
                describe(@"should populate with information from the search results", ^{
                    // check that the cell has the correct content from search results
                });
            });

            context(@"if the user is not currently searching", ^{
                describe(@"should populate with information from the movies array", ^{
                    // check that the cell has the correct content from the movies array
                });
            });
        });
    });

    describe(@"UITableViewDelegate", ^{
        describe(@"tableView:didSelectRowAtIndexPath:", ^{
            pending(@"should tell the search bar to resign firstResponder", ^{

            });

            pending(@"should deselect the cell", ^{

            });

            pending(@"should push a MovieDetailVC for the appropriate movie", ^{

            });
        });
    });

    describe(@"UISearchBarDelegate", ^{
        describe(@"searchBar:textDidChange:", ^{
            context(@"if the search text is empty", ^{
                // Left as an exercise, what should we test?
            });

            context(@"if the search text is not empty", ^{
                // Left as an exercise, what should we test?
            });
        });

        it(@"searchBarSearchButtonClicked:", ^{
            [[controller.searchBar should] receive:@selector(resignFirstResponder)];

            [controller searchBarSearchButtonClicked:controller.searchBar];
        });
    });

    describe(@"fetchData", ^{ // Normally we try to not test private methods, however due to the importance of this method it seemed like a good idea to make sure it behaved appropriately
        beforeEach(^{
            controller = [[MoviesViewController alloc] initWithMode:dvdView];
        });

        it(@"should populate the movies array", ^{
            [[theValue(controller.movies.count) should] equal:theValue(0)];

            [controller fetchData];

            [[expectFutureValue(theValue(controller.movies.count)) shouldNotEventually] equal:theValue(0)];
        });

        it(@"should tell the tableView to reload", ^{
            [[expectFutureValue(controller.tableView) shouldEventually] receive:@selector(reloadData) withCount:2]; // This should really only expect it once, but the viewDidLoad hasn't completed yet in test so it looks like two times for Kiwi

            [controller fetchData];
        });
    });
});

SPEC_END