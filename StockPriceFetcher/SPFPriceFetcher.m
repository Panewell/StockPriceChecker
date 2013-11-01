//
//  SPFPriceFetcher.m
//  StockPriceFetcher
//
//  Chuck Konkol 11/2013

#import "SPFPriceFetcher.h"
#import "JCDHTTPConnection.h"

// Yahoo stock quote API
// Example: http://download.finance.yahoo.com/d/quotes.csv?s=GOOG&f=l1
#define kYahooStockQuoteAPIURL @"http://download.finance.yahoo.com/d/quotes.csv"
#define kYahooStockQuoteAPIFormatString @"l1"


@implementation SPFPriceFetcher

- (void)requestQuoteForSymbol:(NSString *)symbol withCallback:(SPFQuoteRequestCompleteBlock)callback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?s=%@&f=%@",
                                       kYahooStockQuoteAPIURL,
                                       symbol,
                                       kYahooStockQuoteAPIFormatString]];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    JCDHTTPConnection *connection = [[JCDHTTPConnection alloc] initWithRequest:request];
    [connection executeRequestOnSuccess:
     ^(NSHTTPURLResponse *response, NSString *bodyString) {
         if (response.statusCode == 200) {
             NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:bodyString];
             callback(YES, price);
         } else {
             callback(NO, nil);
         }
     } failure:^(NSHTTPURLResponse *response, NSString *bodyString, NSError *error) {
         callback(NO, nil);
     } didSendData:nil];
}

@end
