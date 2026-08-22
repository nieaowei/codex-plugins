当您希望按实际业务场景对上传至存储空间（Bucket）下的文件（Object）进行合理归类时，您需要先创建目录，然后将目标文件存放至指定目录。本文介绍如何使用mkdir命令创建目录。

## **注意事项**

-   要创建目录，您必须具有`oss:GetObject`和`oss:PutObject`权限。具体操作，请参见[为RAM用户授权自定义的权限策略](https://help.aliyun.com/zh/oss/common-examples-of-ram-policies#section-ucu-jv0-zip)。
    

## **命令格式**

```
ossutil mkdir oss://bucket/dir_name [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| bucket | string | Bucket名称。 |
| dir\\_name | string | 目录名称。 |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式，取值：url。 如果不指定该选项，则表示目录名称未经过编码。 |
| \\--request-payer | string | 请求的支付方式。如果为请求者付费模式，请设置该值，取值：requester。 |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

-   创建一个目录。
    
    ```
    ossutil mkdir oss://examplebucket/dir
    ```
    
-   创建一个多级目录。
    
    ```
    ossutil mkdir oss://examplebucket/dir1/dir2
    ```