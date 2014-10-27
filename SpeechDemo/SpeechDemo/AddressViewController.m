//
//  AddressViewController.m
//  SpeechDemo
//
//  Created by sfwan on 14-6-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation AddressViewController


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

    self.title = @"通讯录";
    
    [self _initNavigationItem];

    [self _initData];
}


-(void)_initData
{
    CFErrorRef myError = NULL;
    ABAddressBookRef myAddressBook = ABAddressBookCreateWithOptions(NULL, &myError);
    
    __weak AddressViewController *this = self;
    ABAddressBookRequestAccessWithCompletion(myAddressBook,
                                             ^(bool granted, CFErrorRef error) {
                                                 if (granted) {
                                                     
                                                     __strong AddressViewController *strong = this;
                                                     NSArray *theSmiths = CFBridgingRelease(
                                                                                            ABAddressBookCopyPeopleWithName(myAddressBook,
                                                                                                                            CFSTR("Smith")
                                                                                                                            )
                                                                                            );
                                                     NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(myAddressBook));
                                                     strong.data = [allPeople mutableCopy];
                                                     [strong.tableView reloadData];
                                                 } else {
                                                     // Handle the case of being denied access and/or the error.
                                                 }
                                                 CFRelease(myAddressBook);
                                             });
}

-(void)_initNavigationItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"asdad";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    ABRecordRef recordRef = (__bridge ABRecordRef)(self.data[indexPath.row]);
    NSString *str = (__bridge NSString *) ABRecordCopyCompositeName(recordRef);
    
    ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(recordRef, kABPersonPhoneProperty);
    
    long nCount = ABMultiValueGetCount(phones);
    
//    ABMultiValueRef phone = ABRecordCopyValue(persons, kABPersonPhoneProperty);
    for (int k = 0; k<ABMultiValueGetCount(phones); k++)
    {
        //获取电话Label
        NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, k));
        //获取該Label下的电话值
        NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, k);
        
        NSLog(@"%@", personPhone);
    }
    
    for (int i = 0; i < nCount; i++) {
         NSString *phoneNO    = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, i);  // 这个就是电话号码
        NSLog(@"%@", phoneNO);
    }
   
    
    cell.textLabel.text = str;
//    cell.detailTextLabel.text = phoneNO;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
