# XJNetWorking
## XJNetWorking介绍
`XJNetWorking`是基于`AFNetworking`封装的iOS网络请求库，提供了更高层次的网络访问抽象。一般作为网络请求基类出现,是一种集约式的网络库。

### 关于集约式和离散式
#### 集约式
项目中的每个请求都会走统一的入口，对外暴露了请求的URL和Param以及请求的方式，入口一般都是通过单例来实现的，AFNetworking的官方demo就是采用的集约式的方式对网络请求进行的封装，也是目前比较流行的网络请求方式。

优点

- 使用便捷 ，能实现快速开发

缺点

- 对每个请求的定制型不够强，每个网络请求自由度不高
- 不方便后期业务扩大的扩展

#### 离散式
即每个网络请求类都是一个对象，他的URL以及请求方式和响应的方式均不暴露在外部赋值调用。只能内部通过`重载或实现协议`的方式来实现，外部调用只需要传Param即可，YTKNetwork就是采用的这种网络请求方式。

优点

- URL以及请求和响应的方式不暴露给外部，避免外部调用的时候写错。
- 业务方面使用起来比较简单，业务使用者不需要去关心他的内部实现
- 可定制性强，可以为每个网路请求设置指定的超时时间等。

缺点

- 网络层需要业务实现去写，变相增加了部分工作量（因为自由度高）

#### 关于集约式和离散式的思考
离散式的网络请求适合项目稍微复杂，人数多的公司去使用。因为项目复杂的话，在跟服务器对接的时候可能会出现各种不同的需求，适合各种人去各种实现。

集约式的网路网络请求适合项目相对简单，创业型公司去使用。因为创业型公司项目都是起步阶段，一般项目刚开始简单，对开发速度要求比较高，因此适合这种统一管理的请求，即便是有个别特需也很可以特别对待就OK了。

## XJNetWorking 的使用

XJNetWorking 包括以下几个基本的类：

- `XJRequestBasicConfig`类：用于统一设置网络请求的服务器、公共参数和网络结果解析设置
- `XJBaseDataSource`类: 所有的网络请求按业务需求模块继承此类，将模块的网络请求包装进此子类中。
- `XJRequestConfig`类：每个网络请求的信息，包括请求URL，参数，请求方式等
- `<XJRequestResultProtocol>`类：每个网络请求的结果都以此类型传递给外部

接下来，我们接下他们的详细作用。
我们需要在APP启动的时候，设置好网络请求的配置。例如：

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   XJRequestBasicConfig * basicConfig = [XJRequestBasicConfig sharedConfig];
    [basicConfig setBaseURL:@"http://baidu.com" forPlantform:XJDevelopPlantformRelease];
    [basicConfig setBaseURL:@"http://develop.baidu.com" forPlantform:XJDevelopPlantformDebug];
    [basicConfig setBaseURL:@"http://test.baidu.com" forPlantform:XJDevelopPlantformTest];
    [basicConfig setBaseURL:@"http://uat.baidu.com" forPlantform:XJDevelopPlantformUAT];
    
    basicConfig.publicParameter = @{@"version":@"1.0"};
}
```
在`XJBaseDataSource`的子类中创建网络请求即可，例如：

```
- (void)loginWithUserName:(NSString *)name password:(NSString *)password complete:(void(^)(NSObject * userInfo))complete {
    XJRequestConfig * config = [XJRequestConfig config];
    config.requestURL = @"user/login";
    config.paramDic = @{@"name":name,
                        @"pwd":password,
                        };
    config.mappingModel = [NSObject class];//这里应该是UserInfoModel 啦，如果不设置就是不映射。以原数据返回
    [self.requestService sendRequestWithConfig:config complete:^(id<XJRequestResultProtocol> result) {
        if (result.isSuccess) {
            complete(result.modelInfo);
        }else{
            NSLog(@"请求失败：%@",result.errorMsg);
            complete(nil);
        }
    }];
}
```
## XJNetWorking的一些说明
1. XJNetWorking适合创业初期的App,要求快速开发的
2. XJNetWorking目前没支持到数据缓存，因为大多缓存都想自己做，这里就没实现。以后可能会考虑加上
3. XJNetWorking目前没支持跟UIKit上挂钩，弹出提示框都需要外面自己设置，大多公司都有自己的一套弹窗设计。以后会考虑加上
4. 想加的东西有很多人会用不到，而又徒增类文件，因此会考虑增加的时候，可以随时删除，不影响此库
