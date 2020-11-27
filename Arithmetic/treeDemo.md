## 二叉树
```java
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;
import java.util.Stack;

/**
 * Description
 * Author cloudr
 * Date 2020/7/30 22:42
 * Version 1.0
 **/

class CBType {
    String data;
    CBType left;
    CBType right;
}

public class Tree {
    static final int MAXLEN = 20;
    static Scanner input = new Scanner(System.in);

    CBType InitTree() {
        CBType node = new CBType();
        System.out.println("请先输入一个根节点数据：");
        node.data = input.next();
        node.left = null;
        node.right = null;
        return node;
    }

    void AddTreeNode(CBType treeNode) {
        CBType pNode = new CBType(), parent;
        String data;
        int select;

        System.out.println("请输入二叉树结点数据");
        pNode.data = input.next();
        pNode.left = null;
        pNode.right = null;

        System.out.println("请输入父节点数据");
        data = input.next();
        parent = TreeFindNode(treeNode, data);
        if (parent == null) {
            System.out.println("未找到该父节点");
            pNode = null;
            return;
        }
        System.out.print("1.添加到其左子树\n2.添加到其右子树\n");
        do {
            select = input.nextInt();
            if (select == 1 || select == 2) {
                switch (select) {
                    case 1:
                        if (parent.left != null) {
                            System.out.println("左子树结点不为空");
                        } else {
                            parent.left = pNode;
                        }
                        break;
                    case 2:
                        if (parent.right != null) {
                            System.out.println("右字树不为空");
                        } else {
                            parent.right = pNode;
                        }
                        break;
                    default:
                        System.out.println("无效参数");
                }
            }
        } while (select != 1 && select != 2);
    }

    //查找结点
    CBType TreeFindNode(CBType treeNode, String data) {
        CBType ptr;
        if (treeNode == null) {
            return null;
        } else {
            if (treeNode.data.equals(data)) {   //查找到结点
                return treeNode;
            } else {
                if ((ptr = TreeFindNode(treeNode.left, data)) != null) {    //分别向左右字树循环递归查找
                    return ptr;
                } else if ((ptr = TreeFindNode(treeNode.right, data)) != null) {
                    return ptr;
                } else {
                    return null;
                }
            }
        }
    }

    //获取左子树
    CBType TreeLeftNode(CBType treeNode) {
        if (treeNode != null) {
            return treeNode.left;
        } else {
            return null;
        }
    }

    //获取右子树
    CBType TreeRightNode(CBType treeNode) {
        if (treeNode != null) {
            return treeNode.right;
        } else {
            return null;
        }
    }

    //判断是否空树
    boolean IsEmpty(CBType treeNode) {
        return treeNode == null;
    }

    //计算二叉树深度
    int TreeDepth(CBType treeNode) {
        int depLeft, depRight;
        if (treeNode == null) {
            return 0;
        } else {
            depLeft = TreeDepth(treeNode.left);
            depRight = TreeDepth(treeNode.right);
            if (depLeft > depRight) {
                return depLeft + 1;
            } else {
                return depRight + 1;
            }
        }
    }

    //清空二叉树
    void ClearTree(CBType treeNode) {
        if (treeNode != null) {
            ClearTree(treeNode.left);
            ClearTree(treeNode.right);
            treeNode = null;
        }
    }

    //显示结点数据
    void TreeNodeData(CBType pNode) {
        System.out.println(pNode.data);
    }

    //先序遍历(递归)
    void DLRTree(CBType treeNode) {
        if (treeNode != null) {
            TreeNodeData(treeNode);
            DLRTree(treeNode.left);
            DLRTree(treeNode.right);
        }
    }

    //先序遍历(非递归)
    void DLRsTree(CBType trrNode) {
        CBType p = trrNode;
        Stack<CBType> stack = new Stack<>();
        while (p != null || !stack.empty()) {
            while (p != null) {  //一直向左并将沿途结点压入堆栈
                stack.push(p);
                TreeNodeData(p);
                p = p.left;
            }
            if (!stack.isEmpty()) {
                p = stack.pop();    //结点弹出堆栈
                p = p.right;    //转向右子树
            }
        }
    }

    //中序遍历(递归)
    void LDRTree(CBType treeNode) {
        if (treeNode != null) {
            LDRTree(treeNode.left);
            TreeNodeData(treeNode);
            LDRTree(treeNode.right);
        }
    }

    //中序遍历(非递归)
    void LDRsTree(CBType trrNode) {
        CBType p = trrNode;
        Stack<CBType> stack = new Stack<>();
        while (p != null || !stack.empty()) {
            while (p != null) {  //一直向左并将沿途结点压入堆栈
                stack.push(p);
                p = p.left;
            }
            if (!stack.isEmpty()) {
                p = stack.pop();    //结点弹出堆栈
                TreeNodeData(p);
                p = p.right;    //转向右子树
            }
        }
    }

    //后序遍历(递归)
    void LRDTree(CBType treeNode) {
        if (treeNode != null) {
            LRDTree(treeNode.left);
            LRDTree(treeNode.right);
            TreeNodeData(treeNode);
        }
    }

    //后序遍历
    void LRDsTree(CBType treeNode) {
        Stack<CBType> stack = new Stack<>();
        CBType p;
        CBType pre = new CBType();
        if(treeNode != null)
            stack.push(treeNode);
        else
            return;
        while (!stack.isEmpty()) {
            p = stack.peek();
            //如果p的左右孩子不存在 或者 左右孩子都已经被访问过了 就直接访问此结点，并将其标记为pre
            if ((p.left == null && p.right == null) || (pre == p.left || pre == p.right)) {
                TreeNodeData(p);
                stack.pop();
                pre = p;
            } //否则将左右孩子依次入栈
            else {
                if (p.right != null)
                    stack.push(p.right);
                if (p.left != null)
                    stack.push(p.left);
            }
        }

    }

    //层次遍历
    void LevelTree1(CBType treeNode) {
        CBType p;
        CBType[] q = new CBType[MAXLEN];    //定义一个顺序栈

        int head = 0, tail = 0;
        if (treeNode != null) { //如果结点不为空
            tail = (tail + 1) % MAXLEN; //计算循环队列队尾序号
            q[tail] = treeNode; //将二叉树根引用进队
        }
        while (head != tail) {  //对列不为空 进行循环
            head = (head + 1) % MAXLEN; //计算循环队列的队首序号
            p = q[head];    //获取队首元素
            TreeNodeData(p);    //处理队首元素
            if (p.left != null) {   //如果结点存在左子树
                tail = (tail + 1) % MAXLEN;    //计算循环队列的队尾序号
                q[tail] = p.left;   //将左子树引用进队
            }
            if (p.right != null) {  //如果结点存在右子树
                tail = (tail + 1) % MAXLEN; //计算循环队列的队尾序号
                q[tail] = p.right;  //将右子树引用进队
            }
        }
    }

    //层次遍历
    void LevelTree(CBType treeNode) {
        CBType p;
        Queue<CBType> queue = new LinkedList<>();
        if (treeNode != null) {
            queue.add(treeNode); //首先将根节点存入队列
        }
        while (!queue.isEmpty()) {
            p = queue.remove(); //队首取出结点数据
            TreeNodeData(p);    //打印数据
            if (p.left != null) {
                queue.add(p.left);  //存入此结点的左孩子
            }
            if (p.right != null) {
                queue.add(p.right); //存入此结点的右孩子
            }
        }
    }

    public static void main(String[] args) {
        CBType root = null;
        Tree tree = new Tree();
        root = tree.InitTree();
        int select;

        //添加结点
        do {
            System.out.println("请选择菜单添加二叉树的结点");
            System.out.println("0.退出");
            System.out.println("1.添加二叉树的结点");
            select = input.nextInt();
            switch (select) {
                case 1:
                    tree.AddTreeNode(root);
                    break;
                case 0:
                    break;
                default:
                    ;
            }
        } while (select != 0);

        //遍历
        do {
            System.out.println("请选择菜单遍历二叉树，输入0表示退出");
            System.out.println("1.先序遍历（递归）");
            System.out.println("2.中序遍历（递归）");
            System.out.println("3.后序遍历（递归）");
            System.out.println("4.层次遍历（递归）");
            System.out.println("5.先序遍历（非递归）");
            System.out.println("6.中序遍历（非递归）");
            System.out.println("7.后序遍历（递归）");
            select = input.nextInt();
            switch (select) {
                case 0:
                    break;
                case 1:
                    tree.DLRTree(root);
                    break;
                case 2:
                    tree.LDRTree(root);
                    break;
                case 3:
                    tree.LRDTree(root);
                    break;
                case 4:
                    tree.LevelTree(root);
                    break;
                case 5:
                    tree.DLRsTree(root);
                    break;
                case 6:
                    tree.LDRsTree(root);
                    break;
                case 7:
                    tree.LRDsTree(root);
                    break;
                default:
                    ;
            }
        } while (select != 0);

        System.out.println("二叉树的深度为：" + tree.TreeDepth(root));

        tree.ClearTree(root);
    }
}












```