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
    
    NSArray *threeColors = [self getThreeRandomColors];
    NSArray *threeShapes = [self getThreeRandomShapes];
    
    [self pairDraggableShape:self.leftShape withHole:self.leftHole ofShapeType:((NSNumber *)threeShapes[0]).intValue andColor:threeColors[0]];
    [self pairDraggableShape:self.centerShape withHole:self.rightHole ofShapeType:((NSNumber *)threeShapes[1]).intValue andColor:threeColors[1]];
    [self pairDraggableShape:self.rightShape withHole:self.centerHole ofShapeType:((NSNumber *)threeShapes[2]).intValue andColor:threeColors[2]];
}

- (void)pairDraggableShape:(DraggableShapeView *)draggableShapeView withHole:(ShapeView *)holeView ofShapeType:(ShapeType)shapeType andColor:(UIColor *)color {
    [draggableShapeView configureWithShapeType:shapeType andColor:color isHole:NO];
    [holeView configureWithShapeType:shapeType andColor:color isHole:YES];
    
    draggableShapeView.holeCenter = holeView.center;
}

#pragma mark - DraggableShapeViewDelegate methods

- (void)shapeViewGotMatched:(DraggableShapeView *)shapeView {
    if (self.leftShape.isMatched && self.rightShape.isMatched && self.centerShape.isMatched) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"Well done!" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.leftShape resetToOriginalPosition];
            [self.rightShape resetToOriginalPosition];
            [self.centerShape resetToOriginalPosition];
            
            NSArray *threeColors = [self getThreeRandomColors];
            NSArray *threeShapes = [self getThreeRandomShapes];
            
            [self pairDraggableShape:self.leftShape withHole:self.leftHole ofShapeType:((NSNumber *)threeShapes[0]).intValue andColor:threeColors[0]];
            [self pairDraggableShape:self.centerShape withHole:self.rightHole ofShapeType:((NSNumber *)threeShapes[1]).intValue andColor:threeColors[1]];
            [self pairDraggableShape:self.rightShape withHole:self.centerHole ofShapeType:((NSNumber *)threeShapes[2]).intValue andColor:threeColors[2]];
            
        }]];
        [self presentViewController:ac animated:YES completion:NULL];
    }
}

#pragma mark - Helper methods

- (NSArray *)getThreeRandomColors {
    
    NSArray *arr = [[GKRandomSource sharedRandom] arrayByShufflingObjectsInArray:@[[UIColor lightGrayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor]]];
    
    return @[arr[0], arr[1], arr[2]];
}

- (NSArray *)getThreeRandomShapes {
    NSArray *arr = [[GKRandomSource sharedRandom] arrayByShufflingObjectsInArray:@[@(ShapeTypeCircle), @(ShapeTypeSquare), @(ShapeTypeRectangle), @(ShapeTypeDiamond), @(ShapeTypeStar), @(ShapeTypeHeart)]];
    
    return @[arr[0], arr[1], arr[2]];
}

@end
