//
//  SPFViewController.h
//  StockPriceFetcher
//
//  Chuck Konkol 11/2013

#import <UIKit/UIKit.h>


@interface SPFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *stockSymbolTextField;
-(IBAction) doneEditing:(id) sender;
- (IBAction)getPrice:(id)sender;

@end
