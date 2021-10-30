import CoreData

extension Account {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Account> {
        let request = NSFetchRequest<Account>(entityName: "Account")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }

    static func defaultAccount(in context: NSManagedObjectContext) -> Account {
        let request = fetchRequest(NSPredicate(format: "isDefault = true"))
        if let account = try? context.fetch(request).first {
            return account
        }

        let account = Account(context: context)
        account.name = "Default Account"
        account.currency = Currency.defaultCurrency(in: context)
        account.isDefault = true
        return account
    }

    var name: String {
        get { name_! }
        set { name_ = newValue }
    }

    var currency: Currency {
        get { currency_! }
        set { currency_ = newValue }
    }

    var transactionsFrom: Set<Transaction> {
        get { (transactionsFrom_ as? Set<Transaction>) ?? [] }
        set { transactionsFrom_ = newValue as NSSet }
    }

    var transactionsTo: Set<Transaction> {
        get { (transactionsTo_ as? Set<Transaction>) ?? [] }
        set { transactionsTo_ = newValue as NSSet }
    }
}
