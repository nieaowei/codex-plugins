stat命令用于查看指定存储空间（Bucket）或者对象（Object）的相关信息。例如，您可以通过该命令查看Bucket的存储类型、Object元数据等 。

## **注意事项**

只有Bucket拥有者及授予了`oss:GetObject`、`oss:GetObjectAcl`和`oss:GetBucketInfo`权限的RAM用户允许使用此命令查看Object元数据。

## **命令格式**

```
ossutil stat oss://bucket[/object] [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式。取值：url。 |
| \\--human-readable | /   | 以人类可读方式输出信息。文件大小转换成K\\|M\\|G\\|T\\|P后缀格式。 |
| \\--request-payer | string | 请求的支付方式。如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--version-id | string | 对象的版本标识。 |

## **使用示例**

-   获取存储空间examplebucket的信息。
    
    ```
    ossutil stat oss://examplebucket
    ```
    
-   获取存储空间examplebucket中exampleobject.txt的信息。
    
    ```
    ossutil stat oss://examplebucket/exampleobject.txt 
    ```
    
-   获取已开启版本控制的examplebucket下exampleobject.txt特定版本的信息。
    
    ```
    ossutil stat oss://examplebucket/exampleobject.txt --version-id CAEQKxiBgMCplua..xgiIGFiZjE0NTZkNTU4NjQ5NDdiMDMyMzc4YzIxNDVm****
    ```