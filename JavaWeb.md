[JavaWeb常见面试题](http://www.bjpowernode.com/tutorial_baseinterviewquestions/211.html)
[JavaWeb常见面试题](http://www.bjpowernode.com/tutorial_baseinterviewquestions/211.html)

* JSP和Servlet的区别 [cici](https://www.cnblogs.com/hongchengshise/p/10383186.html)
    * **Jsp经编译后变成了Servlet**（Jsp的本质就是Servlet)
    * JSP侧重于**页面显示**，Servlet主要用于**控制逻辑**。
    * Servlet没有内置对象，JSP的内置对象必须通过HTTPServletRequst，HTTPServletResponse以及HTTPServlet对象获得
***

* JSP的内置对象
    * **request** 
      
        >request 对象是 javax.servlet.httpServletRequest类型的对象。 该对象**代表了客户端的请求信息，主要用于接受通过HTTP协议传送到服务器的数据**。（包括头信息、系统信息、请求方式以及请求参数等）。request对象的**作用域为一次请求**。
    * **reponse**
      
        >response **代表的是对客户端的响应，主要是将JSP容器处理过的对象传回到客户端**。response对象也具有**作用域，它只在JSP页面内有效**。
    * **session**
      
        >session 对象是由服务器自动创建的与用户请求相关的对象。服务器**为每个用户都生成一个session对象**，用于**保存该用户的信息，跟踪用户的操作状态。session对象内部使用Map类来保存数据，因此保存数据的格式为 “Key/value**”。 session对象的value**可以使用复杂的对象类型**，而不仅仅局限于字符串类型。
    * **application**
      
        >application 对象可**将信息保存在服务器中，直到服务器关闭**，否则application对象中保存的信息会在整个应用中都有效。与session对象相比，application对象生命周期更长，类似于系统的“**全局变量**”。
    * **out**
      
        >out 对象用于在**Web浏览器内输出信息**，并且**管理应用服务器上的输出缓冲区**。在使用 out 对象输出数据时，可以对数据缓冲区进行操作，**及时清除缓冲区中的残余数据**，为其他的输出让出缓冲空间。待数据输出完毕后，要及时关闭输出流。
    * **pageContext**
      
        >pageContext 对象的作用是取得任何范围的参数，通过它可以获取 JSP页面的out、request、reponse、session、application 等对象。pageContext对象的创建和初始化都是由容器来完成的，在JSP页面中可以直接使用 pageContext对象。
    * **config**
      
        >config 对象的主要作用是取得服务器的配置信息。通过 pageConext对象的 getServletConfig() 方法可以获取一个config对象。当一个Servlet 初始化时，容器把某些信息通过config对象传递给这个 Servlet。 开发者可以在web.xml 文件中为应用程序环境中的Servlet程序和JSP页面提供初始化参数。
    * **page**
      
        >page 对象代表JSP本身，只有在JSP页面内才是合法的。 page隐含对象本质上包含当前 Servlet接口引用的变量，类似于Java编程中的 this 指针。
    * **exception**
      
        >exception 对象的作用是显示异常信息，只有在包含 isErrorPage="true" 的页面中才可以被使用，在一般的JSP页面中使用该对象将无法编译JSP文件。excepation对象和Java的所有对象一样，都具有系统提供的继承结构。exception 对象几乎定义了所有异常情况。在Java程序中，可以使用try/catch关键字来处理异常情况； 如果在JSP页面中出现没有捕获到的异常，就会生成 exception 对象，并把 exception 对象传送到在page指令中设定的错误页面中，然后在错误页面中处理相应的 exception 对象。
***

* JSP的执行过程
    * 当客户端向一个jsp页面发送请求时，Web Container将jsp转化成类servlet的源代码（只在第一次请求时），然后编译转化后的servlet并加载到内存中执行，执行的结果response到客户端
    * jsp**只在第一次执行的时候会转化成servlet**，以后每次执行，web容器都是直接执行编译后的servlet，所以jsp和servlet只是在第一次执行的时候不一样，jsp慢一点，以后的执行都是相同的
***

* JSP的缺点
    * 不好调试
    * 代码可读性差
***

* JSP的作用域 [cici](https://blog.csdn.net/w405722907/article/details/77530002)
    * **page**：代表与**一个页面相关的对象和属性**。
    * **request**：代表与Web客户机发出的一个请求相关的对象和属性。一个请求可能跨越多个页面，涉及多个Web组件；**需要在页面显示的临时数据可以置于此作用域**。
    * **session**：同一浏览器对服务器进行多次访问，在这多次访问之间传递信息，就是session作用域的体现;所谓当前会话，就是指**从用户打开浏览器开始，到用户关闭浏览器这中间的过程**。
    * **application**：如果把变量放到application里，就说明它的作用域是application，它的有效范围是整个应用。 **整个应用是指从应用启动，到应用结束**。我们没有说“从服务器启动，到服务器关闭”，是**因为一个服务器可能部署多个应用，当然你关闭了服务器，就会把上面所有的应用都关闭了**。 application作用域里的变量，它们的存活时间是最长的，如果不进行手工删除，它们就一直可以使用。 

    |名称|作用域|
    |---|---|
    |page|在当前页面有效|
    |request|在当前请求中有效|
    |session|在当前会话中有效|
    |application|在所有应用程序中有效|
***


* session 和 cookie 
    * 由于HTTP协议是无状态的协议，所以服**务端需要记录用户的状态时，就需要用某种机制来识具体的用户**，这个机制就是Session.典型的场景比如购物车，当你点击下单按钮时，由于HTTP协议无状态，所以并不知道是哪个用户操作的，所以服务端要**为特定的用户创建了特定的Session，用用于标识这个用户，并且跟踪用户，这样才知道购物车里面有几本书**。这个Session是保存在服务端的，有一个唯一标识。在服务端保存Session的方法很多，内存、数据库、文件都有。集群的时候也要考虑Session的转移，在大型的网站，一般会有专门的Session服务器集群，用来保存用户会话，这个时候 Session 信息都是放在内存的，使用一些缓存服务比如Memcached之类的来放 Session。

    * 思考一下服务端**如何识别特定的客户**？这个时候Cookie就登场了。每次HTTP请求的时候，客户端都会发送相应的Cookie信息到服务端。实际上大多数的应用都是**用 Cookie 来实现Session跟踪的**，第一次创建Session的时候，服务端会在HTTP协议中告诉客户端，需要在 Cookie 里面记录一个**Session ID**，以后每次请求把这个会话ID发送到服务器，我就知道你是谁了。有人问，如果客户端的浏览器禁用了 Cookie 怎么办？一般这种情况下，会使用一种叫做URL重写的技术来进行会话跟踪，即每次HTTP交互，URL后面都会被附加上一个诸如 sid=xxxxx 这样的参数，服务端据此来识别用户。

    * Cookie其实还可以用在一些方便用户的场景下，设想你**某次登陆过一个网站，下次登录的时候不想再次输入账号**了，怎么办？这个信息可以写到Cookie里面，访问网站的时候，网站页面的脚本可以读取这个信息，就自动帮你把用户名给填了，能够方便一下用户。这也是Cookie名称的由来，给用户的一点甜头。

    * Cookie是web服务器发送给浏览器的一块信息，浏览器会在本地一个文件中给每个web服务器存储Cookie。以后浏览器再给特定的web服务器发送请求时，同时会发送所有为该服务器存储的Cookie。Session是存储在web服务器端的一块信息。Session对象存储特定用户会话所需的属性及配置信息。当用户在应用程序的Web页之间跳转时，存储在Session对象中的变量将不会丢失，而是在整个用户会话中一直存在下去。

    * 无论客户端做怎样的设置，Session都能够正常工作。当客户端禁用Cookie时将无法使用Cookie。

    * 在存储的数据量方面：Session能够存储任意的java对象，Cookie只能存储String类型的对象。
    
    * 总结一下：**Session是在服务端保存的一个数据结构，用来跟踪用户的状态，这个数据可以保存在集群、数据库、文件中**；Cookie是客户端保存用户信息的一种机制，**用来记录用户的一些信息，也是实现Session的一种方式**。


* sesion的工作原理
    * 其实session是一个存在服务器上的类似于一个散列表格的文件。里面存有我们需要的信息，在我们需要用的时候可以从里面取出来。**类似于一个大号的map**吧，里面的**键存储的是用户的sessionid**，用户向服务器发送请求的时候会带上这个sessionid。这时就可以从中取出对应的值了。

* 如果客户端禁止 cookie 能实现 session 还能用吗？
    * 设置php.ini配置文件中的“session.use_trans_sid = 1”，或者编译时打开打开了“--enable-trans-sid”选项，让PHP自动跨页传递Session ID。
    * 手动通过URL传值、隐藏表单传递Session ID。
    * 用文件、数据库等形式保存Session ID，在跨页过程中手动调用。

***

* CGI
    * 通用网关接口（Common Gateway Interface）是一个Web服务器主机提供信息服务的标准接口。通过CGI接口，Web服务器就能够获取客户端提交的信息，转交给服务器端的CGI程序进行处理，最后返回结果给客户端。
    ![CGI](https://img-blog.csdn.net/20170309183226078?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTGl1Tmlhbl9TaVl1/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
* Servlet和CGI的区别
    * Servlet处于服务器进程中，**只会有一个servlet实例，每个请求都会产生一个新的线程**，而且servlet实例一般不会销毁
    * CGI：**来一个请求就创建一个进程，用完就销毁，效率低于servlet**
***

* **Servlet线程不安全**
    * 对于同一个业务请求，只会有一个servlet实例被容器产生。线程安全是对**多个（线程）用户同时访问同一个对象（实例）的变量，引起线程安全问题**，所以，servlet接收和处理，不处理属性
    * action处理业务时，产生不同的对象，故线程安全的
    * 不同的用户同时对同一个业务（如注册）发出请求，只有一个servlet实例。一个servlet是在第一次被访问时加载到内存并实例化的。**同样的业务请求共享一个servlet实例**。不同的业务请求一般对应不同的servlet. 
***

* Servlet 的生命周期
  
* web 容器加载 servlet，生命周期开始。通过调用 **servlet 的 init()方法进行 servlet 的初始化**。通过调用 **service()方法实现，根据请求的不同调用不同的 do***()方法**。结束服务，web 容器调用 **servlet 的 destroy()**方法。
  
* spring mvc 和 struts 的区别
    * 拦截机制的不同
        >**Struts2是类级别的拦截**，每次请求就会创建一个Action，和Spring整合时Struts2的ActionBean注入作用域是原型模式prototype，然后通过setter，getter吧request数据注入到属性。Struts2中，一个Action对应一个request，response上下文，在接收参数时，可以通过属性接收，这说明属性参数是让多个方法共享的。Struts2中Action的一个方法可以对应一个url，而其类属性却被所有方法共享，这也就无法用注解或其他方式标识其所属方法了，只能设计为多例。

        >**SpringMVC是方法级别的拦截**，一个方法对应一个Request上下文，**所以方法直接基本上是独立的，独享request，response数据**。而**每个方法同时又和一个url对应**，参数的传递是直接注入到方法中的，是方法所独有的。处理结果通过ModeMap返回给框架。在Spring整合时，SpringMVC的Controller Bean默认单例模式Singleton，所以默认对所有的请求，只会创建一个Controller，有**应为没有共享的属性，所以是线程安全的**，如果要改变默认的作用域，需要添加@Scope注解修改。

        >Struts2有自己的拦截**Interceptor机制**，SpringMVC这是用的是**独立的Aop方式**，这样导致Struts2的配置文件量还是比SpringMVC大。

    * 底层框架的不同
        >Struts2采用Filter（StrutsPrepareAndExecuteFilter）实现,Filter在容器启动之后即初始化；

        >SpringMVC（DispatcherServlet）则采用Servlet实现.Servlet在是在调用时初始化，先于Filter调用，服务停止后销毁。


    * 性能方面
        > Struts2是类级别的拦截，每次请求对应实例一个新的Action，需要加载所有的属性值注入，SpringMVC实现了零配置，由于SpringMVC基于方法的拦截，有加载一次单例模式bean注入。所以，SpringMVC开发效率和性能高于Struts2。

***

* 如何避免 sql 注入？[cici](https://www.cnblogs.com/Kluas/p/9773305.html)
    * PreparedStatement（简单又有效的方法）

    * 使用正则表达式过滤传入的参数

    * 字符串过滤

    * JSP中调用该函数检查是否包函非法字符

    * JSP页面判断代码
***

* Statement和pepareStatement区别
    * PreparedStatement是**预编译的**,对于**批量处理可以大大提高效率. 也叫JDBC存储过程**
    * 使用 Statement 对象。在**对数据库只执行一次性存取的时侯，用 Statement 对象进行处理**。PreparedStatement 对象的开销比Statement大，对于一次性操作并不会带来额外的好处。
    * 

***
* 原生JDBC操作数据库流程
    * 第一步：Class.forName()加载**数据库连接驱动**；
    * 第二步：DriverManager.getConnection()**获取数据连接对象**;
    * 第三步：根据SQL**获取sql会话对象**，有2种方式 Statement、PreparedStatement ;
    * 第四步：**执行SQL**，执行SQL前如果有参数值就设置参数值setXXX();
    * 第五步：**处理结果集**；
    * 第六步：**关闭**结果集、关闭会话、关闭连接。

***





























* XSS攻击
    * XSS攻击又称CSS,全称Cross Site Script  （跨站脚本攻击），**其原理是攻击者向有XSS漏洞的网站中输入恶意的 HTML 代码，当用户浏览该网站时，这段 HTML 代码会自动执行，从而达到攻击的目的**。XSS 攻击类似于 SQL 注入攻击，SQL注入攻击中以SQL语句作为用户输入，从而达到查询/修改/删除数据的目的，而在xss攻击中，通过插入恶意脚本，实现对用户游览器的控制，获取用户的一些信息。 XSS是 Web 程序中常见的漏洞，XSS 属于被动式且用于客户端的攻击方式。

    * XSS防范的总体思路是：对输入(和URL参数)进行过滤，对输出进行编码。
***

* CSRF 攻击
    * CSRF（Cross-site request forgery）也被称为 one-click attack或者 session riding，中文全称是**叫跨站请求伪造**。一般来说，**攻击者通过伪造用户的浏览器的请求，向访问一个用户自己曾经认证访问过的网站发送出去，使目标网站接收并误以为是用户的真实操作而去执行命令。常用于盗取账号、转账、发送虚假消息等**。攻击者利用网站对请求的验证漏洞而实现这样的攻击行为，网站能够确认请求来源于用户的浏览器，却不能验证请求是否源于用户的真实意愿下的操作行为。
    
    * 如何避免
        * 验证 HTTP Referer 字段
          
            >HTTP头中的Referer字段记录了**该 HTTP 请求的来源地址**。在通常情况下，访问一个安全受限页面的请求来自于同一个网站，而如果黑客要对其实施 CSRF攻击，他一般只能在他自己的网站构造请求。因此，可以通过验证Referer值来防御CSRF 攻击。
        * 使用验证码
          
            >关键操作页面加上验证码，后台收到请求后通过判断验证码可以防御CSRF。但这种方法对用户不太友好。
        * 在请求地址中添加token并验证
          
            >**CSRF 攻击之所以能够成功，是因为黑客可以完全伪造用户的请求，该请求中所有的用户验证信息都是存在于cookie中，因此黑客可以在不知道这些验证信息的情况下直接利用用户自己的cookie 来通过安全验证。要抵御 CSRF，关键在于在请求中放入黑客所不能伪造的信息，并且该信息不存在于 cookie 之中**。可以**在 HTTP 请求中以参数的形式加入一个随机产生的 token，并在服务器端建立一个拦截器来验证这个 token**，如果请求中没有token或者 token 内容不正确，则认为可能是 CSRF 攻击而拒绝该请求。这种方法要比检查 Referer 要安全一些，token 可以在用户登陆后产生并放于session之中，然后在每次请求时把token 从 session 中拿出，与请求中的 token 进行比对，但这种方法的难点在于如何把 token 以参数的形式加入请求。对于 GET 请求，token 将附在请求地址之后，这样 URL 就变成 `http://url?csrftoken=tokenvalue。`而对于 POST 请求来说，要在 form 的最后加上 `<input type="hidden" name="csrftoken" value="tokenvalue"/>`，这样就把token以参数的形式加入请求了。
        * 在HTTP 头中自定义属性并验证
          
            >这种方法也是使用 token 并进行验证，和上一种方法不同的是，这里并不是把 token 以参数的形式置于 HTTP 请求之中，而是把它放到 HTTP 头中自定义的属性里。通过 XMLHttpRequest 这个类，可以一次性给所有该类请求加上 csrftoken 这个 HTTP 头属性，并把 token 值放入其中。这样解决了上种方法在请求中加入 token 的不便，同时，通过 XMLHttpRequest 请求的地址不会被记录到浏览器的地址栏，也不用担心 token 会透过 Referer 泄露到其他网站中去。

***



