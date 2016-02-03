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
#import <AVFoundation/AVFoundation.h>

#define kNumberOfShapes 3

@interface ViewController () <DraggableShapeViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wellDoneLabel;

@property (nonatomic, strong) NSArray *holes;
@property (nonatomic, strong) NSArray *shapes;

@property (nonatomic, strong) NSMutableArray *pairs;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSURL *matchSoundURL;
@property (nonatomic, strong) NSURL *wellDoneSoundURL;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *holesArray = [NSMutableArray array];
    NSMutableArray *shapesArray = [NSMutableArray array];
    self.pairs = [NSMutableArray array];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat shapeWidth = ceil(screenWidth / 4.0);
    CGFloat shapeHeight = ceil(screenHeight / 3.0);
    CGSize shapeSize = CGSizeMake(shapeWidth, shapeHeight);
    
    for (int shapeIndex = 0; shapeIndex < kNumberOfShapes; shapeIndex++) {
        ShapeView *hole = [ShapeView shapeView];
        [self.view addSubview:hole];
        [holesArray addObject:hole];
        [self setSize:shapeSize forShape:hole];
        
        DraggableShapeView *shape = [DraggableShapeView shapeView];
        shape.delegate = self;
        [self.view addSubview:shape];
        [shapesArray addObject:shape];
        [self setSize:shapeSize forShape:shape];
    }
    
    self.holes = [NSArray arrayWithArray:holesArray];
    self.shapes = [NSArray arrayWithArray:shapesArray];
    
    CGFloat horizintalSpace = ceil((screenWidth - kNumberOfShapes * shapeSize.width) / 4.0);
    CGFloat xOffset = horizintalSpace;
    
    CGFloat verticalSpace = ceil((screenHeight - self.titleLabel.frame.size.height - 2 * shapeSize.height) / 3.0);
    CGFloat holeYOffset = CGRectGetMaxY(self.titleLabel.frame) + verticalSpace;
    CGFloat shapeYOffset = CGRectGetMaxY(self.titleLabel.frame) + 2*verticalSpace + shapeSize.height;
    
    for (int shapeIndex = 0; shapeIndex < [self.shapes count]; shapeIndex++) {
        ShapeView *hole = self.shapes[shapeIndex];
        [self moveShape:hole toOrigin:CGPointMake(xOffset, shapeYOffset)];
        
        DraggableShapeView *shape = self.holes[shapeIndex];
        [self moveShape:shape toOrigin:CGPointMake(xOffset, holeYOffset)];
        
        xOffset += horizintalSpace + shapeSize.width;
    }
    
    NSString *matchSoundPath = [[NSBundle mainBundle] pathForResource:@"match" ofType:@"mp3"];
    self.matchSoundURL = [NSURL fileURLWithPath:matchSoundPath];
    
    NSString *wellDoneSoundPath = [[NSBundle mainBundle] pathForResource:@"well_done" ofType:@"mp3"];
    self.wellDoneSoundURL = [NSURL fileURLWithPath:wellDoneSoundPath];
}

- (void)setSize:(CGSize)shapeSize forShape:(ShapeView *)shapeView {
    CGRect fr = shapeView.frame;
    fr.size = shapeSize;
    shapeView.frame = fr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self generateShapes];
}

- (void)generateShapes {
    NSArray *threeColors = [self getArrayWithRandomElementsFromArray:@[[UIColor lightGrayColor], [UIColor redColor], /*[UIColor greenColor], */[UIColor blueColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor]]];
    NSArray *threeShapes = [self getArrayWithRandomElementsFromArray:@[@(ShapeTypeFlower), @(ShapeTypeFlower), @(ShapeTypeFlower)/*, @(ShapeTypeCircle), @(ShapeTypeTriangle), @(ShapeTypeSquare), @(ShapeTypeRectangle), @(ShapeTypeDiamond), @(ShapeTypeHexagon), @(ShapeTypeStar), @(ShapeTypeHeart), @(ShapeTypeCross)*/]];
    
    NSArray *holePositions = [self getArrayWithRandomPositions];
    NSArray *shapePositions = [self getArrayWithRandomPositions];
    [self.pairs removeAllObjects];
    
    for (int pos = 0; pos < [self.shapes count]; pos++) {
        [self pairShapeType:((NSNumber *)threeShapes[pos]).intValue ofColor:threeColors[pos]
                 inPosition:[(NSNumber *)shapePositions[pos] intValue] withHoleInPosition:[(NSNumber *)holePositions[pos] intValue]];
        
        [self.pairs addObject:@{@"hole":holePositions[pos], @"shape":shapePositions[pos]}];
    }
    
    self.wellDoneLabel.hidden = YES;
}


#pragma mark - DraggableShapeViewDelegate methods

- (void)shapeViewGotMatched:(DraggableShapeView *)shapeView {
    // play match sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.matchSoundURL error:NULL];
    [self.audioPlayer play];
    
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
        [self.audioPlayer stop];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.wellDoneSoundURL error:NULL];
        [self.audioPlayer play];
        
        self.wellDoneLabel.hidden = NO;
        [self.view bringSubviewToFront:self.wellDoneLabel];
        
        [UIView animateWithDuration:1.5 animations:^{
            self.wellDoneLabel.transform = CGAffineTransformMakeScale(2.0, 2.0);
            self.wellDoneLabel.alpha = 0.1;
        } completion:^(BOOL finished) {
            self.wellDoneLabel.transform = CGAffineTransformIdentity;
            self.wellDoneLabel.alpha = 1.0;
            self.wellDoneLabel.hidden = YES;
            
            for (DraggableShapeView *shape in self.shapes) {
                [shape resetToOriginalPosition];
            }
            
            [self generateShapes];
        }];
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

- (NSArray *)getArrayWithRandomElementsFromArray:(NSArray *)array {
    NSArray *arr = [[GKRandomSource sharedRandom] arrayByShufflingObjectsInArray:array];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    for (int ind = 0; ind < kNumberOfShapes; ind++) {
        [mutArr addObject:arr[ind]];
    }
    
    return mutArr;
}

- (NSArray *)getArrayWithRandomPositions {
    NSMutableArray *arr = [NSMutableArray array];
    for (int ind = 0; ind < kNumberOfShapes; ind++) {
        [arr addObject:@(ind)];
    }
    
    return [self getArrayWithRandomElementsFromArray:arr];
}

@end
