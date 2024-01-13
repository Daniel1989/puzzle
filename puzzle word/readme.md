## 怎么使用storyboard
1. 选中main，然后将组件拖进到画布中
2. 在画布底部，可以选择添加constraints，比如宽距的限制
3. 在viewcontroller中，添加对应的变量声明以及对应的 @IBOutlet
4. 回到storyboard，然后选中view，对应的@IBOutlet，然后连接到画布
5. 添加uitableviewcell，然后设置id

## xcode格式化
1. 选中内容
2. 快捷键ctrl+I

https://github.com/AyeshJayasekara/English-Dictionary-SQLite
https://github.com/maximbilan/SwiftOxfordAPI

## 添加数据库等资源文件
1. 选中文件，然后右键选择 file inspection， 然后在target membership中，选中
2. 在代码中通过
```if let dbPath = Bundle.main.path(forResource: "db", ofType: "sqlite3"```
获取路径
3. table这种组件有很多override的方法，每个方法作用不一样，有些是选中事件，有些是渲染
4. 报错sandbox错误，可以在项目build setting中，将build options中的sandbox相关设置为NO
