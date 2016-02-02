//
//  ViewController.m
//  ShapeGame
//
//  Created by Anca Julean on 21/01/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"
#import "DraggableShapeView.h"
#import <GameplayKit/GameplayKit.h>

#define kNumberOfShapes 3

@interface ViewController () <DraggableShapeViewDelegate>

@property (nonatomic, strong) NSArray *holes;
@property (nonatomic, strong) NSArray *shapes;

@property (nonatomic, strong) NSMutableArray *pairs;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *holesArray = [NSMutableArray array];
    NSMutableArray *shapesArray = [NSMutableArray array];
    self.pairs = [NSMutableArray array];
    
    for (int shapeIndex = 0; shapeIndex < kNumberOfShapes; shapeIndex++) {
        ShapeView *hole = [ShapeView shapeView];
        [self.view addSubview:hole];
        [holesArray addObject:hole];
        
        DraggableShapeView *shape = [DraggableShapeView shapeView];
        shape.delegate = self;
        [self.view addSubview:shape];
        [shapesArray addObject:shape];
    }
    
    self.holes = [NSArray arrayWithArray:holesArray];
    self.shapes = [NSArray arrayWithArray:shapesArray];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat holeWidth = ((UIView *)self.shapes[0]).bounds.size.width;
    CGFloat space = ceil((screenWidth - [self.shapes count]*holeWidth) / 4.0);
    
    CGFloat xOffset = space;
    
    for (int shapeIndex = 0; shapeIndex < [self.shapes count]; shapeIndex++) {
        ShapeView *hole = self.shapes[shapeIndex];
        [self moveShape:hole toOrigin:CGPointMake(xOffset, 190.0)];
        
        DraggableShapeView *shape = self.holes[shapeIndex];
        [self moveShape:shape toOrigin:CGPointMake(xOffset, 70.0)];
        
        xOffset += space + holeWidth;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self generateShapes];
}

- (void)generateShapes {
    NSArray *threeColors = [self getArrayWithThreeRandomElementsFromArray:@[[UIColor lightGrayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor]]];
    NSArray *threeShapes = [self getArrayWithThreeRandomElementsFromArray:@[@(ShapeTypeCircle), @(ShapeTypeSquare), @(ShapeTypeRectangle), @(ShapeTypeDiamond), @(ShapeTypeStar), @(ShapeTypeHeart)]];
    
    NSArray *holePositions = [self getArrayWithThreeRandomElementsFromArray:@[@(0), @(1), @(2)]];
    NSArray *shapePositions = [self getArrayWithThreeRandomElementsFromArray:@[@(0), @(1), @(2)]];
    [self.pairs removeAllObjects];
    
    for (int pos = 0; pos < [self.shapes count]; pos++) {
        [self pairShapeType:((NSNumber *)threeShapes[pos]).intValue ofColor:threeColors[pos]
                 inPosition:[(NSNumber *)shapePositions[pos] intValue] withHoleInPosition:[(NSNumber *)holePositions[pos] intValue]];
        
        [self.pairs addObject:@{@"hole":holePositions[pos], @"shape":shapePositions[pos]}];
    }
}


#pragma mark - DraggableShapeViewDelegate methods

- (void)shapeViewGotMatched:(DraggableShapeView *)shapeView {
    __block ShapeView *holeView = nil;
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        shapeView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
        for (NSDictionary *pair in self.pairs) {
            NSNumber *shapePos = pair[@"shape"];
            if (self.shapes[shapePos.intValue] == shapeView) {
                holeView = self.holes[((NSNumber *)pair[@"hole"]).intValue];
                break;
            }
        }
        
        holeView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        shapeView.transform = CGAffineTransformIdentity;
        holeView.transform = CGAffineTransformIdentity;
    }];
    
    BOOL completed = YES;
    for (DraggableShapeView *shape in self.shapes) {
        if (!shape.isMatched) {
            completed = NO;
            break;
        }
    }
    
    if (completed) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"Well done!" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"Thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            for (DraggableShapeView *shape in self.shapes) {
                [shape resetToOriginalPosition];
            }
            
            [self generateShapes];
            
        }]];
        [self presentViewController:ac animated:YES completion:NULL];
    }
}

#pragma mark - Helper methods

- (void)pairShapeType:(ShapeType)shapeType ofColor:(UIColor *)color inPosition:(int)shapePosition withHoleInPosition:(int)holePosition {
    ShapeView *holeView = self.holes[holePosition];
    DraggableShapeView *shapeView = self.shapes[shapePosition];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [shapeView configureWithShapeType:shapeType andColor:color isHole:NO];
        [holeView configureWithShapeType:shapeType andColor:color isHole:YES];
        
        shapeView.transform = CGAffineTransformMakeRotation((CGFloat)(M_PI));
        holeView.transform = CGAffineTransformMakeRotation((CGFloat)(M_PI));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            shapeView.transform = CGAffineTransformMakeRotation((CGFloat)(M_PI));
            holeView.transform = CGAffineTransformMakeRotation((CGFloat)(M_PI));
        } completion:^(BOOL finished) {
            shapeView.transform = CGAffineTransformIdentity;
            holeView.transform = CGAffineTransformIdentity;
        }];
    }];
    
    shapeView.holeCenter = holeView.center;
}
     

- (void)moveShape:(ShapeView *)shapeView toOrigin:(CGPoint)newOrigin {
    CGRect holeFrame = shapeView.frame;
    holeFrame.origin = newOrigin;
    shapeView.frame = holeFrame;
}

#pragma mark - Shuffle methods

- (NSArray *)getArrayWithThreeRandomElementsFromArray:(NSArray *)array {
    NSArray *arr = [[GKRandomSource sharedRandom] arrayByShufflingObjectsInArray:array];
    
    return @[arr[0], arr[1], arr[2]];
}

@end
