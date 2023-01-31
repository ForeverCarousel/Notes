//
//  MasterViewController.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-6.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "BasicViewController.h"
#import "LayerTreeViewController.h"
#import "BoardingFigureViewController.h"
#import "LayerOfGeometryViewController.h"
#import "VisualEffectViewController.h"
#import "CGAffineTransformViewController.h"
#import "SpecialLayerViewController.h"
#import "ImplicitAnimationViewController.h"
#import "ExplicitAnimationViewController.h"
#import "LayerTimeViewController.h"
#import "BufferViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //TableView不显示没内容的Cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self initData];
    
    [self.tableView reloadData];
}

- (void)initData
{
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects addObject:@"1-图层树"];
    [self.objects addObject:@"2-寄宿图"];
    [self.objects addObject:@"3-图层几何学"];
    [self.objects addObject:@"4-视觉效果"];
    [self.objects addObject:@"5-变换"];
    [self.objects addObject:@"6-专有图层"];
    [self.objects addObject:@"7-隐式动画"];
    [self.objects addObject:@"8-显式动画"];
    [self.objects addObject:@"9-图层时间"];
    [self.objects addObject:@"10-缓冲"];
    [self.objects addObject:@"11-基于定时器的动画"];
    [self.objects addObject:@"12-性能调优"];
    [self.objects addObject:@"13-高效绘图"];
    [self.objects addObject:@"14-图像IO"];
    [self.objects addObject:@"15-图层性能"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSString *object = self.objects[indexPath.row];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BasicViewController *viewC = nil;
    switch (indexPath.row)
    {
        case 0:
        {
            viewC = [[LayerTreeViewController alloc] initWithNibName:@"LayerTreeViewController" bundle:nil];
            break;
        }
        case 1:
        {
            viewC = [[BoardingFigureViewController alloc] initWithNibName:@"BoardingFigureViewController" bundle:nil];
            break;
        }
        case 2:
        {
            viewC = [[LayerOfGeometryViewController alloc] initWithNibName:@"LayerOfGeometryViewController" bundle:nil];
            break;
        }
        case 3:
        {
            viewC = [[VisualEffectViewController alloc] initWithNibName:@"VisualEffectViewController" bundle:nil];
            break;
        }
        case 4:
        {
            viewC = [[CGAffineTransformViewController alloc] initWithNibName:@"CGAffineTransformViewController" bundle:nil];
            break;
        }
        case 5:
        {
            viewC = [[SpecialLayerViewController alloc] initWithNibName:@"SpecialLayerViewController" bundle:nil];
            break;
        }
        case 6:
        {
            viewC = [[ImplicitAnimationViewController alloc] initWithNibName:@"ImplicitAnimationViewController" bundle:nil];
            break;
        }
        case 7:
        {
            viewC = [[ExplicitAnimationViewController alloc] initWithNibName:@"ExplicitAnimationViewController" bundle:nil];
            break;
        }
        case 8:
        {
            viewC = [[LayerTimeViewController alloc] initWithNibName:@"LayerTimeViewController" bundle:nil];
            break;
        }
        case 9:
        {
            viewC = [[BufferViewController alloc] initWithNibName:@"BufferViewController" bundle:nil];
            break;
        }
        case 10:
        {
            viewC = [[BoardingFigureViewController alloc] initWithNibName:@"BoardingFigureViewController" bundle:nil];
            break;
        }
        case 11:
        {
            viewC = [[BoardingFigureViewController alloc] initWithNibName:@"BoardingFigureViewController" bundle:nil];
            break;
        }
        case 12:
        {
            viewC = [[BoardingFigureViewController alloc] initWithNibName:@"BoardingFigureViewController" bundle:nil];
            break;
        }
        case 13:
        {
            viewC = [[BoardingFigureViewController alloc] initWithNibName:@"BoardingFigureViewController" bundle:nil];
            break;
        }
        case 14:
        {
            viewC = [[BoardingFigureViewController alloc] initWithNibName:@"BoardingFigureViewController" bundle:nil];
            break;
        }
        default:
        {
            viewC = [[BasicViewController alloc] init];
            break;
        }
    }
    [self.navigationController pushViewController:viewC animated:YES];
}

@end
