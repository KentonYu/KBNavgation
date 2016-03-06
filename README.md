# KBNavgation
通过Url来进行控制器间的跳转，从而降低控制器之间的耦合性。

# Version
V0.1.0

# Usage
1. 类方法，可以通过该方法生成跳转的Url

<pre><code>
NSString *urlStr = [KBNavgation kbNavgationUrlStrWithContent:@"SecondViewController" protocol:KBNavgationUrlProtocolInApp]
</code></pre>

2. 类方法，获取跳转控制器实例

<pre><code>
KBNavgation *instance = [KBNavgation shareInstance];
</code></pre>

3. 实例方法，设置单例的web控制器,全局性设置

<pre><code>
[instance setCustomWebVCCla:WebViewController];
</code></pre>

4. 实例方法，跳转控制器方法,userInfo是传到下个控制器的参数，参数名与目标控制器属性一致

<pre><code>
NSDictionary *userInfo = @{
                             @"title" : @"value"
                             };
[instance kbNavgationJumpToUrlStr:urlStr fromVC:self withUserInfo:userInfo];
</pre></code>

#Histroy
V0.1.0 init KBNavgation

#Remarks
1. 字典映射部分参考MJExtension；
2. iOS初学者，欢迎大家提出意见和建议；
