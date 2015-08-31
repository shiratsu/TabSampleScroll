//
//  FirstViewController.swift
//  TabSampleScroll
//
//  Created by 平塚 俊輔 on 2015/08/02.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var cond_back_view: UIView!
    @IBOutlet weak var menu_view: UITableView!
    var array:NSMutableArray! = NSMutableArray()
    var previousScrollViewYOffset:CGFloat? = 0
    var tab_y:CGFloat!
    var tab_init_y:CGFloat!
    var tab_height:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None
        let tabframe = self.tabBarController?.tabBar.frame
        if tabframe != nil{
            
            self.tab_height = tabframe?.size.height
            self.tab_y = UIScreen.mainScreen().applicationFrame.size.height+20-self.tab_height
            //初期値として維持しておく
            self.tab_init_y = self.tab_y
            
            //tabframe?.origin.y = self.tab_y
            //self.tabBarController?.tabBar.frame = tabframe!
        }
        
        for var i = 0 ; i < 50 ; i++ {
            array.addObject("view "+String(i))
        }
        
        let nib  = UINib(nibName: "CustomCell", bundle:nil)
        self.menu_view.registerNib(nib, forCellReuseIdentifier:"CustomCell")
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return CGFloat.min
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return CGFloat.min
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        
        return 45
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return self.array.count
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cellの.を取得する.
        let icell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        icell.item_label.text = array.objectAtIndex(indexPath.row) as! String
        return icell
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        scrollControllNavication()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func scrollControllNavication(){
        //println(self.view.frame.origin.y)
        let scrollview = self.menu_view as UIScrollView
        
        var frame:CGRect? = self.navigationController?.navigationBar.frame
        var tabframe = self.tabBarController?.tabBar.frame
        var view_frame:CGRect? = self.view.frame
        if frame != nil && tabframe != nil && view_frame != nil{
            
            
            let size = frame!.size.height-21
            
            let scrolloffset = scrollview.contentOffset.y
            let scrollDiff:CGFloat = scrolloffset - self.previousScrollViewYOffset!
            let scrollHeight = scrollview.frame.size.height
            let scrollContentSizeHeight = scrollview.contentSize.height + scrollview.contentInset.bottom
            
            //最大動いてもいい高さを取得
            let max_tab_y = self.tab_y+self.tab_height
            
            if scrolloffset <= -scrollview.contentInset.top {
                
                frame?.origin.y = 20
                view_frame?.origin.y = 64
                tabframe?.origin.y = self.tab_y
                
            } else if (scrolloffset + scrollHeight) >= scrollContentSizeHeight {
                
                //上スクロール終了
                frame?.origin.y = -size
                view_frame?.origin.y = 20
                tabframe?.origin.y = max_tab_y
                
            } else {
                let y:CGFloat! = CGFloat(frame!.origin.y - scrollDiff)
                let tab_y:CGFloat! = CGFloat(tabframe!.origin.y + scrollDiff)
                
                frame?.origin.y = MIN(20, y: MAX(-size, y: y!))
                view_frame?.origin.y = frame!.origin.y+44
                tabframe?.origin.y = MAX(self.tab_y,y: MIN(max_tab_y, y: tab_y))
                
                let sabun = tabframe!.origin.y-(frame!.origin.y+44)
                view_frame?.size.height = sabun
                
            }
            
            
            self.view.frame = view_frame!
            self.navigationController?.navigationBar.frame = frame!
            self.previousScrollViewYOffset = scrolloffset
            self.tabBarController?.tabBar.frame = tabframe!
        }
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        //stoppedScrolling()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        if !decelerate {
            //stoppedScrolling()
        }
    }
    
    func MIN(x:CGFloat,y:CGFloat) -> CGFloat{
        if x >= y{
            return y
        }else{
            return x
        }
    }
    
    func MAX(x:CGFloat,y:CGFloat) -> CGFloat{
        if x >= y{
            return x
        }else{
            return y
        }
    }

    

}

