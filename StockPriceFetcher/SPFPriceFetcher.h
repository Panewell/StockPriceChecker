//
//  SPFPriceFetcher.h
//  StockPriceFetcher
//
//  Chuck Konkol 11/2013

#import <Foundation/Foundation.h>



typedef void (^SPFQuoteRequestCompleteBlock) (BOOL wasSuccessful, NSDecimalNumber *price);

@interface SPFPriceFetcher : NSObject

- (void)requestQuoteForSymbol:(NSString *)symbol
                 withCallback:(SPFQuoteRequestCompleteBlock)callback;

@end

