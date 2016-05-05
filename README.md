# BannerScrollViewTest

CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:


$ gem install cocoapods


To integrate AlamofireImage into your Xcode project using CocoaPods, specify it in your Podfile:

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.1'
use_frameworks!
#Swift
pod 'Alamofire'
pod 'AlamofireImage'

Then, run the following command:

$ pod install


    @IBOutlet weak var bannerView: PageScrollView!//An infinite loop in a clockwise direction
    //depends your demand

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let imageNameArray = ["http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg","http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg","http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg","http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg"]// imageUrl or custom something else
        bannerView.initWithCustom(imageNameArray)
        bannerView.delegate = self
    }
