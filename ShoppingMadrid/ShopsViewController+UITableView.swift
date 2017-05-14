import UIKit

extension ShopsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopTableViewCell
        
        //cell.textLabel?.text = self.fetchedResultsController.object(at: indexPath).name
        cell.shop = self.fetchedResultsController.object(at: indexPath)
        //cell.nameLabel.text = "Test"
        
        return cell
    }
    
}
