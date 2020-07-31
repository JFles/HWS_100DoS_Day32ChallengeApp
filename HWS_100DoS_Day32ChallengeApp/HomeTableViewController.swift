//
//  HomeTableViewController.swift
//  HWS_100DoS_Day32ChallengeApp
//
//  Created by Jeremy Fleshman on 7/29/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
  // MARK: - Properties

  @IBOutlet var uiview: UIView!

  var shoppingItems = [String]()

  // MARK: - Lifecycle methods

  override func viewDidLoad() {
    super.viewDidLoad()

    configureNavigationBar()
  }

  fileprivate func configureNavigationBar() {
    title = "Shopping list"

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addItem)
    )

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .trash,
      target: self,
      action: #selector(resetList)
    )
  }

  // MARK: Selector methods

  @objc func addItem() {
    let alert = UIAlertController(
      title: "Add item to list?",
      message: nil,
      preferredStyle: .alert
    )

    let addAction = UIAlertAction(title: "Add", style: .default) {
      [weak self] _ in guard let strongSelf = self else { return }

      if let item = alert.textFields?[0].text, !item.isEmpty {
        strongSelf.shoppingItems.insert(item, at: 0)
        strongSelf.tableView.insertRows(
          at: [IndexPath(row: 0, section: 0)],
          with: .automatic
        )
      }
    }

    let cancelAction = UIAlertAction(
      title: "Cancel",
      style: .cancel,
      handler: nil
    )

    alert.addTextField(configurationHandler: nil)
    alert.addAction(addAction)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  }

  @objc func resetList() {
    let alert = UIAlertController(
      title: "Reset the list?",
      message: "This will delete all current shopping items",
      preferredStyle: .alert
    )

    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
      [weak self] _ in guard let strongSelf = self else { return }

      strongSelf.shoppingItems = []
      strongSelf.tableView.reloadData()
    }

    let cancelAction = UIAlertAction(
      title: "Cancel",
      style: .cancel,
      handler: nil
    )

    alert.addAction(cancelAction)
    alert.addAction(deleteAction)

    present(alert, animated: true)
  }
}

// MARK: - UITableView methods

extension HomeTableViewController {
  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    shoppingItems.count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "Item",
      for: indexPath
    )

    cell.textLabel?.text = shoppingItems[indexPath.row]

    return cell
  }
}
