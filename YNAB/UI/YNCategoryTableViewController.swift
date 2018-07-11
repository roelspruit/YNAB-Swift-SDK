//
//  YNCategoryTableViewController.swift
//  YNAB
//
//  Created by Roel Spruit on 10/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import UIKit

public class YNCategoryTableViewController: UITableViewController {

    private let client: YNABClient
    private var budgetId: String
    private let hideInternal: Bool
    
    private var categoryGroups = [CategoryGroup]()
    private var categories = [Category]()
    private var categorySelected: (Category) -> Void
    
    public init(client: YNABClient, budgetId: String, hideInternal: Bool = true, categorySelected: @escaping (Category) -> Void) {
        self.client = client
        self.categorySelected = categorySelected
        self.budgetId = budgetId
        self.hideInternal = hideInternal
        super.init(style: .plain)
        
        self.title = NSLocalizedString("Categories", comment: "Category list title")
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
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

        client.getCategories(budgetId: budgetId) { [weak self] (groups) in

            guard let hideInternal = self?.hideInternal else {
                return
            }
            
            self?.categories = groups?
                .filter({(hideInternal && !$0.name.contains("Internal Master")) || !hideInternal})
                .flatMap({$0.categories})
                .filter({!$0.hidden}) ?? []
            
            self?.categoryGroups = groups ?? []
            self?.tableView.reloadData()
        }
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let category = categories[indexPath.row]
        let group = categoryGroups.first(where: {$0.id == category.category_group_id})!
        
        cell.textLabel?.text = "\(category.name) (\(group.name))"

        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        categorySelected(category)
        navigationController?.popViewController(animated: true)
    }
}
