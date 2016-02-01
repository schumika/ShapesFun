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

@interface ViewController () <DraggableShapeViewDelegate>

@property (weak, nonatomic) IBOutlet ShapeView *leftHole;
@property (weak, nonatomic) IBOutlet ShapeView *centerHole;
@property (weak, nonatomic) IBOutlet ShapeView *rightHole;
@property (weak, nonatomic) IBOutlet DraggableShapeView *leftShape;
@property (weak, nonatomic) IBOutlet DraggableShapeView *centerShape;
@property (weak, nonatomic) IBOutlet DraggableShapeView *rightShape;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.leftShape.delegate = self;
    self.centerShape.delegate = self;
    self.rightShape.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat holeWidth = self.leftShape.bounds.size.width;
    CGFloat space = ceil((screenWidth - 3*holeWidth) / 4.0);
    
    [self moveHole:self.leftHole andShape:self.leftShape toXOffset:space];
    [self moveHole:self.centerHole andShape:self.centerShape toXOffset:2*space + holeWidth];
    [self moveHole:self.rightHole andShape:self.rightShape toXOffset:3*space + 2*holeWidth];
    
    [self generateShapes];
}

- (void)generateShapes {
    NSArray *threeColors = [self getArrayWithThreeRandomElementsFromArray:@[[UIColor lightGrayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor]]];
    NSArray *threeShapes = [self getArrayWithThreeRandomElementsFromArray:@[@(ShapeTypeCircle), @(ShapeTypeSquare), @(ShapeTypeRectangle), @(ShapeTypeDiamond), @(ShapeTypeStar), @(ShapeTypeHeart)]];
    
    NSArray *holePositions = [self getArrayWithThreeRandomElementsFromArray:@[@(0), @(1), @(2)]];
    NSArray *shapePositions = [self getArrayWithThreeRandomElementsFromArray:@[@(0), @(1), @(2)]];
    
    for (int pos = 0; pos < 3; pos++) {
        [self pairShapeType:((NSNumber *)threeShapes[pos]).intValue ofColor:threeColors[pos]
                 inPosition:[(NSNumber *)shapePositions[pos] intValue] withHoleInPosition:[(NSNumber *)holePositions[pos] intValue]];
    }
}


#pragma mark - DraggableShapeViewDelegate methods

- (void)shapeViewGotMatched:(DraggableShapeView *)shapeView {
    if (self.leftShape.isMatched && self.rightShape.isMatched && self.centerShape.isMatched) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"Well done!" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
            [self.leftShape resetToOriginalPosition];
            [self.rightShape resetToOriginalPosition];
            [self.centerShape resetToOriginalPosition];
            
            [self generateShapes];
            
        }]];
        [self presentViewController:ac animated:YES completion:NULL];
    }
}

#pragma mark - Helper methods

- (void)pairShapeType:(ShapeType)shapeType ofColor:(UIColor *)color inPosition:(int)shapePosition withHoleInPosition:(int)holePosition {
    ShapeView *holeView = nil;
    switch (holePosition) {
        case 0:
            holeView = self.leftHole;
            break;
        case 1:
            holeView = self.centerHole;
            break;
        case 2:
            holeView = self.rightHole;
            break;
    }
    
    DraggableShapeView *shapeView = nil;
    switch (shapePosition) {
        case 0:
            shapeView = self.leftShape;
            break;
        case 1:
            shapeView = self.centerShape;
            break;
        case 2:
            shapeView = self.rightShape;
    }
    
    [shapeView configureWithShapeType:shapeType andColor:color isHole:NO];
    [holeView configureWithShapeType:shapeType andColor:color isHole:YES];
    
    shapeView.holeCenter = holeView.center;
}

- (void)moveHole:(ShapeView *)holeView andShape:(DraggableShapeView *)shapeView toXOffset:(CGFloat)xOffset {
    CGRect holeFrame = holeView.frame;
    holeFrame.origin.x = xOffset;
    holeView.frame = holeFrame;
    
    CGRect shapeFrame = shapeView.frame;
    shapeFrame.origin.x = xOffset;
    shapeView.frame = shapeFrame;
}

#pragma mark - Shuffle methods

- (NSArray *)getArrayWithThreeRandomElementsFromArray:(NSArray *)array {
    NSArray *arr = [[GKRandomSource sharedRandom] arrayByShufflingObjectsInArray:array];
    
    return @[arr[0], arr[1], arr[2]];
}

@end
