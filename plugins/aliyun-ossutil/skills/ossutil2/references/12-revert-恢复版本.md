revert命令用于在开启版本控制的存储空间（Bucket）中，将已删除的文件（Object）恢复至最近的版本。

## 注意事项

-   要恢复文件的版本，您必须具有`oss:GetObject`、`oss:PutObject`、`oss:ListObjectVersions`和`oss:DeleteObject`权限。具体操作，请参见[为RAM用户授予自定义的权限策略](https://help.aliyun.com/zh/oss/common-examples-of-ram-policies#section-ucu-jv0-zip)。
    
-   关于版本控制的更多信息，请参见[版本控制](https://help.aliyun.com/zh/oss/user-guide/overview-78/#concept-jdg-4rx-bgb)。
    
-   关于删除标记的更多信息，请参见[删除标记](https://help.aliyun.com/zh/oss/user-guide/delete-marker#concept-azw-shj-dgb)。
    

## 命令格式

```
ossutil revert oss://bucket[/prefix] version-directive [flags]
```

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| version-directive | string | 版本信息。取值： - 版本ID，例如CAEQIBiBgICAr6yv9hgiIDZiNmUzNjM5Njg0ZDRhOWQ4Yj。 - 版本索引，HEAD~n，即恢复到第n-1个有效版本 （不包括删除标记）。 - 当HEAD~0时，即恢复到最近的有效版本，如果最新版本是删除标记，则通过删除删除标记恢复。 - 当HEAD~n， n > 0 时，通过拷贝方式把指定版本拷贝成最新版本。 - 时间索引，NOW~相对时间或NOW~绝对时间，即恢复到不大于该时间的第一个版本 （不包括删除标记）。 - NOW~相对时间：使用相对时间索引时，您可以基于当前本地时间向前回溯特定的时间间隔。格式为 `NOW~` 后跟一个时间单位后缀，单位后缀支持：ms毫秒、s秒、m分钟、h小时、d天、w星期、M月、y年。 - 示例：`NOW~1d` 表示恢复到当前本地时间前1天的版本。 - ​​NOW~绝对时间：对于需要精确到具体日期和时间的情况，可以使用绝对时间索引。格式为 `NOW~` 后跟一个遵循 ISO 8601 标准的时间字符串（`YYYY-MM-DDTHH:mm:ss`），这将恢复到指定本地时间之前的最近版本。 - 示例：`NOW~2024-04-12T14:00:00` 表示恢复到本地时间2024年4月12日14:00之前的版本。 |
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
| \\--ignore-version-not-exist | /   | 进行批量操作时，如果版本不存在，默认报错，也可以通过--ignore-version-not-exist忽略错误。 |
| \\--include | stringArray | 路径或文件名的包含规则。 |
| \\--include-from | stringArray | 从规则文件里读取包含规则。 |
| \\--max-age | Duration | 仅恢复修改时间在指定时间间隔内的文件，默认单位是秒，也可以使用单位后缀形式。例如 1h，表示1小时。 **说明** `--min-age 1h` 表示仅恢复修改时间在1小时内的文件。 |
| \\--min-mtime | Time | 仅恢复修改时间在指定时间之后的文件。例如2006-01-02T15:04:05。 **说明** `--min-mtime "2006-01-02T15:04:05"` 表示仅恢复在 2006 年 1 月 2 日 15:04:05 之后修改的文件。 |
| \\--page-size | int | 批量处理时分页列举的对象的最大值（默认值1000），取值范围1~1000。 |
| \\-r, --recursive | /   | 递归进行操作。当指定该选项时，命令会对存储空间下所有符合条件的对象进行操作，否则只对路径指定的对象进行操作。 |
| \\--request-payer | string | 请求的支付方式，如果为请求者付费模式，请设置该值。取值：requester。 |
| \\--start-after | string | 按字母排序，返回设定值之后的对象，不包含设定值。 |

**说明**

关于支持的全局命令行选项，请参见[支持的全局命令行选项](https://help.aliyun.com/zh/oss/command-line-options#65785a4884d85)。

更多说明：该命令不支持通过删除方式恢复到指定版本。如果您需要通过删除版本方式来恢复数据，可以通过rm命令来完成，例如：删除 key123 的前三个版本。

```
ossutil rm oss://bucket/key123 --end-with key123 --limited-num 3 -rf --all-versions 
```

## **使用示例**

### **恢复单个文件的版本**

-   对存储空间examplebucket里的example.txt对象恢复到版本号为123的状态。
    
    ```
    ossutil revert oss://examplebucket/example.txt 123
    ```
    
-   对存储空间examplebucket里的example.txt对象恢复到最近的版本状态。
    
    ```
    ossutil revert oss://examplebucket/example.txt HEAD~0
    ```
    
-   对存储空间examplebucket里的example.txt对象恢复到第4个旧版本状态。
    
    ```
    ossutil revert oss://examplebucket/example.txt HEAD~4
    ```
    
-   对存储空间examplebucket里的example.txt对象恢复到一天前的第一个版本状态。
    
    ```
    ossutil revert oss://examplebucket/example.txt NOW~1d
    ```
    
-   对存储空间examplebucket里的example.txt对象恢复到本地时间2024-04-12T14:00:00前的第一个版本状态。
    
    ```
    ossutil revert oss://examplebucket/example.txt NOW~2024-04-12T14:00:00
    ```
    

### **批量恢复**

-   对存储空间examplebucket里的dir目录下的所有对象恢复到第4个旧版本状态。
    
    ```
    ossutil revert oss://examplebucket/dir -r HEAD~4
    ```
    
-   对存储空间examplebucket里的dir目录下的所有对象恢复到第4个旧版本状态，并忽略版本不存在的错误。
    
    ```
    ossutil revert oss://examplebucket/dir -r HEAD~4 --ignore-version-not-exist
    ```
    
-   恢复存储空间examplebucket中除.jpg格式外的所有对象到最近的版本。
    
    ```
    ossutil revert oss://examplebucket -r --exclude "*.jpg" HEAD~0
    ```
    
-   对存储空间examplebucket中的目录dir1和dir2下的所有后缀为.txt的对象恢复到最近的版本。
    
    ```
    ossutil revert oss://examplebucket -r --include "/dir1/*.txt" --include "/dir2/*.txt" HEAD~0
    ```
    
-   从规则文件中读取包含规则，恢复存储空间examplebucket中dir目录下符合规则的对象到第4个旧版本。
    
    规则文件`include_rules.txt`内容如下：
    
    ```
    *.log
    *.csv
    ```
    
    命令示例如下：
    
    ```
    ossutil revert oss://examplebucket/dir -r HEAD~4 --include-from include_rules.txt
    ```