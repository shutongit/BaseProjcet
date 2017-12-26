//
//  AddressBookHelper.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/4.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "AddressBookHelper.h"
#import "UIAlertView+Extension.h"

@interface AddressBookHelper()<UIAlertViewDelegate>
@end

@implementation AddressBookHelper


+(NSMutableArray *)callbackAddressBook{
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    BOOL __block tip;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook = nil;
    
    //创建通讯簿的引用
    addBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //创建一个出事信号量为0的信号
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //申请访问权限
    ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
        //greanted为YES是表示用户允许，否则为不允许
        if (!greanted) {
            tip = YES;
        }
        //发送一次信号
        dispatch_semaphore_signal(sema);
    });
    //等待信号触发
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (tip) {
        //做一个友好的提示
        [UIAlertView showAlertViewWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" cancelButtonTitle:@"不允许" confirmButtonTitle:@"允许" onCancel:^{
            
        } onConfirm:^{
            NSURL *url = [NSURL URLWithString:@"prefs:root=so.shanku.taosheshenghuo"];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        return nil;
    }
    
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
 
    NSMutableArray *phoneArray = [NSMutableArray new];
    //进行遍历
    for (int i = 0; i < number; i++) {
        //获取当前联系人的电话 数组
        NSMutableDictionary *book = [NSMutableDictionary new];
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        
        //获取当前联系人名字
        NSString * firstName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        //获取当前联系人姓氏
        NSString * lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
//        for (NSInteger j = 0; j < ABMultiValueGetCount(phones); j++) {
        
           NSString *phoneStr =[ (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, 0)) removeWhiteSpace];
            //* 过滤手机号*/
           if (phoneStr.length>0) {
               if ([NSString validateMobile:phoneStr]){
                   //* 过滤空的用户名 */
                   NSString *phoneName;
                   if (lastName!=nil) {
                       if(firstName!=nil){
                           phoneName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
                       }else{
                           phoneName = lastName;
                       }
                   }else if (firstName!=nil){
                       phoneName = firstName;
                   }else{
                       NSAssert(@"数据异常", nil);
                   }
                   [book setValue:phoneName forKey:@"Name"];
                   [book setValue:phoneStr forKey:@"Phone"];

               }
              
           }
//        }
        if ([[book allKeys] containsObject:@"Name"]) {
            if ([NSString stringWithFormat:@"%@",[book objectForKey:@"Name"]].length>0) {
                [phoneArray addObject:book];
            }
        }
        
    }
    allLinkPeople = nil;
    return phoneArray;
}

@end
