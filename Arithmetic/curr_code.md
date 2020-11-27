## [38. 外观数列](https://leetcode-cn.com/problems/count-and-say/)
```java
class Solution {
    public String countAndSay(int n) {
        if (n == 1) {
            return "1";
        }
        StringBuilder result = new StringBuilder();
        String preString = countAndSay(n - 1);
        int count = 1;
        out:
        for (int i = 0; i < preString.length(); ) {
            if (i == preString.length() - 1) { //如果i指向字符串最后一位，则此时只能单独写出来
                result.append("1").append(preString.charAt(i));
                break;
            }
            for (int j = i + 1; j < preString.length(); j++) { //用i后面的每一项与i比较
                if (preString.charAt(j) == preString.charAt(i)) { //如果相等 次数加1
                    count++;
                } else {    //如果不等，则写入其次数及其字符串
                    result.append(count).append(preString.charAt(i));
                    count = 1; //重置计数器
                    i = j;  //将i指针指向下一个不同的地方
                    break;
                }
                if(j == preString.length() - 1){  //注意 如果此时j指向最后一位，则结束整个循环
                    result.append(count).append(preString.charAt(i));
                    break out;
                }
            }
        }
        return result.toString();
    }
}
```