//
//  PageScrollView.swift
//  scrollViewTest
//
//  Created by jiaxiaoyan on 16/4/28.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

protocol pageScrollViewDelegate {
    func pageScrollViewTapWithIndex(index : Int)
}

class PageScrollView: UIView , UIScrollViewDelegate {
    
    
    var scrollView = UIScrollView()
    
    var pageController = UIPageControl()
    
    var dataSource = [String]()//custom image name Array
    
    var delegate : pageScrollViewDelegate?
    
    var timer = NSTimer()
    var timeInteval : Double = 3
    var animationTime : Double = 0.5
    var timerChange = false
    
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
            delegate.pageScrollViewTapWithIndex(pageController.currentPage)
        }
    }
    private   func initSrollView() {
        let width = UIScreen.mainScreen().bounds.width
        let height = frame.height
        scrollView.contentSize = CGSizeMake(width*CGFloat(dataSource.count + 2), height)
        scrollView.contentOffset = CGPointMake(width, 0)//设置初始内容偏移量
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
        for i in 0...dataSource.count + 1{
            var j = 0
            if i == 0 {
                j = dataSource.count-1
            }else if i == dataSource.count + 1{
                j = 0
            }else {
                j = i - 1
            }
                let imageView = UIImageView()
                let URL = NSURL(string: dataSource[j])!
                let placeholderImage = UIImage(named: "page-2-1")!
                imageView.af_setImageWithURL(
                    URL,
                    placeholderImage: placeholderImage,
                    filter: nil,
                    imageTransition: .CrossDissolve(0.2)
                )
                imageView.contentMode = UIViewContentMode.ScaleAspectFill
//
                imageView.frame = CGRectMake(CGFloat(width * CGFloat(i)), 0, width, height)
                scrollView.addSubview(imageView)
//
//            imageView.af_setImageWithURL(URL) //without placehoderImage

        }
    }
    
   
    func scrollViewDidScroll(scrollView: UIScrollView) {
        

        if timerChange  {
            return
        }
        var page = CGFloat(scrollView.contentOffset.x)
        var pagecontrollerCurrentPage = 0
        if page == 0{
            scrollView.setContentOffset(CGPointMake(scrollView.contentSize.width - 2 * self.bounds.size.width, 0), animated: false)
          pagecontrollerCurrentPage   = self.dataSource.count - 1
        }else if page == (scrollView.contentSize.width - self.bounds.size.width){
            scrollView.setContentOffset(CGPointMake( self.bounds.size.width, 0), animated: false)
            pagecontrollerCurrentPage = 0
        }else{
            page = (scrollView.contentOffset.x / self.bounds.size.width ) - 1
            pagecontrollerCurrentPage = Int(page)
        }
        pageController.currentPage = pagecontrollerCurrentPage
    }
    
    
    func initTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInteval, target: self, selector: #selector(PageScrollView.bannerTimer(_:)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func invalidateTimer() {
        timer.invalidate()
    }
    
    func bannerTimer(timer : NSTimer) {
        currentPage = pageController.currentPage

        currentPage += 1

        if currentPage == dataSource.count  {

            timerChange = true
            UIView.animateWithDuration(animationTime, animations: { () -> Void in
                self.scrollView.contentOffset = CGPointMake(CGFloat( 1 + self.currentPage) * self.bounds.size.width, 0)
                }, completion: { (success) -> Void in
                    self.currentPage = 0
                    self.scrollView.contentOffset = CGPointMake(CGFloat( 1 + self.currentPage) * self.bounds.size.width, 0)
                    self.pageController.currentPage =  self.currentPage
                    self.timerChange = false
            })
        }
       else{
            
            timerChange = false
            UIView.animateWithDuration(animationTime, animations: { 
                self.scrollView.setContentOffset(CGPointMake( self.bounds.size.width * CGFloat(self.currentPage + 1), 0), animated: false)
            })
        }
        
        pageController.currentPage = currentPage
        

    }
}
