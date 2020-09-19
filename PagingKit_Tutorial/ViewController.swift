//
//  ViewController.swift
//  PagingKit_Tutorial
//
//  Created by Jeff Jeong on 2020/09/19.
//

import UIKit
import PagingKit

class ViewController: UIViewController {

    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    static var sizingCell = TitleLabelMenuViewCell(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
//    static var sizingCell = MenuCell(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    
    var cellWidth = 100
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
           let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }
        
//    var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.blue)), (menuTitle: "test3", vc: viewController(.yellow))]
    
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData()
        self?.firstLoad = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 커스텀 메뉴
//        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        // 만들어져 있는 타이틀 메뉴
        menuViewController.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier: "titleLabelMenuCell")
        
        // 커스텀 포커스 뷰
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        // 만들어져 있는 포커스 뷰
//        menuViewController.registerFocusView(view: UnderlineFocusView())
        
        menuViewController.cellAlignment = .center
        dataSource = makeDataSource()
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let vc = segue.destination as? PagingMenuViewController {
             menuViewController = vc
             menuViewController.dataSource = self // <- set menu data source
             menuViewController.delegate = self
         } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
         }
     }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let myMenuArray = ["첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째","첫번째", "두번째", "세번째"]
        
        return myMenuArray.map{
            let title = $0
            
            switch title {
            case "첫번째":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menu: title, content: vc)
            case "두번째":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondVC") as! SecondVC
                return (menu: title, content: vc)
            case "세번째":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ThirdVC") as! ThirdVC
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menu: title, content: vc)
            }
            
        }
    }
    
    
}

// 메뉴 데이터 소스
extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        ViewController.sizingCell.titleLabel.text = dataSource[index].menu
//        return CGFloat(cellWidth)
        return CGFloat(cellWidth)
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
//        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "titleLabelMenuCell", for: index) as! TitleLabelMenuViewCell
        cell.titleLabel.text = dataSource[index].menu
        cell.titleLabel.textColor = .black
        return cell
    }
}

// 메뉴 컨트롤 델리겟
extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
    
    
    
}

// 컨텐트 데이터 소스. -내용
extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
    
    
}

// 컨텐트 컨트롤 델리겟
extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        // 내용이 스크롤 되면 메뉴를 스크롤 한다.
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
