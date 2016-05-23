//
//  ViewController.m
//  todolist
//
//  Created by Admin on 09.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *testFieldTODO;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerTODO;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;


@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePickerTODO.minimumDate = [NSDate date];
    
    [self.datePickerTODO addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.buttonSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEndEditing)];
    
    [self.view addGestureRecognizer:handleTap];
    
}

- (void) datePickerValueChanged {
    
    self.eventDate = self.datePickerTODO.date;
    NSLog(@"self.eventDate %@", self.eventDate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonActionSave:(id)sender {
    NSLog(@"buttonActionSave");
}

- (void)handleEndEditing {
    [self.view endEditing:YES];
}

- (void)save {
    
    NSString * eventInfo = self.testFieldTODO.text;
    NSDateFormatter * formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm dd.MMMM.yyyy";
    NSString * eventDate = [formater stringFromDate:self.eventDate];
    
    NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:eventInfo,@"eventInfo",eventDate,@"eventDate",  nil ];
    
    UILocalNotification * notification = [[UILocalNotification alloc]init];
    notification.userInfo = dict;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = self.eventDate;
    notification.alertBody = eventInfo;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.testFieldTODO]) {
    [self.testFieldTODO resignFirstResponder];
    }
    return YES;
}
@end