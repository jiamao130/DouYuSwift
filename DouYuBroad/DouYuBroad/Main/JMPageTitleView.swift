//
//  JMPageTitleView.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/9.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class{
    func PageTitleView(titleView:JMPageTitleView,selectIndex index: Int)
}

private let kScrollLineH: CGFloat =  2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class JMPageTitleView: UIView {
    
    fileprivate var titles: [String]
    fileprivate var currentIndex: Int = 0
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    weak var delegate: PageTitleViewDelegate?
    //懒加载属性
    fileprivate lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    //自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been implemented")
    }

}

extension JMPageTitleView{
    
    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabel()
        //设置底线与滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupBottomLineAndScrollLine(){
        
        //添加底线
        let bottomLine =  UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加滑块线
        guard let firstLebl = titleLabels.first else {return}
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLebl.frame.origin.x, y: frame.height-kScrollLineH, width: firstLebl.frame.width, height: kScrollLineH)
    }
    
    private func setupTitleLabel(){
        
        
        let labelW: CGFloat = frame.width/CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX: CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    
}

extension JMPageTitleView{
    
    @objc fileprivate func titleLabelClick(tapGes:UITapGestureRecognizer){
        
        
        //获取当前lable的下标
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        if  currentLabel.tag == currentIndex{
            return
        }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        currentIndex = currentLabel.tag
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        delegate?.PageTitleView(titleView: self, selectIndex: currentIndex)
    }
}

extension JMPageTitleView{
    func setTitleWithProgres(progress: CGFloat,sourceIndex: Int,targetIndex: Int){
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
    }
}
