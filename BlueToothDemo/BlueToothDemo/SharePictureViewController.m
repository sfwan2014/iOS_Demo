//
//  SharePictureViewController.m
//  BlueToothDemo
//
//  Created by shaofa on 14-4-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SharePictureViewController.h"

@interface SharePictureViewController ()<
GKPeerPickerControllerDelegate,
GKSessionDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
@property (retain, nonatomic) IBOutlet UIImageView *preview;
@property (retain, nonatomic) IBOutlet UIButton *connectBtn;
@property (retain, nonatomic) IBOutlet UIButton *disconnectBtn;
@property (retain, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation SharePictureViewController
{
    GKSession *_currentSession;
    NSData *_imageDate;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _connectBtn.enabled = YES;
    _disconnectBtn.enabled = NO;
    _sendBtn.enabled = NO;
}

#pragma mark - buttonAction
- (IBAction)selectionPicture:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"拍照", nil];
    sheet.tag = 201302;
    [sheet showInView:self.view];
    [sheet release];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [self showHUDWithText:@"已保存"];
        
        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 201301) {
        
        if (buttonIndex == 0) {
            // 保存到相册
            if (_preview.image) {
                UIImageWriteToSavedPhotosAlbum(_preview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }
        
    } else if (actionSheet.tag == 201302) {
        switch (buttonIndex) {
            case 0:
            {
                UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                /*
                 UIImagePickerControllerSourceTypePhotoLibrary  显示用户所有的相册文件夹
                 UIImagePickerControllerSourceTypeSavedPhotosAlbum  仅显示存储照片的文件夹
                 */
                pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerController.delegate = self;
                
                [self presentViewController:pickerController animated:YES completion:^{
                    NSLog(@"模态视图已经弹出");
                }];
            }
                break;
            case 1:
            {
                /*
                 UIImagePickerControllerCameraDeviceRear 后置摄像头
                 UIImagePickerControllerCameraDeviceFront 前置摄像头
                 */
                BOOL isCamer = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear | UIImagePickerControllerCameraDeviceFront];
                if (isCamer == NO) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能在模拟器上跑o" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [alertView show];
                    [alertView release];
                    
                    return;
                }
                
                UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                //                pickerController.allowsEditing = YES;
                
                //UIImagePickerControllerSourceTypeCamera 这个类型调用摄像头拍照
                pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickerController.delegate = self;
                
                
                //设置拍摄界面的Transform
                //                pickerController.cameraViewTransform = CGAffineTransformMakeScale(0.8, 0.8);
                
                [self presentViewController:pickerController animated:YES completion:^{
                    NSLog(@"模态视图已经弹出");
                }];
            }
                break;
                
            default:
                break;
        }
    }
}
- (IBAction)savePicture:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:nil, nil];
    sheet.tag = 201301;
    [sheet showInView:self.view];
    [sheet release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    _preview.image = image;
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    _imageDate = [data retain];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)showHUDWithText:(NSString *)text
{
    UIView *view = [self.view.window viewWithTag:2013];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.tag = 2013;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        view.center = self.view.window.center;
        [self.view.window addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor orangeColor];
        [view addSubview:label];
        [label release];
        [view release];
    }
    
    UILabel *label = (UILabel *)[view viewWithTag:10];
    label.text = text;
}

-(void)hideHUD
{
    UIView *view = [self.view.window viewWithTag:2013];
    if (view.superview != nil) {
        [view removeFromSuperview];
    }
}

- (IBAction)send:(id)sender {
    
    [self sendDataToPeer:_imageDate];
    
}

-(void)sendDataToPeer:(NSData *)data
{
    [self showHUDWithText:@"正在发送..."];
    if (_currentSession) {
        NSError *error = nil;
        if ([_currentSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error]) {
            if (error == nil) {
                [self performSelector:@selector(hideHUD) withObject:nil afterDelay:3];
            } else {
                [self showHUDWithText:[error description]];
                
                [self performSelector:@selector(hideHUD) withObject:nil afterDelay:2];
            }
        }
    }
}

-(void)receiveDataFromPeer:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    _preview.image = image;
}

- (IBAction)connect:(id)sender {
    
    GKPeerPickerController *peerPickerController = [[GKPeerPickerController alloc] init];
    peerPickerController.delegate = self;
    peerPickerController.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    _connectBtn.enabled = NO;
    
    _disconnectBtn.enabled = YES;
    _sendBtn.enabled = YES;
    [peerPickerController show];
}
- (IBAction)disconnect:(id)sender {
    
    [_currentSession disconnectFromAllPeers];
    [_currentSession release];
    _currentSession = nil;
    
    _connectBtn.enabled = YES;
    _disconnectBtn.enabled = NO;
    _sendBtn.enabled = NO;
}

#pragma mark - GKPeerPickerControllerDelegate
- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type
{
    
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    _currentSession = [session retain];
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    picker.delegate = nil;
//    [picker dismiss];
    [picker autorelease];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate = nil;
//    [picker dismiss];
    [picker autorelease];
    
    _connectBtn.enabled = YES;
    _disconnectBtn.enabled = NO;
    _sendBtn.enabled = NO;
}

#pragma mark - GKSessionDelegate
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    switch (state) {
        case GKPeerStateConnected:
            NSLog(@"已连接");
            
            break;
        case GKPeerStateDisconnected:
        {
            NSLog(@"已断开");
            [_currentSession release];
            _currentSession  = nil;
            _connectBtn.enabled = YES;
            _disconnectBtn.enabled = NO;
            _sendBtn.enabled = NO;
        }
            break;
            
        default:
            break;
    }
}
#pragma clang diagnostic pop

-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void*)context
{
    [self receiveDataFromPeer:data];
}

/* Indicates a connection request was received from another peer.
 
 Accept by calling -acceptConnectionFromPeer:
 Deny by calling -denyConnectionFromPeer:
 */
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    
}

/* Indicates a connection error occurred with a peer, which includes connection request failures, or disconnects due to timeouts.
 */
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
    
}

/* Indicates an error occurred with the session such as failing to make available.
 */
- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_preview release];
    [_connectBtn release];
    [_disconnectBtn release];
    [_sendBtn release];
    [super dealloc];
}
@end
