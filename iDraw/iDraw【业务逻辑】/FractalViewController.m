//
//  FractalViewController.m
//  iDraw
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "FractalViewController.h"
#import "Canvas.h"

@interface FractalViewController ()
{
    NSArray *sectionNamesArr;
    
    NSArray *rowNameWithSectionArr;     // 二维
}

@end

@implementation FractalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // tableview 数据初始化
    {
        // 线条二叉树  正方形二叉树   Sierpinski三角形 Sierpinski三角形一笔画
        // peano曲线  aboresent肺  Mandelbrot集 Julia集 Koch雪花
        
        
        sectionNamesArr = @[@"树", @"三角形", @"曲线", @"Mandelbrot集"];
        
        rowNameWithSectionArr = @[@[@"线条二叉树", @"正方形二叉树"],
                                  @[@"Sierpinski三角形", @"Sierpinski三角形曲线", @"aboresent肺"],
                                  @[@"peano曲线", @"Koch雪花"],
                                  @[@"Mandelbrot集", @"Julia集" ]
                                  ];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
}


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

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionNamesArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rowNameWithSectionArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionNamesArr[section];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title = [@"      " stringByAppendingString:rowNameWithSectionArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *vc = [[UIViewController alloc] init];
    
    vc.title = rowNameWithSectionArr[indexPath.section][indexPath.row];
    
    Canvas *canvas = [[Canvas alloc] initWithFrame:vc.view.bounds ];
    
    canvas.controlStr = rowNameWithSectionArr[indexPath.section][indexPath.row];
    
    [canvas drawPicture];
    
    [vc.view addSubview:canvas];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
