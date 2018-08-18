//
//  YNPayeeTableViewController.swift
//  YNAB
//
//  Created by Roel Spruit on 23/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public class YNPayeeTableViewController: UITableViewController {
    
    private let client: YNABClient
    private var budgetId: String
    
    private var payees = [Payee]()
    private var payeeSelected: (Payee) -> Void
    private var selectedPayee: Payee?
    
    public init(client: YNABClient, budgetId: String, selectedPayee: Payee?, payeeSelected: @escaping (Payee) -> Void) {
        self.client = client
        self.payeeSelected = payeeSelected
        self.budgetId = budgetId
        self.selectedPayee = selectedPayee
        super.init(style: .plain)
        
        self.title = NSLocalizedString("Select a payee", comment: "Payee list title")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override init(style: UITableViewStyle) {
        fatalError("init(style:) has not been implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibNameOrNil:, nibBundleOrNil:) has not been implemented")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        client.getPayees(budgetId: budgetId, completion: { [weak self] (payees) in
            
            self?.payees = payees ?? []
            self?.tableView.reloadData()
        })
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payees.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let payee = payees[indexPath.row]
        
        cell.textLabel?.text = payee.name
        cell.accessoryType = payee.id == selectedPayee?.id ? .checkmark : .none
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payee = payees[indexPath.row]
        payeeSelected(payee)
        selectedPayee = payee
        tableView.reloadData()
        dismiss(animated: true, completion: nil )
    }
}
