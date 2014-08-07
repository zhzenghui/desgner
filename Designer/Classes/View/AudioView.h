//
//  AudioView.h
//  Designer
//
//  Created by bejoy on 14/7/22.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZAudio.h"



@interface AudioView : UIView <EZMicrophoneDelegate>


@property (nonatomic, strong) EZAudioPlot *audioPlot;
@property (nonatomic,strong) EZMicrophone *microphone;


- (void)setmicrophone:(id)delegate;

-(void)drawBufferPlot;

@end
