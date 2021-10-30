import CoreData
import SwiftUI

struct AccountsListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            VStack {
                AccountsList()
                    .environment(\.managedObjectContext, viewContext)
                Spacer()
                addAccountButton()
            }.navigationTitle("Accounts")
        }
    }

    private func addAccountButton() -> some View {
        Button(action: addAccount) {
            Label("Add Account", systemImage: "plus")
        }.padding()
    }

    private func addAccount() {
        withAnimation {
            _ = Account.defaultAccount(in: viewContext)
            saveChanges()
        }
    }

    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AccountsList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Account.fetchRequest(.all))
    private var accounts: FetchedResults<Account>

    var body: some View {
        List {
            ForEach(accounts) { account in
                AccountView(account: account)
                    .contextMenu{
                        editButton(account)
                        deleteButton(account)
                    }
            }
            .onDelete(perform: deleteAccounts)
        }
    }

    private func editButton(_ account: Account) -> some View {
        Button {
            deleteAccount(account)
        } label: {
            Label("Edit Account", systemImage: "pencil")
        }
    }

    private func deleteButton(_ account: Account) -> some View {
        Button {
            deleteAccount(account)
        } label: {
            Label("Delete Account", systemImage: "trash")
        }
    }

    private func deleteAccounts(offsets: IndexSet) {
        withAnimation {
            offsets.map { accounts[$0] }.forEach(deleteAccount)
        }
    }

    private func deleteAccount(_ account: Account) {
        viewContext.delete(account)
        saveChanges()
    }

    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AccountView: View {
    let account: Account

    var body: some View {
        HStack {
            Image(systemName: "plus")
            Text(account.name)
            Spacer()
            Text(account.currency.sign ?? account.currency.code)
        }
    }
}

struct AccountsListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsListView()
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
