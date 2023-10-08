# Implementing User Authentication with Sign in with Apple - 实施使用“通过 Apple 登录”进行用户认证

原文地址：
[https://developer.apple.com/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple/](https://developer.apple.com/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple/)

中文地址：
[https://developer.apple.com/cn/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple/](https://developer.apple.com/cn/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple/)

Provide a way for users of your app to set up an account and start using your services.

为 App 的用户提供一种设置账户并开始使用相应服务的方式。

[Download（下载链接）](https://docs-assets.developer.apple.com/published/bdeecc8f6a/ImplementingUserAuthenticationWithSignInWithApple.zip)

> iOS 13.0+
iPadOS 13.0+
Xcode 11.3+

# Overview - 概览

This sample app, Juice, uses the `Authentication Services` framework to provide users an interface to set up accounts and sign in with their Apple ID. The app presents a form in which the user can create and set up an account for the app, then authenticates the user’s Apple ID with Sign in with Apple, and displays the user’s account data.

这个示例 App“Juice”使用 `Authentication Services` 框架为用户提供了一个界面来设置账户并使用他们的 Apple ID 登录。该 App 提供了一个表单，用户可以通过表单在 App 中创建和设置账户，然后使用“通过 Apple 登录”对用户的 Apple ID 进行认证，并显示用户的账户数据。

For more information about implementing Sign in with Apple on iOS 12 and earlier, see [Incorporating Sign in with Apple into other platforms](https://developer.apple.com/documentation/signinwithapplejs/incorporating_sign_in_with_apple_into_other_platforms/).

有关在 iOS 12 及更早版本上实施“通过 Apple 登录”的更多信息，请参阅《[将“通过 Apple 登录”整合到其他平台中 (英文)](https://developer.apple.com/documentation/signinwithapplejs/incorporating_sign_in_with_apple_into_other_platforms/)》。


## Configure the Sample Code Project - 配置示例代码项目

To configure the sample code project, perform the following steps in Xcode:

1. On the `Signing & Capabilities` pane, **set the bundle ID to a unique identifier** (you must change the bundle ID to proceed).
2. **Add your Apple ID account** and **assign the target to a team** so Xcode can enable the Sign in with Apple capability with your provisioning profile.
3. Choose a run destination from the scheme pop-up menu that you’re signed into with an Apple ID and that uses Two-Factor Authentication.
4. If necessary, click Register Device in the Signing & Capabilities pane to create the provisioning profile.
5. In the toolbar, click Run, or choose Product > Run (⌘R).

要配置示例代码项目，请在 Xcode 中按照以下步骤操作：

1. 在“Signing & Capabilities”(签名和功能) 面板中，**将套装 ID 设置为唯一标识符** (必须更改套装 ID 才能继续)。
2. **添加你的 Apple ID 账户** 并 **将目标分配给团队**，这样 Xcode 就可以使用预置描述文件启用“通过 Apple 登录”功能。
3. 从方案弹出菜单中**选择一个运行目的地**，该目的地需使用 Apple ID 登录并使用双重认证。
4. 如有必要，点按“Signing & Capabilities”(签名和功能) 面板中的**“Register Device”(注册设备) 以创建预置描述文件**。
5. 在工具栏中，**点按“Run”(运行)**，或选择“Product”(产品) >“Run”(运行) (⌘R)。

## Add a Sign in with Apple Button - 添加“通过 Apple 登录”按钮

In the sample app, LoginViewController displays a login form and a Sign in with Apple button ([ASAuthorizationAppleIDButton](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidbutton/)) in its view hierarchy. The view controller also adds itself as the button’s target, and passes an action to be invoked when the button receives a touch-up event.

在示例 App 中，LoginViewController 会在其视图层次结构中显示登录表单和“通过 Apple 登录”按钮 ([ASAuthorizationAppleIDButton](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidbutton/))。视图控制器还会将自身添加为按钮的目标，并传递按钮收到触控事件时要调用的操作。

```
func setupProviderLoginView() {
    let authorizationButton = ASAuthorizationAppleIDButton()
    authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    self.loginProviderStackView.addArrangedSubview(authorizationButton)
}
```

> **Important** **重要信息**
>
> When adding the Sign in with Apple button to your storyboard, you must also set the control’s class value to `ASAuthorizationAppleIDButton` in Xcode’s Identity Inspector.
> 
> 在将“通过 Apple 登录”按钮添加到 Storyboard 时，你还必须在 Xcode 的 Identity Inspector 中将该控件的类值设置为 `ASAuthorizationAppleIDButton`。

## Request Authorization with Apple ID - 使用 Apple ID 请求授权

When the user taps the Sign in with Apple button, the view controller invokes the `handleAuthorizationAppleIDButtonPress()` function, which starts the authentication flow by performing an authorization request for the users’s full name and email address. The system then checks whether the user is signed in with their Apple ID on the device. If the user is not signed in at the system-level, the app presents an alert directing the user to sign in with their Apple ID in Settings.

当用户轻点“通过 Apple 登录”按钮时，视图控制器会调用 `handleAuthorizationAppleIDButtonPress()` 函数，该函数会执行授权请求来获取用户的全名和电子邮件地址，从而开始认证流程。然后，系统会检查用户是否在设备上登录了 Apple ID。如果用户没有在系统级登录，App 会显示一条提醒，指引用户在“设置”中使用 Apple ID 登录。

```
@objc
func handleAuthorizationAppleIDButtonPress() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
}
```

> **Important** **重要信息**
>
> The user must enable Two-Factor Authentication to use Sign in with Apple so that access to the account is secure.
> 
> 用户必须启用双重认证才能使用“通过 Apple 登录”，这保证对账户的访问是安全的。

The authorization controller calls the [presentationAnchor(for:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationcontrollerpresentationcontextproviding/3237228-presentationanchor/) function to get the window from the app where it presents the Sign in with Apple content to the user in a modal sheet.

授权控制器会调用 [presentationAnchor(for:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationcontrollerpresentationcontextproviding/3237228-presentationanchor/) 函数来从 App 中获取窗口，用于将“通过 Apple 登录”内容以模态表单的形式呈现给用户。

```
func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
}
```

If the user is signed in at the system-level with their Apple ID, the sheet appears describing the Sign in with Apple feature, followed by another sheet allowing the user to edit the information in their account. The user can edit their first and last name, choose another email address as their contact information, and hide their email address from the app. If the user chooses to hide their email address from the app, Apple generates a proxy email address to forward email to the user’s private email address. Lastly, the user enters the password for the Apple ID, then clicks Continue to create the account.

如果用户已在系统级使用 Apple ID 登录，则会显示该表单来介绍“通过 Apple 登录”功能，然后会显示另一个表单，让用户可以编辑账户中的信息。用户可以编辑自己的名字和姓氏，选取另一个电子邮件地址作为联系信息，以及对 App 隐藏自己的电子邮件地址。如果用户选择对 App 隐藏自己的电子邮件地址，Apple 会生成一个代理电子邮件地址来将电子邮件转发到用户的私人电子邮件地址。最后，用户输入 Apple ID 的密码，然后点按“Continue”(继续) 以创建账户。

## Handle User Credentials - 处理用户凭证

If the authentication succeeds, the authorization controller invokes the [authorizationController(controller:didCompleteWithAuthorization:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationcontrollerdelegate/3153050-authorizationcontroller/) delegate function, which the app uses to store the user’s data in the keychain.

如果认证成功，授权控制器会调用 [authorizationController(controller:didCompleteWithAuthorization:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationcontrollerdelegate/3153050-authorizationcontroller/) 委托函数，App 使用该函数将用户的数据储存在钥匙串中。

```
func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
        
        // Create an account in your system.
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        // For the purpose of this demo app, store the `userIdentifier` in the keychain.
        self.saveUserInKeychain(userIdentifier)
        
        // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
        self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
    
    case let passwordCredential as ASPasswordCredential:
    
        // Sign in using an existing iCloud Keychain credential.
        let username = passwordCredential.user
        let password = passwordCredential.password
        
        // For the purpose of this demo app, show the password credential as an alert.
        DispatchQueue.main.async {
            self.showPasswordCredentialAlert(username: username, password: password)
        }
        
    default:
        break
    }
}
```

> **Note** **注释**
>
> In your implementation, the ASAuthorizationControllerDelegate.authorizationController(controller:didCompleteWithAuthorization:) delegate function should create an account in your system using the data contained in the user identifier.
>
> 在你的实施中，ASAuthorizationControllerDelegate.authorizationController(controller:didCompleteWithAuthorization:) 委托函数应使用用户标识符中包含的数据在你的系统中创建一个账户。

If the authentication fails, the authorization controller invokes the [authorizationController(controller:didCompleteWithError:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationcontrollerdelegate/3153051-authorizationcontroller/) delegate function to handle the error.

如果认证失败，授权控制器会调用 [authorizationController(controller:didCompleteWithError:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationcontrollerdelegate/3153051-authorizationcontroller/) 委托函数来处理错误。

```
func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
}
```

Once the system authenticates the user, the app displays the ResultViewController which shows the user information requested from the framework, including the user-provided full name and email address. The view controller also displays a Sign Out button and stores the user data in the keychain. When the user taps the Sign Out button, the app deletes the user information from the view controller and the keychain, and presents the LoginViewController to the user.

系统对用户进行认证后，App 会显示 ResultViewController，该控制器显示从框架请求的用户信息，其中包括用户提供的全名和电子邮件地址。该视图控制器还会显示“Sign Out”(注销) 按钮，并将用户数据储存在钥匙串中。当用户轻点“Sign Out”(注销) 按钮时，App 会从视图控制器和钥匙串中删除用户信息，并向用户显示 LoginViewController。

## Request Existing Credentials - 请求现有的凭证

The `LoginViewController.performExistingAccountSetupFlows()` function checks if the user has an existing account by requesting both an Apple ID and an iCloud keychain password. Similar to `handleAuthorizationAppleIDButtonPress()`, the authorization controller sets its presentation content provider and delegate to the `LoginViewController` object.

`LoginViewController.performExistingAccountSetupFlows()` 函数会通过请求 Apple ID 和 iCloud 钥匙串密码来检查用户是否已有账户。与 `handleAuthorizationAppleIDButtonPress()` 类似，授权控制器会设置其展示内容提供器，并委托给 `LoginViewController` 对象。

```
func performExistingAccountSetupFlows() {
    // Prepare requests for both Apple ID and password providers.
    let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                    ASAuthorizationPasswordProvider().createRequest()]
    
    // Create an authorization controller with the given requests.
    let authorizationController = ASAuthorizationController(authorizationRequests: requests)
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
}
```

The `authorizationController(controller:didCompleteWithAuthorization:)` delegate function checks whether the credential is an Apple ID ([ASAuthorizationAppleIDCredential](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidcredential/)) or a password credential ([ASPasswordCredential](https://developer.apple.com/documentation/authenticationservices/aspasswordcredential/)). If the credential is a password credential, the system displays an alert allowing the user to authenticate with the existing account.

`authorizationController(controller:didCompleteWithAuthorization:)` 委托函数会检查凭证是 Apple ID ([ASAuthorizationAppleIDCredential](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidcredential/)) 还是密码凭证 ([ASPasswordCredential](https://developer.apple.com/documentation/authenticationservices/aspasswordcredential/))。如果是密码凭证，系统会显示一条提醒，允许用户使用现有账户进行认证。

## Check User Credentials at Launch - 启动时检查用户凭证

The sample app only shows the Sign in with Apple user interface when necessary. The app delegate checks the status of the saved user credentials immediately after launch in the `AppDelegate.application(_:didFinishLaunchingWithOptions:)` function.

示例 App 仅在必要时显示“通过 Apple 登录”用户界面。App 委托会在 App 启动后立即通过 `AppDelegate.application(_:didFinishLaunchingWithOptions:)` 函数检查已存储用户凭证的状态。

The [getCredentialState(forUserID:completion:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidprovider/3175423-getcredentialstate/) function retrieves the state of the user identifier saved in the keychain. If the user granted authorization for the app (for example, the user is signed into the app with their Apple ID on the device), then the app continues executing. If the user revoked authorization for the app, or the user’s credential state not found, the app displays the log in form by invoking the showLoginViewController() function.

[getCredentialState(forUserID:completion:)](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidprovider/3175423-getcredentialstate/) 函数会检索钥匙串中存储的用户标识符的状态。如果用户为 App 授权了 (例如，用户在设备上使用 Apple ID 登录了 App)，那么 App 会继续执行。如果用户撤销了对 App 的授权，或者 App 找不到用户的凭证状态，App 会通过调用 `showLoginViewController()` 函数来显示登录表单。

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
        switch credentialState {
        case .authorized:
            break // The Apple ID credential is valid.
        case .revoked, .notFound:
            // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
            DispatchQueue.main.async {
                self.window?.rootViewController?.showLoginViewController()
            }
        default:
            break
        }
    }
    return true
}
```

# See Also - 其他参考

## Sign In with Apple - 通过 Apple 登录

### Simplifying User Authentication in a tvOS App

Build a fluid sign-in experience for your tvOS apps using AuthenticationServices.

### struct SignInWithAppleButton

The view that creates the Sign in with Apple button for display.

### Sign in with Apple Entitlement

An entitlement that lets your app use Sign in with Apple.

Key: com.apple.developer.applesignin

### class ASAuthorizationAppleIDProvider

A mechanism for generating requests to authenticate users based on their Apple ID.

### class ASAuthorizationAppleIDCredential

A credential that results from a successful Apple ID authentication.


