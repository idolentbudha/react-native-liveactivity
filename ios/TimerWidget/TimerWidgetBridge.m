//
//  TimerWidgetBridge.m
//  FancyTimer
//
//  Created by Buddha Lama on 25/06/2024.
//

//#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(TimerWidgetModule, NSObject)

+ (bool)requiresMainQueueSetup {
  return NO;
}

RCT_EXTERN_METHOD(startLiveActivity:(nonnull double *)timestamp)
RCT_EXTERN_METHOD(pause:(nonnull double *)timestamp)
RCT_EXTERN_METHOD(resume)
RCT_EXTERN_METHOD(stopLiveActivity)

@end

