//
//  ViewController.swift
//  TestPryaniki
//
//  Created by Russ Rosaura on 7/30/21.
//  Copyright © 2021 Russ Rosaura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let baseURL = URL(string: "https://pryaniky.com/static/json/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    func loadItems() {
        let itemsFileURL = baseURL.appendingPathComponent("sample").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: itemsFileURL) else { return }
        
        let stat = try! JSONDecoder().decode(Result.self, from: data)
        // dump(stat)
        for elem in stat.view {
            for elem2 in stat.data {
                if elem == elem2.name {
                    print(elem2.data.selectedID)
                }
            }
        }
    }

}

