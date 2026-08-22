presign用于生成对象的预签名URL。

## **命令格式**

```
ossutil presign oss://bucket[/prefix] [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\-d, --dirs | /   | 返回当前目录下的文件和子目录，而非递归显示所有子目录下的所有文件。 |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式。取值：url。 |
| \\--end-with | string | 按字母排序，返回设定值之前的对象，包含设定值。 |
| \\--exclude | stringArray | 路径或文件名的排除规则。 |
| \\--exclude-from | stringArray | 从规则文件里读取排除规则。 |
| \\--expires-date | Time | 签名URL过期时间点（默认值off）。 |
| \\--expires-duration | Duration | 签名URL过期时间，默认值15m0s（15分钟0秒），取值范围1s~1w（1秒 ~1周）。 |
| \\--files-from | stringArray | 从文件中读取源文件名列表，忽略空行或注释行。 |
| \\--files-from-raw | stringArray | 从文件中读取源文件名列表。 |
| \\--filter | stringArray | 路径或文件名过滤规则。 |
| \\--filter-from | stringArray | 从规则文件读取过滤规则。 |
| \\-f, --force | /   | 强制操作，不进行询问提示。 |
| \\--include | stringArray | 路径或文件名的包含规则。 |
| \\--include-from | stringArray | 从规则文件里读取包含规则。 |
| \\--limited-num | int | 返回结果的最大个数。 |
| \\--list-objects | /   | 使用ListObjects接口列举对象。 |
| \\--min-age | Duration | 仅处理修改时间在指定时间间隔前的文件，默认单位是秒，可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--min-age 1h` 表示仅处理修改时间在1小时前或更早的文件。 |
| \\--max-age | Duration | 仅处理修改时间在指定时间间隔内的文件，默认单位是秒，可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--max-age 1h` 表示仅处理修改时间在1小时内的文件。 |
| \\--min-mtime | Time | 仅处理修改时间在指定时间之后的文件，时间格式：UTC时间。例如2006-01-02T15:04:05。 **说明** `--min-mtime "2006-01-02T15:04:05"` 表示仅处理在 2006 年 1 月 2 日 15:04:05 之后修改的文件。 |
| \\--max-mtime | Time | 仅处理修改时间在指定时间之前的文件，时间格式：UTC时间，例如 2006-01-02T15:04:05。 |
| \\--max-size | SizeSuffix | 限制传输的最大文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--metadata-exclude | stringArray | 对象元数据的排除规则。 |
| \\--metadata-filter | stringArray | 对象元数据过滤规则。 |
| \\--metadata-filter-from | stringArray | 从规则文件读取对象元数据过滤规则。 |
| \\--metadata-include | stringArray | 对象元数据的包含规则。 |
| \\--min-size | SizeSuffix | 限制传输的最小文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--page-size | int | 批量处理时分页列举的对象的最大值（默认值1000），取值范围1~1000。 |
| \\--query-param | stringArray | 请求中的查询参数。 |
| \\-r, --recursive | /   | 递归进行操作。当指定该选项时，命令会对存储空间下所有符合条件的对象进行操作，否则只对路径指定的对象进行操作。 |
| \\--request-payer | string | 请求的支付方式，如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--start-after | string | 按字母排序，返回设定值之后的对象，不包含。 |
| \\--traffic-limit | int | 单连接带宽限制。取值范围：819200~838860800。 |
| \\--version-id | string | 对象的版本标识。 |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

-   对存储空间examplebucket里的example.txt 对象，生成默认有效期为15分钟的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/example.txt
    ```
    
-   对存储空间examplebucket里的example.txt对象，生成有效期为1小时的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/example.txt --expires-duration 1h
    ```
    
-   对存储空间examplebucket里的example.txt对象，生成有效期到2024-06-01T12:00:00（UTC）的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/example.txt --expires-date 2024-06-01T12:00:00
    ```
    
-   对存储空间examplebucket里的example.txt对象，生成包含图片处理参数的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/example.txt --query-param x-oss-process=image/resize,m_fixed,w_100,h_100/rotate,90
    ```
    
-   对存储空间examplebucket里的example.txt对象，生成版本标识为123的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/example.txt --version-id 123
    ```
    
-   对存储空间examplebucket里的folder目录，批量生成默认有效期为15分钟的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/folder/ -r
    ```
    
-   对存储空间examplebucket里的folder目录下的后缀为.txt的文件，批量生成默认有效期为15分钟的预签名URL。
    
    ```
    ossutil presign oss://examplebucket/folder/ -r --include "*.txt"
    ```