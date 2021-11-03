//
//  ViewController.swift
//  ShoppingList
//
//  Created by 김승찬 on 2021/11/03.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let localRealm = try! Realm()
    var tasks : Results<Product>!
    
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var productTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        assignDelegation()
        registerXib()
        changeTextFeildAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = localRealm.objects(Product.self)
        print("Realm:",localRealm.configuration.fileURL!)
        
    }
    
    func setUI() {
        addButton.layer.cornerRadius = 5
    }
    
    func assignDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerXib() {
        let nibName = UINib(nibName: "ShoppingTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ShoppingTableViewCell")
    }
    
    private func changeTextFeildAttributes() {
        productTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    private func setTextField(Bool: Bool, String: String) {
        addButton.isEnabled = Bool
        productTextField.placeholder = String
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = productTextField.text?.count else { return }
        if text == 0 {
            setTextField(Bool: false, String: "품목을 입력해주세요!")
        } else {
            setTextField(Bool: true, String: "무엇을 사실 건가요?")
        }
    }
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        let task = Product(productTitle: productTextField.text!)
        try! localRealm.write {
            localRealm.add(task)
        }
        tableView.reloadData()
    }
    
    @IBAction func touchListButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "정렬하시겠어요?", message: "", preferredStyle: .actionSheet)
        
        let starAction = UIAlertAction(title: "즐겨찾기", style: .default, handler: {_ in
            try! self.localRealm.write {
                self.tasks = self.tasks.sorted(byKeyPath: "isStared", ascending : false)
                self.tableView.reloadData()
            }
        })
        
        let didWorkAction = UIAlertAction(title: "할 일 기준", style: .default, handler: {_ in
            try! self.localRealm.write {
                self.tasks = self.tasks.sorted(byKeyPath: "isChecked", ascending : true)
                self.tableView.reloadData()
            }
        })
        
        let titleAction = UIAlertAction(title: "제목", style: .default, handler: {_ in
            try! self.localRealm.write {
                self.tasks = self.tasks.sorted(byKeyPath: "productTitle", ascending : true)
                self.tableView.reloadData()
            }
        })
        
       let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(starAction)
        alert.addAction(didWorkAction)
        alert.addAction(titleAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tasks.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.identifier) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        let check: UIButton = cell.checkButton
        let star: UIButton = cell.starButton
        cell.productLabel.text = row.productTitle
        
        if row.isChecked == 0 {
            check.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            check.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        if row.isStared == 0 {
            star.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            star.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
        check.tag = indexPath.row
        star.tag = indexPath.row
        
        check.addTarget(self, action: #selector(checkButtonClicked(selected:)), for: .touchUpInside)
        star.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func checkButtonClicked(selected: UIButton) {
        
        let task = tasks[selected.tag]
        
        try! localRealm.write {
            task.isChecked = (task.isChecked + 1) % 2
        }
        tableView.reloadData()
    }
    
    @objc func starButtonClicked(selected: UIButton) {

        let task = tasks[selected.tag]
        
        try! localRealm.write {
            task.isStared = (task.isStared + 1) % 2
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "쇼핑 리스트를 수정하시겠어요?", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
            guard let text = alert.textFields?[0].text else { return }
            
            let taskToUpdate = self.tasks[indexPath.row]
            
            try! self.localRealm.write {
                taskToUpdate.productTitle = "\(text)"
                
            }
            tableView.reloadData()
        }
    
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        try! localRealm.write {
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
}
