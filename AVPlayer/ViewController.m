//
//  ViewController.m
//  AVPlayer
//
//  Created by wangergang on 2016/10/22.
//  Copyright © 2016年 MYCompangName. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import <AVFoundation/AVAsset.h>
//#import <AVFoundation/AVAssetImageGenerator.h>
//#import <AVFoundation/AVTime.h>
//#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
//#import <AVFoundation/AVPlayer.h>

#define screenW [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, screenW, 400)];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(screenW/2-30, 270, 60, 60)];
    UIImage *img = [UIImage imageNamed:@"chat_icon_message_video_play_btn"];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self show];
}
//播放
- (void) play {
    NSURL *videoURL = [NSURL URLWithString:@"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"];
    AVPlayer *player =  [AVPlayer playerWithURL:videoURL];
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.player = player;
   [self presentViewController:playerViewController animated:YES completion:^{
       [playerViewController.player play];
   }];
    
}
//截取视频画面
- (void) show {
    NSURL *videoURL = [NSURL URLWithString:@"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset] ;
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 0.1;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef) {
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
        
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    self.imageView.image = thumbnailImage;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
