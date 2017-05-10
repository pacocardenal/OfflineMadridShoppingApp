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
        testCoreData()
        
        return true
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

