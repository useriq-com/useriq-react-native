
#import "UseriqReactNative.h"
#import "RCTLog.h"
#import <UserIQ/UserIQ.h>

@implementation UseriqReactNative

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(UseriqReactNative);

RCT_EXPORT_METHOD(init:(NSString *)apiKey){
    self.apiKey = apiKey;
    RCTLogInfo(@"\n*****SDK initialized with apiKey: %@*****",apiKey);
    //    resolve(@"successful UserIQ SDK initialization");
}

RCT_EXPORT_METHOD(setUser:(NSDictionary *)user){
    RCTLogInfo(@"%@",user);
    NSString *apiKeyMissing = @"apiKey Missing";
    NSAssert((![self.apiKey isEqualToString:@""]&&self.apiKey), apiKeyMissing);
    NSString *userId, *name, *email, *accountName, *signupDate;
    int accId;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    for (NSString *key in [user allKeys]) {
        if ([key isEqualToString:@"id"]) {
//            userId = [user valueForKey:@"id"];
            if ([[user valueForKey:@"id"] isKindOfClass:[NSString class]]) {
                userId = [user valueForKey:@"id"];
            } else if ([[user valueForKey:@"id"] isKindOfClass:[NSNumber class]]) {
                NSNumber *intUserId = [user valueForKey:@"id"];
                userId = [intUserId stringValue];
            } else {
                userId = @"";
            }
        } else if([key isEqualToString:@"name"]) {
            name = ([[user valueForKey:@"name"] isEqual:[NSNull null]]?@"":[user valueForKey:@"name"]);
        } else if([key isEqualToString:@"email"]) {
            email = ([[user valueForKey:@"email"] isEqual:[NSNull null]]?@"":[user valueForKey:@"email"]);;
        } else if([key isEqualToString:@"accountId"]) {
            accId = ([[user valueForKey:@"accountId"] isEqual:[NSNull null]]?0:[[user valueForKey:@"accountId"] intValue]);
        } else if([key isEqualToString:@"accountName"]) {
            accountName = ([[user valueForKey:@"accountName"] isEqual:[NSNull null]]?@"":[user valueForKey:@"accountName"]);
        } else if([key isEqualToString:@"signUpDate"]) {
            signupDate = ([[user valueForKey:@"signUpDate"] isEqual:[NSNull null]]?@"":[user valueForKey:@"signUpDate"]);
        } else {
            [parameters setObject:[user valueForKey:key] forKey:key];
        }
    }
    [[UserIQSDK sharedInstance] initWithAPIKey:self.apiKey
                                        userId:userId
                                          name:name
                                         email:email
                                     accountId:accId
                                   accountName:accountName
                                    signupDate:signupDate
                                 andParameters:parameters];
    //    resolve(@"successful UserIQ SDK setUser Successful");
}

RCT_EXPORT_METHOD(disableFAB) {
    [[UserIQSDK sharedInstance] disableFAB];
}

RCT_REMAP_METHOD(showHelpCentre,
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject){
    [[UserIQSDK sharedInstance] showHelpCentre];
    resolve(@"true");
}

RCT_EXPORT_METHOD(setHost:(NSString *)host) {
    [[UserIQSDK sharedInstance] setHost:host];
}

RCT_REMAP_METHOD(showCtxHelp,
                 resolver:(RCTPromiseResolveBlock)resolver
                 rejecter:(RCTPromiseRejectBlock)rejecter) {
    BOOL shown = [[UserIQSDK sharedInstance] showCtxHelp];
    resolver((shown?@"true":@"false"));
}

@end

