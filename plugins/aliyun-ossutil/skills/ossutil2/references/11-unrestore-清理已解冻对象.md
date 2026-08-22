本文为您介绍如何通过unrestore命令清理从归档状态或冷归档状态恢复的对象。使用unrestore命令后，恢复的对象将返回到冻结状态。

## **注意事项**

阿里云账号默认拥有清理从归档状态或冷归档状态恢复的对象的权限。如果您需要通过RAM用户或者STS的方式进行清理，您必须拥有`oss:CleanRestoredObject`、`oss:CleanRestoredObjectVersion`权限。具体操作，请参见[为RAM用户授予自定义的权限策略](https://help.aliyun.com/zh/oss/common-examples-of-ram-policies#section-ucu-jv0-zip)。

## 命令格式

```
ossutil unrestore oss://bucket[/prefix] [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\--checkers | int | 并行运行的检查器数量（默认值为16） |
| \\-d, --dirs | /   | 返回当前目录下的文件和子目录，而非递归显示所有子目录下的所有文件。 |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式。取值：url。 |
| \\--end-with | string | 按字母排序，返回设定值之前的对象，包含设定值。 |
| \\--exclude | stringArray | 路径或文件名的排除规则。 |
| \\--exclude-from | stringArray | 从规则文件里读取排除规则。 |
| \\--files-from | stringArray | 从文件中读取源文件名列表，忽略空行或注释行。 |
| \\--files-from-raw | stringArray | 从文件中读取源文件名列表。 |
| \\--filter | stringArray | 路径或文件名过滤规则。 |
| \\--filter-from | stringArray | 从规则文件读取过滤规则。 |
| \\-f, --force | /   | 强制操作，不进行询问提示。 |
| \\--include | stringArray | 路径或文件名的包含规则。 |
| \\--include-from | stringArray | 从规则文件里读取包含规则。 |
| \\-j, --job | int | 在多个文件之间的并发任务数量（默认值为3) |
| \\--limited-num | int | 返回结果的最大个数。 |
| \\--list-format | string | 列表文件的格式，取值：plain、inventory。 |
| \\--list-manifest-from | string | 从文件中读取列表文件格式的描述信息，当列表文件格式为inventory时，需要设置该参数。 |
| \\--list-objects | /   | 使用ListObjects接口列举对象。 |
| \\--max-size | SizeSuffix | 限制传输的最大文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--metadata-exclude | stringArray | 对象元数据的排除规则。 |
| \\--metadata-filter | stringArray | 对象元数据过滤规则。 |
| \\--metadata-filter-from | stringArray | 从规则文件读取对象元数据过滤规则。 |
| \\--metadata-include | stringArray | 对象元数据的包含规则。 |
| \\--min-age | Duration | 仅恢复修改时间在指定时间间隔前的文件，默认单位是秒，可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--min-age 1h` 表示仅恢复修改时间在1小时前或更早的文件。 |
| \\--max-age | Duration | 仅恢复修改时间在指定时间间隔内的文件，默认单位是秒，可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--max-age 1h` 表示仅恢复修改时间在1小时内的文件。 |
| \\--min-mtime | Time | 仅恢复修改时间在指定时间之后的文件，时间格式：UTC时间。例如2006-01-02T15:04:05。 **说明** `--min-mtime "2006-01-02T15:04:05"` 表示仅恢复在 2006 年 1 月 2 日 15:04:05 之后修改的文件。 |
| \\--max-mtime | Time | 仅恢复修改时间在指定时间之前的文件，时间格式：UTC时间，例如 2006-01-02T15:04:05。 |
| \\--min-size | SizeSuffix | 限制传输的最小文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--no-check-status | /   | 清理前不检查对象状态，在列表模式下生效。 |
| \\--no-error-report | /   | 在批量操作期间不生成错误报告文件。 |
| \\--no-progress | /   | 不显示进度条。 |
| \\--page-size | int | 批量处理时分页列举对象的最大值（默认值1000），取值范围1~1000。 |
| \\--output-dir | string | 指定存放输出文件的目录，输出文件包含：批量操作过程中生成的错误报告文件（默认值"ossutil\\_output"） |
| \\-r, --recursive | /   | 递归进行操作。当指定该选项时，命令会对存储空间下所有符合条件的对象进行操作，否则只对路径指定的对象进行操作。 |
| \\--request-payer | string | 请求的支付方式，如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--start-after | string | 按字母排序，返回设定值之后的对象，不包含设定值。 |
| \\--version-id | string | 对象的版本标识。 |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

-   以下示例用于清理目标存储空间examplebucket中名为`example.txt`的从归档或冷归档状态恢复的对象。
    
    ```
    ossutil unrestore oss://examplebucket/example.txt
    ```
    
-   以下示例用于清理目标存储空间examplebucket中`dir`目录下所有从归档或冷归档状态恢复的对象。
    
    ```
    ossutil unrestore oss://examplebucket/dir -r
    ```
    
-   以下示例用于清理目标存储空间examplebucket名为`example.txt`且版本号为`123`的从归档或冷归档状态恢复的对象。
    
    ```
    ossutil unrestore oss://examplebucket/example.txt --version-id 123
    ```
    
-   以下示例用于清理目标存储空间examplebucket中`dir`目录下前100个从归档或冷归档状态恢复的对象。
    
    ```
    ossutil unrestore oss://examplebucket/dir --limited-num 100 -r
    ```
    
-   以下示例用于清理目标存储空间examplebucket中根目录dir下的子目录dir1和dir2内，创建时间在三天内的从归档或冷归档状态恢复的对象。
    
    ```
    ossutil unrestore oss://examplebucket/rootdir/rootdir --include "/dir1/**" --include "/dir2/**" --max-age 3d -r
    ```
    
-   以下示例用于根据文件中列出的对象清理从归档或冷归档状态恢复的对象。
    
    **说明**
    
    list列表文件里的一行表示一个对象，且采用OSS路径格式，即oss://{bucket}/{key}，如list.txt文件：
    
    ```
    oss://examplebucket/key1
    oss://examplebucket/key2
    ```
    
    ```
    ossutil unrestore list://local-list.txt
    ```
    
-   以下示例用于从列表里直接清理从归档或冷归档状态恢复的对象，不会检查 object 的状态。
    
    ```
    ossutil unrestore list://local-list.txt --no-check-status
    ```
    
-   以下示例用于从清单文件里清理从归档或冷归档状态恢复的对象。
    
    **说明**
    
    执行清单任务后，会在清单结果中生成一个 csv.gz 和 manifest.json 文件。从清单文件里解冻对象需要用到这两个文件。
    
    ```
    ossutil unrestore list://ca8007fc-4123-493e-9a01-dd1511fb****.csv.gz --list-format inventory --list-manifest-from manifest.json
    ```