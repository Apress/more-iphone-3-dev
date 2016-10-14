#import "Hero.h"


@implementation Hero 

@dynamic age;
@dynamic secretIdentity;
@dynamic sex;
@dynamic name;
@dynamic birthdate;
@dynamic favoriteColor;

- (void) awakeFromInsert
{
	self.favoriteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}
- (NSNumber *)age {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *components = [gregorian components:NSYearCalendarUnit
												fromDate:self.birthdate
												  toDate:[NSDate date]
												 options:0];
	NSInteger years = [components year];
    
    [gregorian release];
    
    return [NSNumber numberWithInteger:years];
}
-(BOOL)validateBirthdate:(id *)ioValue error:(NSError **)outError{
    
    NSDate *date = *ioValue;
    
    // If entered date is in the future, don't allow
    if ([date compare:[NSDate date]] ==  NSOrderedDescending) {
        if (outError != NULL) {
            NSString *errorStr = NSLocalizedString(@"Birthdate cannot be in the future", @"Birthdate cannot be in the future");
            NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorStr
                                                                     forKey:NSLocalizedDescriptionKey];
            NSError *error = [[[NSError alloc] initWithDomain:kHeroValidationDomain
                                                         code:kHeroValidationBirthdateCode
                                                     userInfo:userInfoDict] autorelease];
            *outError = error;
        }
        return NO;
    }
    
    
    return YES;
}
- (BOOL)validateNameOrSecretIdentity:(NSError **)outError {
    if ( (self.name == nil || [self.name length] == 0) && (self.secretIdentity == nil || [self.secretIdentity length] == 0)) {
        if (outError != NULL) {
            NSString *errorStr = NSLocalizedString(@"Must provide name or secret identity.", @"Must provide name or secret identity.");
            NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorStr
                                                                     forKey:NSLocalizedDescriptionKey];
            NSError *error = [[[NSError alloc] initWithDomain:kHeroValidationDomain
                                                         code:kHeroValidationNameOrSecretIdentityCode
                                                     userInfo:userInfoDict] autorelease];
            *outError = error;
        }
    }
    return YES;
}
// The original version of these two books did not have
// the call to super. Without that call, other validations
// did not happen.
- (BOOL)validateForInsert:(NSError **)outError {
    BOOL validated = [self validateNameOrSecretIdentity:outError];
    if (!validated)
        return validated;
    return [super validateForInsert:outError];
}
- (BOOL)validateForUpdate:(NSError **)outError {
    BOOL validated = [self validateNameOrSecretIdentity:outError];
    if (!validated)
        return validated;
    return [super validateForUpdate:outError];
}
@end
