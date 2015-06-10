// UIImage+Alpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image
#import <UIKit/UIKit.h>

@interface UIImage (Alpha)

/* 是否存在 alpha layer */
- (BOOL)hasAlpha;

/* Returns a copy of the given image, adding an alpha channel if it doesn't already have one */
- (UIImage *)imageWithAlpha;

/* Returns a copy of the image with a transparent border of the given size added around its edges.
   If the image has no alpha layer, one will be added to it.
  */
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

@end
