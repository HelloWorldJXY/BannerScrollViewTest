//
//  ViewController.swift
//  BannerScrollViewTest
//
//  Created by jiaxiaoyan on 16/4/28.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIScrollViewDelegate , pageScrollViewDelegate,BackForthScrollViewDelegate{
    
    @IBOutlet weak var bannerView: PageScrollView!//An infinite loop in a clockwise direction
    //    @IBOutlet weak var bannerView: BackForthScrollView! //Scroll back and forth
    //depends your demand

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let imageNameArray = ["http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg","http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg","http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg","http://ac-feqh9l4j.clouddn.com/05bac9a7badfdfb8.jpg"]// imageUrl or custom something else
        bannerView.initWithCustom(imageNameArray)
        bannerView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pageScrollViewTapWithIndex(index : Int){
        print(index)

    }
    func BackForthScrollViewTapWithIndex(index : Int)
    {
        
    }
}

