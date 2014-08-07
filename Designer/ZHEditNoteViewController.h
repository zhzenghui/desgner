//
//  ZHEditNoteViewController.h
//  Designer
//
//  Created by bejoy on 14/7/2.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NoteBaseViewController.h"
#import "PhotoCell.h"
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechRecognizer.h>
#import "PopupView.h"
#import <iflyMSC/IFlyDataUploader.h>
#import "RecognizerFactory.h"
#import "POVoiceHUD.h"

@class EAGLView;

@class Note;
@class Customer;
@interface ZHEditNoteViewController : NoteBaseViewController<UICollectionViewDataSource,POVoiceHUDDelegate,  IFlySpeechSynthesizerDelegate, UICollectionViewDelegate, UITextFieldDelegate,UICollectionViewDelegateFlowLayout, UIAlertViewDelegate>
{
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *telephoneTF;
    UIPlaceHolderTextView *addressTV;
    
    UICollectionView *_collectionView;

    
    UILabel *customerLable;
    
    UIButton *mscButton;
    UIButton *trashButton;
    UIView *vicesView;
    
    PhotoCellType photoCellType;
    
    UIImageView *contentImageView;
    
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    
    
    IBOutlet EAGLView       *view;

}


@property (nonatomic, retain) POVoiceHUD *voiceHud;

@property (nonatomic, strong) IFlySpeechRecognizer * iFlySpeechRecognizer;
@property (nonatomic, strong) PopupView            * popUpView;
@property (nonatomic, strong) IFlyDataUploader     * uploader;
@property (nonatomic, strong) NSString             * result;
@property (nonatomic)        BOOL       isCanceled;
@property(nonatomic, retain) IBOutlet UIImageView *pageAnimotionImageView;




@property (nonatomic, retain) NSNumber *customer_id;

@property (nonatomic, retain) Note      *note;
@property (nonatomic, retain) Customer  *customer;



@end
