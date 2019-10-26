//
//   Copyright (c) 2009 Bálint Jánvári
//       www.programmaticmagic.com
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

//
//  OMMutableImage.h
//  ObjectiveMagic
//

/*
 OMMutableImage provides a quick way to create CGBitmapContexts
 You can access the underlying memory to perform fast operations,
 or you can use the context like any other CGContext.
 */

#import <Foundation/Foundation.h>

@interface OMMutableImage : NSObject<NSCoding, NSCopying> {
	CGRect bounds;
	CGContextRef context;
	void* memory;
}
@property(readonly, nonatomic) CGRect bounds;
@property(readonly, nonatomic) CGContextRef context;
@property(readonly, nonatomic) void* memory;
- (id)initWithWidth:(NSInteger)width height:(NSInteger)height;
/*
 Memory management note:
 When a CGImage is created using a CGBitmapContext, 
 the underlying memory is NOT copied until you make
 changes to the context. So if you create an image,
 and wish to avoid the overhead, don't modify the context
 until the image is released.
 This also means that an image, once created, will not be
 modified when you change the original graphics context. If
 the OMMutableImage object is deallocated, the images created
 will still work.
 For more information, see
 http://developer.apple.com/DOCUMENTATION/GraphicsImaging/Reference/CGBitmapContext/
 */
- (UIImage*)image;
@end
