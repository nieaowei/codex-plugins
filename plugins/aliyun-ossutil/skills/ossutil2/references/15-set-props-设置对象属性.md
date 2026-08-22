set-props命令用于设置对象属性，支持设置访问权限、存储类型、元数据和标签。

## **注意事项**

set-props命令会根据修改的对象属性类型调用不同的API接口，请确保拥有相应的权限（如调用`PutObjectAcl` 接口需具备 `oss:PutObjectAcl` 操作权限），具体如下：

1.  仅修改对象权限 (ACL)：调用 `PutObjectAcl` 接口。
    
2.  仅修改对象标签 (Tagging)：调用 `PutObjectTagging` 接口。如果标签修改指令涉及基于现有标签更新（如增量添加），系统将先调用 `GetObjectTagging`接口 获取原始标签。
    
3.  修改对象存储类型或元数据：此类操作涉及对象重写，调用 `CopyObject` 接口或使用分片拷贝流程（`InitiateMultipartUpload` -> `UploadPartCopy` -> `CompleteMultipartUpload`）。
    
4.  同时修改多个属性：基于最优方式选择合适的接口组合。例如：
    
    -   同时修改对象权限和标签： 调用 `PutObjectAcl` 和 `PutObjectTagging`。
        
    -   同时修改对象权限和存储类型： 直接调用 `CopyObject` 或分片拷贝接口（利用拷贝操作`InitiateMultipartUpload` -> `UploadPartCopy` -> `CompleteMultipartUpload`同时更新权限与类型）。
        

**说明**

修改对象的存储类型会产生 PUT 类型请求费用：

-   对象大小不超过 `--bigfile-threshold` 指定的阈值时，ossutil 调用 `CopyObject`。该请求按源对象的存储类型计费。
    
-   对象大小超过该阈值时，ossutil 使用分片拷贝。每个分片调用一次 `UploadPartCopy`，该请求按目标对象的存储类型计费。
    
-   批量将对象转换为深度冷归档存储时，PUT 请求费用可能较高。可以提高 `--bigfile-threshold` 或 `--part-size` 以减少 `UploadPartCopy` 请求数。修改存储类型时，`CopyObject` 仅支持不超过 1 GB 的对象。
    

具体计费规则，请参见[请求费用](https://help.aliyun.com/zh/oss/api-operation-calling-fees)。有关深度冷归档存储的计费说明和使用建议，请参见[深度冷归档存储使用最佳实践](https://help.aliyun.com/zh/oss/user-guide/deep-cold-archive-storage-usage-best-practices)。

## **命令格式**

```
ossutil set-props oss://bucket[/prefix] [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\--acl | string | 对象的访问权限。取值： - private：私有。 - public-read：公共读。 - public-read-write：公共读写。 - default：继承Bucket。 |
| \\--bigfile-threshold | SizeSuffix | 大文件分片上传、下载或拷贝的阈值。对象大小超过该阈值时使用分片拷贝。默认值为 100 MiB。支持 B、K、M、G、T 和 P 单位后缀。 |
| \\--cache-control | string | 指定该对象被下载时网页的缓存行为。 |
| \\--content-disposition | string | 指定对象的展示形式。 |
| \\--content-encoding | string | 声明对象的编码方式。 |
| \\--content-type | string | 对象的内容类型。 |
| \\-d, --dirs | /   | 返回当前目录下的文件和子目录，而非递归显示所有子目录下的所有文件。 |
| \\--encoding-type | string | 输入的对象名或文件名的编码方式。取值：url。 |
| \\--end-with | string | 按字母排序，返回设定值之前的对象，包含设定值。 |
| \\--exclude | stringArray | 路径或文件名的排除规则。 |
| \\--exclude-from | stringArray | 从规则文件里读取排除规则。 |
| \\--expires | string | 指定缓存内容的绝对过期时间。 |
| \\--files-from | stringArray | 从文件中读取源文件名列表，忽略空行或注释行。 |
| \\--files-from-raw | stringArray | 从文件中读取源文件名列表。 |
| \\--filter | stringArray | 路径或文件名过滤规则。 |
| \\--filter-from | stringArray | 从规则文件读取过滤规则。 |
| \\-f, --force | /   | 强制操作，不进行询问提示。 |
| \\--include | stringArray | 路径或文件名的包含规则。 |
| \\--include-from | stringArray | 从规则文件里读取包含规则。 |
| \\-j, --job | int | 并发任务数，默认值为 3。 **重要** 仅在同时指定 `-f`、`--update`、`--size-only` 或 `--ignore-existing` 中任意一个参数时生效。 |
| \\--list-objects | /   | 使用ListObjects接口列举对象。 |
| \\--max-size | SizeSuffix | 限制传输的最大文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--metadata | strings | 指定对象的用户元数据，使用key=value格式。 例如：--metadata test=value,test1=value1。 |
| \\--metadata-directive | string | 元数据的修改指令。取值： - replace：只保留命令行选项里的元数据。 - update：取命令行和对象中元数据的并集。 - purge：清除所有的元数据。 - delete：删除命令行选项里的元数据，其它的保留。 |
| \\--metadata-exclude | stringArray | 对象元数据的排除规则。 |
| \\--metadata-filter | stringArray | 对象元数据过滤规则。 |
| \\--metadata-filter-from | stringArray | 从规则文件读取对象元数据过滤规则。 |
| \\--metadata-include | stringArray | 对象元数据的包含规则。 |
| \\--min-age | Duration | 仅设置修改时间在指定时间间隔前的文件，默认单位是秒，可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--min-age 1h` 表示仅设置修改时间在1小时前或更早的文件。 |
| \\--max-age | Duration | 仅设置修改时间在指定时间间隔内的文件，默认单位是秒，可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--max-age 1h` 表示仅设置修改时间在1小时内的文件。 |
| \\--min-mtime | Time | 仅设置修改时间在指定时间之后的文件，时间格式：UTC时间。例如2006-01-02T15:04:05。 **说明** `--min-mtime "2006-01-02T15:04:05"` 表示仅设置在 2006 年 1 月 2 日 15:04:05 之后修改的文件。 |
| \\--max-mtime | Time | 仅设置修改时间在指定时间之前的文件，时间格式：UTC时间，例如 2006-01-02T15:04:05。 |
| \\--min-size | SizeSuffix | 限制传输的最小文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--no-progress | /   | 不显示进度条。 |
| \\--page-size | int | 批量处理时分页列举对象的最大值（默认值1000），取值范围1~1000。 |
| \\--parallel | int | 单文件内部操作的并发任务数。 |
| \\--part-size | SizeSuffix | 分片大小。默认情况下，ossutil 根据对象大小自动计算分片大小。增大分片可以减少 `UploadPartCopy` 请求数。取值范围为 100 KiB～5 GiB。 |
| \\-r, --recursive | /   | 递归进行操作。当指定该选项时，命令会对存储空间下所有符合条件的对象进行操作，否则只对路径指定的对象进行操作。 |
| \\--request-payer | string | 请求的支付方式，如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--start-after | string | 按字母排序，返回设定值之后的对象，不包含设定值。 |
| \\--storage-class | string | 对象的存储类型。取值： - Standard：标准存储。 - IA：低频访问。 - Archive：归档存储。 - ColdArchive：冷归档存储。 - DeepColdArchive：深度冷归档存储。 |
| \\--tagging | strings | 指定对象的标签，使用key=value格式。 例如：--tagging tag1=value1,tag2=value2。 |
| \\--tagging-directive | string | 标签的修改指令。取值： - replace：只保留命令行选项里的标签。 - update：取命令行和对象中标签的并集。 - purge：清除所有的标签。 - delete：删除命令行选项里的标签，其它的保留。 |
| \\--version-id | string | 对象的版本标识。 |
| \\--list-format | string | 列表文件的格式，取值：plain、inventory。 |
| \\--list-manifest-from | string | 从文件中读取列表文件格式的描述信息，当列表文件格式为inventory时，需要设置该参数。 |

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

-   设置对象的访问权限为私有。
    
    ```
    ossutil set-props oss://examplebucket/exampleobject.txt --acl private
    ```
    
-   设置对象的存储类型为归档存储。
    
    ```
    ossutil set-props oss://examplebucket/exampleobject.txt --storage-class Archive
    ```
    
-   批量将对象转换为深度冷归档存储，并预估 PUT 类型请求费用。
    
    对于不超过 1 GB 的对象，可以提高分片阈值以使用 `CopyObject`。例如，将阈值设置为 1 GB：
    
    ```
    ossutil set-props oss://examplebucket/exampledir/ --storage-class DeepColdArchive --bigfile-threshold 1G -r
    ```
    
    对于超过 1 GB 的对象，必须使用分片拷贝。增大分片可以减少 `UploadPartCopy` 请求数。例如，将分片大小设置为 1 GiB：
    
    ```
    ossutil set-props oss://examplebucket/exampledir/ --storage-class DeepColdArchive --part-size 1G -r
    ```
    
    按以下公式估算 `UploadPartCopy` 请求数：
    
    ```
    每个对象的分片数 = ceil(对象大小 / 分片大小)
    UploadPartCopy 请求数 = 对象数量 × 每个对象的分片数
    ```
    
    例如，批量转换 1000 个大小为 10 GiB 的对象，设置 `--part-size 1G` 后，每个对象产生 10 次 `UploadPartCopy` 请求，共产生 10000 次。`UploadPartCopy` 按目标对象的存储类型计费，因此应根据深度冷归档 PUT 请求的计费规则估算这部分费用。分片拷贝还会调用 `InitiateMultipartUpload` 和 `CompleteMultipartUpload`。对象列举和重试也可能产生请求费用。
    
-   对\*.txt对象，修改content-type为text/plain。
    
    ```
    ossutil set-props oss://bucket/prefix --content-type text/plain --include "*.txt" --metadata-directive update -r
    ```
    
-   设置对象的标签。
    
    ```
    ossutil set-props oss://examplebucket/exampleobject.txt --tagging tag1=value1 --tagging-directive update
    ```
    
-   从列表设置对象的属性。
    
    **说明**
    
    list列表文件里的一行表示一个对象，且采用OSS路径格式，即oss://{bucket}/{key}，如list.txt文件：
    
    ```
    oss://examplebucket/key1
    oss://examplebucket/key2
    ```
    
    ```
    ossutil set-props list://list.txt 
    ```
    
-   从清单文件设置对象的属性。
    
    **说明**
    
    执行清单任务后，会在清单结果中生成一个 csv.gz 和 manifest.json 文件。从清单文件中设置对象需要用到这两个文件。
    
    ```
    ossutil set-props list://ca8007fc-4123-493e-9a01-dd1511fbac54.csv.gz --list-format inventory --list-manifest-from manifest.json
    ```