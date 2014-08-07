//
//  ZHEditCustomerViewController.h
//  Designer
//
//  Created by bejoy on 7/2/14.
//  Copyright (c) 2014 zeng hui. All rights reserved.
//

#import "NoteBaseViewController.h"
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechRecognizer.h>
#import "PopupView.h"
#import <iflyMSC/IFlyDataUploader.h>
#import "RecognizerFactory.h"

#import "POVoiceHUD.h"



@class Customer;
@interface ZHEditCustomerViewController : NoteBaseViewController <POVoiceHUDDelegate, UITextViewDelegate>
{
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *telephoneTF;
    UIPlaceHolderTextView *addressTV;
    UIPlaceHolderTextView *descTV;

    
    UIImageView *contentImageView;
    
    UILabel *customerLable;
    UIView *vicesView;

}


@property (nonatomic, retain) POVoiceHUD *voiceHud;

@property (nonatomic, retain) NSNumber *customer_id;

@property (nonatomic, retain) Customer *customer;

@property(nonatomic, retain) IBOutlet UIImageView *pageAnimotionImageView;


@property (nonatomic, strong) IFlySpeechRecognizer * iFlySpeechRecognizer;
@property (nonatomic, strong) PopupView            * popUpView;
@property (nonatomic, strong) IFlyDataUploader     * uploader;
@property (nonatomic, strong) NSString             * result;
@property (nonatomic)        BOOL       isCanceled;

@end
