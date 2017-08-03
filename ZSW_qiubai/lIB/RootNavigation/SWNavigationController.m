//
//  SWNavigationController.m
//  SWNavigationViewCtrl
//
//  Created by iSongWei on 2016/11/7.
//  Copyright © 2016年 iSong. All rights reserved.
//

#import "SWNavigationController.h"
#import "UIViewController+SWNavigationExtension.h"
#import "UIBarButtonItem+Extension.h"

#define kDefaultBackImageName @"backImage"

#pragma mark - SWNavigationController
@interface SWNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation SWNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.SW_navigationController = self;
        rootViewController.automaticallyAdjustsScrollViewInsets = NO;
        self.viewControllers = @[[SWWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.SW_navigationController = self;
        self.viewControllers = @[[SWWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
}



#pragma mark - UINavigationControllerDelegate


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.SW_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的  ScrollView  时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)SW_viewControllers {
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (SWWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}


@end















#pragma mark - SWWrapNavigationController 导航栏的相关设置

@implementation SWWrapNavigationController

-(instancetype)init{
    if (self = [super init]) {
        UIColor * color = [UIColor blackColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
        self.navigationBar.titleTextAttributes = dict;
        self.navigationBar.translucent = NO;
//        self.navigationBar.barTintColor = BMCommonColor;
//        self.navigationBar.backgroundColor = BMCommonColor;
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
    
}



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}



- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SWNavigationController *SW_navigationController = viewController.SW_navigationController;
    
    NSInteger index = [SW_navigationController.SW_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:SW_navigationController.viewControllers[index] animated:animated];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.SW_navigationController = (SWNavigationController *)self.navigationController;
    
    viewController.SW_fullScreenPopGestureEnabled = viewController.SW_navigationController.fullScreenPopGestureEnabled;
    
    
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    UIImage *backButtonImage = viewController.SW_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
    }

    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"backImage" highImageName:nil title:@"返回" target:self action:@selector(didTapBackButton)];
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    [self.navigationController pushViewController:[SWWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
    
    

    
    
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.SW_navigationController=nil;
}

@end









#pragma mark - SWWrapViewController
static NSValue *SW_tabBarRectValue;


@interface SWWrapViewController ()

@property (nonatomic, strong) __kindof SWWrapNavigationController *contentViewController;

@end


@implementation SWWrapViewController

+ (SWWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    SWWrapNavigationController *wrapNavController = [[SWWrapNavigationController alloc] init];
    
    wrapNavController.viewControllers = @[viewController];
    //设置一张空的图片
    
    SWWrapViewController *wrapViewController = [[SWWrapViewController alloc] init];
    
    wrapViewController.contentViewController = wrapNavController;
//    [wrapViewController.view addSubview:wrapNavController.view];
 
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.view addSubview:self.contentViewController.view];
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !SW_tabBarRectValue) {
        SW_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && SW_tabBarRectValue) {
        self.tabBarController.tabBar.frame = SW_tabBarRectValue.CGRectValue;
    }else{
        self.tabBarController.tabBar.frame = CGRectMake(0, KScreenHeight - 49 , KScreenWidth, 49);
    }
    
}

- (BOOL)SW_fullScreenPopGestureEnabled {
    return [self rootViewController].SW_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    
    SWWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    
    return wrapNavController.viewControllers.firstObject;
    
}

@end









