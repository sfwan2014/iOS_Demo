//
//  RootViewController.m
//  BlueToothDemo
//
//  Created by shaofa on 14-4-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<
    GKPeerPickerControllerDelegate,
    GKSessionDelegate
>

@property (retain, nonatomic) IBOutlet UITextField *msgTextField;
@property (retain, nonatomic) IBOutlet UIButton *connectBtn;
@property (retain, nonatomic) IBOutlet UIButton *disconnectBtn;
@property (retain, nonatomic) IBOutlet UITextView *receiveMessage;

@end

@implementation RootViewController
{
    GKSession *_currentSession;
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

    _connectBtn.enabled = YES;
    _disconnectBtn.enabled = NO;
    
}
#pragma mark - button action
- (IBAction)connect:(id)sender {
    GKPeerPickerController *peerPickerController = [[GKPeerPickerController alloc] init];
    peerPickerController.delegate = self;
    peerPickerController.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    _connectBtn.enabled = NO;
    
    _disconnectBtn.enabled = YES;
    [peerPickerController show];
}

- (IBAction)disconnect:(id)sender {
    
    [_currentSession disconnectFromAllPeers];
    [_currentSession release];
    _currentSession = nil;
    
    _connectBtn.enabled = YES;
    _disconnectBtn.enabled = NO;
    
}
- (IBAction)send:(id)sender {
    
    NSString *message = self.msgTextField.text;
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    [self sendDataToPeer:data];
}

-(void)sendDataToPeer:(NSData *)data
{
    if (_currentSession) {
        [_currentSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
    }
}

-(void)receiveData:(NSData *)data
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *lastMsg = self.receiveMessage.text;
    if (lastMsg.length > 0) {
        message = [NSString stringWithFormat:@"%@/n%@", lastMsg, message];
    }
    
    self.receiveMessage.text = message;
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
    [picker autorelease];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate = nil;
    [picker autorelease];
    
    _connectBtn.enabled = YES;
    _disconnectBtn.enabled = NO;
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
        }
            break;
            
        default:
            break;
    }
}



#pragma clang diagnostic pop

-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void*)context
{
    [self receiveData:data];
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
    [_msgTextField release];
    [_connectBtn release];
    [_disconnectBtn release];
    [_receiveMessage release];
    [super dealloc];
}
@end
