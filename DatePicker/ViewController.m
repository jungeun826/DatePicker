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
    /*datePicker와 tiemr 실습 localValue*/
    NSTimer *timer;
    BOOL timerWorking;
    
    /*datePicker와 actionSheet 실습 localValue*/
    UIActionSheet *sheet;
    UIDatePicker *picker;
    NSDateFormatter *formatter;
    float height;
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
    self.yearField.enabled = NO;
    self.monthField.enabled = NO;
    self.dayField.enabled = NO;
    
    timerWorking = NO;
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
/*timer에 따라 button의 출력값을 바꿔주고, 
 취해야 할 acitond을 실행해준다.*/
- (IBAction)toggleTimer:(UIButton *)sender{
    NSString *title = timerWorking ? @"Start":@"Stop";
    [sender setTitle:title forState:UIControlStateNormal];
    timerWorking = !timerWorking;
    if( timerWorking)
        [self startTimer];
    else
        [self startTimer];
}
-(void)handleDone:(id)sender{
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    
    if(formatter == nil){
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy년 MM월 dd일"];
    }
    NSDate *date = picker.date;
    NSString *dateStr = [formatter stringFromDate:date];
    [self.button setTitle:dateStr forState:UIControlStateNormal];
}
- (IBAction)chooseDate:(id)sender{
    CGSize viewSize = self.view.bounds.size;
    if(sheet == nil){
        sheet = [[UIActionSheet alloc]init];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,viewSize.width,44)];
        UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleDone:)];
        NSArray *items = [NSArray arrayWithObjects:done, nil];
        [toolbar setItems:items];
        picker = [[UIDatePicker alloc]init];
        picker.datePickerMode = UIDatePickerModeDateAndTime;
        picker.frame = CGRectMake(0,toolbar.frame.size.height, viewSize.width, picker.frame.size.height);
        
        [sheet addSubview:toolbar];
        [sheet addSubview:picker];
        
        [sheet showInView:self.view];
        
        height = toolbar.frame.size.height + picker.frame.size.height;
    }
    
    [sheet showInView:self.view];
    sheet.frame = CGRectMake(0, viewSize.height - height, viewSize.width, height);
}
@end
