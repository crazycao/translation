# Realm - Swift SDK

原文地址：[https://www.mongodb.com/docs/realm/sdk/swift/realm-database/](https://www.mongodb.com/docs/realm/sdk/swift/realm-database/)

Realm is a reactive, object-oriented, cross-platform, mobile database:

Reactive: query the current state of data and subscribe to state changes like the result of a query, or even changes to a single object.

Object-oriented: organizes data as objects, rather than rows, documents, or columns.

Cross-platform: use the same database on iOS, Android, Linux, macOS, or Windows. Just define a schema for each SDK you use.

Mobile: designed for the low-power, battery-sensitive, real-time environment of a mobile device.

Realm is a cross-platform and mobile-optimized alternative to other mobile databases such as 
SQLite
, 
Core Data
, and 
Room.

This page explains some of the implementation details and inner workings of Realm and Device Sync. This page is for you if you are:

a developer interested in learning more about Realm

comparing Realm with competing databases

trying to understand how Realm works with Device Sync

This explanation begins with a deep dive into database internals, continues with a high-level introduction to some of the features of Realm, and wraps up with some of the differences of working with Device Sync and the local version of Realm.

Database Internals
Realm uses a completely unique database engine, file format, and design. This section describes some of the high-level details of those choices. This section applies to both the device-local version of Realm as well as the networked Device Sync version. Differences between the local database and the synchronized database are explained in the Atlas Device Sync section.

Native Database Engine
Realm is an entire database written from scratch in C++, instead of building on top of an underlying database engine like SQLite. Realm's underlying storage layer uses 
B+ trees
 to organize objects. As a result, Realm controls optimizations from the storage level all the way up to the access level.

Realm stores data in realms: collections of heterogeneous realm objects. You can think of each realm as a database. Each object in a realm is equivalent to a row in a SQL database table or a MongoDB document. Unlike SQL, realms do not separate different object types into individual tables.

Realm stores objects as groups of property values. We call this column-based storage. This means that queries or writes for individual objects can be slower than row-based storage equivalents when unindexed, but querying a single field across multiple objects or fetching multiple objects can be much faster due to spatial locality and in-CPU vector operations.

Realm uses a 
zero-copy
 design to make queries faster than an ORM, and often faster than raw SQLite.

Realm Files
Realm persists data in files saved on device storage. The database uses several kinds of file:

realm files, suffixed with "realm", e.g. default.realm: contain object data.

lock files, suffixed with "lock", e.g. default.realm.lock: keep track of which versions of data in a realm are actively in use. This prevents realm from reclaiming storage space that is still used by a client application.

note files, suffixed with "note", e.g. default.realm.note: enable inter-thread and inter-process notifications.

management files, suffixed with "management", e.g. default.realm.management: internal state management.

Realm files contain object data with the following data structures: Groups, Tables, Cluster Trees, and Clusters. Realm organizes these data structures into a tree structure with the following form:

The top level, known as a Group, stores object metadata, a transaction log, and a collection of Tables.

Each class in the realm schema corresponds to a Table within the top-level Group.

Each Table contains a Cluster Tree, an implementation of a B+ tree.

Leaves on the Cluster Tree are called Clusters. Each contains a range of objects sorted by key value.

Clusters store objects as collections of columns.

Each column contains data for a single property for multiple instances of a given object. Columns are arrays of data with uniformly sized values.

Columns store data in one of the following sizes: 1, 2, 4, 8, 16, 32, or 64 bits. Each column uses one value size, determined by the largest value.

Since pointers refer to memory addresses, objects written to persistent files cannot store references as pointers. Instead, realm files refer to data using the offset from the beginning of the file. We call this a ref. As Realm uses memory mapping to read and write data, database operations translate these refs from offsets to memory pointers when navigating database structures.

Copy-on-Write: The Secret Sauce of Data Versioning
Realm uses a technique called copy-on-write, which copies data to a new location on disk for every write operation instead of overwriting older data on disk. Once the new copy of data is fully written, the database updates existing references to that data. Older data is only garbage collected when it is no longer referenced or actively in use by a client application.

Because of copy-on-write, older copies of data remain valid, since all of the references in those copies still point to other valid data. Realm leverages this fact to offer multiple versions of data simultaneously to different threads in client applications. Most applications tie data refreshes to the repaint cycle of the looper thread that controls the UI, since data only needs to refresh as often as the UI does. Longer-running procedures on background threads, such as large write operations, can work with a single version of data for a longer period of time before committing their changes.

Memory Mapping
Writes use 
memory mapping
 to avoid copying data back and forth from memory to storage. Accessors and mutators read and write to disk via memory mapping. As a result, object data is never stored on the stack or heap of your app. By default, data is memory-mapped as read-only to prevent accidental writes.

Realm uses operating system level paging, trusting each operating system to implement memory mapping and persistence better than a single library could on its own.

Compaction
Realm automatically reuses free space that is no longer needed after database writes. However, realm files never shrink automatically, even if the amount of data stored in your realm decreases significantly. Compact your realm to optimize storage space and decrease file size if possible.

You should compact your realms occasionally to keep them at an optimal size. You can do this manually, or by configuring your realms to compact on launch. However, Realm reclaims unused space for future writes, so compaction is only an optimization to conserve space on-device.

ACID Compliance
Realm guarantees that transactions are 
ACID
 compliant. This means that all committed write operations are guaranteed to be valid and that clients don't see transient states in the event of a system crash. Realm complies with ACID with the following design choices:

Atomicity
: groups operations in transactions and rolls back all operations in a transaction if any of them fail.

Consistency
: avoids data corruption by validating changes against the schema. If the result of any write operation is not valid, Realm cancels and rolls back the entire transaction.

Isolation
: allows only one writer at a time. This ensures thread safety between transactions.

Durability
: writes to disk immediately when a transaction is committed. In the event of an app crash, for example, changes are not lost or corrupted.

Features
Realm supports many popular database features.

Queries
You can query Realm using platform-native queries or a raw query language that works across platforms.

Encryption
Realm supports on-device realm encryption. Since memory mapping does not support encryption, encrypted realms use a simulated in-library form of memory mapping instead.

NOTE
Realm forbids opening the same encrypted realm from multiple processes. Attempting to do so will throw the error: "Encrypted interprocess sharing is currently unsupported."

Indexes
Indexes are implemented as trees containing values of a given property instead of a unique internal object key. This means that indexes only support one column, and thus only one property, at a time.

Schemas
Every realm object has a schema. That schema is defined via a native object in your SDK's language. Object schemas can include embedded lists and relations between object instances.

Each realm uses a versioned schema. When that schema changes, you must define a migration to move object data between schema versions. Non-breaking schema changes, also referred to as additive schema changes, do not require a migration. After you increment the local schema version, you can begin using the updated schema in your app. Breaking schema changes, also called destructive schema changes, require a migration function.

See your SDK's documentation for more information on migrations.

Persistent or In-Memory Realms
You can use Realm to store data persistently on disk, or ephemerally in memory. Ephemeral realms can be useful in situations where you don't need to persist data between application instances, such as when a user works in a temporary workspace.

Atlas Device Sync
Device Sync adds network synchronization between an App Services backend and client devices on top of all of the functionality of Realm. When you use Realm with Sync, realms exist on device, similar to using Realm without Sync. However, changes to the data stored in those realms synchronize between all client devices through a backend App Services instance. That backend also stores realm data in a cloud-based Atlas cluster running MongoDB.

Device Sync relies on a worker client that communicates with your application backend in a dedicated thread in your application. Additionally, synced realms keep a history of changes to contained objects. Sync uses this history to resolve conflicts between client changes and backend changes.

Applications that use Device Sync define their schema on the backend using 
JSON Schema
. Client applications must match that backend schema to synchronize data. However, if you prefer to define your initial schema in your application's programming language, you can use 
Development Mode
 to create a backend JSON Schema based on native SDK objects as you write your application. However, once your application is used for production purposes, you should alter your schema using JSON Schema on the backend.

Realm vs Other Databases
The Realm data model is similar to both relational and document databases but has distinct differences from both. To underscore these differences, it's helpful to highlight what a realm is not:

A realm is not a single, application-wide database.
Applications based on other database systems generally store all of their data in a single database. Apps often split data across multiple realms to organize data more efficiently and to enforce access controls.
A realm is not a relational table.
Normalized tables in relational databases only store one type of information, such as street addresses or items in a store inventory. A realm can contain any number of object types that are relevant to a given domain.
A realm is not a collection of schemaless documents.
Document databases don't necessarily enforce a strict schema for the data in each collection. While similar to documents in form, every Realm object conforms to a schema for a specific object type in the realm. An object cannot contain a property that is not described by its schema.
Live Queries
You can read back the data that you have stored in Realm by finding, filtering, and sorting objects. You can optionally section these results by a key path, making it easier to populate sectioned tables.

To get the best performance from Realm as your app grows and your queries become more complex, design your app's data access patterns around a solid understanding of Realm read characteristics.

Live Object
All Realm objects are live objects, which means they automatically update whenever they're modified. Realm emits a notification event whenever any property changes.

You can use live objects to work with object-oriented data natively without an 
ORM
 tool. Live objects are direct proxies to the underlying stored data, which means that a live object doesn't directly contain data. Instead, a live object always references the most up-to-date data on disk and 
lazy loads
 property values when you access them from a collection. This means that a realm can contain many objects but only pay the performance cost for data that the application is actually using.

Valid write operations on a live object automatically persist to the realm and propagate to any other synced clients. You do not need to call an update method, modify the realm, or otherwise "push" updates.

Realm Swift SDK Examples
Each of the pages in the Swift SDK documentation contain example code showing a specific task. The Quick Starts folder contains several example applications you can run to experiment with different ways of using Realm.

Beyond the examples in this documentation, the Realm community has created many applications that demonstrate the usage of the Realm Swift SDK.

NOTE
These community examples are not part of the documentation, and may not be actively maintained or show the most up-to-date way of working with Realm.

Examples by the Realm Engineering Team
The 
realm-swift example applications
 provide examples for both iOS and macOS that demonstrate how to use Realm features such as migrations and encryption. The examples also demonstrate how to combine Realm with common iOS concepts like UITableViewController.

Community Examples
Performing a Client Reset with Swift by "pmanna-tse-realm"