//
//  ZHEditCustomerViewController.m
//  Designer
//
//  Created by bejoy on 7/2/14.
//  Copyright (c) 2014 zeng hui. All rights reserved.
//

#import "ZHEditCustomerViewController.h"
#import "Customer.h"
#import <iflyMSC/IFlySpeechUtility.h>
#import "UIView+Utilities.h"

@interface ZHEditCustomerViewController ()

{
    
    UIImageView *penImageView;
    
}
@end



#define KRECTpenImageView RectMake2x(1716, 228, 308, 1094 )
#define KRECThiddenpenImageView RectMake2x(2048, 228, 308, 1094 )

@implementation ZHEditCustomerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)closeAnimation
{
    
    
    
    
#ifdef AppStore
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlDown animations:^{
        
        penImageView.frame = KRECThiddenpenImageView;
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        
        if (finished) {
            
            //            noteOpenAnimation
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noteOpenAnimation" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noteRefreshNotes" object:nil];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
    
#else
//    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlRight];
//    
//    [UIView animateWithDuration:KLongDuration animations:^{
//        
//        self.view.alpha  = 0 ;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            
//            [self.view removeFromSuperview];
//            [self removeFromParentViewController];
//            
//        }
//    }];
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlRight];

    [UIView animateWithDuration:KLongDuration animations:^{
        
        penImageView.frame = KRECThiddenpenImageView;
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        
        if (finished) {
            
            //            noteOpenAnimation
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noteOpenAnimation" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noteRefreshNotes" object:nil];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
#endif
    

}

- (void)loadAnimation
{
    [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:.8  initialSpringVelocity:.4 options:UIViewAnimationOptionCurveLinear animations:^{
        
        penImageView.frame = KRECTpenImageView;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)back:(UIButton *)button
{

    [self closeAnimation];
}

- (void)openMSC:(UIButton *)button
{
    
    [descTV resignFirstResponder];
    self.isCanceled = NO;
    
    bool ret = [_iFlySpeechRecognizer startListening];
    if (ret) {
        
        //        [_cancelBtn setEnabled:YES];
        //        [_stopBtn setEnabled:YES];
    }
    else
    {
        
        [_popUpView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
        [self.view addSubview:_popUpView];
    }

}
- (void)stopMSC:(UIButton *)button
{
    [_iFlySpeechRecognizer stopListening];
    
}
- (void)openCam:(UIButton *)button
{
    
}

- (void)saveCustomer:(UIButton *)button
{
    
    if (nameTF.text.length == 0) {
        [[Message share] messageAlert:@"客户名称不能为空"];
        return;
    }

  
    
    if ( ! self.customer) {
        Customer *c = [Customer createEntity];
        
        c.customer_id = [NSString md5Date];
        c.name =  nameTF.text;
        c.telephone = telephoneTF.text;
        c.mobile =   phoneTF.text ;
        c.adress = addressTV.text;
        c.descript = descTV.text;

        c.dgn_id = [NSString stringWithFormat:@"%d", SharedAppUser.ID];
        c.sync = @(0);
        
        c.create_time = [NSDate date];
        c.update_time = [NSDate date];
        c.status = [NSNumber numberWithInteger:1];
        
    }
    else {
        self.customer.name =  nameTF.text;
        self.customer.telephone = telephoneTF.text; //[NSNumber numberWithInt:[telephoneTF.text intValue]];
        self.customer.mobile =    phoneTF.text; //[NSNumber numberWithInt:[phoneTF.text intValue]];
        self.customer.adress = addressTV.text;
        self.customer.descript = descTV.text;

        
        
        self.customer.update_time = [NSDate date];

        
    }
    
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
    
    
    [self closeAnimation];
}

#pragma mark ifly

- (void)speech
{
    //    // 创建合成对象,为单例模式
    //    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    //    _iFlySpeechSynthesizer.delegate = self;
    //    //设置语音合成的参数
    //    //语速,取值范围 0~100
    //    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]]; //音量;取值范围 0~100
    //    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表 [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]];
    //    //音频采样率,目前支持的采样率有 16000 和 8000
    //    [_iFlySpeechSynthesizer setParameter:@"8000" forKey: [IFlySpeechConstant SAMPLE_RATE]]; //asr_audio_path保存录音文件路径,如不再需要,设置value为nil表示取消,默认目录是 documents
    //    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //    //启动合成会话
    //    [_iFlySpeechSynthesizer startSpeaking: @"你好,我是科大讯飞的小燕"];
    
}
- (void)setiFly {
    
    //创建语音配置
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@", KiflyAPPID, TIMEOUT_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    _iFlySpeechRecognizer = [RecognizerFactory CreateRecognizer:self Domain:@"iat"];
    
    
    
}


- (void) onCompleted:(IFlySpeechError *) error{
    
    
    
    
}

/**
 * @fn      onVolumeChanged
 * @brief   音量变化回调
 *
 * @param   volume      -[in] 录音的音量，音量范围1~100
 * @see
 */
- (void) onVolumeChanged: (int)volume
{
    if (self.isCanceled) {
        [_popUpView removeFromSuperview];
        return;
    }
    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    [_popUpView setText: vol];
    [self.view addSubview:_popUpView];
}

/**
 * @fn      onBeginOfSpeech
 * @brief   开始识别回调
 *
 * @see
 */
- (void) onBeginOfSpeech
{
    [_popUpView setText: @"正在录音"];
    [self.view addSubview:_popUpView];
    
    [self.voiceHud startForFilePath:[NSString stringWithFormat:@"%@/Documents/MySound.caf", NSHomeDirectory()]];

    [UIView animateWithDuration:KMiddleDuration animations:^{
        vicesView.alpha = 1;
    }];
    
}

/**
 * @fn      onEndOfSpeech
 * @brief   停止录音回调
 *
 * @see
 */
- (void) onEndOfSpeech
{
    [_popUpView setText: @"停止录音"];
    [self.view addSubview:_popUpView];
    
    
    [self.voiceHud cancelRecording];

    [UIView animateWithDuration:KMiddleDuration animations:^{
        vicesView.alpha = 0;
    }];
}


/**
 * @fn      onError
 * @brief   识别结束回调
 *
 * @param   errorCode   -[out] 错误类，具体用法见IFlySpeechError
 */
- (void) onError:(IFlySpeechError *) error
{
    NSString *text ;
    if (self.isCanceled) {
        text = @"识别取消";
    }
    else if (error.errorCode ==0 ) {
        if (_result.length==0) {
            text = @"无识别结果";
        }
        else
        {
            text = @"识别成功";
        }
    }
    else
    {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
    
    
    [_popUpView setText: text];
    [self.view addSubview:_popUpView];
    
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        vicesView.alpha = 0;
    }];
    
    
}

/**
 * @fn      onResults
 * @brief   识别结果回调
 *
 * @param   result      -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度
 * @see
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        NSArray *array = [key objectFromJSONString][@"ws"];
        
        for (NSDictionary *dict in array) {
            NSString *res = dict[@"cw"][0][@"w"];
            NSLog(@"%@", res );
            [resultString appendFormat:@"%@",res];
            
        }
        
    }
    NSLog(@"听写结果：%@", [resultString objectFromJSONString]);
    
    self.result =  resultString ;
    descTV .text = [NSString stringWithFormat:@"%@%@", descTV.text,resultString];
    [descTV scrollRangeToVisible:NSMakeRange([descTV.text length], 0)];
    if (isLast) {
        NSLog(@"this is the last result");
    }
    else
    {
        NSLog(@"this is not last ");
    }
}

/**
 * @fn      onCancel
 * @brief   取消识别回调
 * 当调用了`cancel`函数之后，会回调此函数，在调用了cancel函数和回调onError之前会有一个短暂时间，您可以在此函数中实现对这段时间的界面显示。
 * @param
 * @see
 */
- (void) onCancel
{
    NSLog(@"识别取消");
}


#pragma mark - view 

- (void)viewDidLoad
{
    
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setiFly];

    [[ImageView share] addToView:self.view imagePathName:@"笔记-bgall-01" rect:CGRectMake(0, 20, 964, 729)];
    contentImageView =  [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-页" rect:CGRectMake(0, 47, 927, 675)];
    contentImageView.userInteractionEnabled = YES;
    [[ImageView share] addToView:contentImageView imagePathName:@"笔记-新建客户-线框" rect:RectMake2x(80, 147, 1708, 1077)];
    [[ImageView share] addToView:contentImageView imagePathName:@"笔记-新建客户-蓝色" rect:RectMake2x(22, 9, 395, 80)];
    
    //    [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-蓝色" rect:RectMake2x(80, 28, 169, 44)];
    //    [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-蓝色" rect:RectMake2x(80, 28, 169, 44)];
    
    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(1657, 1091, 110, 110) tag:1000 action:@selector(openMSC:) imagePath:@"按钮-语音-00"];
    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(829, 1243, 196, 86) tag:1001 action:@selector(saveCustomer:) imagePath:@"按钮-确定-00"];
    
//    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(78, 1337-47*2, 80, 80) tag:1001 action:@selector(back:) imagePath:@"按钮-返回-00"];

    
    
    penImageView = [[ImageView share] addToView:self.view imagePathName:@"钢笔" rect:KRECThiddenpenImageView];
    
    
    
    
    
    nameTF = [[UITextField alloc] init] ;
    nameTF.frame = RectMake2x (222, 183, 627, 44);
    nameTF.placeholder = @"客户名字（必填）";
    nameTF.font = [UIFont systemFontOfSize:19];

    
    phoneTF = [[UITextField alloc] init] ;
    phoneTF.frame = RectMake2x(219, 291, 300, 44);
    phoneTF.placeholder = @"移动电话";
    phoneTF.font = [UIFont systemFontOfSize:19];

    
    telephoneTF = [[UITextField alloc] init] ;
    telephoneTF.frame = RectMake2x(1071, 291, 300, 44);
    telephoneTF.placeholder = @"固定电话";
    telephoneTF.font = [UIFont systemFontOfSize:19];

    

    addressTV = [[UIPlaceHolderTextView alloc] init] ;
    addressTV.frame = RectMake2x(209, 394, 1434, 64);
    addressTV.backgroundColor = [UIColor clearColor];
    addressTV.font = [UIFont systemFontOfSize:19];

    addressTV.placeholder = @"客户地址";

    
    
    descTV = [[UIPlaceHolderTextView alloc] init] ;
    descTV.frame = RectMake2x(200, 549, 1410, 630);
    descTV.backgroundColor = [UIColor clearColor];
    descTV.placeholder = @"客户说明";
    descTV.font = [UIFont systemFontOfSize:19];

    descTV.delegate= self;
    
    customerLable = [[UILabel alloc] init];
    customerLable.font = [UIFont boldSystemFontOfSize:18];
    customerLable.frame = RectMake2x(72, 9, 365, 80);
//    customerLable.textAlignment = NSTextAlignmentCenter;
    
    
    [contentImageView addSubview:nameTF];
    [contentImageView addSubview:phoneTF];
    [contentImageView addSubview:telephoneTF];
    [contentImageView addSubview:addressTV];
    [contentImageView addSubview:descTV];
    [contentImageView addSubview:customerLable];
    
    
    
    
    vicesView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *v = [[UIView alloc] initWithFrame:self.view.frame];
    v.backgroundColor = [ UIColor blackColor];
    v.alpha = .8;
    
    [vicesView addSubview:v];
    
    [self.view addSubview:vicesView];
    vicesView.alpha = 0;
    
    [[ImageView share] addToView:vicesView imagePathName:@"话筒" rect:RectMake2x(744, 0, 471, 980)];
    
    
    
    
    
    
    UIView *voiceView = [[UIView alloc] initWithFrame:RectMake2x(-80 , 670, 250, 200)];
    [vicesView addSubview:voiceView];
    
    
    self.voiceHud = [[POVoiceHUD alloc] initWithParentView:self.view];
    [self.voiceHud setDelegate:self];
    [voiceView addSubview:self.voiceHud];
    
    
    
    
    
    
    
    UIButton *b  = [[Button share] addToView:vicesView addTarget:self rect:RectMake2x(800, 0, 400, 900) tag:1000 action:@selector(stopMSC:)];

    
    
    
    
    
//    UIButton *b  = [[Button share] addToView:vicesView addTarget:self rect:RectMake2x(800, 1000, 200, 200) tag:1000 action:@selector(stopMSC:)];
//    //    UIButton buttonWithType:<#(UIButtonType)#>
//    //    b.buttonType = UIButtonTypeRoundedRect;
//    
//    [b setTitle:@"说好了" forState:UIControlStateNormal];
    
    
    
    
    
    
//    self.popUpView = [[PopupView alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
//    _popUpView.ParentView = self.view;
    
    
    
    UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [gr setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft )];
    [[self view] addGestureRecognizer:gr];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self loadAnimation];
    
//    nameTF.text = @"name";
//    phoneTF.text = @"phone";
//    telephoneTF.text = @"telephone";
//    addressTV.text = @"contenttv";
//    
//    customerLable.text = @"新建客户";

    if (self.customer) {
        nameTF.text = self.customer.name;
        if (self.customer.mobile == 0) {
            phoneTF.text = @"";
        }
        else {
            phoneTF.text = [NSString stringWithFormat:@"%@", self.customer.mobile];
        }
        if (self.customer.telephone == 0) {
            telephoneTF.text = @"";
        }
        else  {
            telephoneTF.text =[NSString stringWithFormat:@"%@",  self.customer.telephone];
        }

        addressTV.text = self.customer.adress;
        
        customerLable.text = self.customer.name;
        descTV.text = self.customer.descript;

    }
    else {
        customerLable.text = @"新建客户";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - textField


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.frame = CGRectMake(0, -300, 1024, 768);
    }];

    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }];

    
}



@end
