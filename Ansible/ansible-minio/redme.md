# 目录结构
ansible-minio/
├── inventory/
│   └── minio.ini
├── group_vars/
│   └── minio.yml
├── roles/
│   └── minio/
│       ├── files/
│       │   └── minio.rpm
│       ├── templates/
│       │   └── minio.service.j2
│       └── tasks/
│           └── main.yml
└── site.yml
# 执行部署（只需一条命令）
cd ansible-minio
ansible-playbook -i inventory/minio.ini site.yml
