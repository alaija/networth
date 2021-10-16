import CoreData

extension Currency {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Currency> {
        let request = NSFetchRequest<Currency>(entityName: "Currency")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }

    static func defaultCurrency(in context: NSManagedObjectContext) -> Currency {
        let request = fetchRequest(NSPredicate(format: "isDefault = true"))
        if let account = try? context.fetch(request).first {
            return account
        }

        let currency = Currency(context: context)
        currency.name = "Russian Ruble"
        currency.code = "RUR"
        currency.sign = "₽"
        currency.isDefault = true
        return currency
    }

    var name: String {
        get { name_! }
        set { name_ = newValue }
    }

    var code: String {
        get { code_! }
        set { code_ = newValue }
    }

    var accounts: Set<Account> {
        get { (accounts_ as? Set<Account>) ?? [] }
        set { accounts_ = newValue as NSSet }
    }

    var exchangeRatesFrom: Set<ExchangeRate> {
        get { (exchangeRatesFrom_ as? Set<ExchangeRate>) ?? [] }
        set { exchangeRatesFrom_ = newValue as NSSet }
    }

    var exchangeRatesTo: Set<ExchangeRate> {
        get { (exchangeRatesTo_ as? Set<ExchangeRate>) ?? [] }
        set { exchangeRatesTo_ = newValue as NSSet }
    }
}
