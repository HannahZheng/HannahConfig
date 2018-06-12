//
//  HannahMacro.h
//  GlobalTimes
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 Hannah. All rights reserved.
//

#ifndef HannahMacro_h
#define HannahMacro_h

#define APP_ID @"1139158081"
#define APP_CheckURL(appId) [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",appId]
#define APP_DownloadURL(appId) [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8",appId]

/******* 日志打印替换 *******/
#ifdef DEBUG
// Debug
#define HHLog(FORMAT, ...) fprintf(stderr, "%s [%d lines] %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


#else
// Release
#define HHLog(FORMAT, ...) nil

#endif

/** APP版本号 */
#define HHAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** APP BUILD 版本号 */
#define HHAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//(NSString*) kCFBundleVersionKey
/** APP名字 */
#define HHAppDisplayName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
/** 当前语言 */
#define HHLocalLanguage [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]
/** 当前国家 */
#define HHLocalCountry [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]

/******* 设备型号和系统 *******/
#define HHDevice [UIDevice currentDevice]
#define HHDeviceName HHDevice.name                           // 设备名称
#define HHDeviceModel HHDevice.model                         // 设备类型
#define HHDeviceLocalizedModel HHDevice.localizedModel       // 本地化模式
#define HHDeviceSystemName HHDevice.systemName               // 系统名字
#define HHDeviceSystemVersion HHDevice.systemVersion         // 系统版本
#define HHDeviceOrientation HHDevice.orientation             // 设备朝向
#define HHDeviceUUID HHDevice.identifierForVendor.UUIDString // UUID
#define HHiOS8 ([HHDeviceSystemVersion floatValue] >= 8.0)   // iOS8以上
#define HHiOS9 ([HHDeviceSystemVersion floatValue] >= 9.0)   // iOS9以上
#define HHiOS10 ([HHDeviceSystemVersion floatValue] >= 10.0)   // iOS10以上
#define HHiOS11 ([HHDeviceSystemVersion floatValue] >= 11.0)   // iOS11以上

#define HHiPhone ([HHDeviceModel rangeOfString:@"iPhone"].length > 0)
#define HHiPod ([HHDeviceModel rangeOfString:@"iPod"].length > 0)
#define HHiPad (HHDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)


#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

/******* 设备型号和系统 *******/

/***** 屏幕适配 *****/
#define HHUIScreenScale  ([[UIScreen mainScreen] scale])
#define HHIsLandscape   (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

#define HHRETINA          (HHUIScreenScale >= 2)
// iphone 6以上的scale叫做RETINAHD好了
#define HHRETINAHD        (HHUIScreenScale >= 3)
// 当前屏幕的宽度和高度，已经考虑旋转的因素(iOS8上[UIScreen mainScreen].bounds直接就考虑了旋转因素，iOS8以下[UIScreen mainScreen].bounds是不变的值)
#define HHUIScreenWidth    ((!HHIsLandscape) ?[UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)
#define HHUIScreenHeight   ((!HHIsLandscape) ?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)

#define HHMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define HHMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define HHMainScreenBounds [UIScreen mainScreen].bounds

//用分辨率做屏幕的适配（基于6s）
#define kMaxOfWOrH MAX(HHMainScreenWidth, HHMainScreenHeight)
#define kMinOfWOrH MIN(HHMainScreenWidth, HHMainScreenHeight)
/**
 *   高度 * 屏幕高 / 1334
 */
#define kRelativeHeight(h) ((h) * kMaxOfWOrH / 667.0)
/**
 *   宽度 * 屏幕宽 / 750
 */
#define kRelativeWidth(w) ((w) * kMinOfWOrH / 375.0)
#define kRelativeAvaliableHeight(h) ((h)*HHNormalAvaliableHeight/568.0)
#define HHRelativeHeight(h) ((h)*HHUIScreenHeight/568.0)

#define kRelativeFontSize(fs) (fs * kMinOfWOrH / 375.0)
#define kFont(fs) [UIFont systemFontOfSize:kFontSize(fs)]
#define kFontSize(fs) (HHMainScreenWidth == 320?kRelativeFontSize(fs):fs)
#define HHFontName @"Heiti SC"
//不同设备的字号比例(当然倍数可以自己控制)
#define HHFont(fs) [UIFont systemFontOfSize:fs]
#define HHFontHeight(fs) [UIFont systemFontOfSize:fs].lineHeight

#define kWidth(w) (HHMainScreenWidth == 320?kRelativeWidth(w):(w))
#define kHeight(h) (HHMainScreenWidth == 320?kRelativeHeight(h):(h))

#define kWidthPercent kMinOfWOrH / 375.0
#define kHeightPercent kMaxOfWOrH / 667.0





//手动布局view起始Y坐标
#define HHViewStartOffsetY HHIsLandscape ? 52:64
#define HHTopbarTotalHeight ([[UIApplication sharedApplication] statusBarFrame].size.height+44)
#define HHNavBarHeight  44
#define HHStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define HHPixel (1.0/[[UIScreen mainScreen] scale])

#define HHSafeAreaBottomHeight ({CGFloat i; if(@available(iOS 11.0, *)) {i = HHKeyWindow.safeAreaInsets.bottom;} else {i = 0;} i;})
//- (void)viewSafeAreaInsetsDidChange在UIViewController中第一次调用的时间是在- (void)viewWillAppear:(BOOL)animated调用之后, 在- (void)viewWillLayoutSubviews调用之前.
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

#define HHNormalAvaliableHeight (HHMainScreenHeight-HHSafeAreaBottomHeight-HHTopbarTotalHeight)

#define HHiPhoneX (HHMainScreenHeight == 812)
#define HHiPhone4 (HHMainScreenHeight == 480)
/***** 屏幕适配 *****/


#define HH_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

#define HH_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;

/******* 通知中心 *******/
#define HHNotificationCenter [NSNotificationCenter defaultCenter]
/******* UserPlist *******/
#define HHUserDefaults [NSUserDefaults standardUserDefaults]
/******* 根Window *******/
#define HHKeyWindow [UIApplication sharedApplication].keyWindow
/******* 根视图 *******/
#define HHRootViewController HHKeyWindow.rootViewController






//弱引用和弱引用
#define HHWeakSelf(weakSelf) __weak typeof(&*self) weakSelf = self;
#define HHStrongSelf(strongSelf) __strong typeof(&*weakSelf) strongSelf = weakSelf;

#ifndef	 axc_weakify_self
#if __has_feature(objc_arc)
#define axc_weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define axc_weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif

#ifndef	 axc_strongify_self
#if __has_feature(objc_arc)
#define axc_strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define axc_strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif



/*** 取 View的坐标和宽高 ***/
#define HHGet_W(view) view.frame.size.width
#define HHGet_H(view) view.frame.size.height
#define HHGet_X(view) view.frame.origin.x
#define HHGet_Y(view) view.frame.origin.y

#define Mix(a,b) (((a) <= (b))?(a):(b))
#define Max(a,b) (((a) >= (b))?(a):(b))

// 是否为空对象
#define HHObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define HHStringIsEmpty(__string) ((__string.length == 0) || HHObjectIsNil(__string))
//字符串不为空
#define HHIsStrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])

// 数组为空
#define HHArrayIsEmpty(__array) ((HHObjectIsNil(__array)) || (__array.count==0))


/*** 沙盒路径 ***/
#define HHHomePath NSHomeDirectory()
#define HHCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define HHDocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define HHTemporaryPath NSTemporaryDirectory()

//获取工程中plist文件的路径
#define HHPlistPath(fileName) [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"]
//获取Caches中的Plist文件夹下的plist文件路径
#define HHSortPlistPath(plistName) [CachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Plist/%@.plist",plistName]]

/***** 组件中的图片及xib或者字体加载 *****/

#define HHCurrentBundle [NSBundle bundleForClass:[self class]]
#define HHBundleImage(name) [UIImage imageNamed:name inBundle:HHCurrentBundle compatibleWithTraitCollection:nil]
#define HHBundleFilePath(fileName,bundleName)  [HHCurrentBundle pathForResource:fileName ofType:nil inDirectory:bundleName]
#define HHBundleNib(bibName) [[NSBundle bundleForClass:[self class]] loadNibNamed:nibName owner:self options:nil].lasObject]


// 设置颜色
#define HHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define HHRandomColor HHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//可设置透明度及颜色
#define HHAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


//十六进制设置转化为UIColor eg:0xff098a
#define HEX2UICOLOR(hexValue) [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16)/255.0 green:((hexValue & 0xFF00) >> 8)/255.0 blue:((hexValue & 0xFF))/255.0 alpha:1.0]

#define HEXA2UICOLOR(hexValue,a) [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16)/255.0 green:((hexValue & 0xFF00) >> 8)/255.0 blue:((hexValue & 0xFF))/255.0 alpha:(CGFloat)a]



// 16进制转uicolor 支持@“#123456”、 @“0X123456”、 @“123456”三种格式

#define HEXTOUICOLOR(hexValue) [UIColor colorWithHexString:hexValue]

#endif /* HannahMacro_h */
