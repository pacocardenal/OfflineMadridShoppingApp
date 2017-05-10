import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let container = persistentContainer(dbName: "ShoppingMadrid") { (error: NSError) in
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        self.context = container.viewContext
        injectContextToFirstViewController()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else { return }
        saveContext(context: context)
    }
    
    func injectContextToFirstViewController() {
        if let navController = window?.rootViewController as? UINavigationController,
            let initialViewController = navController.topViewController as? ViewController
        {
            initialViewController.context = self.context
        }
    }
    
    func testCoreData() {
        let shop1 = Shop(context: self.context!)
        shop1.name = "Uno"
        do {
            try self.context?.save()
        } catch {
            
        }
    }

}

