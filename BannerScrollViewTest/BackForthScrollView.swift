//
//  BackForthScrollView.swift
//  BannerScrollViewTest
//
//  Created by jiaxiaoyan on 16/5/3.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

protocol BackForthScrollViewDelegate {
    func BackForthScrollViewTapWithIndex(index : Int)
}
class BackForthScrollView: UIView ,UIScrollViewDelegate {

    var scrollView = UIScrollView()
    
    var pageController = UIPageControl()
    
    var dataSource = [String]()//custom image name Array
    
    var delegate : BackForthScrollViewDelegate?
    
    var timer = NSTimer()
    var timeInteval : Double = 3
    var animationTime : Double = 0.5
    var directionChange = false
    
    var currentPage = 0
    //custom pageController frame
    var pageControllerBottomConstraint : CGFloat = 20
    var pageControllerHeight: CGFloat = 20
    var pageControllerWidth: CGFloat = 200
    
    
    func initWithCustom(sourceArray : [String]){ // code init
        scrollView.backgroundColor = UIColor.clearColor()
        pageController.backgroundColor = UIColor.clearColor()
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        scrollView.frame = CGRectMake(0, 0, screenWidth, frame.height)
        pageController.frame = CGRectMake(60, frame.height - pageControllerHeight - pageControllerBottomConstraint, pageControllerWidth, pageControllerHeight)
        self.addSubview(scrollView)
        self.addSubview(pageController)
        
        dataSource = sourceArray
        initSrollView()
        self.performSelector(#selector(PageScrollView.initTimer), withObject: nil, afterDelay: 2)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PageScrollView.tappedCallback(_:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    func tappedCallback(index : Int) {
        if let delegate = delegate  {
            delegate.BackForthScrollViewTapWithIndex(pageController.currentPage)
        }
    }
    private   func initSrollView() {
        let width = UIScreen.mainScreen().bounds.width
        let height = frame.height
        scrollView.contentSize = CGSizeMake(width*CGFloat(dataSource.count), height)
        scrollView.contentOffset = CGPointMake(0, 0)//设置初始内容偏移量
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true//设置分页显示
        
        pageController.numberOfPages = dataSource.count
        pageController.pageIndicatorTintColor = UIColor.yellowColor()
        pageController.currentPageIndicatorTintColor = UIColor.purpleColor()
        pageController.currentPage = 0
        if dataSource.count < 1 {
            return
        }
        for i in 0..<dataSource.count{
            let imageView = UIImageView()
            let URL = NSURL(string: dataSource[i])!
            let placeholderImage = UIImage(named: "page-2-1")!
            
            
            imageView.af_setImageWithURL(
                URL, 
                placeholderImage: placeholderImage,
                filter: nil,
                imageTransition: .CrossDissolve(0.2)
            )
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            
            imageView.frame = CGRectMake(CGFloat(width * CGFloat(i)), 0, width, height)
            scrollView.addSubview(imageView)
        }
        //            imageView.af_setImageWithURL(URL) //without placehoderImage

    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
       
        let width = scrollView.frame.size.width
        let contentoffsetX  = scrollView.contentOffset.x
        pageController.currentPage = Int(contentoffsetX/width)
    }
    
    
    func initTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInteval, target: self, selector: #selector(BackForthScrollView.bannerTimer(_:)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func invalidateTimer() {
        timer.invalidate()
    }
    
    func bannerTimer(timer : NSTimer) {
        currentPage = pageController.currentPage
        
        
        if currentPage == dataSource.count - 1 || currentPage == 0 {
            
            directionChange = !directionChange
        }
        if !directionChange {
            currentPage -= 1
        }else{
            currentPage += 1
        }
        
        UIView.animateWithDuration(animationTime, animations: {
            self.scrollView.setContentOffset(CGPointMake(CGFloat(self.currentPage)*self.scrollView.frame.size.width, 0), animated: false)
        })
        pageController.currentPage = currentPage
        
        
    }

}
