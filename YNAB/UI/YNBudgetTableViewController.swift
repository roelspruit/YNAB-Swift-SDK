//
//  YNBudgetTableViewController.swift
//  YNAB
//
//  Created by Roel Spruit on 24/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public class YNBudgetTableViewController: UITableViewController {
    
    private let client: YNABClient
    
    private var budgets = [BudgetSummary]()
    private var budgetSelected: (BudgetSummary) -> Void
    private var selectedBudget: BudgetSummary?
    
    public init(client: YNABClient, selectedBudget: BudgetSummary?, budgetSelected: @escaping (BudgetSummary) -> Void) {
        
        self.client = client
        self.budgetSelected = budgetSelected
        self.selectedBudget = selectedBudget
        
        super.init(style: .plain)
        
        self.title = NSLocalizedString("Select a budget", comment: "Budget list title")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                 target: self,
                                                                 action: #selector(cancel))
        
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
        
        client.getBudgets(completion: { [weak self] (budgets) in
            self?.budgets = budgets ?? []
            self?.tableView.reloadData()
        })
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let budget = budgets[indexPath.row]
        
        cell.textLabel?.text = budget.name
        cell.accessoryType = budget.id == selectedBudget?.id ? .checkmark : .none
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = budgets[indexPath.row]
        budgetSelected(budget)
        selectedBudget = budget
        tableView.reloadData()
        dismiss(animated: true, completion: nil )
    }
}
