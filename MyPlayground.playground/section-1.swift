// Playground - noun: a place where people can play

import UIKit

var label:UILabel
var label1:UILabel
var view:UIView
var btn:UIButton
label = UILabel(frame:CGRectMake(0, 50, 320, 70))
label.backgroundColor = UIColor.blueColor()

view = UIView(frame:CGRectMake(0, 100, 320, 100))
view.backgroundColor = UIColor.cyanColor();

label1 = UILabel(frame:CGRectMake(0, 0, 320, 70))
label1.backgroundColor = UIColor.blueColor()
label.textColor = UIColor.blackColor()
label1.text = "hehehehaaaaaaaaaaaaaaaaaaaa"
label.textAlignment = NSTextAlignment.Right
view.addSubview(label1)

btn = UIButton.buttonWithType(UIButtonType.System) as UIButton
btn.frame = CGRectMake(0, 0, 100, 50)
btn.backgroundColor = UIColor.greenColor()


var label2 = UILabel(frame:CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(150, 30)))
label2.text = "asdadasd"


