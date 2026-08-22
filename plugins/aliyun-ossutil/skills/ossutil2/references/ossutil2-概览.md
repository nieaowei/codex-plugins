使用命令行工具 ossutil 2.0 在多种操作系统中高效管理阿里云对象存储 OSS 资源，实现文件的快速上传、下载、同步和管理，适合开发者、运维人员和企业进行大规模数据迁移和日常运维操作。

| **操作系统** | **系统架构** | **下载地址** | **SHA256校验和** |
| --- | --- | --- | --- |
| Linux | x86\\_32 | [ossutil-2.3.0-linux-386.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-386.zip) | 29cbd49b6c401c740c2f036cdf9d44ee8da340b16bdb3be71a33bcbebbe35ec5 |
| x86\\_64 | [ossutil-2.3.0-linux-amd64.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-amd64.zip) | 3ae4d9fc85a7a6e9f5654d1599766f1a3a42a3692870887b5ae9338d582ef65a |
| arm32 | [ossutil-2.3.0-linux-arm.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-arm.zip) | 8aff883c676961a11c89ac98b807fafa54fb424851d0557b1691b9d320324b9e |
| arm64 | [ossutil-2.3.0-linux-arm64.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-arm64.zip) | f6c95ba0c2d2ef30290af686ce4d706c701f4734ce8090bee4288a77e3f1d764 |
| macOS | x86\\_64 | [ossutil-2.3.0-mac-amd64.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-mac-amd64.zip) | 8437fdd3ef1a3eb12310f61fcf1c00a5bff5cdab47b4fea815527472e7cf896c |
| arm64 | [ossutil-2.3.0-mac-arm64.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-mac-arm64.zip) | 058fd048f321f8c80def8b748030531646eefe3a82837bf16b581ba7d9c84ac7 |
| Windows | x86\\_32 | [ossutil-2.3.0-windows-386.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-windows-386.zip) | ae5f20b0bfe2aadf61c87931cbb342f743e266bb56b49dace16f59942305c1ea |
| x86\\_64 | [ossutil-2.3.0-windows-amd64.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-windows-amd64.zip) | 98209156987667b39fd12a0c7b940342900daef61a9306ea7f34acf17f287da2 |
| amd64 | [ossutil-2.3.0-windows-amd64-go1.20.zip](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-windows-amd64-go1.20.zip) | 0b9249d1c1437a9f052a9bf5eeaf1d4358b515e08efa82a3b7048950ce7efdea |

## 快速接入

接入命令行工具ossutil 2.0的流程如下：

![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/6962328771/CAEQYhiBgICGzdjYyhkiIDkyN2FmNmNlYjkyNzRjYzY4OGNhYmVhOWMzMzlkYWIx5272737_20250624105943.598.svg)

### **安装ossutil**

### **Linux**

1.  安装unzip解压工具。
    
    ### Alibaba Cloud Linux
    
    ```
    sudo yum install -y unzip
    ```
    
    ### CentOS
    
    ```
    sudo yum install -y unzip
    ```
    
    ## Ubuntu
    
    ```
    sudo apt install -y unzip
    ```
    
2.  根据操作系统与架构选择对应安装包（[Linux x86 32bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-386.zip)、[Linux x86 64bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-amd64.zip)、[Linux ARM 32bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-arm.zip)、[Linux ARM 64bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-arm64.zip)），也可通过 curl 下载。以下以在 Linux x86\_64 上使用 curl 获取为例：
    
    ```
    curl -o ossutil-2.3.0-linux-amd64.zip https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-linux-amd64.zip
    ```
    
3.  在下载压缩包的所在目录执行以下解压命令。
    
    ```
    unzip ossutil-2.3.0-linux-amd64.zip
    ```
    
4.  进入ossutil-2.3.0-linux-amd64目录。
    
    ```
    cd ossutil-2.3.0-linux-amd64
    ```
    
5.  在当前目录执行以下命令。
    
    ```
    chmod 755 ossutil
    ```
    
6.  执行以下命令，实现ossutil的全局调用。
    
    ```
    sudo mv ossutil /usr/local/bin/ && sudo ln -s /usr/local/bin/ossutil /usr/bin/ossutil
    ```
    
7.  验证是否成功安装ossutil，执行`ossutil`命令。
    
    ```
    ossutil
    ```
    
    返回ossutil的帮助信息即表示安装成功。
    

### **Windows**

1.  安装ossutil。
    
    1.  根据操作系统与架构选择对应安装包（[Windows x86 32bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-windows-386.zip)、[Windows x86 64bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-windows-amd64.zip)、[Windows 7, Windows 8, Windows Server 2008R2](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-windows-amd64-go1.20.zip)）。
        
    2.  将下载好的.zip压缩包解压到目标文件夹，然后进入解压后的目录。
        
    3.  复制当前解压后ossutil文件夹路径配置系统环境变量。
        
        1.  单击当前目录的路径栏，复制其中显示的当前文件夹路径。
            
            ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5365188371/p912167.png)
            
        2.  打开**环境变量**对话框，在**系统变量**栏中找到并双击**Path**变量，单击**新建**按钮，然后将复制好的ossutil文件夹路径粘贴到新的条目框中。
            
            ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/5365188371/p912166.png)
            
    4.  验证是否成功安装ossutil，执行ossutil命令。
        
        ```
        ossutil
        ```
        
        返回ossutil的帮助信息即表示安装成功。
        
    

### **macOS**

1.  根据操作系统与架构选择对应安装包（[macOS x86 64bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-mac-amd64.zip)、[macOS ARM 64bit](https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-mac-arm64.zip)），也可通过 curl 下载。以下以在 macOS ARM64 位系统上使用 curl 获取为例：
    
    ```
    curl -o ossutil-2.3.0-mac-arm64.zip  https://gosspublic.alicdn.com/ossutil/v2/2.3.0/ossutil-2.3.0-mac-arm64.zip
    ```
    
2.  在下载压缩包的所在目录执行以下解压命令。
    
    ```
    unzip ossutil-2.3.0-mac-arm64.zip
    ```
    
3.  进入ossutil-2.3.0-mac-arm64目录。
    
    ```
    cd ossutil-2.3.0-mac-arm64
    ```
    
4.  在当前目录执行以下命令。
    
    ```
    chmod 755 ossutil
    ```
    
5.  执行以下命令，实现ossutil的全局调用。
    
    ```
    sudo mv ossutil /usr/local/bin/ && sudo ln -s /usr/local/bin/ossutil /usr/bin/ossutil
    ```
    
6.  验证是否成功安装ossutil。
    
    ```
    ossutil
    ```
    
    返回ossutil的帮助信息即表示安装成功。
    

### 配置**ossutil**

为避免因配置缺失导致操作失败，推荐使用 ossutil config 命令的配置向导快速完成 AccessKey ID、AccessKey Secret 和地域 ID 的配置。若还需管理高级配置，可参考[配置指南](#65af941549umg)进行手动[配置访问凭证](#7413ab74b5tab)等。

> 以使用 RAM 用户的 AccessKey 配置为访问凭证为示例，结合配置向导快速完成配置。

### Linux

1.  输入配置命令。
    
    ```
    ossutil config
    ```
    
2.  根据提示设置配置文件路径。可以直接回车使用默认的配置文件路径。
    
    ```
    Please enter the config file name,the file name can include path(default /root/.ossutilconfig, carriage return will use the default file. If you specified this option to other file, you should specify --config-file option to the file when you use other commands):
    ```
    
    ossutil默认使用/root/.ossutilconfig作为配置文件。
    
3.  根据提示分别设置AccessKey ID、AccessKey Secret、地域ID信息。
    
    1.  输入创建的AccessKey ID。
        
        ```
        Please enter Access Key ID [****************id]:yourAccessKeyID
        ```
        
    2.  输入创建的AccessKey Secret。
        
        ```
        Please enter Access Key Secret [****************sk]:yourAccessKeySecret
        ```
        
    3.  输入OSS的数据中心所在的地域，如无任何输入，默认值为cn-hangzhou。
        
        ```
        Please enter Region [cn-hangzhou]:cn-hangzhou
        ```
        
    4.  输入OSS的数据中心的Endpoint，如果不需要自定义 Endpoint，可以直接按回车跳过该参数的配置。
        
        在上一步配置完地域信息后，将默认使用该地域 ID 对应的外网 Endpoint。例如，如果设置的 `region-id` 为 `cn-hangzhou`，默认使用的外网 Endpoint 是 `https://oss-cn-hangzhou.aliyuncs.com`。
        
        如果需要自定义 OSS 数据中心所在地域的 Endpoint，请输入 Endpoint 信息。例如，如果希望通过与OSS同地域的其他阿里云产品访问OSS，请使用内网Endpoint如`https://oss-cn-hangzhou-internal.aliyuncs.com`。
        
        ```
        Please enter Endpoint (optional, use public endpoint by default) [None]: https://oss-cn-hangzhou-internal.aliyuncs.com
        ```
        
    
    参数说明如下：
    
    | **参数** | **是否必填** | **说明** |
    | --- | --- | --- |
    | accessKeyID | 是   | 账号的AccessKey，AccessKey的获取方式参见[创建AccessKey](https://help.aliyun.com/zh/ram/create-an-accesskey-pair-1#section-rjh-18m-7kp)。 使用ROS脚本快速创建有OSS管理权限的RAM用户AccessKey 在资源编排ROS控制台的[**创建资源栈**](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20241114/itgrlo/createossadmin.yaml&step=1&hideTemplateSelector=false)页面的**安全确认**下，勾选确认，然后单击**创建**。 ![1.png](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/1448561371/p873205.png) 创建完成后，在**输出**中，复制创建的AccessKey。 ![image](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0895645471/p948495.png) |
    | accessKeySecret | 是   |
    | Region | 是   | Bucket所在的地域ID，本文以杭州地域为例，设置为cn-hangzhou，其他地域的ID参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints)。 |
    | endpoint | 否   | Bucket所在地域的Endpoint。若未手动设置Endpoint，Region将自动生成对应的外网endpoint，内网需显式指定。例如，本示例使用华东1（杭州）外网Endpoint，设置为`https://oss-cn-hangzhou.aliyuncs.com`。 如果希望通过与OSS同地域的其他阿里云产品访问OSS，请使用内网Endpoint，设置为`https://oss-cn-hangzhou-internal.aliyuncs.com`。 关于各地域Endpoint的更多信息，请参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints#concept-zt4-cvy-5db)。 |
    

### Windows

1.  输入配置命令。
    
    ```
    ossutil config
    ```
    
2.  根据提示设置配置文件路径。可以直接回车使用默认的配置文件路径。
    
    ```
    Please enter the config file name,the file name can include path(default "C:\Users\issuser\.ossutilconfig", carriage return will use the default file. If you specified this option to other file, you should specify --config-file option to the file when you use other commands):
    ```
    
    ossutil默认使用C:\\Users\\issuser\\.ossutilconfig作为配置文件。
    
3.  根据提示分别设置AccessKey ID、AccessKey Secret、地域ID信息。
    
    1.  输入创建的AccessKey ID。
        
        ```
        Please enter Access Key ID [****************id]:yourAccessKeyID
        ```
        
    2.  输入创建的AccessKey Secret。
        
        ```
        Please enter Access Key Secret [****************sk]:yourAccessKeySecret
        ```
        
    3.  输入OSS的数据中心所在的地域，如无任何输入，默认值为cn-hangzhou。
        
        ```
        Please enter Region [cn-hangzhou]:cn-hangzhou
        ```
        
    4.  输入OSS的数据中心的Endpoint，如果不需要自定义 Endpoint，可以直接按回车跳过该参数的配置。
        
        在上一步配置完地域信息后，将默认使用该地域 ID 对应的外网 Endpoint。例如，如果设置的 `region-id` 为 `cn-hangzhou`，默认使用的外网 Endpoint 是 `https://oss-cn-hangzhou.aliyuncs.com`。
        
        如果需要自定义 OSS 数据中心所在地域的 Endpoint，请输入 Endpoint 信息。例如，如果希望通过与OSS同地域的其他阿里云产品访问OSS，请使用内网Endpoint如`https://oss-cn-hangzhou-internal.aliyuncs.com`。
        
        ```
        Please enter Endpoint (optional, use public endpoint by default) [None]: https://oss-cn-hangzhou-internal.aliyuncs.com
        ```
        
    
    参数说明如下：
    
    | **参数** | **是否必填** | **说明** |
    | --- | --- | --- |
    | accessKeyID | 是   | 账号的AccessKey，AccessKey的获取方式参见[创建AccessKey](https://help.aliyun.com/zh/ram/create-an-accesskey-pair-1#section-rjh-18m-7kp)。 使用ROS脚本快速创建有OSS管理权限的RAM用户AccessKey 在资源编排ROS控制台的[**创建资源栈**](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20241114/itgrlo/createossadmin.yaml&step=1&hideTemplateSelector=false)页面的**安全确认**下，勾选确认，然后单击**创建**。 ![1.png](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=) 创建完成后，在**输出**中，复制创建的AccessKey。 ![image](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=) |
    | accessKeySecret | 是   |
    | Region | 是   | Bucket所在的地域ID，本文以杭州地域为例，设置为cn-hangzhou，其他地域的ID参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints)。 |
    | endpoint | 否   | Bucket所在地域的Endpoint。若未手动设置Endpoint，Region将自动生成对应的外网endpoint，内网需显式指定。例如，本示例使用华东1（杭州）外网Endpoint，设置为`https://oss-cn-hangzhou.aliyuncs.com`。 如果希望通过与OSS同地域的其他阿里云产品访问OSS，请使用内网Endpoint，设置为`https://oss-cn-hangzhou-internal.aliyuncs.com`。 关于各地域Endpoint的更多信息，请参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints#concept-zt4-cvy-5db)。 |
    

### macOS

1.  输入配置命令。
    
    ```
    ossutil config
    ```
    
2.  根据提示设置配置文件路径。可以直接回车使用默认的配置文件路径。
    
    ```
    Please enter the config file name,the file name can include path(default "/Users/user/.ossutilconfig", carriage return will use the default file. If you specified this option to other file, you should specify --config-file option to the file when you use other commands): 
    ```
    
    ossutil默认使用/Users/user/.ossutilconfig作为配置文件。
    
3.  根据提示分别设置AccessKey ID、AccessKey Secret、地域ID信息。
    
    1.  输入创建的AccessKey ID。
        
        ```
        Please enter Access Key ID [****************id]:yourAccessKeyID
        ```
        
    2.  输入创建的AccessKey Secret。
        
        ```
        Please enter Access Key Secret [****************sk]:yourAccessKeySecret
        ```
        
    3.  输入OSS的数据中心所在的地域，如无任何输入，默认值为cn-hangzhou。
        
        ```
        Please enter Region [cn-hangzhou]:cn-hangzhou
        ```
        
    4.  输入OSS的数据中心的Endpoint，如果不需要自定义 Endpoint，可以直接按回车跳过该参数的配置。
        
        在上一步配置完地域信息后，将默认使用该地域 ID 对应的外网 Endpoint。例如，如果设置的 `region-id` 为 `cn-hangzhou`，默认使用的外网 Endpoint 是 `https://oss-cn-hangzhou.aliyuncs.com`。
        
        如果需要自定义 OSS 数据中心所在地域的 Endpoint，请输入 Endpoint 信息。例如，如果希望通过与OSS同地域的其他阿里云产品访问OSS，请使用内网Endpoint如`https://oss-cn-hangzhou-internal.aliyuncs.com`。
        
        ```
        Please enter Endpoint (optional, use public endpoint by default) [None]: https://oss-cn-hangzhou-internal.aliyuncs.com
        ```
        
    
    参数说明如下：
    
    | **参数** | **是否必填** | **说明** |
    | --- | --- | --- |
    | accessKeyID | 是   | 账号的AccessKey，AccessKey的获取方式参见[创建AccessKey](https://help.aliyun.com/zh/ram/create-an-accesskey-pair-1#section-rjh-18m-7kp)。 使用ROS脚本快速创建有OSS管理权限的RAM用户AccessKey 在资源编排ROS控制台的[**创建资源栈**](https://ros.console.aliyun.com/cn-hangzhou/stacks/create?templateUrl=https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20241114/itgrlo/createossadmin.yaml&step=1&hideTemplateSelector=false)页面的**安全确认**下，勾选确认，然后单击**创建**。 ![1.png](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=) 创建完成后，在**输出**中，复制创建的AccessKey。 ![image](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=) |
    | accessKeySecret | 是   |
    | Region | 是   | Bucket所在的地域ID，本文以杭州地域为例，设置为cn-hangzhou，其他地域的ID参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints)。 |
    | endpoint | 否   | Bucket所在地域的Endpoint。若未手动设置Endpoint，Region将自动生成对应的外网endpoint，内网需显式指定。例如，本示例使用华东1（杭州）外网Endpoint，设置为`https://oss-cn-hangzhou.aliyuncs.com`。 如果希望通过与OSS同地域的其他阿里云产品访问OSS，请使用内网Endpoint，设置为`https://oss-cn-hangzhou-internal.aliyuncs.com`。 关于各地域Endpoint的更多信息，请参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints#concept-zt4-cvy-5db)。 |
    

### 运行命令

1.  创建Bucket。
    
    ```
    ossutil mb oss://examplebucket
    ```
    
    以下输出结果表明已成功创建examplebucket。
    
    ```
    0.668238(s) elapsed
    ```
    
2.  上传文件到Bucket。
    
    1.  创建本地文件`uploadFile.txt`。
        
        ```
        echo 'Hello, OSS!' > uploadFile.txt
        ```
        
    2.  上传文件到存储空间`examplebucket`。
        
        ```
        ossutil cp uploadFile.txt oss://examplebucket
        ```
        
        以下输出结果表明文件已成功上传至`examplebucket`。
        
        ```
        Success: Total 1 file, size 12 B, Upload done:(1 objects, 12 B), avg 44 B/s
        
        0.271779(s) elapsed
        ```
        
3.  下载文件。
    
    将已上传的示例文件uploadFile.txt从examplebucket下载至本地localfolder文件夹下。
    
    ```
    ossutil cp oss://examplebucket/uploadFile.txt localfolder/
    ```
    
    以下输出结果表明文件已成功下载至本地localfolder文件夹下。
    
    ```
    Success: Total 1 object, size 12 B, Download done:(1 files, 12 B), avg 74 B/s
    
    0.162447(s) elapsed
    ```
    
4.  列举examplebucket下的文件。
    
    ```
    ossutil ls oss://examplebucket
    ```
    
    以下输出结果表明已成功列举examplebucket下的文件。
    
    ```
    LastModifiedTime                   Size(B)  StorageClass   ETAG                                  ObjectName
    2024-11-26 14:35:29 +0800 CST           12      Standard   1103F650EB2C292D179A032D2A97B0F5      oss://examplebucket/uploadFile.txt
    Object Number is: 1
    
    0.124679(s) elapsed
    ```
    
5.  删除examplebucket下的uploadFile.txt。
    
    ```
    ossutil rm oss://examplebucket/uploadFile.txt
    ```
    
    以下输出结果表明已成功删除examplebucket下的uploadFile.txt。
    
    ```
    0.295530(s) elapsed
    ```
    
6.  删除examplebucket。
    
    ```
    ossutil rb oss://examplebucket
    ```
    
    以下输出结果表明已成功删除examplebucket。
    
    ```
    0.478659(s) elapsed
    ```
    

## **配置指南**

ossutil 支持通过配置文件、环境变量和命令行选项进行配置，灵活性高。

### **配置的优先级**

ossutil 按以下顺序读取配置：

**命令行选项** (如 `-i`, `-k`, `-e`) > **环境变量** (如 `OSS_ACCESS_KEY_ID`) > **配置文件** (`~/.ossutilconfig`)

**说明**

-   从 2.2.0 版本开始，支持通过--ignore-env-var 命令行选项忽略 OSS\_为前缀的环境变量配置。
    
-   从 2.3.0 版本开始，`--job`、`--parallel`、`--bigfile-threshold`、`--part-size`、`--write-buffer-size` 选项支持通过配置文件设置。在配置文件对应 profile 段下以 `key=value` 格式追加（例如 `job=10`），或通过 `ossutil config set` 写入。命令行选项的优先级高于配置文件。
    

### **配置文件**

可以利用配置文件（默认路径为 `~/.ossutilconfig`，或通过 `-c` 选项指定自定义路径）配置 `ossutil`。如果使用默认配置文件，则不需要额外指定配置文件路径。直接运行 `ossutil` 命令即可，例如：

```
ossutil ls oss://examplebucket
```

如果使用自定义配置文件路径，例如 `/path/yourconfig`，则需要通过 `-c` 选项指定配置文件路径。例如：

```
ossutil -c /path/yourconfig ls oss://examplebucket
```

#### **配置文件格式**

配置文件采用INI格式结构，以节（section）和键值（key）构成，配置参数保存在指定的节里。这些配置按照节分成多个段，可以通过--profile使用某一个节的配置。 默认情况下，ossutil使用配置文件中的\[default\]设置。要使用其他设置，可以创建和引用其他配置。

##### **节和键值对**

配置文件中的每个节由方括号 `[ ]` 包围的名称标识，节内的设置项采用 `key=value` 形式。例如：

```
[default]
accessKeyID = "your-access-key-id"
accessKeySecret = "your-access-key-secret"
```

-   节中的设置项采用`key=value`形式。
    
-   节名和键值中的key不区分大小写。
    
-   配置参数的key支持多种格式，全小写、小驼峰、短划线（-）连接和下划线（\_）连接，例如：accesskeyid、accessKeyId、access-key-id、access\_key\_id表示同一个参数名。
    
-   井号字符（#）开头的行表示注释行。
    

##### **支持的节类型**

| **节（Section）名称** | **说明** | **其它说明** |
| --- | --- | --- |
| \\[default\\] | 用于保存缺省设置，即当不设置--profile选项时，使用该节里的配置。 | 为\\[profile default\\]简化形式。 |
| \\[profile name\\] | 用于配置参数，通过--profile name来引用。 | 支持通过source\\_profile方式引用其它配置。 |
| \\[buckets name\\] | 针对具体bucket配置访问域名，包括region、 endpoint和addressing style。 | 支持内联写法。 |

**说明**

可以使用config命令查看和设置配置内容。更多信息，请参见[config（管理配置文件）](https://help.aliyun.com/zh/oss/developer-reference/config-create-configuration-file)。

#### **节类型：profile**

用于配置访问凭证和全局配置参数，支持的参数名如下：

-   访问凭证相关参数
    
    | **参数名** | **别名** | **含义** |
    | --- | --- | --- |
    | mode | /   | 鉴权模式。 取值：AK、StsToken、RamRoleArn、EcsRamRole、Anonymous。 |
    | access-key-id | accessKeyId access\\_key\\_id | 访问OSS使用的AccessKey ID。 |
    | access-key-secret | accessKeySecret access\\_key\\_secret | 访问OSS使用的AccessKey Secret。 |
    | sts-token | stsToken sts\\_token | 访问OSS使用的STS Token。 |
    | role-arn | roleArn role\\_arn | RAM角色的ARN，主要用于RamRoleArn模式。 |
    | role-session-name | roleSessionName role\\_session\\_name | 会话名字，主要用于RamRoleArn模式。 |
    | ecs-role-name | ecsRoleName ecs\\_role\\_name | 角色名，主要用于EcsRamRole模式。 |
    | credential-process | credentialProcess credential\\_process | 指定一个外部命令。 |
    | credential-uri | credentialUri credential\\_uri | 指定一个获取访问凭证的URI地址。 |
    | oidc-provider-arn | oidcProviderArn oidc\\_provider\\_arn | 指定OIDC提供者的ARN（Aliyun Resource Name），格式为`acs:ram::account-id:oidc-provider/provider-name`。 |
    | oidc-token-file-path | oidcTokenFilePath oidc\\_token\\_file\\_path | 指定OIDC令牌的文件路径，用于存储OIDC令牌。 |
    | credential-process-timeout | credentialProcessTimeout credential\\_process\\_timeout | 用于指定外部凭证请求的超时时间，单位为秒。默认值为15即指定15秒；最大值为600即指定10分钟；`credential-process-timeout = 60`即指定60秒的超时时间。自 2.0.3 版本起支持。 |
    
-   全局参数
    
    | **参数名** | **别名** | **含义** |
    | --- | --- | --- |
    | region | /   | 地域ID，必须设置。 |
    | loglevel | /   | 日志级别 。取值： - off（默认值） - info - debug |
    | read-timeout | readTimeout read\\_timeout | 客户端读写请求超时时间。单位为秒，默认值20。 |
    | connect-timeout | connectTimeout connect\\_timeout | 客户端连接超时的时间。单位为秒，默认值10。 |
    | retry-times | retryTimes retry\\_times | 当错误发生时的重试次数。默认值10。 |
    | skip-verify-cert | skipVerifyCert skip\\_verify\\_cert | 不校验服务端的数字证书。 |
    | sign-version | signVersion sign\\_version | 请求使用的签名算法版本。取值： - v1 - v4（默认值） |
    | output-format | outputFormat output\\_format | 输出格式。取值： - raw（默认值） - json - xml - yaml |
    | addressing-style | addressingStyle addressing\\_style | 请求地址的格式 。取值： - virtual（默认值） - path - cname |
    | language | /   | 显示的语言。 |
    | endpoint | /   | 对外服务的访问域名，可不设置。 |
    
-   其它参数
    
    | **参数名** | **别名** | **含义** |
    | --- | --- | --- |
    | source-profile | sourceProfile source\\_profile | 引用指定profile里的参数，例如： ``` [profile cred] access-key-id=ak access-key-secret=sk [profile dev] region=cn-hangzhou source-profile=cred ``` |
    | buckets | /   | 引用指定buckets里的参数。 ``` [profile dev] region=cn-hangzhou access-key-id=ak access-key-secret=sk buckets=dev-bucket [buckets dev-bucket] bucket-name-hz = endpoint=oss-cn-hangzhou-internal.aliyuncs.com bucket-name-bj = region=cn-beijing ``` |
    | endpoint-suffix-list-path-style | /   | 指定自动使用 path-style 请求模式的 Endpoint 后缀列表，多个后缀以英文逗号（`,`）分隔。自 2.2.0 版本起支持。 示例1：`endpoint-suffix-list-path-style=DEFAULT` 示例2：`endpoint-suffix-list-path-style=DEFAULT,.path-style.com` DEFAULT：表示内置的缺省列表，当前为 .privatelink.aliyuncs.com |
    

#### **节类型：buckets**

用于配置特定Bucket和访问点的映射关系。支持嵌套写法，即buckets节按bucket-name = 行分成多个小节。格式如下：

```
[buckets name]
bucket-name = 
  key=value
```

其中，name为该buckets节的名字，bucket-name为具体的Bucket名字，key=value配置参数，支持的参数如下：

| **参数名** | **别名** | **含义** |
| --- | --- | --- |
| region | /   | 数据中心所在的地域。 当不设置时，使用引入该参数的profile里的region值。 |
| endpoint | /   | 对外服务的访问域名，可不设置。 |
| addressing-style | addressingStyle addressing\\_style | 请求地址的格式。取值： virtual（默认值）：使用Bucket虚拟域名请求地址格式。 path：使用path style请求地址格式。 cname：使用cname请求地址格式。 |

节类型buckets示例如下：

```
[buckets dev-bucket]
bucket-hz-01 = 
  region=cn-hangzhou
bucket-hz-02 = 
  region=cn-hangzhou
  endpoint=test.com
  addressing-style=cname
bucket-bj-01 = 
  region=cn-beijing
```

### **配置环境变量**

可以参照以下步骤配置环境变量。

## Linux系统

1.  在命令行界面执行以下命令来将环境变量设置追加到`~/.bashrc`文件中。
    
    ```
    echo "export OSS_ACCESS_KEY_ID='your-access-key-id'" >> ~/.bashrc
    echo "export OSS_ACCESS_KEY_SECRET='your-access-key-secret'" >> ~/.bashrc
    ```
    
2.  执行以下命令使变更生效。
    
    ```
    source  ~/.bashrc
    ```
    
3.  执行以下命令检查环境变量是否生效。
    
    ```
    echo $OSS_ACCESS_KEY_ID
    echo $OSS_ACCESS_KEY_SECRET
    ```
    

## macOS系统

1.  在终端中执行以下命令，查看默认Shell类型。
    
    ```
    echo $SHELL
    ```
    
2.  根据默认Shell类型进行操作。
    
    #### **Zsh**
    
    1.  执行以下命令来将环境变量设置追加到 `~/.zshrc` 文件中。
        
        ```
        echo "export OSS_ACCESS_KEY_ID='your-access-key-id'" >> ~/.zshrc
        echo "export OSS_ACCESS_KEY_SECRET='your-access-key-secret'" >> ~/.zshrc
        ```
        
    2.  执行以下命令使变更生效。
        
        ```
        source ~/.zshrc
        ```
        
    3.  执行以下命令检查环境变量是否生效。
        
        ```
        echo $OSS_ACCESS_KEY_ID
        echo $OSS_ACCESS_KEY_SECRET
        ```
        
    
    #### **Bash**
    
    1.  执行以下命令来将环境变量设置追加到 `~/.bash_profile` 文件中。
        
        ```
        echo "export OSS_ACCESS_KEY_ID='your-access-key-id'" >> ~/.bash_profile
        echo "export OSS_ACCESS_KEY_SECRET='your-access-key-secret'" >> ~/.bash_profile
        ```
        
    2.  执行以下命令使变更生效。
        
        ```
        source ~/.bash_profile
        ```
        
    3.  执行以下命令检查环境变量是否生效。
        
        ```
        echo $OSS_ACCESS_KEY_ID
        echo $OSS_ACCESS_KEY_SECRET
        ```
        
    

## Windows系统

1.  在CMD中运行以下命令。
    
    ```
    setx OSS_ACCESS_KEY_ID "your-access-key-id"
    setx OSS_ACCESS_KEY_SECRET "your-access-key-secret"
    ```
    
2.  打开一个新的CMD窗口。
    
3.  在新的CMD窗口运行以下命令，检查环境变量是否生效。
    
    ```
    echo %OSS_ACCESS_KEY_ID%
    echo %OSS_ACCESS_KEY_SECRET%
    ```
    

当前支持配置的环境变量如下：

| **环境变量名** | **对应的参数名** |
| --- | --- |
| OSS\\_ACCESS\\_KEY\\_ID | access-key-id |
| OSS\\_ACCESS\\_KEY\\_SECRET | access-key-secret |
| OSS\\_SESSION\\_TOKEN | sts-token |
| OSS\\_ROLE\\_ARN | ram-role-arn |
| OSS\\_ROLE\\_SESSION\\_NAME | role-session-name |
| OSS\\_REGION | region |
| OSS\\_ENDPOINT | endpoint |
| OSSUTIL\\_CONFIG\\_FILE | config-file |
| OSSUTIL\\_PROFILE | profile |

### 配置命令行选项

ossutil提供了多个命令行选项，支持配置[全局命令行选项](#d7282c6664szl)。命令行选项的优先级最高，可以覆盖配置文件设置或环境变量设置的参数。

**重要**

通过命令行选项需要传入访问密钥，可能会被日志系统记录，存在密钥泄露的风险，请谨慎使用。

```
ossutil ls oss://examplebucket -i "your-access-key-id" -k "your-access-key-secret" --region cn-hangzhou
```

## **访问凭证配置**

### **使用 RAM 用户的 AK**

如果应用程序部署运行在安全、稳定且不易受外部攻击的环境中，需要长期访问的OSS，且不能频繁轮转凭证时，可以使用阿里云主账号或RAM用户的AK（Access Key ID、Access Key Secret）初始化凭证提供者。需要注意的是，该方式需要手动维护一个AK，存在安全性风险和维护复杂度增加的风险。

## **配置文件**

生成如下配置文件，并保存在`~/.ossutilconfig`。

```
[default]
accessKeyID = yourAccessKeyID
accessKeySecret = yourAccessKeySecret
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

## **环境变量**

```
export OSS_ACCESS_KEY_ID=yourAccessKeyID
export OSS_ACCESS_KEY_SECRET=yourAccessKeySecret
ossutil ls oss://examplebucket
```

## **命令行选项**

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -i yourAccessKeyID -k yourAccessKeySecret
```

### **使用STS临时访问凭证**

如果应用程序需要临时访问OSS，可以使用通过STS服务获取的临时身份凭证（Access Key ID、Access Key Secret和Security Token）初始化凭证提供者。需要注意的是，该方式需要手动维护一个STS Token，存在安全性风险和维护复杂度增加的风险。此外，如果需要多次临时访问OSS，需要手动刷新STS Token。

## **配置文件**

生成如下的配置文件，并保存在`~/.ossutilconfig`。

```
[default]
accessKeyID = yourSTSAccessKeyID
accessKeySecret = yourSTSAccessKeySecret
stsToken = yourSecurityToken
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

## **环境变量**

```
export OSS_ACCESS_KEY_ID=yourSTSAccessKeyID
export OSS_ACCESS_KEY_SECRET=yourSTSAccessKeySecret
export OSS_SESSION_TOKEN=yourSecurityToken
ossutil ls oss://examplebucket
```

## **命令行选项**

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -i yourSTSAccessKeyID -k yourSTSAccessKeySecret -t yourSecurityToken --region cn-hangzhou
```

### **使用RAMRoleARN**

如果应用程序需要授权访问OSS，例如跨阿里云账号访问OSS，可以使用RAMRoleARN初始化凭证提供者。该方式底层实现是STS Token。通过指定RAM角色的ARN（Alibabacloud Resource Name），Credentials工具会前往STS服务获取STS Token，并在会话到期前调用AssumeRole接口申请新的STS Token。此外，还可以通过为`policy`赋值来限制RAM角色到一个更小的权限集合。

**重要**

-   阿里云账号拥有资源的全部权限，AK一旦泄露，会给系统带来巨大风险，不建议使用。推荐使用最小化授权的RAM用户的AK。
    
-   如需创建RAM用户的AK，请直接访问[创建AccessKey](https://help.aliyun.com/zh/ram/user-guide/create-an-accesskey-pair#section-rjh-18m-7kp)。RAM用户的Access Key ID、Access Key Secret信息仅在创建时显示，请及时保存，如若遗忘请考虑创建新的AK进行轮换。
    
-   如需获取RAMRoleARN，请直接访问[创建角色](https://help.aliyun.com/zh/ram/developer-reference/api-ram-2015-05-01-createrole)。
    

生成如下配置文件，并保存在`~/.ossutilconfig`。不支持通过环境变量或者命令行选项方式设置。

```
[default]
accessKeyID = yourAccessKeyID
accessKeySecret = yourAccessKeySecret
mode = RamRoleArn
roleArn = acs:ram::137918634953****:role/Alice
roleSessionName = session_name_example
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

### **使用ECSRAMRole**

如果应用程序运行在ECS实例、ECI实例、容器服务Kubernetes版的Worker节点中，建议使用ECSRAMRole初始化凭证提供者。该方式底层实现是STS Token。ECSRAMRole允许将一个角色关联到ECS实例、ECI实例或容器服务 Kubernetes 版的Worker节点，实现在实例内部自动刷新STS Token。该方式无需提供一个AK或STS Token，消除了手动维护AK或STS Token的风险。如何获取ECSRAMRole，请参见[创建角色](https://help.aliyun.com/zh/ram/developer-reference/api-ram-2015-05-01-createrole)。

**说明**

不支持通过环境变量方式设置。

#### **EcsRamRole模式**

## 配置文件

生成如下配置文件，并保存在`~/.ossutilconfig`。

```
[default]
mode = EcsRamRole
# ecsRoleName可以不设置，当不设置时，自动获取。
ecsRoleName = EcsRamRoleOss 
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

## 命令行工具

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket --mode EcsRamRole
```

#### **EcsRamRole** IMDSv2**模式**

**说明**

从 2.2.0 版本开始，支持 EcsRamRole IMDSv2 模式。

## 配置文件

生成如下配置文件，并保存在`~/.ossutilconfig`。

```
[default]
mode = Ali-EcsRamRole
# ecsRoleName可以不设置，当不设置时，自动获取。
ecsRoleName = EcsRamRoleOss 
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

## 命令行工具

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket --mode Ali-EcsRamRole
```

### **使用OIDCRoleARN**

在容器服务Kubernetes版中设置了Worker节点RAM角色后，对应节点内的Pod中的应用也就可以像ECS上部署的应用一样，通过元数据服务（Meta Data Server）获取关联角色的STS Token。但如果容器集群上部署的是不可信的应用（比如部署的客户提交的应用，代码也没有对开放），可能并不希望它们能通过元数据服务获取Worker节点关联实例RAM角色的STS Token。为了避免影响云上资源的安全，同时又能让这些不可信的应用安全地获取所需的STS Token，实现应用级别的权限最小化，可以使用RRSA（RAM Roles for Service Account）功能。该方式底层实现是STS Token。阿里云容器集群会为不同的应用Pod创建和挂载相应的服务账户OIDC Token文件，并将相关配置信息注入到环境变量中，Credentials工具通过获取环境变量的配置信息，调用STS服务的AssumeRoleWithOIDC接口换取绑定角色的STS Token。该方式无需提供一个AK或STS Token，消除了手动维护AK或STS Token的风险。详情请参见[通过RRSA配置ServiceAccount的RAM权限实现Pod权限隔离](https://help.aliyun.com/zh/ack/ack-managed-and-ack-dedicated/user-guide/use-rrsa-to-authorize-pods-to-access-different-cloud-services#task-2142941)。

生成如下的配置文件，并保存在`~/.ossutilconfig`。不支持通过环境变量或者命令行选项方式设置。

```
[default]
mode = oidcRoleArn
#指定 OIDC 提供者的 ARN（Aliyun Resource Name），格式为 acs:ram::account-id:oidc-provider/provider-name。
OIDCProviderArn=acs:ram::113511544585****:oidc-provider/TestOidcProvider
#指定 OIDC 令牌的文件路径，用于存储 OIDC 令牌
OIDCTokenFilePath=OIDCTokenFilePath
#填写角色的ARN信息，即需要扮演的角色ID。格式为acs:ram::113511544585****:oidc-provider/TestOidcProvider
roleArn=acs:ram::113511544585****:role/testoidc
# 自定义角色会话名称，用于区分不同的令牌。
roleSessionName= TestOidcAssumedRoleSession
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

### **外部进程获取凭证**

ossutil通过外部命令启动一个进程，该进程与ossutil进程是独立的，称为外部进程。外部进程执行后，通过标准输出把结果返回给进程的启动者，即ossutil。可以通过外部进程获取凭证。

**说明**

-   生成凭证的命令不可由未经批准的进程或用户访问，否则可能存在安全风险。
    
-   生成凭证的命令不会把任何秘密信息写入stderr或stdout，因为该信息可能会被捕获或记录，可能会将其向未经授权的用户公开。
    

外部命令返回的凭证，支持长期凭证和临时凭证，格式如下。

## 长期凭证

```
{
  "AccessKeyId" : "ak",
  "AccessKeySecret" : "sk"
}
```

## 临时凭证

```
{
  "AccessKeyId" : "ak",
  "AccessKeySecret" : "sk",
  "Expiration" : "2023-12-29T07:45:02Z",
  "SecurityToken" : "token"
}
```

生成如下配置文件，并保存在`~/.ossutilconfig`。不支持通过环境变量或者命令行选项方式设置。

```
[default]
mode = Process
credentialProcess = user-cmd
region=cn-hangzhou
```

通过如下命令查询examplebucket中的对象。

```
ossutil ls oss://examplebucket -c ~/.ossutilconfig
```

### **匿名访问**

如果只需要访问公共读取权限的OSS资源，可以使用匿名访问方式，无需提供任何凭证。

```
ossutil cat oss://bucket/public-object --mode Anonymous
```

## **命令参考**

ossutil提供了高级命令、API级命令、辅助命令等三类命令。

### **命令结构**

ossutil常用命令格式如下：

```
ossutil command [argument] [flags]  

ossutil command subcommond [argument] [flags]  

ossutil topic
```

-   argument：参数，为字符串。
    
-   flags：选项，支持短名字风格`-o[=value]/ -o [ value]`和长名字风格`--options[=value]/--options[ value]`。如果多次指定某个排它参数，则仅最后一个值生效。
    

命令示例如下：

-   命令：`ossutil cat oss://bucket/object`
    
-   多级命令：`ossutil api get-bucket-cors --bucket bucketexample`
    
-   帮助主题：`ossutil filter`
    

### **命令列表**

ossutil 提供了三类命令：

-   高级命令
    
    用于常用的存储空间或者对象的操作场景，例如存储空间创建、删除、数据拷贝、对象属性修改等。
    
    | **命令名** | **含义** |
    | --- | --- |
    | [mb](https://help.aliyun.com/zh/oss/developer-reference/mb-create-storage-space) | 创建存储空间 |
    | [rb](https://help.aliyun.com/zh/oss/developer-reference/rb-delete-bucket) | 删除存储空间 |
    | [du](https://help.aliyun.com/zh/oss/developer-reference/du-get-size) | 获取存储或者指定前缀所占的存储空间大小 |
    | [stat](https://help.aliyun.com/zh/oss/developer-reference/stat2) | 显示存储空间或者对象的描述信息 |
    | [mkdir](https://help.aliyun.com/zh/oss/developer-reference/mkdir-create-directory) | 创建一个名字有后缀字符`/`的对象 |
    | [append](https://help.aliyun.com/zh/oss/developer-reference/append-append-upload) | 将内容上传到追加类型的对象末尾 |
    | [cat](https://help.aliyun.com/zh/oss/developer-reference/cat-output-file-contents) | 将对象内容连接到标准输出 |
    | [ls](https://help.aliyun.com/zh/oss/developer-reference/ls-list-resources-under-the-account-level) | 列举存储空间或者对象 |
    | [cp](https://help.aliyun.com/zh/oss/developer-reference/cp-upload-download-and-copy-files/) | 上传、下载或拷贝对象 |
    | [rm](https://help.aliyun.com/zh/oss/developer-reference/rm-deleted) | 删除存储空间里的对象 |
    | [set-props](https://help.aliyun.com/zh/oss/developer-reference/set-props-set-object-properties) | 设置对象的属性 |
    | [presign](https://help.aliyun.com/zh/oss/developer-reference/presign-generate-presigned-url) | 生成对象的预签名URL |
    | [restore](https://help.aliyun.com/zh/oss/developer-reference/restore-unfrozen-file) | 恢复冷冻状态的对象为可读状态 |
    | [revert（恢复版本）](https://help.aliyun.com/zh/oss/developer-reference/revert-recovery-version) | 将对象恢复成指定的版本 |
    | [sync](https://help.aliyun.com/zh/oss/developer-reference/sync-synchronizing-files/) | 将本地文件目录或者对象从源端同步到目的端 |
    | [hash](https://help.aliyun.com/zh/oss/developer-reference/hash-calculate-crc64-or-md5) | 计算文件/对象的哈希值 |
    
-   API级命令，提供了API操作的直接访问，支持该接口的配置参数。
    
    **说明**
    
    仅列举部分命令，可以通过`ossutil api -h`查看所有命令。
    
    | **命令名** | **含义** |
    | --- | --- |
    | [put-bucket-acl](https://help.aliyun.com/zh/oss/developer-reference/manage-bucket-access-permissions) | 设置、修改Bucket的访问权限 |
    | [get-bucket-acl](https://help.aliyun.com/zh/oss/developer-reference/get-bucket-acl) | 获取访问权限 |
    | .... |     |
    | [put-bucket-cors](https://help.aliyun.com/zh/oss/developer-reference/put-bucket-cors) | 设置跨域资源共享规则 |
    | [get-bucket-cors](https://help.aliyun.com/zh/oss/developer-reference/get-bucket-cors) | 获取跨域资源共享规则 |
    | [delete-bucket-cors](https://help.aliyun.com/zh/oss/developer-reference/delete-a-cross-domain-resource-sharing-rule) | 删除跨域资源共享规则 |
    
-   辅助命令，例如配置文件的配置、额外的帮助主题等。
    
    | **命令名** | **含义** |
    | --- | --- |
    | [help](https://help.aliyun.com/zh/oss/developer-reference/get-help-information) | 获取帮助信息 |
    | [config（管理配置文件）](https://help.aliyun.com/zh/oss/developer-reference/config-create-configuration-file) | 创建配置文件用以存储配置项和访问凭证 |
    | [update](https://help.aliyun.com/zh/oss/developer-reference/update-ossutil-version-upgrade) | 版本更新 |
    | [version](https://help.aliyun.com/zh/oss/developer-reference/version-displays-version-information) | 显示版本信息 |
    | [probe](https://help.aliyun.com/zh/oss/developer-reference/probe-probe-state) | 探测命令 |
    

### **命令选项类型**

| **选项类型** | **选项** | **说明** |
| 字符串 | \\--option string | - 字符串参数可以包含ASCII字符集中的字母数字字符、符号和空格。 - 如果包含空格时，需要用引号引起来。 例如：--acl private。 |
| 布尔值 | \\--option | 打开或关闭某一选项。 例如：--dry-run。 |
| 整数  | \\--option Int | 无符号整数。 例如：--read-timeout 10。 |
| 时间戳 | \\--option Time | ISO 8601格式，即DateTime或Date。 例如：--max-mtime 2006-01-02T15:04:05。 |
| 字节单位后缀 | \\--option SizeSuffix | 默认单位是字节（B），也可以使用单位后缀形式，支持的单位后缀为：K（KiB）=1024字节、M（MiB）、G（GiB）、G（GiB）、T（TiB）、P（PiB）、E（EiB） 例如：最小size为1024字节 \\--min-size 1024 \\--min-size 1K |
| 时间单位后缀 | \\--option Duration | 时间单位，默认单位是秒。支持的单位后缀为：ms 毫秒，s 秒，m 分钟，h 小时，d 天，w 星期，M 月，y 年。 支持小数。例如：1.5天 \\--min-age 1.5d |
| 字符串列表 | \\--option strings | 支持单个或者多个同名选项，支持以逗号（,）分隔的多个值。 支持多选项输入的单值。 例如：--metadata user=jack,email=ja\\*\\*@test.com --metadata address=china |
| 字符串数组 | \\--option stringArray | 支持单个或者多个同名选项，只支持多选项输入的单值。 例如 ：--include \\*.jpg --include \\*.txt。 |

### **从非命令行中加载数据**

一般情况下，参数的值都放在命令行里，当参数值比较复杂时，需要从文件加载参数值；当需要串联多个命令操作时，需要标准输中加载参数值。所以，对需要支持多种加载参数值的参数，做了如下约定：

-   以`file://`开始的，表示从文件路径中加载。
    
-   当参数值为`-`时，表示从标准输入中加载。
    

例如， 设置存储空间的跨域设置，以JSON参数格式为例，通过文件方式加载跨域参数。cors-configuration.json文件如下：

```
{
  "CORSRule": {
    "AllowedOrigin": ["www.aliyun.com"],
    "AllowedMethod": ["PUT","GET"],
    "MaxAgeSeconds": 10000
  }
}
```

```
ossutil api put-bucket-cors --bucket examplebucket --cors-configuration file://cors-configuration.json
```

通过选项参数值加载跨域参数，cors-configuration.json的紧凑形式如下：

```
{"CORSRule":{"AllowedOrigin":["www.aliyun.com"],"AllowedMethod":["PUT","GET"],"MaxAgeSeconds":10000}}
```

```
ossutil api put-bucket-cors --bucket examplebucket --cors-configuration  "{\"CORSRule\":{\"AllowedOrigin\":[\"www.aliyun.com\"],\"AllowedMethod\":[\"PUT\",\"GET\"],\"MaxAgeSeconds\":10000}}"
```

从标准输入加载参数的示例如下：

```
cat cors-configuration.json | ossutil api put-bucket-cors --bucket examplebucket --cors-configuration -
```

### **控制命令输出**

#### **输出格式**

对ossutil api下的子命令，以及du、stat命令，支持通过`--output-format`参数调整其输出格式，当前支持的格式如下：

| **格式名称** | **说明** |
| --- | --- |
| raw | 以原始方式输出，即服务端返回什么内容，则输出什么内容。 |
| json | 输出采用JSON字符串的格式。 |
| yaml | 输出采用YAML字符串的格式。 |
| xml | 输出采用XML字符串的格式。 |

例如：以`get-bucket-cors`为例，原始内容如下：

```
ossutil api get-bucket-cors --bucket bucketexample
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration>
  <CORSRule>
    <AllowedOrigin>www.aliyun.com</AllowedOrigin>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>10000</MaxAgeSeconds>
  </CORSRule>
  <ResponseVary>false</ResponseVary>
</CORSConfiguration>
```

转成JSON如下：

```
ossutil api get-bucket-cors --bucket bucketexample --output-format json
{
  "CORSRule": {
    "AllowedMethod": [
      "PUT",
      "GET"
    ],
    "AllowedOrigin": "www.aliyun.com",
    "MaxAgeSeconds": "10000"
  },
  "ResponseVary": "false"
}
```

#### **筛选输出**

ossutil提供了基于JSON的内置客户端筛选功能，通过`--output-query value`选项使用。

**说明**

该选项仅支持ossutil api下的子命令。

该功能基于JMESPath语法，当使用该功能时，会把返回的内容转成JSON，然后再使用JMESPath进行筛查，最后按照指定的输出格式输出。有关JMESPath 语法的说明，请参见[JMESPath Specification](https://jmespath.org/specification.html#)。

例如：以get-bucket-cors为例，只输出AllowedMethod内容，示例如下：

```
ossutil api get-bucket-cors --bucket bucketexample --output-query CORSRule.AllowedMethod --output-format json
[
  "PUT",
  "GET"
]
```

#### **友好显示**

对于高级命令（du、stat），提供了`--human-readable`选项，对字节、数量数据，提供了以人类可读方式输出信息。即字节数据转成Ki|Mi|Gi|Ti|Pi后缀格式（1024 base），数量数据转成k|m|g|t|p后缀格式(1000 base)。

例如：原始模式

```
ossutil stat oss://bucketexample
ACL                         : private
AccessMonitor               : Disabled
ArchiveObjectCount          : 2
ArchiveRealStorage          : 10
ArchiveStorage              : 131072
...
StandardObjectCount         : 119212
StandardStorage             : 66756852803
Storage                     : 66756852813
StorageClass                : Standard
TransferAcceleration        : Disabled
```

友好模式

```
ossutil stat oss://bucketexample --human-readable
ACL                         : private
AccessMonitor               : Disabled
ArchiveObjectCount          : 2
ArchiveRealStorage          : 10
ArchiveStorage              : 131.072k
...
StandardObjectCount         : 119.212k
StandardStorage             : 66.757G
Storage                     : 66.757G
StorageClass                : Standard
TransferAcceleration        : Disabled
```

### **命令返回码**

通过进程等方式调用ossutil时，无法实时查看回显信息。ossutil支持在进程运行结束后，根据不同的运行结果生成不同的返回码，具体的返回码及其含如下。可以通过以下方式获取最近一次运行结果的返回码，然后根据返回码分析并处理问题。

## Linux

执行命令获取返回码：`echo $?`。

## Windows

执行命令获取返回码：`echo %errorlevel%`。

## macOS

执行命令获取返回码：`echo $?`。

| **返回码** | **含义** |
| --- | --- |
| 0   | 命令操作成功，发送到服务端的请求执行正常，服务端返回200响应。 |
| 1   | 参数错误，例如缺少必需的子命令或参数，或使用了未知的命令或参数。 |
| 2   | 该命令已成功解析，并已对指定服务发出了请求，但该服务返回了错误（非2xx响应）。 |
| 3   | 调用OSS GO SDK时，遇到的非服务端错误。 |
| 4   | 批量操作时，例如cp、rm部分请求发生了错误。 |
| 5   | 中断错误。命令执行过程中，通过ctrl +c取消某个命令。 |

## **命令行选项**

在命令行操作中，部分命令需要附加参数以指定操作对象或设置选项，而其他命令则不需要参数。对于带参数的命令，可以根据具体要求提供适当的参数值，以实现预期功能，例如，带参数的命令如：

```
ossutil ls --profile dev
```

`ossutil ls --profile dev`允许用户通过参数值`dev`指定特定的配置文件。带参数的选项通常需要通过空格或等号（=）将选项名称与参数值分隔，例如`--profile dev`或`--profile=dev`。当参数值包含空格时，必须使用双引号将整个参数值括起来，以确保命令正确解析，例如 `--description "OSS bucket list"`。

### **全局命令行选项**

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| \\-i, --access-key-id | string | 访问OSS使用的AccessKey ID。 |
| \\-k, --access-key-secret | string | 访问OSS使用的AccessKey Secret。 |
| \\--addressing-style | string | 请求地址的格式。取值范围如下： - virtual（默认值），表示虚拟托管模式**。** - path，表示路径模式。 - cname，表示自定义域名模式。 |
| \\-c, --config-file | string | 配置文件的路径。 默认值为`~\\\\.ossutilconfig`。 |
| \\--connect-timeout | int | 客户端连接超时的时间。单位为秒，默认值为10。 |
| \\-n, --dry-run | /   | 在不进行任何更改的情况下执行试运行。 |
| \\-e, --endpoint | string | 对外服务的访问域名。 |
| \\-h, --help | /   | 显示帮助信息。 |
| \\--language | string | 显示的语言。 |
| \\--loglevel | string | 日志级别。取值范围如下： - off（默认值） - info - debug |
| \\--mode | string | 鉴权模式。取值： - AK，表示访问密钥。 - StsToken，表示临时安全凭证。 - EcsRamRole，表示使用ECS实例角色（RAM Role）进行鉴权。 - Anonymous，表示匿名访问。 |
| \\--output-format | string | 输出格式，默认值为raw。 |
| \\--output-query | string | JMESPath查询条件。 |
| \\--profile | string | 指定配置文件里的profile。 |
| \\-q, --quiet | /   | 安静模式，打印尽可能少的信息。 |
| \\--read-timeout | int | 客户端读写请求超时时间。单位为秒，默认值为20。 |
| \\--region | string | 数据中心所在的地域，配置值可设置为cn-hangzhou。 |
| \\--retry-times | int | 当错误发生时的重试次数。默认值为10。 |
| \\--sign-version | string | 请求使用的签名算法版本。取值： - v1 - v4（默认值） |
| \\--skip-verify-cert | /   | 表示不校验服务端的数字证书。 |
| \\-t, --sts-token | string | 访问OSS使用的STS Token。 |
| \\--proxy | string | 指定代理服务器。自 2.0.1 版本起支持。 配置值可以为以下几种： - 直接配置：可以直接指定代理服务器的详细信息，例如： - `http://proxy.example.com:8080` - `https://proxy.example.com:8443` - `env`：表示使用环境变量 `HTTP_PROXY` 和 `HTTPS_PROXY` 来获取代理服务器信息。用户需要在操作系统中配置这两个环境变量，例如： - `HTTP_PROXY=http://proxy.example.com:8080` - `HTTPS_PROXY=https://proxy.example.com:8443` 配置这些环境变量后，将代理服务器选项的值设置为 `env`，系统将自动使用这些环境变量中的代理设置。 |
| \\--log-file | string | 指定日志输出文件，自 2.0.1 版本起支持。配置值为： - `-`：表示将日志输出到标准输出（Stdout）。 - `文件路径`：指定一个具体的文件路径，将日志输出到该文件。 如果未指定日志输出文件，输出到默认配置文件上。 |
| \\--cloudbox-id | string | 云盒ID，应用于云盒场景。自 2.1.0 版本起支持。 |
| \\--ignore-env-var | /   | 忽略所有以 `OSS_` 为前缀的环境变量配置。自 2.2.0 版本起支持。 |
| \\--bind-address | string | 指定出站连接所绑定的本地 IP 地址（支持 IPv4、IPv6）。自2.2.0 版本起支持。 |
| \\--account-id | string | 账号ID，用于向量 Bucket 场景中的身份识别与资源归属判断。自 2.2.0 版本起支持。 |
| \\--user-agent | string | 在默认的 User-Agent 末尾追加指定的值。自 2.2.2 版本起支持。 |

### **常用命令行选项**

| **命令范围** | **支持的选项** |
| 所有高级命令 | - \\--encoding-type string：输入的对象名或文件名的编码方式，取值：url。 - \\--request-payer string：请求的支付方式。如果为请求者付费模式，请设置该值，取值：requester。 |
| 支持批量操作的命令 | - \\--start-after/--end-with (, \\] ：前开后闭 ，用于设置key的查询范围。 - filter选项：对象/文件名、对象/文件目录、对象/文件大小、对象/文件时间、对象元数据等信息可设置过滤条件，具体的过滤规则，请参见[过滤选项](https://help.aliyun.com/zh/oss/developer-reference/advanced-commands/#331825ba29zi4)。 - \\--limited-num：设置查询接口的返回数据。 - \\--recursive/-r：用于递归操作，递归访问根目录下的文件或对象，包括子目录。 - \\--dirs/-d：只访问根目录下的文件或对象，不包括子目录。 **说明** 对于对象，采用Delimiter方式来模拟，需要扫描该前缀下的所有对象，对象数量越多，则越耗时。 - \\--force/-f：强制操作，不进行询问提示。 - \\--list-objects：使用ListObjects接口列举对象。 |
| 支持目的过滤规则的命令 | - \\--update：跳过目标端已存在且修改时间比源文件更新的所有文件。如果目标端已存在的文件的修改时间与源文件的修改时间相同，则将更新该文件。 - \\--size-only：只对比文件大小，只同步文件大小不一样的数据。 - \\--checksum：对比crc64，优先对比文件大小，当文件大小一样时，再对比crc64。如果某一端crc64不存在，则判定为不一致，仅当对象间拷贝有效。 - \\--ignore-existing：跳过已存在的文件。自 2.0.3 版本起支持。 |
| 支持单个对象的命令 | \\--version-id string：对象的版本标识。 |
| 支持列表模式的命令 | \\--list-format：列表文件的格式，取值：plain、inventory。 \\--list-manifest-from：从文件中读取列表文件格式的描述信息，当列表文件格式为inventory时，需要设置该参数。 |

## **常见问题**

### **使用ossutil执行相关命令时，报错region must be set in sign version 4**

问题原因：在配置ossutil2.0时没有配置地域ID项。

解决方法：为避免在使用ossutil时因配置项缺失导致操作失败，请确保按照以下步骤配置必要的基础项：AccessKey ID、AccessKey Secret、地域ID。特别是地域ID，由于签名已升级到V4版本，因此成为必需项。关于如何获取地域ID，请参见[地域和Endpoint](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints)。