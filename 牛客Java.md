*  2020.3.1  
    * IntegerCache  
        * `Integer i=100;` 实际执行的是`Interge i=Integer.valueOf(100);`
            > Integer把-128到127（可通过JVM参数配置进行调整，增大范围）的整数都提前实例化了。所以不管创建多少个这个范围内的Integer用ValueOf出来的都是同一个对象。
            >但是为什么JDK要这么多此一举呢？ 我们仔细想想， 比如订单的交易数量，大多数都是100以内的价格， 一天后台服务器会new多少个这个的Integer， 用了IntegerCache，就减少了new的时间也就提升了效率。同时JDK还提供cache中high值得可配置，这无疑提高了灵活性，方便对JVM进行优化。另外，在Long和Short的源码中，jdk也做了同样的优化

    * ````java
        Integer i01 = 59;
        int i02 = 59;
        System.out.println(i01 == i02); //Integer会自动拆箱成int，然后进行值的比较。所以，为真。 ture
        ````
        * **所有基本类型的比较都是比较值**

    * **静态变量所有的对象都共享**

    * 
        >静态的include：是jsp的指令来实现的，`<% @ include file="xx.html"%>` 特点是 共享request请求域，先包含再编译，不检查包含页面的变化。<br>
        >动态的include：是jsp动作来实现的，`<jsp:include page="xx.jsp" flush="true"/> ` 这个是不共享request请求域，先编译在包含，是要检查包含页面的变化的。
    
    * 
        >Xmx10240m：代表最大堆<br>
        >-Xms10240m：代表最小堆 

    * 关于JVM内存
        * 程序计数器是一个比较小的内存区域，用于指示当前线程所执行的字节码执行到了第几行，是线程隔离的                  `正确`
        * 虚拟机栈描述的是Java方法执行的内存模型，用于存储局部变量，操作数栈，动态链接，方法出口等信息，是线程隔离的     `正确`
        * 方法区用于存储JVM加载的类信息、常量、静态变量、以及编译器编译后的代码等数据，是线程隔离的                     `错误`
        * 原则上讲，所有的对象都在堆区上分配内存，是线程之间共享的                                                   `正确`

             >大多数 JVM 将内存区域划分为 Method Area（Non-Heap）（方法区） ,Heap（堆） , Program Counter Register（程序计数器） ,   VM Stack（虚拟机栈，也有翻译成JAVA 方法栈的）,Native Method Stack  （ 本地方法栈 ），其中Method Area 和  Heap 是线程共享的  ，VM Stack，Native Method Stack  和Program Counter Register  是非线程共享的。为什么分为 线程共享和非线程共享的呢?请继续往下看。<BR>

            >首先我们熟悉一下一个一般性的 Java 程序的工作过程。一个 Java 源程序文件，会被编译为字节码文件（以 class 为扩展名），每个java程序都需要运行在自己的JVM上，然后告知 JVM 程序的运行入口，再被 JVM 通过字节码解释器加载运行。那么程序开始运行后，都是如何涉及到各内存区域的呢？<BR>

            >概括地说来，JVM初始运行的时候都会分配好 Method Area（方法区） 和Heap（堆） ，而JVM 每遇到一个线程，就为其分配一个 Program Counter Register（程序计数器） ,   VM Stack（虚拟机栈）和Native Method Stack  （本地方法栈）， 当线程终止时，三者（虚拟机栈，本地方法栈和程序计数器）所占用的内存空间也会被释放掉。这也是为什么我把内存区域分为线程共享和非线程共享的原因，非线程共享的那三个区域的生命周期与所属线程相同，而线程共享的区域与JAVA程序运行的生命周期相同，所以这也是系统垃圾回收的场所只发生在线程共享的区域（实际上对大部分虚拟机来说知发生在Heap上）的原因。<BR>
    
    * 有关jdbc statement
        * JDBC提供了Statement、PreparedStatement 和 CallableStatement三种方式来执行查询语句，其中 Statement 用于通用查询， PreparedStatement 用于执行参数化查询，而 CallableStatement则是用于存储过程 `正确普通的不带参的查询SQL；支持批量更新,批量删除;`
        * 对于PreparedStatement来说，数据库可以使用已经编译过及定义好的执行计划，由于 PreparedStatement 对象已预编译过，所以其执行速度要快于 Statement 对象”`正确``接口添加了处理 IN 参数的方法;可变参数的SQL,编译一次,执行多次,效率高;安全性好，有效防止Sql注入等问题; ` `CallableStatement: 继承自PreparedStatement,支持带参数的SQL操作; 支持调用存储过程,提供了对输出和输入/输出参数(INOUT)的支持; `
        * PreparedStatement中，“?” 叫做占位符，一个占位符可以有一个或者多个值 `错误 只能有一个`
        * PreparedStatement可以阻止常见的SQL注入式攻击 `正确`

        >PreparedStatement是预编译的，使用PreparedStatement有几个好处 
        >1. 在执行可变参数的一条SQL时，PreparedStatement比Statement的效率高，因为DBMS预编译一条SQL当然会比多次编译一条SQL的效率要高。 
        >2. 安全性好，有效防止Sql注入等问题。 
        >3.  对于多次重复执行的语句，使用PreparedStament效率会更高一点，并且在这种情况下也比较适合使用batch； 
        >4.  代码的可读性和可维护性。

    * 关于servlet
        >Servlet生命周期分为三个阶段： 　　1，初始化阶段  调用init()方法 　　2，响应客户请求阶段　　调用service()方法 　　3，终止阶段　　调用destroy()方法 <br> 所以要区分这里的service方法之于做数据库处理的service对象。 <br>

        >doGet/doPost 则是在 javax.servlet.http.HttpServlet 中实现的

        >init方法： 是在servlet实例创建时调用的方法，用于创建或打开任何与servlet相的资源和初始 化servlet的状态，Servlet规范保证调用init方法前不会处理任何请求  <br>
        >service方法：是servlet真正处理客户端传过来的请求的方法，由web容器调用， 根据HTTP请求方法（GET、POST等），将请求分发到doGet、doPost等方法 <br>
        >destory方法：是在servlet实例被销毁时由web容器调用。Servlet规范确保在destroy方法调用之 前所有请求的处理均完成，需要覆盖destroy方法的情况：释放任何在init方法中 打开的与servlet相关的资源存储servlet的状态 <br>

        `Servlet是线程不安全的，在Servlet类中可能会定义共享的类变量，这样在并发的多线程访问的情况下，不同的线程对成员变量的修改会引发错误。`

    * forword和redirect
        * forword 一次请求，地址栏不变。
        * edirect 两次请求，地址栏变。

    * JDBC的连接
        ![image.png](https://i.loli.net/2020/03/31/a2Z864qMVHlG1yD.png)
        ![image.png](https://i.loli.net/2020/03/31/8RhajPYtDQGxfJH.png)


    * Stack和Heap
        ![image.png](https://i.loli.net/2020/03/31/CYrqL71uphoPtXx.png)



    * 重载与重写
        * 方法重载（overload）：
            * 必须是同一个类
            * 方法名（也可以叫函数）一样
            * 参数类型不一样或参数数量不一样
        * 方法的重写（override）两同两小一大原则：
            * 方法名相同，参数类型相同
            * 子类返回类型小于等于父类方法返回类型，
            * 子类抛出异常小于等于父类方法抛出异常，
            * 子类访问权限大于等于父类方法访问权限。

            * 面试：
                 > 答：方法的重载和重写都是实现多态的方式，区别在于前者实现的是编译时的多态性，而后者实现的是运行时的多态性。重载发生在一个类中，同名的方法如果有不同的参数列表（参数类型不同、参数个数不同或者二者都不同）则视为重载；重写发生在子类与父类之间，重写要求子类被重写方法与父类被重写方法有相同的参数列表，有兼容的返回类型，比父类被重写方法更好访问，不能比父类被重写方法声明更多的异常（里氏代换原则）。重载对返回类型没有特殊的要求，不能根据返回类型进行区分。



         




