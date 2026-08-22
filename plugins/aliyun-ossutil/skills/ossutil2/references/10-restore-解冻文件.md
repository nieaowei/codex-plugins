如果未开启归档直读，归档类型的Object需要解冻后才能读取。冷归档、深度冷归档不支持开启直读，冷归档、深度冷归档类型的Object需要解冻后才能读取。归档类型Object完成解冻通常需要数分钟。冷归档类型Object完成解冻通常需要数小时。深度冷归档类型Object完成解冻通常需要12～48小时。解冻时间请以实际为准。本文为您介绍如何通过restore命令解冻文件。

## **注意事项**

-   要解冻单个文件，您必须具有`oss:RestoreObject`权限；要按目录解冻文件，您必须具有`oss:RestoreObject`和`oss:ListObjects`权限。具体操作，请参见[为RAM用户授予自定义的权限策略](https://help.aliyun.com/zh/oss/common-examples-of-ram-policies#section-ucu-jv0-zip)。
    
-   关于归档存储、冷归档存储或者深度冷归档存储类型文件的解冻状态以及费用说明，请参见[解冻文件](https://help.aliyun.com/zh/oss/user-guide/restore-objects-for-access#concept-wx5-szt-tdb)。
    

## 命令格式

```
ossutil restore oss://bucket/object [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\--days | int | 解冻天数。取值范围1~365。 当批量操作时，如果对象的存储类型存在混合情况，且days值超过该类型支持的最大值，则自动调整为该类型支持的最大值。例如：归档存储类型支持的最大天数为7天，深度冷归档存储类型支持365天，当--days设置为100时，对于归档存储类型的对象，自动调整为7；对于深度冷归档存储类型的对象，使用100。 |
| \\--tier | string | 解冻优先级。归档类型对象无需指定此参数，解冻时间为1分钟。 - 冷归档类型： - Expedited（高优先级）：1小时内完成解冻。 - Standard（标准）：2~5小时内完成解冻。 - Bulk（批量）：5~12小时内完成解冻。 - 深度冷归档类型： - Expedited（高优先级）：12小时内完成解冻。 - Standard（标准）：48小时内完成解冻。 当批量操作时，如果对象的存储类型存在混合情况，且tier值超过该类型支持的优先级，则自动调整为该类型支持的最低优先级。例如ColdArchive支持Bulk，DeepColdArchive仅支持Standard，当--tier设置为Bulk时，对于DeepColdArchive类型的对象，自动调整为Standard。 |
| \\--dirs | /   | 返回当前目录下的文件和子目录，而非递归显示所有子目录下的所有文件。 |
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
| \\--limited-num | int | 返回结果的最大个数。 |
| \\--list-objects | /   | 使用ListObjects接口列举对象。 |
| \\--min-age | Duration | 不传输任何比此更新的文件，默认单位是秒，也可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--min-age 1h` 表示仅传输修改时间在1小时前或更早的文件。 |
| \\--max-age | Duration | 不传输任何比此更早的文件，默认单位是秒，也可以使用单位后缀形式。例如 1h，表示1小时。 |
| \\--min-mtime | Time | 不传输任何比此更早的文件，时间格式：UTC时间。例如2006-01-02T15:04:05。 **说明** `--min-mtime "2006-01-02T15:04:05"` 表示仅传输在 2006 年 1 月 2 日 15:04:05 之后修改的文件。 |
| \\--max-mtime | Time | 不传输任何比此更新的文件，时间格式：UTC时间，例如 2006-01-02T15:04:05。 |
| \\--max-size | SizeSuffix | 限制传输的最大文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--metadata-exclude | stringArray | 对象元数据的排除规则。 |
| \\--metadata-filter | stringArray | 对象元数据过滤规则。 |
| \\--metadata-filter-from | stringArray | 从规则文件读取对象元数据过滤规则。 |
| \\--metadata-include | stringArray | 对象元数据的包含规则。 |
| \\--min-size | SizeSuffix | 限制传输的最小文件大小，默认是字节，或单位后缀形式B\\|K\\|M\\|G\\|T\\|P，1K(KiB)=1024B。 |
| \\--page-size | int | 批量处理时分页列举对象的最大值（默认值1000），取值范围1~1000。 |
| \\-r, --recursive | /   | 递归进行操作。当指定该选项时，命令会对存储空间下所有符合条件的对象进行操作，否则只对路径指定的对象进行操作。 |
| \\--request-payer | string | 请求的支付方式，如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--start-after | string | 按字母排序，返回设定值之后的对象，不包含设定值。 |
| \\--version-id | string | 对象的版本标识。 |
| \\--list-format | string | 列表文件的格式，取值：plain、inventory。 |
| \\--list-manifest-from | string | 从文件中读取列表文件格式的描述信息，当列表文件格式为inventory时，需要设置该参数。 |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

## **使用示例**

### 解冻归档类型Object

-   以下示例用于解冻目标存储空间examplebucket下归档类型文件exampleobject.txt。
    
    ```
    ossutil restore oss://examplebucket/exampleobject.txt
    ```
    
-   以下示例用于解冻目标存储空间examplebucket下归档类型文件exampleobject.txt，并将解冻天数设置为3天。
    
    ```
    ossutil restore oss://examplebucket/exampleobject.txt --days 3
    ```
    
-   以下示例用于从列表里解冻对象。
    
    **说明**
    
    list列表文件里的一行表示一个对象，且采用OSS路径格式，即oss://{bucket}/{key}，如list.txt文件：
    
    ```
    oss://examplebucket/key1
    oss://examplebucket/key2
    ```
    
    ```
    ossutil restore list://list.txt
    ```
    
-   以下示例用于从列表里直接解冻对象，不会检查 object 的状态。
    
    ```
    ossutil restore list://list.txt --no-check-status 
    ```
    
-   以下示例用于从清单文件里解冻对象。
    
    **说明**
    
    执行清单任务后，会在清单结果中生成一个 csv.gz 和 manifest.json 文件。从清单文件里解冻对象需要用到这两个文件。
    
    ```
    ossutil restore list://ca8007fc-4123-493e-9a01-dd1511fbac54.csv.gz --list-format inventory --list-manifest-from manifest.json
    ```
    
-   以下示例用于从清单文件里直接解冻对象，不会检查 object 的状态。
    
    ```
    ossutil restore list://ca8007fc-4123-493e-9a01-dd1511fbac54.csv.gz --list-format inventory --list-manifest-from manifest.json --no-check-status
    ```
    

### 解冻冷归档类型Object

以下示例用于解冻目标存储空间examplebucket下冷归档类型文件exampleobject.txt，并将解冻天数设置为5天。

```
ossutil restore oss://examplebucket/exampleobject.txt --tier Bulk --days 5
```

以下示例用于递归解冻目标存储空间examplebucket下dir目录中所有冷归档类型的.csv文件，并将解冻天数设置为5天。

```
ossutil restore oss://examplebucket/dir/ -r --include "*.csv" --tier Bulk --days 5
```

### 解冻深度冷归档类型Object

以下示例用于解冻目标存储空间examplebucket下深度冷归档类型文件exampleobject.txt，并将解冻天数设置为10天。

```
ossutil restore oss://examplebucket/exampleobject.txt --tier Standard --days 10
```

以下示例用于递归解冻目标存储空间examplebucket下dir目录中所有深度冷归档类型的.csv文件，并将解冻天数设置为10天。

```
ossutil restore oss://examplebucket/dir/ -r --include "*.csv" --tier Standard --days 10
```

## 计费说明

-   解冻归档、冷归档和深度冷归档类型的Object会产生数据取回费用。更多信息，请参见[数据处理费用](https://help.aliyun.com/zh/oss/data-processing-fees#concept-2558464)。
    
-   归档类型Object可达到最长7天的解冻持续时间，冷归档和深度冷归档类型Object可达到最长365天的解冻持续时间，在此期间不再重复收取数据取回费用。
    
-   解冻状态结束后，Object又回到冷冻状态，再次执行解冻操作会收取数据取回费用。
    
-   冷归档和深度冷归档类型Object在数据解冻时会生成一份标准存储类型的文件副本用于访问，该文件在解冻时间结束前会以标准存储的存储费率计算临时存储费用。更多信息，请参见[临时存储费用](https://help.aliyun.com/zh/oss/temporary-storage-fees#concept-2558617)。