#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CoreStore.h"
#import "CoreStoreBridge.h"

FOUNDATION_EXPORT double CoreStoreVersionNumber;
FOUNDATION_EXPORT const unsigned char CoreStoreVersionString[];

