//
//  TelephoneVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/23.
//  Copyright © 2016年 greatRong. All rights reserved.
/*
 不错的通讯录选择
 */

#import "TelephoneVC.h"

@interface TelephoneVC ()


@end

@implementation TelephoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"不错的通讯录选择";
    

    
    // Do any additional setup after loading the view.
}

/*
 {
 ABAddressBookRef _addressBook;
 }

 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 _addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
 [self authenticateContact];
 }
 
 - (IBAction)pickSomeContact:(id)sender
 {
 ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc]init];
 picker.peoplePickerDelegate = self;
 NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
 [NSNumber numberWithInt:kABPersonOrganizationProperty], nil];
 
 picker.displayedProperties = displayedItems;
 [self presentViewController:picker animated:YES completion:nil];
 }
 
 
 #pragma mark - ABPeoplePickerNavigationControllerDelegate
 
 // The delegate is responsible for dismissing the peoplePicker
 - (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
 NSLog(@"AppDelegate: peoplePickerNavigationController - peoplePicker");
 [peoplePicker dismissViewControllerAnimated:YES completion:nil];
 }
 
 // new iOS8 API
 - (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
 didSelectPerson:(ABRecordRef)person
 property:(ABPropertyID)property
 identifier:(ABMultiValueIdentifier)identifier
 {
 NSLog(@"peoplePickerNavigationController - didSelectPerson");
 //    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
 NSLog(@"this is a phone property");
 ABMultiValueRef phonePro = ABRecordCopyValue(person, property);
 CFIndex count = ABMultiValueGetCount(phonePro);
 CFIndex idx = ABMultiValueGetIndexForIdentifier(phonePro, identifier);
 for (int i = 0; i < count; i++) {
 NSString* phoneNumber = (__bridge_transfer NSString *)(ABMultiValueCopyValueAtIndex(phonePro, i));
 NSLog(@"tapped phone number:%@ at %d,id:%d",phoneNumber,i,ABMultiValueGetIdentifierAtIndex(phonePro, i)) ;
 }
 
 NSString* phoneNumber = (__bridge_transfer NSString *)(ABMultiValueCopyValueAtIndex(phonePro, idx));
 //NSLog(@"tapped phone number:%@ at %ld",phoneNumber,idx) ;
 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"tapped phone number:%@ at %ld",phoneNumber,idx] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 }
 
 // Called after a value has been selected by the user.
 // Return YES if you want default action to be performed.
 // Return NO to do nothing (the delegate is responsible for dismissing the peoplePicker).
 - (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
 NSLog(@"peoplePickerNavigationController - shouldContinueAfterSelectingPerson2");
 
 // FIXME duplicate code from FavoritesListController.personViewController
 if (kABPersonPhoneProperty == property)
 {
 //NSString* firstName = (__bridge_transfer NSString *) ABRecordCopyValue(person, kABPersonFirstNameProperty);
 //NSString* lastName = (__bridge_transfer NSString *) ABRecordCopyValue(person, kABPersonLastNameProperty);
 
 NSLog(@"this is a phone property");
 ABMultiValueRef phonePro = ABRecordCopyValue(person, property);
 CFIndex count = ABMultiValueGetCount(phonePro);
 for (int i = 0; i < count; i++) {
 NSString* phoneNumber = (__bridge_transfer NSString *)(ABMultiValueCopyValueAtIndex(phonePro, i));
 NSLog(@"tapped phone number:%@ at %d,id:%d",phoneNumber,i,ABMultiValueGetIdentifierAtIndex(phonePro, i)) ;
 }
 CFIndex idx = ABMultiValueGetIndexForIdentifier(phonePro, identifier);
 NSString* phoneNumber = (__bridge_transfer NSString *)(ABMultiValueCopyValueAtIndex(phonePro, idx));
 NSLog(@"tapped phone number:%@ at %ld,id:%d",phoneNumber,idx,identifier) ;
 //
 //        CFTypeRef multiValue;
 //        CFIndex valueIdx;
 
 //        multiValue = ABRecordCopyValue(person, property);
 //        ABMultiValueRef phoneLabels = ABRecordCopyValue(person, kABPersonPhoneProperty);
 //        valueIdx = ABMultiValueGetIndexForIdentifier(multiValue,identifier);
 //        NSString *phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(multiValue, valueIdx);
 //        NSLog(@"tapped phone number:%@ at %ld",phoneNumber,valueIdx) ;
 //        if (phoneLabels) CFRelease(phoneLabels);
 //        if (multiValue) CFRelease(multiValue);
 return NO;
 }
 
 return YES;
 
 }
 
 - (void)authenticateContact
 {
 switch (ABAddressBookGetAuthorizationStatus()) {
 case kABAuthorizationStatusNotDetermined: {
 
 ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
 dispatch_async(dispatch_get_main_queue(), ^{
 if (granted) {
 [self accessContactAuthenticated:YES];
 }else{
 [self accessContactAuthenticated:NO];
 }
 });
 });
 } break;
 case kABAuthorizationStatusAuthorized: {
 [self accessContactAuthenticated:YES];
 } break;
 case kABAuthorizationStatusDenied: {
 [self accessContactAuthenticated:NO];
 } break;
 case kABAuthorizationStatusRestricted: {
 [self accessContactAuthenticated:NO];
 } break;
 
 default: {
 } break;
 }
 }
 
 - (void)accessContactAuthenticated:(BOOL)authenticated
 {
 if (authenticated) {
 
 }else{
 
 }
 }

 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
