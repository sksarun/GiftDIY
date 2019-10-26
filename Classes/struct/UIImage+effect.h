//
//  UIImage+effect.h
//  GiftDIY
//
//  Created by Tong on 1/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (effect) 

- (UIImage*)imageWithShadow;
-(UIImage*) NegativeImage;
-(UIImage*)makeSepiaScale;
-(UIImage*) BurnImage;
-(UIImage*) imageOverlay;

-(UIImage*) ApplyBendWithMode:(int)mode withColor:(UIColor*) color;
- (UIImage*)sepiaImage;
- (UIImage*)greyscaleImage;
@end
