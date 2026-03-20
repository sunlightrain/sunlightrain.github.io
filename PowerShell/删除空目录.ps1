#仅删除当前目录下的空子文件夹（不递归）
#先预览（不删除）：
Get-ChildItem -Directory |
  Where-Object { (Get-ChildItem -LiteralPath $_.FullName -Force | Measure-Object).Count -eq 0 } |
  Select-Object -ExpandProperty FullName

#确认后删除
Get-ChildItem -Directory |
  Where-Object { (Get-ChildItem -LiteralPath $_.FullName -Force | Measure-Object).Count -eq 0 } |
  Remove-Item -Force

#递归清理：从最深处开始删除所有层级的空文件夹（会“抽干”空链）
#先预览（不删除）：
Get-ChildItem -Directory -Recurse |
  Sort-Object FullName -Descending |
  Where-Object { (Get-ChildItem -LiteralPath $_.FullName -Force | Measure-Object).Count -eq 0 } |
  Select-Object -ExpandProperty FullName

#确认后删除：
Get-ChildItem -Directory -Recurse |
  Sort-Object FullName -Descending |
  Where-Object { (Get-ChildItem -LiteralPath $_.FullName -Force | Measure-Object).Count -eq 0 } |
  Remove-Item -Force
