**cat**命令仅支持将存储空间（Bucket）内文件（Object）的内容输出到屏幕。

## **注意事项**

要输出文件内容，您必须具有`oss:GetObject`权限。具体操作，请参见[为RAM用户授权自定义的权限策略](https://help.aliyun.com/zh/oss/common-examples-of-ram-policies#section-ucu-jv0-zip)。

## 命令格式

```
ossutil cat oss://bucket/object [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\--count | int | 仅打印N个字符。默认值：-1。 |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式。取值：url。 |
| \\--head | int | 仅打印前N个字符。 |
| \\--offset | int | 从位置N开始打印。 |
| \\--request-payer | string | 请求的支付方式，如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--tail | int | 仅打印最后N个字符。 |
| \\--version-id | string | 对象的版本标识。 |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

-   将存储空间examplebucket内名为example.txt的文件内容输出到屏幕。
    
    ```
    ossutil cat oss://examplebucket/example.txt
    ```
    
-   显示开始的10个字符。
    
    ```
    ossutil cat oss://examplebucket/example.txt --head 10
    ```
    
-   显示最后的10个字符。
    
    ```
    ossutil cat oss://examplebucket/example.txt --tail 10
    ```
    
-   显示从位置10开始的20个字符。
    
    ```
    ossutil cat oss://examplebucket/example.txt --offset 10 --count 20
    ```
    
-   显示从位置10到文件尾的字符。
    
    ```
    ossutil cat oss://examplebucket/example.txt --offset 10
    ```