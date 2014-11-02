#import "Movie.h"

#import "Kiwi.h"
#import "Kiwi+Helpers.h"

SPEC_BEGIN(MovieSpec)

describe(@"Movie", ^{
    describe(@"initWithDictionary", ^{
        __block Movie *movie;

        beforeEach(^{
            movie = [[Movie alloc] initWithDictionary:[Fixtures fixtureNamed:@"Godzilla"]];
        });

        it(@"should create a Movie object, populated with the given dictionary", ^{
            [[movie.title should] equal:@"Godzilla"];
            [[movie.mpaaRating should] equal:@"PG-13"];
            [[movie.synopsis should] equal:@"This is a story about a lizard wrecking stuff"];
            [[movie.posterThumbUrl should] equal:@"http://content8.flixster.com/movie/11/17/95/11179578_tmb.jpg"];
            [[movie.posterUrl should] equal:@"http://content8.flixster.com/movie/11/17/95/11179578_tmb.jpg"];

            [[theValue(movie.year) should] equal:theValue(2014)];
            [[theValue(movie.criticsScore) should] equal:theValue(73)];
            [[theValue(movie.audienceScore) should] equal:theValue(68)];
        });
    });

    describe(@"+moviesWithArray:", ^{
        __block NSArray *moviesJSON;
        __block NSArray *movies;

        beforeEach(^{
            moviesJSON = @[[Fixtures fixtureNamed:@"Godzilla"], [Fixtures fixtureNamed:@"Godzilla"], [Fixtures fixtureNamed:@"Godzilla"]];
        });

        it(@"should create a movie for every entry in the array", ^{
            movies = [Movie moviesWithArray:moviesJSON];
            [[theValue(movies.count) should] equal:theValue(3)];
        });

        it(@"should create the movies with the correct information", ^{
            movies = [Movie moviesWithArray:moviesJSON];

            Movie *movie0 = movies[0];
            [[movie0.title should] equal:@"Godzilla"];
        });

    });
});

SPEC_END