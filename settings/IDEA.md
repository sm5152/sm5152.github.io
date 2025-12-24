# idea

## 基本设置

```text
外观与行为>系统设置 取消[退出IDE之前确认] 选择[终止进程]
外观与行为>系统设置 取消[启动时重新打开项目] 选择[新窗口]
外观与行为>系统设置>更新 取消[检查IDE更新]

编辑器>常规>代码折叠 取消[一行方法折叠][HTML‘style’特性]
编辑器>常规>代码补全 取消[区分大小写]
编辑器>常规>内联补全 取消[启用本地 Full Line 补全建议]
【确定】
编辑器>常规>编辑器标签页>关闭策略 选择[最近打开的标签页]
【确定】
编辑器>字体 大小[15] 行高[1]
【应用】
编辑器>嵌入提示 取消[Code Vision]

版本控制>提交 勾选[优化import] 取消[分析代码][检查TODO][提交后检查]

呼出注册表[opt+cmd+shift+/](双击shift 搜索reg) 取消[projectView.hide.dot.idea]
```

## 键盘映射

```text
重新设置代码格式(ReformatCode) [鼠标4] [移除]
VCS组>提交(CheckinProject) [鼠标5] [移除]
显示历史记录(Vcs.ShowTabbedFileHistory) [鼠标中建] [移除]
删除行(EditorDeleteLine) [opt+d](alt+d)
(仅win)关闭标签页(CloseContent) (ctrl+w)
```

## 代码样式

```text
编辑器>代码样式>PHP>换行和大括号 勾选[对齐连续赋值][对齐列中属性][对齐常量][对齐键值对]
编辑器>代码样式>PHP>PHPDoc 勾选[对齐形参/属性名称][对齐标记注释]
编辑器>代码样式>PHP>代码转换>数组 勾选[强制短声明样式][...最后添加逗号]

编辑器>代码样式>HTML>其他 强制换行位置[160]
编辑器>代码样式>HTML>其他>空格 勾选[在空的标签]

编辑器>代码样式>JavaScript>制表符和缩进 缩进[2] 连续缩进[2]
编辑器>代码样式>JavaScript>空格>内部 勾选[对象文字大括号][ES6导入/导出大括号]
编辑器>代码样式>JavaScript>标点 尾随逗号[多行时添加]

编辑器>代码样式>TypeScript>制表符和缩进 缩进[2] 连续缩进[2]
编辑器>代码样式>TypeScript>空格>内部 勾选[对象文字大括号][ES6导入/导出大括号]
编辑器>代码样式>TypeScript>标点 尾随逗号[多行时添加]

编辑器>代码样式>Vue模板>制表符和缩进 缩进[2] 连续缩进[2]

编辑器>代码样式>样式表>CSS>空行>最小的空白行 顶层块周围[0]

编辑器>文件和代码模板>Include>PHP Function Doc Comment "清空内容"
```

## 控制台中文乱码

```text
帮助>编辑自定义VM选项 加参数[-Dfile.encoding=UTF-8]
```

## Android Studio

```text
Editor>Code Style>Java>Blank LInes>{In code=1, Before '}'=0}
Editor>Code Style>XML>Other>Keep blank lines=0
```

# AI 提示词

```text
查找给出的代码的问题，请严格遵守以下4点：
1. 彻底忽略异常捕获和错误处理问题
2. 彻底忽略所有值可能为空的问题
3. 彻底忽略代码的导入和引用问题
4. 只考虑这段代码本身，不考虑引用的代码的问题
   代码为：
   $SELECTION
```

# eval 配置目录

```text
~/Library/Application Support/JetBrains/
```
