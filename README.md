
# MVVMPrictice
A simple project to clarify the meaning of MVVM.
MVVM架构涉及再简化了Massive View Controller 的基础上使业务逻辑和界面逻辑进一步解耦。功能清晰明确，便于维护。

MVVM是一种软件设计中的架构模式。目前在MVC诟病下逐渐由前端过度到移动端的软件设计中。

---

#### 组成

#####Model

代表数据状态或者数据访问层的内容。

####View

与在MVC和MVP设计模式中一样，View即用户界面。

####View Model

ViewModel是View的抽象，其中包含的是共用属性和命令。与MVC模式中的controller、MVP模式中的Presenter均不同。MVVM拥有一个粘合剂。在ViewModel中，这个粘合剂协调View和数据。ViewModel被描述为数据模型中的数据状态。

---

MVVM是一种编程范式而并不会因此限制你的编程思想。实现技术也有许多种。

具体的实现：

* **View**

在实际使用中就是一个ViewController，基于MVVM的基本思想，在ViewController中我们处理的仅仅是用户事件的监听和主要业务逻辑，界面逻辑的处理，但并不会涉及具体的业务逻辑。例如，在登录页面中，View层次负责用户输入数据的验证、登录请求的发起等业务逻辑， 但是实现这些技术的细节，并不在View中实现。

* **ViewModel**

这是一个基于 `NSObject` 的专门处理View页面产生的业务逻辑和界面逻辑实现的类，这个类仅由相应的View调用（由于其功能特殊性，仅针对某个View的业务逻辑进行设计和实现）。
例如，在Demo中，登录页面对应的ViewModel中包含以下方法

```
/**
*  @author lzy, 15-08-24 09:08:53
*
*  @brief  检查用户输入是否合法
*
*  @param userName 要检查的用户名
*  @param password 要检查的密码
*/
- (BOOL)checkTheUserInputNameString: (NSString *) userName passwordString: (NSString *) password;
/**
*  @author lzy, 15-08-24 16:08:24
*
*  @brief  发起登录请求
*
*  @param requestView 在此页面发送请求，并且显示HUD
*/
- (void)requestLoginInView:(UIView *)requestView;
```

* **Model**

Model在本例中具体来讲就是一个用户模型，包含用户的姓名、电话、等属性，但是对于此Model，仅由ViewModel去更新，读取，修改，删除。同样也是基于 `View 不负责具体的业务逻辑`的原则。

* **类之间的通讯**

View发起一个事件之后，由ViewModel处理事件并通过带参的Block回调给View，再由View显示给用户结果。


