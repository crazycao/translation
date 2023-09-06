# Quick Start 快速入门

原文地址：[https://www.mongodb.com/docs/realm/sdk/swift/quick-start/](https://www.mongodb.com/docs/realm/sdk/swift/quick-start/)

This Quick Start demonstrates how to use Realm with the Realm Swift SDK. Before you begin, ensure you have Installed the Swift SDK.

这个快速入门演示了如何将 Realm 与 Realm Swift SDK 一起使用。在开始之前，请确保您已安装 Swift SDK。

> *TIP*
> 
> **See also:**
> 
> If your app uses SwiftUI, check out the SwiftUI Quick Start.
> 
> 如果您的应用程序使用 SwiftUI，请查看SwiftUI快速入门。

## Import Realm - 导入 Realm

Near the top of any Swift file that uses Realm, add the following import statement:

在任何使用 Realm 的 Swift 文件的顶部附近，添加以下导入语句：

```
import RealmSwift
```

## Define Your Object Model - 定义对象模型

For a local-only realm, you can define your object model directly in code. In this quick start, you can remove `ownerId` unless you want to add the optional Device Sync.

对于仅限本地的 realm，可以直接在代码中定义对象模型。在此快速入门中，如果您不想添加可选的设备同步，您可以删除 `ownerId`。

```
class Todo: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var status: String = ""
   @Persisted var ownerId: String
   convenience init(name: String, ownerId: String) {
       self.init()
       self.name = name
       self.ownerId = ownerId
   }
}
```

## Open a Realm - 打开 Realm

In a local-only realm, the simplest option to open a realm is to use the default realm with no configuration parameter:

在仅限本地的 realm 中，打开 realm 的最简单方式是使用不带配置参数的默认 realm：

```
// Open the local-only default realm
// 打开一个仅限本地的默认 realm
let realm = try! Realm()
```

You can also specify a `Realm.Configuration` parameter to open a realm at a specific file URL, in-memory, or with a subset of classes.

你也可以指定一个 `Realm.Configuration` 参数来在文件URL、内存或类的子集中打开一个 realm。

For more information, see: _Configure and Open a Realm_.

更多信息，参见《配置和打开 Realm》。

## Create, Read, Update, and Delete Objects - 创建、读取、更新和删除对象

Once you have opened a realm, you can modify it and its objects in a write transaction block.

一旦打开了一个 realm，就可以在写事务块中修改它及其对象。

To create a new `Todo` object, instantiate the `Todo` class and add it to the realm in a write block:

要创建新的 `Todo` 对象，请实例化 `Todo` 类并在写块中将其添加到领域：

```
let todo = Todo(name: "Do laundry", ownerId: user.id)
try! realm.write {
    realm.add(todo)
}
```

You can retrieve a live collection of all todos in the realm:

你可以检索在 realm 中的所有 `todos` 的实时集合：

```
// Get all todos in the realm
// 获取 realm 中的所有 todos
let todos = realm.objects(Todo.self)
```

You can also filter that collection using `where`:

你也可以使用 `where` 过滤该集合：

```
let todosInProgress = todos.where {
    $0.status == "InProgress"
}
print("A list of all todos in progress: \(todosInProgress)")
```

To modify a todo, update its properties in a write transaction block:

要修改 `todo`，可以在写事务块中更新它的属性：

```
// All modifications to a realm must happen in a write block.
// 对 realm 的所有修改都必须放在写块中
let todoToUpdate = todos[0]
try! realm.write {
    todoToUpdate.status = "InProgress"
}
```

Finally, you can delete a todo:

最后，你可以删除 `todo`：

```
// All modifications to a realm must happen in a write block.
// 对 realm 的所有修改都必须放在写块中
let todoToDelete = todos[0]
try! realm.write {
    // Delete the Todo.
    realm.delete(todoToDelete)
}
```

## Watch for Changes - 监听修改

You can watch a realm, collection, or object for changes with the `observe` method.

你可以使用 `observe` 方法监听 realm、集合或对象的变更。

```
// Retain notificationToken as long as you want to observe
// 只要你想监听，就要一直持有 notificationToken
let notificationToken = todos.observe { (changes) in
    switch changes {
    case .initial: break
        // Results are now populated and can be accessed without blocking the UI
        // 结果现在已填充，并且可以在不阻塞UI的情况下访问
    case .update(_, let deletions, let insertions, let modifications):
        // Query results have changed.
        // 查询的结果已经变更
        print("Deleted indices: ", deletions)
        print("Inserted indices: ", insertions)
        print("Modified modifications: ", modifications)
    case .error(let error):
        // An error occurred while opening the Realm file on the background worker thread
        // 在后台工作线程上打开Realm文件时出错
        fatalError("\(error)")
    }
}
```

Be sure to retain the notification token returned by `observe` as long as you want to continue observing. When you are done observing, invalidate the token to free the resources:

只要你想继续观察，请确保保留 `observe` 返回的通知令牌。完成观察后，使令牌无效以释放资源：

```
// Invalidate notification tokens when done observing
// 完成观察后，使令牌无效
notificationToken.invalidate()
```

## Add Device Sync (Optional) - 添加设备同步（可选）

If you want to sync Realm data across devices, you can set up an Atlas App Services App and enable Device Sync. For more information on what you can do with App Services, see: _App Services - Swift SDK_.

如果您想在设备之间同步 Realm 数据，您可以安装 Atlas 应用服务程序并启用设备同步。有关如何使用应用服务的更多信息，请参阅：《App Services-Swift SDK》。

### Prerequisites

Before you can sync Realm data, you must:

- _Create an App Services App_
- _Enable anonymous authentication_
- _Enable Flexible Sync_ with _Development Mode_ toggled to `On` and an `ownerId` field in the **Queryable Fields** section.

### Initialize the App

To use App Services features such as authentication and sync, access your App Services App using your App ID. You can _find your App ID_ in the App Services UI.

```
let app = App(id: APP_ID) // Replace APP_ID with your Atlas App ID
```

### Authenticate a User

In this quick start, you use _anonymous authentication_ to log in users without requiring them to provide any identifying information. After authenticating the user, you can open a realm for that user.

```
do {
    let user = try await app.login(credentials: Credentials.anonymous)
    print("Successfully logged in user: \(user)")
    await openSyncedRealm(user: user)
} catch {
    print("Error logging in: \(error.localizedDescription)")
}
```

The Realm Swift SDK provides many additional ways to authenticate, register, and link users. For other authentication providers, see: _Authenticate Users - Swift SDK_

### Open a Realm
Once you have enabled Device Sync and authenticated a user, you can create a _Configuration_ object and open the realm. You can then add a the _Flexible Sync subscription_ that determines what data the realm can read and write.

Once you have a realm with a subscription, this example passes the realm and the user to another function where you can use the realm.

> TIP
> 
> If your app accesses Realm in an `async/await` context, mark the code with `@MainActor` to avoid threading-related crashes.

```
// Opening a realm and accessing it must be done from the same thread.
// Marking this function as `@MainActor` avoids threading-related issues.
@MainActor
func openSyncedRealm(user: User) async {
    do {
        var config = user.flexibleSyncConfiguration()
        // Pass object types to the Flexible Sync configuration
        // as a temporary workaround for not being able to add a
        // complete schema for a Flexible Sync app.
        config.objectTypes = [Todo.self]
        let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
        // You must add at least one subscription to read and write from a Flexible Sync realm
        let subscriptions = realm.subscriptions
        try await subscriptions.update {
            subscriptions.append(
                QuerySubscription<Todo> {
                    $0.ownerId == user.id
                })
        }
        await useRealm(realm: realm, user: user)
    } catch {
        print("Error opening realm: \(error.localizedDescription)")
    }
}
```

The syntax to read, write, and watch for changes on a synced realm is identical to the syntax for non-synced realms above. While you work with local data, a background thread efficiently integrates, uploads, and downloads changesets.

Every write transaction for a subscription set has a performance cost. If you need to make multiple updates to a Realm object during a session, consider keeping edited objects in memory until all changes are complete. This improves sync performance by only writing the complete and updated object to your realm instead of every change.