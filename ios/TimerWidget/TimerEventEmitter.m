//
//  TimerEventEmitter.m
//  FancyTimer
//
//  Created by Buddha Lama on 04/07/2024.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE (TimerEventEmitter,RCTEventEmitter)
+ (bool)requiresMainQueueSetup{
  return NO;
}
RCT_EXTERN_METHOD(supportedEvents)

@end
