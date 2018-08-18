# YNAB Swift SDK
This is an unofficial Swift SDK for the [YouNeedABudget (YNAB)](https://www.youneedabudget.com) API. Please be aware that this SDK is not supported in any way by YNAB itself. No guarantees can be made about its functionality. Improper use of this SDK might corrupt your YNAB budget data.

## Features

- Supports Authorization Code Grant to authorize a user
- Request data:
	- Budgets
	- Accounts
	- Categories
	- Transactions
- Create transactions
- Basic UI components:
	- Login
	- Select a budget
	- Select a category
	- Select a payee

## Requirements

- iOS 11.0+
- Xcode 9.4

## Installation
Cocoapods installation is not supported yet. Download the project and include it in your XCode workspace to use it.

## Basic Usage Example
``` Swift
// Ask the user to log into YNAB
let authorize = YNABLoginViewController(clientId: "CLIENTID", redirectUri: "REDIRECTURL") { (accessToken) in

	// Use returned accesstoken to create a YNAB client
	let ynab = YNABClient(accessToken: accessToken!)
	    
	// Use the client to request the desired data
	ynab.getBudgets { (budgets) in
	    // Use data
	}
}

// Present the login viewcontroller        
present(authorize, animated: true, completion: nil)
```
