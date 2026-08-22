append命令用于在已上传的追加类型对象（Appendable Object）末尾直接追加内容。

## **注意事项**

-   要追加上传，您必须具有`oss:GetObject`和`oss:PutObject`权限。具体操作，请参见[为RAM用户授予自定义的权限策略](https://help.aliyun.com/zh/oss/common-examples-of-ram-policies#section-ucu-jv0-zip)。
    
-   关于追加上传的更多信息，请参见[追加上传](https://help.aliyun.com/zh/oss/user-guide/append-upload-11#concept-ls5-yhb-5db)。
    
-   若目标对象不存在，则创建追加类型的对象；如果对象已存在但不是追加类型的，则返回错误。
    

## **命令格式**

```
ossutil append source oss://bucket/object [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| source | string | 表示数据源，支持本地路径、OSS资源地址和`-`。 当为`-`时，表示从标准输入读入。 |
| \\--storage-class | string | 指定对象的存储类型, 取值： - Standard：标准存储。 - IA：低频存储。 - Archive：归档存储。 |
| \\--acl | string | 指定对象的访问权限。取值： - default：继承Bucket。 - private：私有。 - public-read：公共读。 - public-read-write：公共读写。 |
| \\--request-payer | string | 请求的支付方式。若启用请求者付费模式，需设置为 `requester` |
| \\--metadata | strings | 指定对象的用户自定义元数据，使用key=value格式。 |
| \\--tagging | strings | 指定对象的标签，使用key=value格式。 |
| \\--cache-control | string | 指定对象被下载时网页的缓存行为。 |
| \\--content-disposition | string | 指定对象的展示形式。 |
| \\--content-encoding | string | 声明对象的编码方式。 |
| \\--content-type | string | 指定对象的内容类型。 |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式。取值：url。 |
| \\--expires | string | 指定缓存内容的绝对过期时间，格式是格林威治时间（GMT）。例如`2022-10-12T00:00:00.000Z` |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

-   首次上传本地文件1.txt，并指定文件读写权限为私有，标签为tag=value。
    
    ```
    ossutil append 1.txt oss://dst-bucket/append.txt --acl private --tagging tag=value
    ```
    
-   采用标准输入方式，在append.txt文件末尾追加2.txt。
    
    ```
    cat 2.txt | ossutil append - oss://dst-bucket/append.txt
    ```
    
-   把存储空间src-bucket里的3.txt追加到append.txt文件末尾。
    
    ```
    ossutil append oss://src-bucket/3.txt oss://dst-bucket/append.txt
    ```