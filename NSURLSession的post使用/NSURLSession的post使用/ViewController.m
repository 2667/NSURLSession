//
//  ViewController.m
//  NSURLSession的post使用
//
//  Created by czbk on 16/7/17.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "ViewController.h"
//#import "NSArray+YZLog.h"
//#import "NSDictionary+YZLog.h"
#import "AFHTTPSessionManager.h"

@interface ViewController ()

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self loadData];
//    [self ARequest];
    
//    [self postRequest];
//    [self QingQiuMaRequest];
//    [self BanDinSenFenZenRequest];
//    [self postRequest2];
//    [self ZaoHUiPasswordRequest];
//    [self zhifuRequest];
    [self RoleRequest];
    
}

- (void)loadData {
    //服务器
    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/?"];
    
    //请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求方式
    request.HTTPMethod = @"POST";
    
    //设置请求体
//    NSString *data = [NSString stringWithFormat:@"username=zhangsan&password=zhang"];
    // 1找回密码,0或者绑定手机号
    NSString *data = [NSString stringWithFormat:@" 'a':verify,'phone':15920198662,'type': 0"];
    
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //session
    NSURLSession *session = [NSURLSession sharedSession];
    
    //
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if(error == nil){
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"result是%@",result);
        }
    }];
    
    //
    [task resume];
}


-(void)ARequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
//    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
      NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/member/gto/3";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
//    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
//    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
//    [params setObject:@"15920198662" forKey:@"user_name"];
//
//    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
    NSString *data = [NSString stringWithFormat:@"user_name=15920198662&password=123456&device_code="];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];

    //6根据会话创建一个task（发送请求）
    
//    第一个参数：请求对象
//    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
//    28                 data：响应体信息（期望的数据）
//    29                 response：响应头信息，主要是对服务器端的描述
//    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}

#pragma mark 获取验证码
-(void)QingQiuMaRequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
    //    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
    //gto 为1找回密码,0或者2绑定手机号
    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/verify/gto/0";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
    //    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
    //    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //
    //    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
    NSDictionary *dict = @{@"phone":@"15920198662"};
    NSString *data = [self DictToJson:dict];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //6根据会话创建一个task（发送请求）
    
    //    第一个参数：请求对象
    //    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //    28                 data：响应体信息（期望的数据）
    //    29                 response：响应头信息，主要是对服务器端的描述
    //    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}


#pragma mark 登陆 已经ok
-(void)LoginRequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
    //    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
    //gto 为1找回密码,0或者2绑定手机号

    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/member/gto/3";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
    //    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
    //    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //
    //    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
//    NSDictionary *dict = @{@"phone":@"15920198662"};
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:@"15920198662" forKey:@"user_name"];
    
    [params setObject:@"123456" forKey:@"password"];
    
    NSString *data = [self DictToJson:params];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //6根据会话创建一个task（发送请求）
    
    //    第一个参数：请求对象
    //    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //    28                 data：响应体信息（期望的数据）
    //    29                 response：响应头信息，主要是对服务器端的描述
    //    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}


#pragma mark 支付/下单
-(void)zhifuRequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
    //    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
    //gto 为1找回密码,0或者2绑定手机号
    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/memberorder/gto/0";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
    //    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
    //    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //
    //    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
//    NSDictionary *dict = @{@"phone":@"15920198662"};
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
//    _userName.text = @"15920198662";
//    _passWord.text = @"123456";
//    pay_type = ON;sanfan
//    YES pinguo
    [params setObject:@"0" forKey:@"adv_id"];
//    用户ID
    [params setObject:@"100002796" forKey:@"uid"];
    //    渠道ID
    [params setObject:@"15920198662" forKey:@"user_name"];
    //    游戏ID
    [params setObject:@"1" forKey:@"gid"];
    //    子游戏ID
    [params setObject:@"1044"  forKey:@"sub_gid"];
    //    0: IOS
    [params setObject:@"3" forKey:@"cp_server_id"];
        [params setObject:@"guofu" forKey:@"server_name"];
    
    [params setObject:@"0" forKey:@"platform_id"];
    [params setObject:@"0" forKey:@"channel_id"];
    [params setObject:@"0.1" forKey:@"pay_money"];
    [params setObject:@"IDFA" forKey:@"product_name"];
    [params setObject:@"IDFA" forKey:@"game_grade"];
    [params setObject:@"2.0.5" forKey:@"game_ver"];
    [params setObject:@"IDFA" forKey:@"role_id"];
    [params setObject:@"IDFA" forKey:@"role_name"];

//    [self varName_game_version]
    NSString *data = [self DictToJson:params];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //6根据会话创建一个task（发送请求）
    
    //    第一个参数：请求对象
    //    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //    28                 data：响应体信息（期望的数据）
    //    29                 response：响应头信息，主要是对服务器端的描述
    //    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}


#pragma mark 用户角色表
// 登陆 注册  角色升级
-(void)RoleRequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
    //    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
    //gto 为1找回密码,0或者2绑定手机号
    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/memberole/gto/0";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
    //    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
    //    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //
    //    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
    //    NSDictionary *dict = @{@"phone":@"15920198662"};
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //    _userName.text = @"15920198662";
    //    _passWord.text = @"123456";
    //    pay_type = ON;sanfan
    //    YES pinguo
    
    //    用户ID
    [params setObject:@"100002796" forKey:@"uid"];
    
    //    用户名
    [params setObject:@"15920198662" forKey:@"user_name"];

//    游戏角色ID
    [params setObject:@"2345" forKey:@"role_id"];
    //    角色名
    [params setObject:@"IDFA" forKey:@"role_name"];
    
//    广告ID
    [params setObject:@"0" forKey:@"adv_id"];
    //    0: IOS
    [params setObject:@"0" forKey:@"platform_id"];
    
    //    主游戏ID
    [params setObject:@"1" forKey:@"gid"];
    //    子游戏ID
    [params setObject:@"1044"  forKey:@"sub_gid"];
    //    游戏等级
    [params setObject:@"5" forKey:@"game_grade"];
    //    渠道ID
    [params setObject:@"0" forKey:@"channel_id"];
    
//    区服ID
    [params setObject:@"3" forKey:@"cp_server_id"];
//    区服名
    [params setObject:@"guofu" forKey:@"server_name"];
//    vip
    [params setObject:@"2" forKey:@"vip"];
    //游戏币
    [params setObject:@"20" forKey:@"game_coin"];




    [params setObject:@"0.1" forKey:@"pay_money"];
    [params setObject:@"IDFA" forKey:@"product_name"];

    [params setObject:@"2.0.5" forKey:@"game_ver"];

    
    //    [self varName_game_version]
    NSString *data = [self DictToJson:params];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //6根据会话创建一个task（发送请求）
    
    //    第一个参数：请求对象
    //    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //    28                 data：响应体信息（期望的数据）
    //    29                 response：响应头信息，主要是对服务器端的描述
    //    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}



#pragma mark 找回密码
-(void)ZaoHUiPasswordRequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
    //    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
    //gto 为1找回密码,0或者2绑定手机号
    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/backuserpsw/gto/0";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
    //    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
    //    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //
    //    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
//    NSString *data = [NSString stringWithFormat:@"phone=15920198662&code=234"];
    
    //设置请求体
    NSDictionary *dict = @{@"phone":@"15920198662",@"code":@"496165",@"password":@"123456"};
    NSString *data = [self DictToJson:dict];
    
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //6根据会话创建一个task（发送请求）
    
    //    第一个参数：请求对象
    //    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //    28                 data：响应体信息（期望的数据）
    //    29                 response：响应头信息，主要是对服务器端的描述
    //    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}


#pragma mark 找回/修改密码
-(void)BanDinSenFenZenRequest{
    //1，创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2,根据会话创建task
    //    NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/"];
    //gto 为1找回密码,0或者2绑定手机号
    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/bindidcard/gto/1";
    NSURL *url = [NSURL URLWithString:actionRequestURL];
    
    //3,创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4,请求方法改为post
    request.HTTPMethod = @"POST";
    //5,设置请求体
    //    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON"dataUsingEncoding:NSUTF8StringEncoding];
    
    //5,设置请求体
    //    request.HTTPBody = [@"phone=15920198662&type=0"dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *data = [NSString stringWithFormat:@"'phone'=> '15920198662','type'=> '0'"];
    //    [params setObject:@"15920198662" forKey:@"user_name"];
    //
    //    [params setObject:@"123456" forKey:@"password"];
    
    //设置请求体
    NSString *data = [NSString stringWithFormat:@"user_name=15920198662&real_name=唐斌&idcard=45032419880804651x"];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //6根据会话创建一个task（发送请求）
    
    //    第一个参数：请求对象
    //    27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //    28                 data：响应体信息（期望的数据）
    //    29                 response：响应头信息，主要是对服务器端的描述
    //    30                 error：错误信息，如果请求失败，则error有值
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSLog(@"post dic = %@",dic);
        NSLog(@"dic是%@",dic);
        
        
    }];
    //开始任务
    [dataTask resume];
}

-(void)postRequest
{

        // 取消之前的所有请求
        //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
        // 请求参数
        //    NSMutableDictionary* params = [NSMutableDictionary dictionary];
        NSMutableDictionary* params = [NSMutableDictionary dictionary];
        
        //一张图片的base64格式文件
    
        
    
    
        
//        [params setObject:@"15920198662" forKey:@"phone"];
//        [params setObject:@"0" forKey:@"type"];

    [params setObject:@"15920198662" forKey:@"user_name"];
    
    [params setObject:@"123456" forKey:@"password"];
//    [params setObject:@"3" forKey:@"type"];
    
    //        [params setObject:@"9866661" forKey:@"phone"];
        //    [params setObject:@(9866661) forKey:@"phone"];
    
    
        
        NSLog(@"params内容是%@",params);
        NSLog(@"realname内容是%@",params[@"phone"]);
        
        //发送请求
        __weak typeof(self) WeakSelf = self;
        
        /** 请求路径 */
    
//        NSString * const actionRequestURL = @"user/taxiRegist";
//          NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/?"];
//    NSString * const actionRequestURL = @"http://api.gzzongsi.com/?/a=verify";
//    NSString * const actionRequestURL = @"http://api.gzzongsi.com/?/a=member";
//    NSString * const actionRequestURL = @"http://192.168.0.93:10001/ua/member/gto/3";
        NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/member/gto/3";
//    http://106.14.149.217:10001
    
    
//        NSString * const BTRequestURL = [NSString stringWithFormat:@"%@%@",baseRequestURL,actionRequestURL];
    
        
        
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        self.manager.requestSerializer.timeoutInterval = 15;
        
        [self.manager POST:actionRequestURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"进度%@",uploadProgress);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"返回数据是%@",responseObject);
            NSString *fanhuidata = responseObject[@"message"];
            NSLog(@"返回数据是%@",fanhuidata);
//            NSLog(@"上传成功");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传失败原因%@",error);
            
        }];
        
        
        
        
        
        
    }
    
//yanzenma
-(void)postRequest2
{
    
    // 取消之前的所有请求
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    //    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    //一张图片的base64格式文件
    
    
    
    
    
    //        [params setObject:@"15920198662" forKey:@"phone"];
    //        [params setObject:@"0" forKey:@"type"];
    
    [params setObject:@"15920198662" forKey:@"phone"];
//    phone=15920198662
//    [params setObject:@"123456" forKey:@"password"];
    //    [params setObject:@"3" forKey:@"type"];
    
    //        [params setObject:@"9866661" forKey:@"phone"];
    //    [params setObject:@(9866661) forKey:@"phone"];
    
    
    
    NSLog(@"params内容是%@",params);
    NSLog(@"realname内容是%@",params[@"phone"]);
    
    //发送请求
    __weak typeof(self) WeakSelf = self;
    
    /** 请求路径 */
    
    //        NSString * const actionRequestURL = @"user/taxiRegist";
    //          NSURL *url = [NSURL URLWithString:@"http://api.gzzongsi.com/?"];
    //    NSString * const actionRequestURL = @"http://api.gzzongsi.com/?/a=verify";
    //    NSString * const actionRequestURL = @"http://api.gzzongsi.com/?/a=member";
    //    NSString * const actionRequestURL = @"http://192.168.0.93:10001/ua/member/gto/3";
//    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/member/gto/3";
    //gto 为1找回密码,0或者2绑定手机号
    NSString * const actionRequestURL = @"http://106.14.149.217:10001/ua/verify/gto/1";
    //    http://106.14.149.217:10001
    
    
    //        NSString * const BTRequestURL = [NSString stringWithFormat:@"%@%@",baseRequestURL,actionRequestURL];
    
//    NSJSONSerialization
    
    
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    self.manager.requestSerializer.timeoutInterval = 15;
    
    [self.manager POST:actionRequestURL parameters:[self DictToJson:params] progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度%@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据是%@",responseObject);
        NSString *fanhuidata = responseObject[@"message"];
        NSLog(@"返回数据是%@",fanhuidata);
        //            NSLog(@"上传成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败原因%@",error);
        
    }];
    
    
    
    
    
    
}


-(NSString*)DictToJson:(NSDictionary*)dict{
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dict
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    [ClassName_LogMsgShow methodName_logMessageShow:jsonString];
    
    return jsonString;
}

-(NSString*)varName_game_version{
    NSDictionary *varName_infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *varName_versionString = varName_infoDict[@"CFBundleShortVersionString"];
    return varName_versionString;
}

#pragma mark 懒加载
/** manager属性的懒加载 */
-(AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}




@end
