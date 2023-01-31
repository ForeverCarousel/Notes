# GameObject
GameObject是游戏场景中真实存在的，而且有位置的一个物件
Component附属于GameObject，控制GameObject的各种属性
GameObject是由Component组合成的，Component的生命周期和GameObject息息相关。调用此GameObject的Destroy方法，它的子对象和对应的所有Component都会被销毁，但也可以一次只销毁一个Component

# MonoBeahviour
MonoBehaviour 类提供对大量事件消息的访问，允许您根据项目中当前发生的情况执行代码。下面是一些比较常见的例子。有关完整的列表，请参阅 MonoBehaviour 脚本参考页面 上的消息部分

Start - 在游戏对象开始存在时（加载场景或实例化游戏对象时）调用。

Update - 每帧都会被调用。

FixedUpdate - 每个物理时间步进调用。

OnBecameVisible 和 OnBecameInvisible - 当游戏对象的渲染器进入或离开摄像机的视图时调用。

OnCollisionEnter 和 OnTriggerEnter - 在发生物理碰撞或触发时调用。

OnDestroy - 在销毁游戏对象时调用。


# Componet


