//
//  RootViewController.m
//  ScrollViewDemo
//
//  Created by shaofa on 14-3-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RootViewController.h"
#import "EditPictureViewController.h"

@interface RootViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@end

@implementation RootViewController

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

    
}
- (IBAction)selectImage:(id)sender {
    
    [self selectePictureFromPhotoAlbum];
}

-(void)selectePictureFromPhotoAlbum
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"拍照", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 2014) {
        
        // 保存二维码
        
        return;
    }
    
    switch (buttonIndex) {
        case 0:
            // 调用相册
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
            // 调用摄像头
        {
            /*
             UIImagePickerControllerCameraDeviceRear 后置摄像头
             UIImagePickerControllerCameraDeviceFront 前置摄像头
             */
            BOOL isCamer = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear | UIImagePickerControllerCameraDeviceFront];
            if (isCamer == NO) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能在模拟器上跑o" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alertView show];
                
                return;
            }
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                pickerController.allowsEditing = YES;
            
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

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    EditPictureViewController *editPictureViewController = [[EditPictureViewController alloc] init];
    editPictureViewController.image = image;
    [picker pushViewController:editPictureViewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [self dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
