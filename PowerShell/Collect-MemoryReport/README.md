✅ 脚本功能概览

采集 系统级内存指标（可用/已提交/缓存/分页池/非分页池等）
采集 TOP 进程（按工作集/私有字节/提交大小排序）
采集 常用性能计数器（可用于趋势分析）
可选：抓取每个进程的句柄/线程数、服务映射
输出：CSV（数据）、JSON（结构化）、HTML（可阅读报告）

权限建议：用管理员权限运行，以保证计数器和进程信息完整。

🧩 使用方法

在服务器上用管理员权限打开 PowerShell。
将下面脚本保存为：Collect-MemoryReport.ps1。
运行：
.\Collect-MemoryReport.ps1 -OutputFolder "C:\MemReport" -TopN 30 -SampleSeconds 5 -Samples 12

这会在 1 分钟（5 秒采样 × 12 次）内收集数据并输出报告。

🔍 报告怎么看？

system_memory_overview.csv
关注：

AvailableMBytes（是否很低）
CommittedBytesMB（是否接近物理内存）
CacheBytesMB（文件缓存是否偏大）
PoolNonpagedBytesMB（非分页池是否异常）

top_process_by_workingset.csv / top_process_by_privatebytes.csv
快速定位占用大户（应用/服务）。

perf_counter_samples.csv
看 Pages Input/Output/sec 是否尖刺（可能内存压力或频繁分页）。

MemoryReport_xxx.html
可直接在浏览器打开，概览一目了然。

一、先看 HTML 概览（MemoryReport_*.html）
HTML 报告里通常有四块：

System Memory Overview（系统内存概览）
这些字段最关键：

TotalVisibleMemoryMB：系统可见的物理内存（不含硬件保留）。这是你对比占比的“总量”。
AvailableMBytes：可用内存（= Free + Standby）。
👉 判断：如果 AvailableMBytes < 10% 的物理内存或 < 1GB（取较小值），说明内存压力较大。
CommittedBytesMB：系统总体提交内存（commit charge）。
👉 判断：若 CommittedBytesMB 接近或超过 TotalVisibleMemoryMB（且页面文件较小），说明逼近提交上限，可能会出现分配失败或频繁分页。
CacheBytesMB：文件系统缓存。
👉 判断：若 CacheBytesMB 占物理内存的 30–50%+，而业务进程并不占用很多，往往是文件缓存导致“进程看起来不高、系统使用率却高”。在文件服务器上这比较正常；在应用/数据库服务器上则可能让业务内存被挤压。
PoolNonpagedBytesMB / PoolPagedBytesMB（非分页池/分页池）
👉 判断：Nonpaged 持续增长到数 GB（具体要看总内存），是驱动/内核泄漏的强信号；Paged 过高也需留意。
PagesInputPerSec / PagesOutputPerSec：分页指标。
👉 判断：持续的高值或频繁尖刺，意味着内存压力导致磁盘分页，会拖慢系统。

Top Processes by Working Set（按工作集）

WorkingSetMB：进程当前驻留的物理内存。
👉 排在最前的进程是“物理占用大户”。

Top Processes by Private Bytes（按私有字节）

PrivateMemorySizeMB：进程独占的已提交内存，更接近进程“真占用”。
👉 如果某进程 Private Bytes 很大且持续增长，是进程级泄漏的线索。

Notes & Recommendations（建议）
我在脚本里总结了排查要点（英文），可对照下面的详细解读。

二、看 CSV/JSON 时如何“量化判断”
1）system_memory_overview.csv

先算几个占比（相对 TotalVisibleMemoryMB）：

AvailableMBytes / TotalVisibleMemoryMB
→ <10%：有内存压力。
CacheBytesMB / TotalVisibleMemoryMB
→ >30–50%：文件缓存占比很高（结合你的角色判断是否合理）。
PoolNonpagedBytesMB / TotalVisibleMemoryMB
→ 达到几个百分点（例如 5%+）且随时间增长：重点关注驱动。
同时看 CommittedBytesMB 是否接近 TotalVisibleMemoryMB（或总可提交=物理+页面文件上限）。

典型结论示例

进程不高 & CacheBytes 很高 → 是文件系统缓存导致的总占用偏高。
Nonpaged 持续攀升 → 驱动/内核泄漏方向。
Committed 高、Available 低、Pages I/O 高 → 总体内存压力，可能分页明显。

2）top_process_by_workingset.csv & top_process_by_privatebytes.csv

WorkingSet VS Private Bytes：

WorkingSet 高、Private 适中：可能进程映射了较多文件/共享内存，不一定泄漏。
Private Bytes 很高（尤其 > 物理内存的显著比例）且随时间增长：排查该进程的内存泄漏。

看 ServiceName（如果映射到了服务），以及 Path 来识别具体应用（SQL Server、IIS、Java、.NET）。
Threads/Handles 畸高也可作为边线证据（资源泄漏）。

3）perf_counter_samples.csv（趋势）

折线趋势很关键：

Available MBytes 是否一路下降？
Committed Bytes 是否一路上升？
Pages Input/Output/sec 是否有持续的高位或频繁尖刺？
Process(_Total)\Private Bytes 是否跟随系统提交增长？

如果你这次采样只有 1 分钟，建议再延长到 10–30 分钟，更能体现趋势。

三、结合常见场景给出定位路径
场景 A：系统使用率高，但进程总体占用不高

多数为**文件系统缓存（CacheBytes/Standby List）**占用：

验证：CacheBytesMB 占比高；AvailableMBytes 低但 top_process 没有异常；RAMMap（Sysinternals）里看到 Standby 很大。
处理策略：

如果是文件服务器：属正常，除非业务受影响。
如果业务内存被挤压：可短暂清理 Standby（RAMMap → Empty → Standby Lists），作为实验验证；并结合应用（如 SQL Server）内存上限做资源边界。
长期策略：评估工作负载与内存容量是否匹配，必要时加内存或优化应用缓存策略。

场景 B：Nonpaged Pool 异常高/持续增长

多为驱动/内核泄漏：

验证：PoolNonpagedBytesMB 占比持续上升。
下一步：用 PoolMon（WDK 工具）按Tag定位驱动；结合近期驱动/安全软件/备份代理更新情况，升级或回退。

场景 C：某业务进程异常

Private Bytes 高且趋势向上；或者 WorkingSet 与 Private 都高：

下一步：

用 PerfMon 监控该进程的 Process(<name>)\Private Bytes、.NET CLR Memory（如果 .NET）、SQLServer:Memory Manager（如果 SQL）等。
用 Procdump/Userdump 抓取内存快照，配合 WinDbg 分析（仅在确认泄漏方向后进行）。

场景 D：分页明显（Pages Input/Output/sec 高）

一般是内存压力 + 页面文件参与：

检查：页面文件尺寸是否合理（系统管理或容量足够）；是否有进程/缓存过度占用。
处理：调整页面文件策略、优化进程内存、考虑加内存。