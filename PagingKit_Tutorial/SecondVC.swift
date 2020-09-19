//
//  SecondVC.swift
//  PagingKit_Tutorial
//
//  Created by Jeff Jeong on 2020/09/19.
//

import Foundation
import UIKit

class SecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondVC - viewDidLoad() called")
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        return cell
    }
    
    
}
