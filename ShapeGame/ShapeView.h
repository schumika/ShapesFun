//
//  ShapeView.h
//  ShapeGame
//
//  Created by Anca Julean on 21/01/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShapeTypeCircle = 0,
    ShapeTypeSquare,
    ShapeTypeTriangle,
    ShapeTypeRectangle,
    ShapeTypeDiamond,
    ShapeTypeHexagon,
    ShapeTypeTrapese,
    ShapeTypeStar,
    ShapeTypeFlower,
    ShapeTypeHeart,
    ShapeTypeCross,
} ShapeType;



@interface ShapeView : UIView

@property (nonatomic, assign) ShapeType shapeType;
@property (nonatomic, strong) UIColor *shapeColor;
@property (nonatomic, assign) BOOL isHole;

- (instancetype)initWithDefaultFrame;
+ (instancetype)shapeView;

- (void)configureWithShapeType:(ShapeType)shapeType andColor:(UIColor *)color isHole:(BOOL)isHole;

@end

