#import "HeroValueDisplay.h"

@implementation NSString (HeroValueDisplay)
- (NSString *)heroValueDisplay {
	return self;
}
@end

@implementation NSDate (HeroValueDisplay)
- (NSString *)heroValueDisplay {
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	NSString *ret = [formatter stringFromDate:self];
	[formatter release];
	return ret;
}
@end

@implementation NSNumber (HeroValueDisplay) 
- (NSString *)heroValueDisplay {
    return [self descriptionWithLocale:[NSLocale currentLocale]];
}
@end

@implementation NSDecimalNumber (HeroValueDisplay) 
- (NSString *)heroValueDisplay {
    return [self descriptionWithLocale:[NSLocale currentLocale]];
}
@end
