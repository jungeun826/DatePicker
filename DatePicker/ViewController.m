//
//  ViewController.m
//  DatePicker
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/*datePicker 실습 oulet property*/
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *monthField;
@property (weak, nonatomic) IBOutlet UITextField *dayField;

/*datePicker와 timer실습 oulet property , 함수*/
@property (weak, nonatomic) IBOutlet UIDatePicker *timerPicker;
- (void)stopTimer;
- (void)startTimer;

/*datePicker와 actionSheet 실습 ouplet property*/
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController{
    NSTimer *timer;
    BOOL timerWorking;
}
- (IBAction)pickerChanged:(id)sender {
    NSLog(@"pickerChanged");
    NSDate *selectedDate = self.datePicker.date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger flag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:flag fromDate:selectedDate ];
    self.yearField.text = [NSString stringWithFormat:@"%ld", (long)[comp year]];
    self.monthField.text = [NSString stringWithFormat:@"%ld", (long)[comp month]];
    self.dayField.text = [NSString stringWithFormat:@"%ld", (long)[comp day]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*datePicker 실습 localValue*/
    self.yearField.enabled = NO;
    self.monthField.enabled = NO;
    self.dayField.enabled = NO;
    
    /*datePicker와 tiemr 실습 localValue*/
    timerWorking = NO;
    
    /*datePicker와 actionSheet 실습 localValue*/
    UIActionSheet *sheet;
    UIDatePicker *picker;
    NSDateFormatter *formmatter;
    float height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tickDown:(NSTimer *)timer{
    self.timerPicker.countDownDuration -=  60;
    if(self.timerPicker.countDownDuration <= 60){
        NSLog(@"Done!");
        [self stopTimer];
    }
}
- (void)stopTimer{
    [timer invalidate];
    timer = nil;
    timerWorking = NO;
}
- (void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(tickDown:) userInfo:nil repeats:YES];
}
- (IBAction)toggleTimer:(UIButton *)sender{
    NSString *title = timerWorking ? @"Start":@"Stop";
    [sender setTitle:title forState:UIControlStateNormal];
    timerWorking = !timerWorking;
    if( timerWorking)
        [self startTimer];
    else
        [self startTimer];
}
@end
