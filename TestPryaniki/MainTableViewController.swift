//
//  MainTableViewController.swift
//  TestPryaniki
//
//  Created by Russ Rosaura on 7/30/21.
//  Copyright © 2021 Russ Rosaura. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let baseURL = URL(string: "https://pryaniky.com/static/json/")!
    var welcome = [Welcome]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return welcome[0].view.count
    }

    func loadItems(){
        let itemsFileURL = baseURL.appendingPathComponent("sample").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: itemsFileURL), let stat = try? JSONDecoder().decode(Welcome.self, from: data) else { return }
        
        welcome.append(stat)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        var i = 0
        
        while i < welcome[0].view.count {
            if welcome[0].view[i] == "hz" && indexPath.row == i {
                if let correctId = getId(ofName: welcome[0].view[i]) {
                    cell.textLabel?.text = welcome[0].data[correctId].data.text
                }
            } else if welcome[0].view[i] == "picture" && indexPath.row == i {
                if let correctId = getId(ofName: welcome[0].view[i]), let img = welcome[0].data[correctId].data.url {
                    let task = URLSession.shared.dataTask(with: URL.init(string: img)!) { (data, response, error) in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.imageView?.image = image
                                if let text = self.welcome[0].data[correctId].data.text {
                                    cell.textLabel?.text = text
                                }
                            }
                        }
                    }
                    task.resume()
                }
            } else if welcome[0].view[i] == "selector" && indexPath.row == i {
                var j = 1
                if let correctId = getId(ofName: welcome[0].view[i]), let selId = welcome[0].data[correctId].data.selectedID, let vars = welcome[0].data[correctId].data.variants {
                    while j < vars.count {
                        if j == selId {
                            cell.textLabel?.text = vars[j].text
                        }
                        j += 1
                    }
                }
            }
            i += 1
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let correctId = getId(ofName: welcome[0].view[indexPath.row]) {
            let tappedCell = welcome[0].data[correctId].name
            var res = "Объект с именем \(tappedCell.uppercased()) инициировал событие."
            if let selId = welcome[0].data[correctId].data.selectedID {
                res += " Выбранный ID: \(selId + 1)"
            }
            print(res)
        }
    }
    
    func getId(ofName name: String) -> Int? {
        var i = 0
        while i < welcome[0].data.count {
            if name == welcome[0].data[i].name {
                return i
            }
            i += 1
        }
        return nil
    }
}
