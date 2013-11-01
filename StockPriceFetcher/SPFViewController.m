//
//  SPFViewController.m
//  StockPriceFetcher
//
//  Chuck Konkol 11/2013

#import "SPFViewController.h"
#import "SPFPriceFetcher.h"


@interface SPFViewController ()
@property (strong, nonatomic) SPFPriceFetcher *quoter;
@end


@implementation SPFViewController
@synthesize priceLabel,stockSymbolTextField;
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.stockSymbolTextField becomeFirstResponder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}
-(void)dismissKeyboard {
    [stockSymbolTextField resignFirstResponder];
}
- (IBAction)getPrice:(id)sender {
    SPFQuoteRequestCompleteBlock callback = ^(BOOL wasSuccessful, NSDecimalNumber *price) {
        if (wasSuccessful) {
            self.priceLabel.text = [NSString stringWithFormat:@"Latest price: $%@", [price stringValue]];
        } else {
            self.priceLabel.text = @"Unable to fetch price. Try again.";
        }
    };

    [self.quoter requestQuoteForSymbol:self.stockSymbolTextField.text
                          withCallback:callback];
}

- (SPFPriceFetcher *)quoter
{
    if (!_quoter) {
        self.quoter = [[SPFPriceFetcher alloc] init];
    }

    return _quoter;
}
-(IBAction) doneEditing:(id) sender {
    [sender resignFirstResponder];
}
@end
