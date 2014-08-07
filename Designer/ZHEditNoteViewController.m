//
//  ZHEditNoteViewController.m
//  Designer
//
//  Created by bejoy on 14/7/2.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHEditNoteViewController.h"
#import "Customer.h"
#import "Note.h"
#import "WKKViewController.h"
#import "Photo.h"
#import "PhotoCell.h"
#import "PhotosViewController.h"
//#import " IFlySpeechUtility.h"
#import <iflyMSC/IFlySpeechUtility.h>
#import "UIPlaceHolderTextView.h"
#import "UIView+Utilities.h"





@interface ZHEditNoteViewController ()
{
    
    UIImageView *penImageView;
    
}
@end



#define KRECTpenImageView RectMake2x(1716, 228, 308, 1094 )
#define KRECThiddenpenImageView RectMake2x(2048, 228, 308, 1094 )

#define KlineHeightMultiple 0.0

@implementation ZHEditNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 -(void)back:(UIButton *)button
{
    [self closeAnimation];
}

-(void)closeAnimation
{

    
    
    
    
#ifdef AppStore
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.view.alpha = 0;
        penImageView.frame = KRECThiddenpenImageView;
        
    } completion:^(BOOL finished) {
        
        
        if (finished) {
            
            //            noteOpenAnimation
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
        self.view.alpha = 0;
        penImageView.frame = KRECThiddenpenImageView;
        
    } completion:^(BOOL finished) {
        
        
        if (finished) {
            
            //            noteOpenAnimation
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



- (void)openCam:(UIButton *)button
{
    
    if ( ! self.note ) {
        Note *n = [Note createEntity];
        n.note_id = [NSString md5Date];
        n.cstm_id = self.customer.customer_id;
        n.sync = Sync_Unsync;
        n.create_time = [NSDate date];
        n.update_time = [NSDate date];
        self.note = n;
    }
    
    WKKViewController *kk = [[WKKViewController alloc] initWithNibName:@"WKKViewController" bundle:nil];
    kk.customer = self.customer;
    kk.note = self.note;
    
    [self.view addSubview:kk.view];
    [self addChildViewController:kk  ];
}

- (void)createNote {
    
    if (addressTV.text.length == 0) {
        [[Message share] messageAlert:@"日志内容不能为空"];
        return;
    }
    
    
    if ( ! self.note ) {
        Note *n = [Note createEntity];
        n.content = addressTV.text;
        n.note_id = [NSString md5Date];
        n.cstm_id = self.customer.customer_id;
        n.sync = Sync_Unsync;
        n.create_time = [NSDate date];
        n.update_time = [NSDate date];
        self.note = n;

    }
    else {
        self.note.content = addressTV.text;
        self.note.update_time = [NSDate date];

    }
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
    

    [self closeAnimation];
    
}

- (void)saveCustomer:(UIButton *)button
{

    [self createNote];
    
    
    
//    self.note.content = addressTV.text;
//    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
//
//    
//    
//    
//    [self closeAnimation];
}



- (void)customerControl:(UIButton *)button {
    
    if (button.selected == YES) {
        button.selected = NO;
        photoCellType = PhotoCellTypeNormal;
    }
    else {
        button.selected = YES;
        photoCellType = PhotoCellTypeDelete;
    }
    
    [_collectionView reloadData];
}


- (void)openMSC:(UIButton *)button
{
    
    [addressTV resignFirstResponder];
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
#pragma mark ifly

- (void)speech
{
    // 创建合成对象,为单例模式
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //设置语音合成的参数
    //语速,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]]; //音量;取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表 [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]];
    //音频采样率,目前支持的采样率有 16000 和 8000
    [_iFlySpeechSynthesizer setParameter:@"8000" forKey: [IFlySpeechConstant SAMPLE_RATE]]; //asr_audio_path保存录音文件路径,如不再需要,设置value为nil表示取消,默认目录是 documents
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //启动合成会话
    [_iFlySpeechSynthesizer startSpeaking: @"你好,我是科大讯飞的小燕"];
    
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
- (void) onVolumeChanged:(int)volume
{
    if (self.isCanceled) {
        [_popUpView removeFromSuperview];
        return;
    }
    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    [_popUpView setText: vol];
    [self.view addSubview:_popUpView];

    
    NSLog(@"%d" , volume);
    
    

    
    
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
    addressTV.text = [NSString stringWithFormat:@"%@%@", addressTV.text,resultString];
    [addressTV scrollRangeToVisible:NSMakeRange([addressTV.text length], 0)];
    
    
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = KlineHeightMultiple;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:19], NSParagraphStyleAttributeName:paragraphStyle };
    addressTV.attributedText = [[NSAttributedString alloc]initWithString:addressTV.text attributes:attributes];
    
    
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

- (void)loadView
{
    [super loadView];
    [[ImageView share] addToView:self.view imagePathName:@"笔记-bgall-01" rect:CGRectMake(0, 20, 964, 729)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setiFly];
    
    
    contentImageView =  [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-页" rect:CGRectMake(0, 47, 927, 675)];
    contentImageView.userInteractionEnabled = YES;
    [[ImageView share] addToView:contentImageView imagePathName:@"笔记-信息编辑-线框" rect:RectMake2x(80, 147, 1708, 1077)];
    [[ImageView share] addToView:contentImageView imagePathName:@"笔记-信息编辑-紫色" rect:RectMake2x(22, 9, 395, 80)];
    
    //    [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-蓝色" rect:RectMake2x(80, 28, 169, 44)];
    //    [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-蓝色" rect:RectMake2x(80, 28, 169, 44)];
    
   mscButton = [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(1657, 555, 110, 110) tag:1000 action:@selector(openMSC:) imagePath:@"按钮-语音-00"];
    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(1657, 1091, 110, 110) tag:1000 action:@selector(openCam:) imagePath:@"按钮-相机-00"];
    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(829, 1243, 196, 86) tag:1001 action:@selector(saveCustomer:) imagePath:@"按钮-确定-00"];
//    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(78, 1337-47*2, 80, 80) tag:1001 action:@selector(back:) imagePath:@"按钮-返回-00"];


    trashButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1858, 1296, 150, 150) tag:2002
                                     action:@selector(customerControl:)
                                  imagePath:@"按钮-删除-00"
                       highlightedImagePath:@"按钮-删除-01"
                          SelectedImagePath:@"按钮-删除-01"
                   ];
//    penImageView = [[ImageView share] addToView:self.view imagePathName:@"钢笔" rect:KRECThiddenpenImageView];
    
    

    

    
    addressTV = [[UIPlaceHolderTextView alloc] init] ;

    addressTV.frame = RectMake2x(223, 189, 1406, 472);
    addressTV.backgroundColor = [UIColor clearColor];
    addressTV.placeholder = @"点击开始写入内容（必填）";
    addressTV.font = [UIFont systemFontOfSize:19];

    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = KlineHeightMultiple
    ;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:19], NSParagraphStyleAttributeName:paragraphStyle };
    addressTV.attributedText = [[NSAttributedString alloc]initWithString:@"" attributes:attributes];
  
    
    
    
    customerLable = [[UILabel alloc] init];
//    customerLable.frame = RectMake2x(22, 9, 365, 80);
//    customerLable.textAlignment = NSTextAlignmentCenter;
    customerLable.font = [UIFont boldSystemFontOfSize:18];
    customerLable.frame = RectMake2x(72, 9, 365, 80);

    [contentImageView addSubview:addressTV];
    [contentImageView addSubview:customerLable];
    
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:RectMake2x(222, 840, 1406, 380) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"PhotoCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    
    
    
    [self.view addSubview:_collectionView];


    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteRefreshNote) name:@"noteRefreshNote" object:nil];


    
    
    
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
//    [b setTitle:@"说完了" forState:UIControlStateNormal];
//    b.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    
//    self.popUpView = [[PopupView alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
//    _popUpView.ParentView = self.view;
    
    
    
    UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [gr setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft )];
    [[self view] addGestureRecognizer:gr];
    
    self.pageAnimotionImageView.alpha = 1;

    
    
    
 
 
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_iFlySpeechRecognizer cancel];
    
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@", KiflyAPPID, TIMEOUT_VALUE];
    [IFlySpeechUtility createUtility:initString];
    [_iFlySpeechRecognizer setDelegate: nil];
    [super viewWillDisappear:animated];
}

- (void)noteRefreshNote
{
    [self loadPhotos];
}


- (void)loadPhotos {
    
    [self.dataMArray removeAllObjects];
    self.dataMArray = [NSMutableArray arrayWithArray: [Photo findByAttribute:@"note_id" withValue:self.note.note_id andOrderBy:@"update_time" ascending:NO]];
    
    [_collectionView reloadData];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    [self loadAnimation];
    
    
    nameTF.text = @"name";
    phoneTF.text = @"phone";
    telephoneTF.text = @"telephone";
    addressTV.text = @"";
    
    

    if (_note) {
//        addressTV.text = _note.content;
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineHeightMultiple = KlineHeightMultiple;
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:19], NSParagraphStyleAttributeName:paragraphStyle };
        addressTV.attributedText = [[NSAttributedString alloc]initWithString: _note.content attributes:attributes];

        
        
    }
    else {
        
    }

    customerLable.text = _customer.name;
    
    

    [self loadPhotos];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.nameLabel.delegate = self;
    
    
    
    Photo *c = [self.dataMArray objectAtIndex:indexPath.row];
    cell.photo = c;
    [cell setCellType:photoCellType];
    
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(460/2, 380/2);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    PhotosViewController *pvc = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController" bundle:nil];

    pvc.photos = self.dataMArray;
    
    
    [self.view addSubview:pvc.view];
    [self addChildViewController:pvc];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0) {
//        
//    }
//    else {
//        Customer *c =   self.dataMArray[currentCustomerIndexPath.row];
//        c.status = @(1);
//        
//        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
//        
//        [self fetchAllCustomer];
//    }
}


- (IBAction)deletePhoto:(UIButton *)button {
    UICollectionViewCell *cell = (UICollectionViewCell *)[[button superview] superview];
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    
    Photo *c = self.dataMArray[indexPath.row];
    [c deleteEntity];
    

    [self loadPhotos];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, -350, 1024, 768);
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = KlineHeightMultiple;
    
    
    
    NSString *s  = [NSString stringWithFormat:@"%@%@", addressTV.text,string];

    
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:19], NSParagraphStyleAttributeName:paragraphStyle };
    addressTV.attributedText = [[NSAttributedString alloc]initWithString:s attributes:attributes];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [self savePhoto:textField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [textField resignFirstResponder];

    return YES;
}

- (void)savePhoto:(UITextField *)textField{
    
    PhotoCell *pc = (PhotoCell *)[[textField superview] superview];

    NSIndexPath *indexPath = [_collectionView indexPathForCell:pc];
    
    
    Photo *photo = self.dataMArray[indexPath.row];
    
    photo.name = textField.text;


    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        
        if (success) {
            
        }
        else {
            NSLog(@"%@", error);
        }
        
    }];
    
}

@end
