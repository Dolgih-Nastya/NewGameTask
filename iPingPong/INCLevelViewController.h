//
//  incLevelViewController.h
//  iPingPong
//
//  Created by Анастасия Долгих on 6/18/14.
//  Copyright (c) 2014 Анастасия Долгих. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Level) {
    Easy = 1,
    Medium = 2,
    Strong = 3
};


@interface INCLevelViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@end
