# NDH5ToNative
The way of H5 send message to native

# Scene
* Example
```objc
有个需求，点击 H5页面的一个按钮，将 H5页面的信息传递给我们 native
```

* method
```objc
目前我做过的项目中使用过3种方案：
第一种是集成WebViewJavascriptBridge（地址：https://github.com/marcuswestin/WebViewJavascriptBridge）这是方案简单快速，推荐使用
第二种自己来写，原理如下：因为 native 中可以时刻监听 webView 的请求，故我们可以从这点出发，下面有两种实现方式：
1>我们可以让 H5开发人员在点击按钮的这个动作中，发起一个虚拟的请求（拼一个无效的 url，可以将传给 native 的信息拼入，看了WebViewJavascriptBridge的源码，发现他的原理与这类似）；
2>如果不将 native 的信息拼入，也可以这样操作，因为是无效 url，肯定是请求失败，H5端可以将需要传给 native 端的信息包入失败信息里面传给我们（不推荐这样做,时间耗费的比第一种多）
第三种使用 iOS7.0后新增 API 实现
self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
self.jsContext[@"jsBack"] = ^(NSDictionary *param) {
/// param返回数据
};

以上两种方案均可实现 H5端向 Native 传送信息
```

# Usage
See the Demo

# Demo Show
![image](https://github.com/indexjincieryi/NDH5ToNative/blob/master/NDH5ToNative/NDH5ToNative.gif)

# More Info
Have a question? Please [open an issue](https://github.com/indexjincieryi/NDH5ToNative/issues)!