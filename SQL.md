#### LeetCode SQL596

* 题目描述

  ![65c gfdfxz54trfesd7 777777777777777777777xcv6vcdx](https://i.loli.net/2020/04/15/Dyc2JHemAXIOBqU.png)

  * SQL语句：`SELECT class FROM courses GROUP BY class HAVING COUNT(DISTINCT student) >= 5;`

    * GROUP BY：分组
      * count()  *计数*
      * sum()  *求和*
      * avg()   *平均数*
      * max()  *最大值*
      * min()   *最小值*
    * HAVING:过滤由GROUP BY语句返回的记录集。
    * DISTINCT ：返回唯一不同的值.

    
  ***
  


 &nbsp;  
 &nbsp;  
 &nbsp;  
 &nbsp;  
 &nbsp;  
 &nbsp;  
 &nbsp;  
  




#### Leetcode SQL595

* 题目描述

  ![图片.png](https://i.loli.net/2020/04/15/Jgd9Khr6mUftb4k.png)

​    

* SQL语句

  * ```sql
    select name,population,area from World where area>3000000 
    union
    select name,population,area from World where population>25000000;
    ```

  * ```sql
    select name,population,area from World where area>3000000 orpopulation>25000000;
    ```

  * 推荐使用第二种；因为[Mysql使用OR可能导致索引失效](https://blog.csdn.net/wenniuwuren/article/details/89472136)

***


&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;


#### LeetCode SQL197
* 题目描述
  ![SQL197](https://i.loli.net/2020/04/15/AVcG62pOKzQEi4b.png)

* SQL语句
  ```sql
    //计算时间日期差 dataDiff()
    DATEDIFF('2007-12-31','2007-12-30');   # 1
    DATEDIFF('2010-12-30','2010-12-31');   # -1

    SELECT a.Id FROM Weather as a,Weather as b WHERE a.Temperature < b.Temperature and DATEDIFF(a.RecordDate,b.RecordDate)=-1;

  ```

***

&nbsp;
&nbsp;
&nbsp;


#### LeetCode 



