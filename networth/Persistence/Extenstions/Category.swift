import CoreData

extension Category {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Category> {
        let request = NSFetchRequest<Category>(entityName: "Category")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }

    var name: String {
        get { name_ ?? "Default category" }
        set { name_ = newValue }
    }

    var transactions: Set<Transaction> {
        get { (transactions_ as? Set<Transaction>) ?? [] }
        set { transactions_ = newValue as NSSet }
    }
}
