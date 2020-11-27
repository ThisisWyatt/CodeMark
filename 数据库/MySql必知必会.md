---
title: 《MySql必知必会》学习笔记
categories: Code
tags: Mysql
declare: true
wordCount: true
abbrlink: 27b4eaba
date: 2020-07-23 20:59:10
---
<div style="width: 95%">

![《MySql必知必会》学习笔记](https://img2020.cnblogs.com/blog/2104937/202007/2104937-20200723232459669-218625272.png)

</div>


MySQL已经成为世界上最受欢迎的数据库管理系统之一。无论是用 在小型开发项目上，还是用来构建那些声名显赫的网站，MySQL都证明 了自己是个稳定、可靠、快速、可信的系统，足以胜任任何数据存储业 务的需要。
<!-- more -->

## MySql的使用
```sql
--选择数据库
use database; 

--返回可用数据库列表
show database; 

--返回一个数据库内表的列表
show tables; 

--对一个表的每个字段返回一行，行中包括字段名、数据类型、是否允许NULL、键信息、默认值以及其他信息等
show columns from table;    
--功能同上
describe table;

--用于显示广泛的服务器状态信息； 
show status;    

--显示创建创建数据库和表的MySql信息
show create database; 
show create table; 

--用于显示服务器错误或警告信息
show errors; 
show warnings; 
```
<br><br> 

***

<br><br>

## 检索数据
```sql
--查询多个字段
select nickname,email from user;  

--查询不同的姓名
select distinct nickname from user; 

--返回前几行
select nickname,email from user limit 1; 

--返回从第0行开始的2行
select nickname,email from user limit 0,2;  

--功能同上
select nickname,email from user limit 0 offset 2;  
```

<br><br> 

***

<br><br>

## 排序和过滤检索数据
```sql
--按照年龄从大到小排序，如果年龄相同则按照昵称从小到大排序
select nickname,email from user order by age desc , nickname;   

--返回年龄不等于20的用户姓名 `<>`用法等同于`!=`
select nickename from user where age <> 20; 

--返回邮箱信息为空的用户名
select nickename from user where email is NULL; 

--返回邮箱信息为空的用户名
select nickename from user where email is NULL; 

--默认执行顺序为 `( age=10 ) or ( age=20 and eamil is NULL )`，`and`优先级更高
select * from user where age=10 or age=20 and eamil is NULL; //

--对`IN`后圆括中的每一个元素进行匹配，等同于`OR`
select * from user where age in(10,20); 

--对其中条件进行否定
select * from user where age not in(10,20); 

--表示昵称包含字符e的所有用户，%表示通配符 表示任何字符出现的次数，0次、1次或多次。
select * from user where nickname like '%e%';   

--表示昵称第二个字符为e的所有用户，`_`表示匹配单个字符。 
select * from user where nickname like '_e%';   

```

<br><br> 

***

<br><br>

## 正则表达式

```sql
--正则表达式，匹配年龄为10、20、30... 的用户，`.`表示匹配任意一个字符
select * from user where age REGEXP '.0';   

-- `BINARY`用于正则表达式中区分大小写
select * from user where age BINARY REGEXP 'JetPack.000';   

--正则表达式进行OR匹配
select * from user where age BINARY REGEXP '1000|1000';   

--返回的是`1 Ton` `2 Ton` ,`[123]`为`[1|2|3]`的缩写，表示匹配1或2或3
select nickname from user where nickname BINARY REGEXP '[123] Ton';   

--返回的是匹配指定字符串以外的值
select nickname from user where nickname BINARY REGEXP '[^123] Ton';   

--nikename中包含`a Ton` `b Ton` `c Ton`，age中包含1,2,3
select nickname from user where nickname BINARY REGEXP '[a-c] Ton' and age REGEXP '[1-3]';  
```



### 匹配字符类     
类|说明 
-|-
[:alnum:]|任意字符和数字（同[a-zA-Z0-9]）
[:alpha:]|任意字符（同[a-zA-Z]）
[:blank:]|空格和制表（同[\\t]）
[:cntrl:]|ASCII控制字符（ASCII 0到31和127）
[:digit:]|任意数字（同[0-9]）
[:graph:]|与[:print:]相同，但不包括空格
[:lower:]|任意小写字母（同[a-z]）
[:print:]|任意可打印字符
[:punct:]|既不在[:alnum:]又不在[:cntrl:]中的任意字符
[:space:]|包括空格在内的任意空白字符（同[\\f\\n\\r\\t\\v]）
[:upper:]|任意大写字母（同[A-Z]）
[:xdigit:]|任意十六进制数字（同[a-fA-F0-9]）

<br>

### 匹配多个实例
元字符|说明
-|-
*|0个或多个匹配
+|1个或多个匹配（等于{1,}）
?|0个或1个匹配（等于{0,1}）
{n}|指定数目的匹配
{n,}|不少于指定数目的匹配
{n,m}|匹配数目的范围（m不超过255）

> **'\\\\([0-9]stick?\\\\)'**    
> A (1 stick)     
> B (1 sticks)    
> `\\`为转移符 ，第一个\是MySql自己解释一个，第二\是正则表达式解释一个

<br>

### 定位符
元字符|说明
-|-
^|文本的开始
$|文本的结尾
[[:<:]]|词的开始
[[:>:]]|词的结尾

> '^\[0-9\\.]'     
> `^`匹配串的开始，即以数字开头或者`.`开头的字符串



## 计算字段
### 拼接
```sql
-- 按照 `云卷云舒（20）`这样的昵称+年龄格式表示，`RTrim`去掉值右边的所有空格，
select Concat(RTrim(nick_name),'(',RTrim(age),')') from user_info;
```
<br>

### 使用别名
```sql
-- as info
select Concat(RTrim(nick_name),'(',RTrim(age),')') as info from user_info;
```
<br>

### 算术运算 
```sql
select order_id,quantity,item_price,quantity*item_price as cost from order_items;
```
操作符|说明
-|-
+|加法
-|减法
*|乘法
/|除法



<br><br> 

***

<br><br>

## 数据处理函数
### 文本处理函数
函数|说明
-|-
Left()|返回串左边的字符
Length()|返回串的长度
Locate()|找出串的一个子串
Lower()|将串转换为小写
LTrim()|去掉串左边的空格
Right()|返回串右边的字符
RTrim()|去掉串右边的空格
Soundex()|返回串的SOUNDEX值
SubString()|返回子串的字符
Upper()|将串转换为大写



>SOUNDEX:将任何文本串转换为其语音表示的字母数字模式的算法。使得能**对串进行发音比较而不是字母比较**
```sql
-- nikename发音类似cc的所有nickname
select nickname from user_info where Soundex(nickname)=Soundex('cc');
```
<br>

### 时间处理函数
函数|说明
-|-
AddDate()|增加一个日期（天、周等）
AddTime()|增加一个时间（时、分等）
CurDate()|返回当前日期
CurTime()|返回当前时间
Date()|返回日期时间的日期部分
DateDiff()|计算两个日期之差
Date_Add()|高度灵活的日期运算函数
Date_Format()|返回一个格式化的日期或时间串
Day()|返回一个日期的天数部分
DayOfWeek()|对于一个日期，返回对应的星期几
Hour()|返回一个时间的小时部分
Minute()|返回一个时间的分钟部分
Month()|返回一个日期的月份部分
Now()|返回当前日期和时间
Second()|返回一个时间的秒部分
Time()|返回一个日期时间的时间部分
Year()|返回一个日期的年份部分

>日期格式最好为yyyy-mm-dd,可以排除多义性，这样MySql就不必做出任何假设，更加可靠

>`select * from user where birthday='2000-01-01'` 会和 birthday为'2000-01-01 01:01:01'的匹配失败     
> 更好的解决方案是利用`Date()`函数直接匹配日期部分 `select * from user where Date(birthday)='2000-01-01'`

### 数值处理函数
函数|说明
-|-
Abs()|返回一个数的绝对值
Cos()|返回一个角度的余弦
Exp()|返回一个数的指数值
Mod()|返回除操作的余数
Pi()|返回圆周率
Rand()|返回一个随机数
Sin()|返回一个角度的正弦
Sqrt()|返回一个数的平方根
Tan()|返回一个角度的正切

<br><br>
***
<br><br>

## 汇总数据
### 聚集函数
函数|说明
-|-
AVG()|返回某列的平均值
COUNT()|返回某列的行数
MAX()|返回某列的最大值
MIN()|返回某列的最小值
SUM()|返回某列值之和

>以上函数均忽略列值为NULL的行

```sql
select AVG(age)    from user_info;
select COUNT(age)  from user_info;
select MAX(age)    from user_info;
select MIN(age)    from user_info;
select SUM(age)    from user_info;
```

<br><br>
***
<br><br>

## 分组函数

### 创建分组

1. 先按照特定顺序分组
2. 再对**每一组**进行计算

```sql
-- 先按照昵称分组，然后对每一组进行求和运算
select nick_name,SUM(age) from user_info group by nick_name;
```
>select后的每一列都**必须在GROUP BY字句中给出**

>如果在select中使用表达式，则必须在group by子句中指定相同的表达式

### 过滤分组
HAVING:
* 基础功能和WHERE一样，在简单句式中可以替代WHERE
* 区别：
    * WHERE过滤行，HAVING过滤分组
    * WHERE在数据**分组前**过滤数据，HAVING在数据**分组后**对组进行分组。

```sql
-- 先对过滤掉age<=10的数据，再筛选出分组总年龄大于100的小组
select nick_name,SUM(age) from user_info where age>10 group by nick_name having SUM(age)>100;
```

<br><br>
***
<br><br>

## 子查询

### 利用子查询过滤
>现在有订单表orderitems，客户信息表customers，订单物品表orderitems      
>查询出订购物品cc2的所有客户姓名

* 检索包含物品cc2的所有订单的编号。
```sql
select order_num from orderitems where prod_id='cc2';
```
* 检索具有前一步骤列出的订单编号的所有客户的ID。
```sql
select cust_id from orders where order_num IN (2005,2006);
```
* 检索前一步骤返回的所有客户ID的客户信息。 **从内向外执行**
```sql
select cust_id from orders where order_num IN (select order_num from orderitems where prod_id='cc2');
```
* 从客户ID中查询出信息
```sql
select 
    cust_name 
from 
    customers 
where 
    cust_id IN (select 
                    cust_id 
                from 
                    orders 
                where 
                    order_num IN (select 
                                    order_num 
                                from 
                                    orderitems 
                                where 
                                    prod_id='cc2'));
```


### 作为计算手段使用子查询
>现有订单表orderitems，客户信息表customers      
>查询每个用户的订单总数

* 查询某个用户的所有订单数
```sql
select count(*) as orders from orders where cust_id=1001;
```
* 查询在订单表中每个用户的订单总数及其信息
```sql
select cust_name,
       (select count(*)
        from orders 
        where oders.cust_id=customers.cust_id) as orders 
from customer 
order by cust_name;
```   


<br><br>
***
<br><br>

## 联结表
### 使用where
```sql
select vend_name,prod_name,prod_price from vendors,products where vendors.vend_id=prodcts.vend_id order by vend_name,prod_name;
```
### 内部联结
使用 INNER JOIN 指定表，再使用 ON 执行特定条件的连接

* 检索所有客户及其订单
```sql
SELECT customer.cust_id,orders.order_num FROM customer INNER JOIN orders ON customers.cust_id = orders.cust_id;
```

### 多表联结
```sql
select cust_name 
from customer,orders,orderitems 
where customer.cust_id=oders.cust_id 
and orderitems.order_num=orders.order_num
and prod_id='cc2';
```

<br><br>
***
<br><br>

## 高级联结
### 使用表别名
```sql
select cust_name 
from customer as c,orders as o,orderitems as oi 
where c.cust_id=o.cust_id 
and oi.order_num=o.order_num
and prod_id='cc2';
```

### 自联结
>在商品表中发一下一个不合格商品(id为cc3)，现在需要查找出生产这个商品的厂家的其他产品

* 使用子查询
```sql
SELECT prod_id,prod_name FROM products where vend_id = (SELECT vend_id FROM products WHERE prod_id = 'cc2');
```

* 使用自联结
```sql
SELECT p1.prod_id,p1.prod_name FROM products AS p1, products AS p2 WHERE p1.vend_id=p2.vend_id AND p2.prod_id = 'cc3';
```
>p1,p2实际上是相同的一张表

### 自然联结
无论何时对表进行联结，应该至少有一个列出现在不止一个表中，标准的联结(内部联结)返回所有的数据，**甚至所有的列多次出现**。

**自然联结排除多次出现，使每个列只返回一次。**


### 外部联结
许多联结将一个表中的行与另外一个表中的行相关联。但有时候需要**包含没有关联行的那些行**。
* 列出所有产品以及订购数据，**包括哪些没有人订购的产品**
* 对每个客户下了多少订单进行计数，**包括哪些至今尚未下订单的客户**
* 检索所有客户及其订单(内部联结)

```sql
SELECT customer.cust_id,orders.order_num FROM customer INNER JOIN orders ON customers.cust_id = orders.cust_id;
```

* 检索所有客户，包括那些没有下订单的客户(外部联结)
```sql
SELECT customer.cust_id,orders.order_num FROM customer LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id;
```

>RIGHT表示OUTER JION右边的表的所有行（匹配或不匹配）都将被检索出来   
>LEFT 表示OUTER JION左边的表   


### 带聚集函数的联结
检索出所有客户及每个客户所下的订单数
```sql
SELECT customers.cust_id,count(orders.ooder_num) FROM customer LEFT OUTER JOIN orders ON customer.cust_id = orders.cust_id ORDER BY customers.id;
```

<br><br>
***
<br><br>

## 组合查询
* 对于单个查询中从不同表汇总返回类似结构的数据
* 对单个表执行多个查询，按单个查询返回数据

### 使用UNION
>检索出所有价格小于5且来自2001,2002的供应商的所有商品
```sql
SELECT prod_id,pro_name
FROM products
WHERE prod_price < 5
UNION
SELECT prod_id,pro_name
FROM productes
WHERE vend_id in (2001,2003)
ORDER BY prod_name;
```

>默认去除多个SELECT结果的重复行，但是可以使用UNION ALL来返回所有的改变行      
>排序语句放在最后一个SELECT的后面


<br><br>
***
<br><br>

## 全文本搜索
### 启用全文搜索
MySql指定列中各词的一个索引，搜索可以针对这些词进行。这样，MySql可以快速有效地判断哪些行包含它们，哪些词不匹配，它们匹配的频率，等等
**FULLTEXT(列名称)**    
```sql
CREATE TABLE product(
    note_id     int         NOT NULL,
    pro_id      char(10)    NOT NULL,
    note_text   text        NOT NULL,
    PRIMARY KEY(pro_id),
    FULLTEXT(note_text)
)ENGINE=MyISAM;
```
>InnoDB不支持全文本搜索引擎

### 进行全文本搜索
Match()：指定被搜索的列      
Against()：指定要使用的搜索表达式
```sql
SELECT note_text FROM productnotes WHERE Match (note_text) Against('rabbit');
```

### 使用扩展查询
考虑下面 的情况。你想找出所有提到anvils的注释。只有一个注释包含词anvils， 但你还想找出可能与你的搜索有关的所有其他行，即使它们不包含词anvils。 这也是查询扩展的一项任务。在使用查询扩展时，MySQL对数据和 索引进行两遍扫描来完成搜索： 
* 首先，进行一个基本的全文本搜索，**找出与搜索条件匹配的所有行**；
* 其次，MySQL检查这些匹配行并**选择**所有有用的词（我们将会简 要地解释MySQL如何断定什么有用，什么无用）。 
* 再其次，MySQL再次进行全文本搜索，这次不仅使用原来的条件， 而且还使用所有有用的词。 
```sql
SELECT note_text FROM productnotes WHERE Match(note_text) Against ('anvil' WITH QUERY EXPANsION);
```
>可能返回多行，但只有第一行含有关键字'anvil'，其他行因为含有第一行的相关字而有可能被检索出来

### 布尔文本搜索
可以提供关于如下内容的细节：
* 要匹配的词
* 要排斥的词（如果某行包含这个词，则不返回该行，即使它包含 其他指定的词也是如此） 
* 排列提示（指定某些词比其他词更重要，更重要的词等级更高）
* 表达式分组
* 另外一些内容

布尔操作符|说明
-|-
+|包含，词必须存在
-|排除，词必须不出现
\>|包含，而且增加等级值 
<|包含，且减少等级值 
()|把词组成子表达式（允许这些子表达式作为一个组被包含、 排除、排列等） 
~|取消一个词的排序值 
*|词尾的通配符 
""|定义一个短语（与单个词的列表不一样，它匹配整个短语以 便包含或排除这个短语） 
 
```sql
SELECT note_text FROM productnotes WHERE Match(note_text) Against('heavy -rope*' IN BOOLEAN MODE);
```
>检索含有关键字`heavy`**但不含有以`rope`开头的行**


### 一些说明
* 在索引全文本数据时，**短词被忽略且从索引中排除**。短词定义为 那些具有*3个或3个以下字符的词*（如果需要，这个数目可以更改）。
* MySQL带有一个**内建的非用词（stopword）列表，这些词在索引全文本数据时总是被忽略**。如果需要，可以覆盖这个列表（请参 阅MySQL文档以了解如何完成此工作）。
* 许多词出现的频率很高，搜索它们没有用处（返回太多的结果）。 因此，MySQL规定了一条50%规则，**如果一个词出现在50%以上的行中，则将它作为一个非用词忽略**。*50%规则不用于IN BOOLEAN MODE。*
* 如果表中的**行数少于3行，则全文本搜索不返回结果**（因为每个词 或者不出现，或者至少出现在50%的行中）。 
* *忽略词中的单引号*。例如，don't索引为dont。 
* *不具有词分隔符（包括日语和汉语）的语言不能恰当地返回全文*本搜索结果。 
* 如前所述，**仅在MyISAM数据库引擎中支持全文本搜索。** 

<br><br> 

***

<br><br>

## 插入数据
### 插入完整的行
```sql
INSERT into customers VALUES (1,cc,cc@foxmail);
```
>对每个列**必须**提供一个值。**如果某个列没有值，应该使用NULL值**（假定表允许对该列指定空值）。
>对于自增的字段，也需要设为NULL

>种语法很简单，但并不安全，**应该尽量避免使用**。不能保证下一次表结构变动后各个列 保持完全相同的次序

```sql
INSERT into customers(cust_id,cust_name,cust_email) VALUES (1,cc,cc@foxmail);
```
>用VALUES 列表中的相应值填入列表中的对应项        
>对于自增字段，可以不出现

>如果数据检索是最重要的（通常是这样），则你可以通过在 INSERT和INTO之间添加关键字LOW_PRIORITY，指示MySQL 降低INSERT语句的优先级，如下所示：         
>`INSERT LOW_PRIORITY INTO`        
>这也适用于UPDATE和DELETE语句      

### 插入多行
```sql
INSERT into customers(cust_id,cust_name,cust_email) VALUES (1,cc1,cc1@foxmail),(2,cc2,cc2@foxmail);
```
###  插入检索出来的数据
合并新旧表
```sql
INSERT into cust_new(cust_id,
                      cust_name,
                      cust_email)
SELECT  cust_id,
        cust_name,   
        cust_email                
FROM cust_old;
```

<br><br> 

***

<br><br>

## 更新和删除数据
### 更新
```sql
UPDATE customers SET cust_email = 'newmail@foxmial.com', cust_name = 'newname' WHERE cust_id = '1';
```
> 如果没有`WHERE`语句，**则将更新这张表中所有数据**

>IGNORE关键字，如果用UPDATE语句更新多行，并且在更新这些行中的一行或多行时出一个现错误，则整个UPDATE操作被取消 （错误发生前更新的所有行被恢复到它们原来的值）。为即使是发生错误，也继续进行更新，可使用IGNORE关键字，如下所示： UPDATE IGNORE customers… 

>为了删除某一行的某个列值，可以将它更新为NULL

### 删除
* 删除一行
```sql
DELETE FROM customers WHERE cust_id = '1231';
```
>如果没有`WHERE`语句，**则将删除这张表中所有数据**     
>如果更快的删除而且删除清零自增字段，可以使用`truncate tablename`

除非确实打算更新和删除每一行，否则绝对不要使用不带WHERE 子句的UPDATE或DELETE语句。
保证每个表都有主键（如果忘记这个内容，请参阅第15章），尽可能 像WHERE子句那样使用它（可以指定各主键、多个值或值的范围）。
在对UPDATE或DELETE语句使用WHERE子句前，应该先用SELECT进 行测试，保证它过滤的是正确的记录，以防编写的WHERE子句不正确。 

### 创建和删除表
#### 创建表
```sql
CREATE TABLE product(
    pro_id      char(10)    NOT NULL  AUTO_INCREMENT, --自增
    note_id     int         NOT NULL,
    note_text   text        NOT NULL,
    pro_price   ine         NOT NULL DEFAULT 1, --默认值为1
    PRIMARY KEY(pro_id)
)ENGINE=InnoDB;
```
>自增字段 AUTO_INCREMENT，（每个表**只允许有一个自增字段**，且**必须被索引**<例如使它变为主键>）       
>使用`SELECT last_insert_id()`语句**返回最后一个AUTO_INCREMENT值**

> DEFAULT 设置默认值

#### 引擎类型
与其他DBMS一样，MySQL有一个**具体管理和处理数据**的内部引擎。 在你使用CREATE TABLE语句时，该引擎具体创建表，而在你使用SELECT 语句或进行其他数据库处理时，该引擎在内部处理你的请求。多数时候， 此引擎都隐藏在DBMS内，不需要过多关注它。   

但MySQL与其他DBMS不一样，**它具有多种引擎**。它打包多个引擎， 这些引擎都隐藏在MySQL服务器内，全都能执行CREATE TABLE和SELECT 等命令。 

为什么要发行多种引擎呢？因为它们**具有各自不同的功能和特性**， 为不同的任务选择正确的引擎能获得**良好的功能和灵活性**。 

当然，你完全可以忽略这些数据库引擎。如果省略ENGINE=语句，则 使用默认引擎（很可能是MyISAM），多数SQL语句都会默认使用它。但并不是所有语句都默认使用它，这就是为什么ENGINE=语句很重要的原因 （也就是为什么本书的样列表中使用两种引擎的原因）。 

* InnoDB是一个**可靠的事务处理引擎**（参见第26章），它**不支持全文本搜索**
* MEMORY在功能等同于MyISAM，但由于**数据存储在内存**（不是磁盘） 中，**速度很快**（特别适合于临时表）
* MyISAM是一个**性能极高**的引擎，它支持全文本搜索（参见第18章）， 但**不支持事务处理**。 
 
#### 更新表
为更新表定义，可使用**ALTER TABLE**语句。但是，理想状态下，*当表中存储数据以后，该表就不应该再被更新*。在表的设计过程中需要花费大量时间来考虑，以便后期不对该表进行大的改动。 

```sql
--增加字段
ALTER TABLE products ADD prod_price;
--删除字段
ALTER TABLE products DROP prod_price;
--定义外键
ALTER TABLE products ADD CONSTRAINT orderitems FOREIGN KEY (order_num) REFERENCES (order_num);
```

**复杂的表结构更改**一般需要手动删除过程，它涉及以下步骤： 
* 用新的列布局创建一个新表
* 使用INSERT SELECT语句从旧表复制数据到新表
* 检验包含所需数据的新表
* 重命名旧表（如果确定，可以删除它）
* 用旧表原来的名字重命名新表
* 根据需要，重新创建触发器、存储过程、索引和外键
 
#### 删除表
```sql
DROP TABLE customers;
```

#### 重命名表
```sql
RENAME TABLE customer1 TO customer2;
```

<br><br> 

***

<br><br>

## 视图
视图是**虚拟的表**。与包含数据的表不一样，视图**只包含使用时动态检索数据的查询**。 
>它**本身不包含**表中应该有的**任何列或数据**，它**包含的是一个SQL查询**


### 视图的应用
* **重用SQL语句**
* **简化复杂的SQL操作**。在编写查询后，可以方便地重用它而不必知道它的基本查询细节
* **使用表的组成部分**而不是整个表。
* **保护数据**。可以给用户授予表的特定部分的访问权限而不是整个 表的访问权限
* **更改数据格式和表示**。视图可返回与底层表的表示和格式不同的数据

在视图创建之后，可以用与表基本相同的方式利用它们。可以对视图**执行SELECT操作**，**过滤**和**排序**数据，将视**图联结到其他视图或表**，甚至能**添加**和**更新**数据（添加和更新数据存在某些限制。关于这个内容稍 后还要做进一步的介绍）。 
>如果你用多个联结和过滤创建了复杂的视图或者嵌套了视图，可能会发现性能下降得很厉害。

### 视图的规则和限制
* 视图必须唯一命名
* 创建的视图数目没有限制
* **必须具有足够的访问权限**
* **视图可以嵌套**，即可以利用从其他视图中检索数据的查询来构造 一个视图
* ORDER BY可以用在视图中，但如果从该视图检索数据SELECT中也含有ORDER BY，那么该视图中的ORDER BY将被覆盖
* **视图不能索引**，也不能有关联的触发器或默认值
* 视图可以和表一起使用。例如，编写一条联结表和视图的SELECT 语句。 

### 使用视图
* CREATE VIEW语句来创建
* SHOW CREATE VIEW viewname；来查看创建视图的语
* 用DROP删除视图，其语法为DROP VIEW viewname
* 更新视图时，可以先用DROP再用CREATE，也可以直接用`CREATE OR REPLACE VIEW`。如果要更新的视图不存在，则第2条更新语句会创 建一个视图；如果要更新的视图存在，则第2条更新语句会替换原 有视图

### 更新视图
通常，视图是可更新的，但是，并非所有视图都是可更新的。基本上可以说，**如果MySQL不能正确地确定被更新的基数据，则不允许更新**（包括插入和删除）。这实际上意味着，如果视图定义中有以下操作，则不能进行视图的更新： 
* 分组
* 联结
* 子查询
* 并
* 聚集函数（Min()、Count()、Sum()等）
* DISTINCT
* 导出（计算）列

<br><br> 

***

<br><br>

## 存储过程 
迄今为止，使用的大多数SQL语句都是针对一个或多个表的单条语 句。并非所有操作都这么简单，经常会有一个完整的操作需要多条语句 才能完成。例如，考虑以下的情形
* 为了处理订单，需要核对以保证库存中有相应的物品
* 如果库存有物品，这些物品需要预定以便不将它们再卖给别的人，并且要减少可用的物品数量以反映正确的库存量
* 库存中没有的物品需要订购，这需要与供应商进行某种交互 
* 关于哪些物品入库（并且可以立即发货）和哪些物品退订，需要通知相应的客户

执行这个**处理需要针对许多表的多条MySQL语句**。此外，需要执行的**具体语句及其次序**也不是固定的，它们可能会（和将）根据哪些物品在库存中哪些不在而变化。 

存储过程简单来说，就是为以后的使用而保存的**一条或多条MySQL语句的集合**。
>可将其视为批文件，虽然它们的作用不仅限于批处理。 

### 使用存储过程的优缺点
#### 优点
**简单、安全、高性能**
* 通过把处理封装在容易使用的单元中，**简化复杂的操作**（正如前 面例子所述）
* 由于不要求反复建立一系列处理步骤，这**保证了数据的完整性**。*如果所有开发人员和应用程序都使用同一（试验和测试）存储过程，则所使用的代码都是相同的*。 这一点的延伸就是防止错误。需要执行的步骤越多，出错的可能性就越大。防止错误**保证了数据的一致性**
* **简化对变动的管理**。如果表名、列名或业务逻辑（或别的内容） 有变化，只需要更改存储过程的代码。使用它的人员甚至不需要知道这些变化
* **提高性能**。因为使用存储过程比使用单独的SQL语句要快 
* 存在一些只能用在单个请求中的MySQL元素和特性，存储过程可以使用它们来编写**功能更强更灵活**的代码

#### 缺点
* 存储过程的**编写比基本SQL语句复杂**，编写存储过程需要更高的技能，更丰富的经验。 
* 你可能**没有创建存储过程的安全访问权限**。许多数据库管理员限 制存储过程的创建权限，允许用户使用存储过程，但不允许他们 创建存储过程。 

### 使用存储过程
* 执行（call）
```sql
CALL productpricing(@pricelow,@pricehigh,@priceaverage);
```
### 创建存储过程
返回产品平均过程的存储过程
```sql
CREATE PROCEDURE productpricing()
BEGIN
    SELECT AVG(prod_price) AS priceaverage FROM products;
END
```
> 注意productpricing()的()

mysql命令行客户机的分隔符(命令行工具)
```sql
DELIMITER//


CREATE PROCEDURE productpricing()
BEGIN
    SELECT AVG(prod_price) AS priceaverage FROM products;
END//

DELIMITER;

```
>因为在存储过程存在`;`，所以在命令行程序中需使用特定的分隔符     
>DELIMITER+符号（分隔符）：表示告诉程序使用此分隔符作为新的语句结束分隔符,所以由`END`变为了`END//`     
>除\符号外，任何字符都可以用作语句分隔符。 

### 删除存储过程
```sql
DROP PROCEDURE productpricing;
```
>注意没有`()`    
>如果该存储过程不存在，则会报错，所以建议使用`DROP PROCEDURE IF EXISTS`

### 使用参数
* 创建带参数的存储过程
```sql
CREATE PROCEDURE productpricing(
    OUT pl DECIMAL(8,2),    --pl:存储产品最低价格
    OUT ph DECIMAL(8,2),    --ph:存储产品最高价格
)
BEGIN
    SELECT MIN(prod_price) INTO pl FROM products;
    SELECT MAX(prod_price) INTO ph FROM products;
END
```
>存储过程保存在BEGIN和END之间

> OUT指出相应的参数用来**从存储过程传出** 一个值（返回给调用者）     
> IN,传递给存储过程     
> INOUT，对存储过程传入传出


* 使用存储过程
```sql
--指定变量名
CALL productpricing(@pricelow, @prichigh);

--检索
SELECT @prcielow;

SELECT @prcielow, @prichigh;
```

### 检查存储过程
```sql
-- 显示创建的语句
SHOW CREATE PROCEDURE ordertotal;

-- 显示更加详细，何时、由何人创建的信息
SHOW CREATE PROCEDURE STATUS ordertotal;

-- 过滤查看更多存储过程的信息
SHOW CREATE PROCEDURE STATUS LIKE 'ordertotal';
```
<br><br> 

***

<br><br>

## 游标

（~~有待填坑~~）

有时，**需要在检索出来的行中前进或后退一行或多行**。这就是使用游标的原因。游标（cursor）是**一个存储在MySQL服务器上的数据库查询**， 它不是一条SELECT语句，**而是被该语句检索出来的结果集**。在存储了游标之后，应用程序可以根据需要滚动或浏览其中的数据。 

游标主要用于交互式应用，其中用户需要滚动屏幕上的数据，并对数据进行浏览或做出更改。 

### 使用注意
* 在能够**使用游标前，必须声明**（定义）它
* 一旦声明后，必须打开游标以供使用。
* 对于填有数据的游标，根据需要取出（检索）各行。 
* 在结束游标使用时，必须关闭游标。 

### 创建游标
```sql
CREATE PROCEDURE processorders()
BEGIN
    DECLARE ordernumbers CURSOR
    FOR
    SELECT order_num FROM orders;
END;
```
### 打开和关闭游标
```sql
--打开
OPEN ordernumbers;

--关闭
CLOSE ordernumbers;
```
>如果不明确关闭游标，MySql将会在到达END语句时自动关闭

### 使用游标
在一个游标被打开后，可以使用**FETCH语句**分别访问它的每一行。 FETCH指定检索什么数据（所需的列），检索出来的数据存储在什么地方。 它还向前移动游标中的内部行指针，使下一条FETCH语句检索下一行（不重复读取同一行）。
```sql
CREATE PROCEDURE processorders()
BEGIN
    --声明一个变量
    DECLARE o INT;
    --声明一个游标
    DECLARE ordernumbers CURSOR
    FOR
    SELECT order_num FROM orders;
    --打开一个游标
    OPEN ordernumbers;
    --获取数据
    FETCH ordernumbers INTO o;
    --关闭游标
    CLOSE ordernumbers;
END;
```
<br><br> 

***

<br><br>
 
## 触发器
MySQL语句在需要时被执行，存储过程也是如此。但是，如果你想要**某条语句（或某些语句）在事件发生时自动执行**，怎么办呢？例如： 
* 每当增加一个顾客到某个数据库表时，都检查其电话号码格式是 否正确，州的缩写是否为大写； 
* 每当订购一个产品时，都从库存数量中减去订购的数量； 
* 无论何时删除一行，都在某个存档表中保留一个副本。 

所有这些例子的共同之处是它们都需要在某个表发生更改时自动处理。这确切地说就是触发器。触发器是MySQL响应以下任意语句而自动执行的一条MySQL语句（或位于BEGIN和END语句之间的一组语 句） ： 
* DELETE； 
* INSERT； 
* UPDATE。

*其他MySQL语句不支持触发器。* 

### 创建触发器
在创建触发器时，需要给出4条信息： 
* 唯一的触发器名； 
* 触发器关联的表； (只有表支持触发器，视图不支持)
* 触发器应该响应的活动（DELETE、INSERT或UPDATE）； 
* 触发器何时执行（处理之前或之后）。 

>每个表将最多支持6个触发器，DELETE、INSERT或UPDATE的处理之前或之后

 
> 在MySQL 5中，触发器名必 须在每个表中唯一，但不是在每个数据库中唯一。这表示同一 数据库中的两个表可具有相同名字的触发器。这在其他每个数 据库触发器名必须唯一的DBMS中是不允许的，而且以后的 MySQL版本很可能会使命名规则更为严格。因此，现在最好 是在数据库范围内使用唯一的触发器名。 
 
```sql
CREATE TRIGGER newproduct AFTER INSERT ON products FOR EACH ROW SELECT 'product added';
```
> 使用INSERT语句添加一行或多行到products表中时，将对每一行显示文本product added
 
### 删除触发器
```sql
DROP TRIGGER newproduct;
```
>触发器不能更新或覆盖。为了修改一个触发器，必须先删除它， 然后再重新创建。

### 使用触发器
#### INSERT触发器 
INSERT触发器在INSERT语句执行之前或之后执行。需要知道以下几点： 
* 在INSERT触发器代码内，可引用一个**名为NEW的虚拟表，访问被插入的行**； 
* 在BEFORE INSERT触发器中，NEW中的值也可以被更新（允许更改被插入的值） ； 
* 对于AUTO_INCREMENT列，NEW在INSERT执行之前包含0，在INSERT执行之后包含新的自动生成值。 
```sql
CREATE TRIGGER newproduct AFTER INSERT ON products FOR EACH ROW SELECT NEW.order_num;
```
>在插入一个新订单到orders表时，MySQL生成一个新订单号并保存到order_num中。触发器从NEW. order_num取得这个值并返回它。

#### DELETE触发器
DELETE触发器在DELETE语句执行之前或之后执行。需要知道以下两 点： 
* 在DELETE触发器代码内，你可以引用一个名为**OLD的虚拟表，访问被删除的行**；
* OLD中的值全都是只读的，不能更新。  
```sql
CREATE TRIGGER deleteorder BEFORE DELETE ON products FOR EACH ROW
BEGIN
    INSERT INTO archive_orders(order_num,order_date)
    VALUES(OLD.order_num,OLD.order_num);
END;
```
>在任意订单被删除前将执行此触发器。它使用一条INSERT语句 将OLD中的值（要被删除的订单）保存到一个名为archive_ orders的存档表中


#### UPDATE触发器 
UPDATE触发器在UPDATE语句执行之前或之后执行。需要知道以下几点：
* 在UPDATE触发器代码中，你可以引用一个名为**OLD**的虚拟表**访问以前**（UPDATE语句前）的值，引用一个名为**NEW的虚拟表访问新更新的值**； 
* 在BEFORE UPDATE触发器中，NEW中的值可能也被更新（允许更改 将要用于UPDATE语句中的值）； 
* OLD中的值全都是**只读的，不能更新**。 
```sql
CREATE TRIGGER updateevendor BEFORE DELETE ON vendors FOR EACH ROW SET NEW.vend_state = Upper(NEW.vend-state);
```
>下面的例子保证州名缩写总是大写（不管UPDATE语句中给出的是大 写还是小写）： 
 

### 进一步介绍

在结束本章之前，我们再介绍一些使用触发器时需要记住的重点。
* 与其他DBMS相比，MySQL 5中支持的触发器相当初级。未来的 MySQL版本中有一些改进和增强触发器支持的计划。 
* 创建触发器可能需要特殊的安全访问权限，但是，**触发器的执行是自动的。如果INSERT、UPDATE或DELETE语句能够执行，则相关的触发器也能执行**。 
* 应该用触发器来**保证数据的一致性**（大小写、格式等）。在触发器中执行这种类型的处理的优点是它总是进行这种处理，而且是透明地进行，与客户机应用无关。 
* 触发器的一种非常有意义的使用是**创建审计跟踪**。使用触发器，把更改（如果需要，甚至还有之前和之后的状态）记录到另一个 表非常容易。 
* 遗憾的是，MySQL触发器中不支持CALL语句。这表示不能从触发器内调用存储过程。所需的存储过程代码需要复制到触发器内。

<br><br> 

***

<br><br>

## 事务处理
事务处理（transaction processing）可以用来维护数据库的完整性，它 保证成批的MySQL操作**要么完全执行，要么完全不执行。** 

 
利用事务处理，可以保证一组操作不会中途停止，它们或者作为整体执行，或者完全不执行（除非明确指示）**。如果没有错误发生，整组语句提交给（写到）数据库表。如果发生错误，则进行回退（撤销）以恢复数据库到某个已知且安全的状态。**
 
> * 事务（transaction）指一组SQL语句； 
> * 回退（rollback）指撤销指定SQL语句的过程； 
> * 提交（commit）指将未存储的SQL语句结果写入数据库表； 
> * 保留点（savepoint）指事务处理中设置的临时占位符（place- holder），你可以对它发布回退（与回退整个事务处理不同

### 使用ROLLBACK 
MySQL的ROLLBACK命令用来回退（撤销）MySQL语句。
```sql
SELECT * FROM ordertotals ;
--开始事物
START TRANSACTION; 
DELETE FROM ordertotals;
SELECT * FROM ordertotals;
--撤销
ROLLBACK;
SELECT * FROM ordertotals;
```
>首先执行一条SELECT以显示该表不为空。然后开始一个事务处理，用一条DELETE语句删除ordertotals中的所有行。另一条 SELECT语句验证ordertotals确实为空。这时用一条ROLLBACK语句**回退 START TRANSACTION之后的所有语句**，最后一条SELECT语句显示该表不为空。 

### 使用COMMIT
一般的MySQL语句都是直接针对数据库表执行和编写的。这就是所谓的隐含提交（implicit commit），即提交（写或保存）操作是自动进行的。 

但是，**在事务处理块中，提交不会隐含地进行**。为进行明确的提交，使用COMMIT语句，如下所示： 
 ```sql
--开始事物
START TRANSACTION; 
DELETE FROM ordertotals WHERE order_num = 20010;
DELETE FROM orders WHERE order_num = 20010;
--提交
COMMIT;
```
>从系统中完全删除订单20010。因为涉及更新两个数据库表orders和orderItems，所以使用事务处理块来**保证订单不被部分删除**。最后的COMMIT语句**仅在不出错时写出更改**。如 果第一条DELETE起作用，但第二条失败，则DELETE不会提交（实际上，它是被自动撤销的） 

>**隐含事务关闭**  当COMMIT或ROLLBACK语句执行后，事务会自 动关闭（将来的更改会隐含提交）。 

### 使用保用点
简单的ROLLBACK和COMMIT语句就可以写入或撤销整个事务处理。但 是，只是对简单的事务处理才能这样做，更复杂的事务处理可能需要**部分提交或回退**。 
```sql
--创建保用点
SAVEPOINT delete1;
--回退
ROLLBACK TO delete1
```
>**保留点越多越好** .可以在MySQL代码中设置任意多的保留 点，越多越好。为什么呢？因为保留点越多，你就越能按自己的意愿**灵活**地进行回退。

> 保留点在事务处理完成（执行一条**ROLLBACK或 COMMIT）后**自动释放**。自MySQL 5以来，也可以用RELEASE SAVEPOINT明确地释放保留点。 
 
### 更改默认提交方式
正如所述，默认的MySQL行为是自动提交所有更改。换句话说，任何时候你执行一条MySQL语句，该语句实际上都是针对表执行的，而且所做的更改立即生效。为指示MySQL不自动提交更改，需要使用以下语句： 
```sql
SET autocommit=0;
```

## 全球化和本地化 
**不同的语言和字符集需要以不同的方式存储和检索**。

因此，MySQL需要适应不同的字符集（不同的字母和字符），适应不同的排序和检索数据的方法。

* **字符集**：字母和符号的集合； 
* **编码**：某个字符集成员的内部表示； 
* **校对**：规定字符如何比较的指令。 
>校对为什么重要  排序英文正文很容易，对吗？或许不。考 虑词APE、apex和Apple。它们处于正确的排序顺序吗？这有 赖于你是否想区分大小写。使用区分大小写的校对顺序，这 些词有一种排序方式，使用不区分大小写的校对顺序有另外 一种排序方式。这不仅影响排序（如用ORDER BY排序数据） ， 还影响搜索（例如，寻找apple的WHERE子句是否能找到 APPLE）。在使用诸如法文à或德文ö这样的字符时，情况更复 杂，在使用不基于拉丁文的字符集（日文、希伯来文、俄文 等）时，情况更为复杂


### 使用字符集和校对顺序 
为查看所支持的字符集完整列表
```sql
SHOW CHARACTER SET;
```
为了查看所支持校对的完整列
```sql
SHOW COLLATION;
```

通常系统管理在安装时定义一个默认的字符集和校对。此外，也可 以在创建数据库时，指定默认的字符集和校对。为了确定所用的字符集和校对可以使用以下语句： 
```sql
SHOW VARIABLES LIKE 'character%';
SHOW VARIABLES LIKE 'collation%';
```

为了给表指定字符集和校对，可使用带子句的CREATE TABLE       
```sql
CREATE TABLE mytable
(
    column1 INT,
    column2 VARCHAR(10),
) DEFAULT CHARACTER SET brew     --字符集
  COLLATE hebrew_general_ci;     --校对顺序
```

对某个列设置单独的字符集和校对
```sql
CREATE TABLE mytable
(
    column1 INT,
    column2 VARCHAR(10),
    column3 VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_general_ci
) DEFAULT CHARACTER SET brew     --字符集
  COLLATE hebrew_general_ci;     --校对顺序
```


如前所述，校对在对用ORDER BY子句检索出来的数据排序时起重要 的作用。如果你**需要用与创建表时不同的校对顺序排序特定的SELECT语句**，可以在SELECT语句自身中进行：
```sql
    SELECT * FROM  customer ORDER BY lastname COLLATE latin1_general_ci;
```
<br><br> 

***

<br><br>

## 安全管理
MySQL服务器的安全基础是：**用户应该对他们需要的数据具有适当的访问权，既不能多也不能少**。换句话说，用户不能对过多的数据具有过多的访问权。 
>应该严肃对待root登录的使用。仅在绝对需 要时使用它（或许在你不能登录其他管理账号时使用）。不应 该在日常的MySQL操作中使用root。 

### 管理用户
MySQL用户账号和信息存储在名为mysql的MySQL数据库中。一般不需要直接访问mysql数据库和表（你稍后会明白这一点），但有时需要直接访问。需要直接访问它的时机之一是在需要获得所有用户账号列表时。

mysql数据库有一个名为user的表，它包含所有用户账号。user 表有一个名为user的列，它存储用户登录名。

#### 创建用户
```sql
--创建账户名为cc1,密码为123的账户
CREATE USER cc1 IDENTIFIED BY '123';
--重命名
RENAME USER cc1 TO cc2;
```
> **使用GRANT或INSERT** GRANT语句也可以创建用 户账号，但一般来说CREATE USER是最清楚和最简单的句子。 此外，也可以通过直接插入行到user表来增加用户，不过为安全起见，一般不建议这样做。MySQL用来存储用户账号信息 的表（以及表模式等）极为重要，对它们的任何毁坏都 可能严重地伤害到MySQL服务器。因此，相对于直接处理来 说，最好是用标记和函数来处理这些表。 

#### 更改口令
```sql
SET PASSWORD FOR  cc2 = Password('456');
--设置当前账户口令
SET PASSWORD = Password('456');
```

#### 删除用户
```sql
DROP USER cc2;
```

### 设置访问权限
在创建用户账号后，必须接着分配访问权限。**新创建的用户账号没有访问权限**。它们能登录MySQL，但不能看到数据，不能执行任何数据库操作。
```sql
--看到赋予用户账号的权限
SHOW GRANTS FOR cc2;
```
为**设置权限**，使用GRANT语句。GRANT要求你至少给出以下信息： 
* 要授予的权限
* 被授予访问权限的数据库或表；
* 用户名

```sql
--此GRANT允许用户在crashcourse.*（crashcourse数据库的所有表）上使用SELECT。
GRANT SELECT ON crashcourse.* TO cc3;
```
>通过只授予SELECT访问权限，用户bforta对crashcourse数据库中的所有数据具有只读访问权限。 

GRANT的反操作为REVOKE，用它来**撤销特定的权限**。
```sql
--取消刚赋予用户cc3的SELECT访问权限
REVOKE SELECT ON crashcourse.* FROM cc3;
```

GRANT和REVOKE可在几个层次上控制访问权限： 
* 整个服务器，使用GRANT ALL和REVOKE ALL； 
* 整个数据库，使用ON database.*； 
* 特定的表，使用ON database.table； 
* 特定的列； 
* 特定的存储过程。

下标列出可以授予或撤销的每个权限。 

权限|说明
-|-
ALL|除GRANT OPTION外的所有权限 
ALTER|使用ALTER TABLE 
ALTER ROUTINE|使用ALTER PROCEDURE和DROP PROCEDURE 
CREATE|使用CREATE TABLE 
CREATE ROUTINE|使用CREATE PROCEDURE 
CREATE TEMPORARY TABLES|使用CREATE TEMPORARY TABLE 
CREATE USER|使用CREATE USER、DROP USER、RENAME USER和REVOKE ALL PRIVILEGES 
CREATE VIEW|使用CREATE VIEW 
DELETE|使用DELETE 
DROP|使用DROP TABLE 
EXECUTE|使用CALL和存储过程 
FILE|使用SELECT INTO OUTFILE和LOAD DATA INFILE 
GRANT OPTION|使用GRANT和REVOKE 
INDEX|使用CREATE INDEX和DROP INDEX 
INSERT|使用INSERT 
LOCK TABLES|使用LOCK TABLES 
PROCESS|使用SHOW FULL PROCESSLIST 
RELOAD|使用FLUSH 
REPLICATION CLIENT|服务器位置的访问 
REPLICATION SLAVE|由复制从属使用 
SELECT|使用SELECT 
SHOW DATABASES|使用SHOW DATABASES 
SHOW VIEW|使用SHOW CREATE VIEW 
SHUTDOWN|使用mysqladmin shutdown（用来关闭MySQL） 
SUPER|使用CHANGE MASTER、KILL、LOGS、PURGE、MASTER 和SET GLOBAL。还允许mysqladmin调试登录
UPDATE|使用UPDATE
USAGE|无访问权限 

，当某个数据库或表被删除时（用DROP语 句），相关的访问权限仍然存在。而且，如果将来重新创建该 数据库或表，这些权限仍然起作用。 

>未来的授权  在使用GRANT和REVOKE时，用户账号必须存在， 但对所涉及的对象没有这个要求。这允许管理员在创建数据库 和表之前设计和实现安全措施。 这样做的副作用是，当某个数据库或表被删除时（用DROP语 句），相关的访问权限仍然存在。而且，如果将来重新创建该 数据库或表，这些权限仍然起作用。 

>简化多次授权  可通过列出各权限并用逗号分隔，将多条 GRANT语句串在一起，如下所示： `GRANT SELECT,INSERT ON crashcourse.* TO cc2;`

<br><br> 

***

<br><br>

## 数据库维护
### 数据库备份
像所有数据一样，MySQL的数据也必须经常备份。由于MySQL数据 库是基于磁盘的文件，普通的备份系统和例程就能备份MySQL的数据。 但是，**由于这些文件总是处于打开和使用状态，普通的文件副本备份不一定总是有效**。 
下面列出这个问题的可能解决方案。 
* 使用**命令行实用程序mysqldump**转储所有数据库内容到某个外部文件。在进行常规备份前这个实用程序应该正常运行，以便能正 确地备份转储文件。
* 可用**命令行实用程序mysqlhotcopy**从一个数据库复制所有数据 （并非所有数据库引擎都支持这个实用程序）。 
* 可以使用**MySQL的BACKUP TABLE或SELECT INTO OUTFILE转储**所有数据到某个外部文件。这两条语句都接受将要创建的系统文件名，此系统文件必须不存在，否则会出错。数据可以用RESTORE TABLE来复原。 

>首先刷新未写数据 为**了保证所有数据被写到磁盘（包括索引数据）**，可能需要在进行备份前使用**FLUSH TABLES**语句。 
### 数据库维护

**ANALYZE TABLE**，用来检查**表键**是否正确

如果从一个表中删除大量数据，应该使用**OPTIMIZE TABLE**来收回所用的空间，从而优化表的性能。 
 
### 诊断启动问题

命令行mysqld手动启动

### 查看错误日志
MySQL维护管理员依赖的一系列日志文件。主要的日志文件有以下几种。 
* **错误日志**。它包含启动和关闭问题以及任意关键错误的细节。此 日志通常名为hostname.err，位于data目录中。此日志名可用 --log-error命令行选项更改。 
* **查询日志**。它记录所有MySQL活动，在诊断问题时非常有用。此 日志文件可能会很快地变得非常大，因此不应该长期使用它。此 日志通常名为hostname.log，位于data目录中。此名字可以用 --log命令行选项更改。 
* **二进制日志**。它记录更新过数据（或者可能更新过数据）的所有 语句。此日志通常名为hostname-bin，位于data目录内。此名字 可以用--log-bin命令行选项更改。注意，这个日志文件是MySQL 5中添加的，以前的MySQL版本中使用的是更新日志。 
* **缓慢查询日志**。顾名思义，此日志记录执行缓慢的任何查询。这 个日志在确定数据库何处需要优化很有用。此日志通常名为 hostname-slow.log ，位于data 目录中。此名字可以用 --log-slow-queries命令行选项更改。 在使用日志时，可用FLUSH LOGS语句来刷新和重新开始所有日志文 件。 

在使用日志时，可用FLUSH LOGS语句来刷新和重新开始所有日志文件。 

## 改善性能

* 首先，MySQL（与所有DBMS一样）具有**特定的硬件建议**。在学 习和研究MySQL时，使用任何旧的计算机作为服务器都可以。但 对用于生产的服务器来说，应该坚持遵循这些硬件建议。
* 一般来说，关键的生产DBMS应该运行在自己的**专用服务器**上。 
* MySQL是用一系列的默认设置预先配置的，从这些设置开始通常是很好的。但过一段时间后你**可能需要调整内存分配、缓冲区大小等。**（为查看当前设置，可使用SHOW VARIABLES;和SHOW STATUS;。） 
* MySQL一个多用户多线程的DBMS，换言之，它经常同时执行多个任务。**如果这些任务中的某一个执行缓慢，则所有请求都会执行缓慢**。如果你遇到显著的性能不良，可使用SHOW PROCESSLIST 显示所有活动进程（以及它们的线程ID和执行时间）。你还可以用KILL命令终结某个特定的进程（使用这个命令需要作为管理员登录） 。 
* 总是有**不止一种方法编写同一条SELECT语句**。应该试验联结、并、 子查询等，找出最佳的方法。 
* 使用**EXPLAIN语句**让MySQL**解释它将如何执行一条SELECT语句**。 
* 一般来说，**存储过程执行得比一条一条地执行其中的各条MySQL语句快**。 
*  应该总是使用正确的数据类型。 
* 决**不要检索比需求还要多的数据**。换言之，不要用SELECT *（除 非你真正需要每个列）。 
* 有的操作（包括INSERT）支持一个可选的DELAYED关键字，如果使用它，将把控制立即返回给调用程序，并且一旦有可能就实际执行该操作。
* **在导入数据时，应该关闭自动提交**。你**可能还想删除索引**（包括 FULLTEXT索引），然后在导入完成后再重建它们。 
* **必须索引数据库表以改善数据检索的性能**。确定索引什么不是一件微不足道的任务，需要分析使用的SELECT语句以找出重复的 WHERE和ORDER BY子句。如果一个简单的WHERE子句返回结果所花的时间太长，则可以断定其中使用的列（或几个列）就是需要索引的对象。 
* 你的SELECT语句中有一系列复杂的OR条件吗？通过使用多条SELECT语句和连接它们的**UNION语句**，你能看到极大的性能改 进。 
* **索引改善数据检索的性能，但损害数据插入、删除和更新的性能**。 如果你有一些表，它们收集数据且不经常被搜索，则在有必要之 前不要索引它们。（索引可根据需要添加和删除。） 
*  LIKE很慢。一般来说，**最好是使用FULLTEXT而不是LIKE**。 
* 数据库是不断变化的实体。一组优化良好的表一会儿后可能就面 目全非了。由于表的使用和内容的更改，理想的优化和配置也会 改变。 
* 最重要的规则就是，每条规则在某些条件下都会被打破。 


<br><br> 


<br><br>





## 参考
<div style="margin-left: 5px  font-size:16px;">
[1]Ben Forta, Mysql必知必会. 北京：人民邮电出版社，2019.
</div>
