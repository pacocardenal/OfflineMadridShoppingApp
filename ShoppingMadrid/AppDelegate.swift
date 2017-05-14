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
        //zapDataInCoreDataEntity(entity: "Shop")
        
        injectContextToFirstViewController()
        
        //testFunctions()
        
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
    
    func testFunctions() {
//        let url = "http://madrid-shops.com//media//shops//logo-cortefiel-200.jpg";
//        
//        let theFileName = (url as NSString).lastPathComponent
//        print(theFileName)
    }
    
    func zapDataInCoreDataEntity(entity: String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        let _ = try! context?.execute(request)
    }

}

