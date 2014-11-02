#import "Kiwi.h"

SPEC_BEGIN(ExampleSpec)

describe(@"Example", ^{
    beforeAll(^{
        // This code will be ran once, before all of the specs
    });

    afterAll(^{
        // This code will be ran once, after all of the specs
    });

    beforeEach(^{
        // This code will be ran before every spec
    });

    afterEach(^{
        // This code will be ran after every spec
    });

    describe(@"my big class method", ^{
        context(@"when foo", ^{
            describe(@"this group of behavior", ^{
                it(@"should do this", ^{
                    NSObject *object = [NSObject new];

                    [[object should] equal:object];
                });
            });
        });

        context(@"when bar", ^{
            pending(@"this test won't be run", ^{
                // do stuff
            });
        });
    });
});

SPEC_END