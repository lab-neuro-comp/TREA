//
//  AVFViewController+CWPopup.h
//  TREA
//
//  Created by andre vinicius alves fonseca on 08/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CWPopup)

@property (nonatomic, readwrite) UIViewController *popupViewController;
@property (nonatomic, readwrite) BOOL useBlurForPopup;
@property (nonatomic, readwrite) CGPoint popupViewOffset;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
- (void)setUseBlurForPopup:(BOOL)useBlurForPopup;
- (BOOL)useBlurForPopup;

@end
