create table sys_admin_user
(
    id             bigint auto_increment comment '主键ID'
  primary key,
    email          varchar(64)  default '' not null comment '邮箱',
    mobile         varchar(64)  default '' not null comment '手机',
    user_name      varchar(64)  default '' not null comment '用户姓名, 不能重复',
    nick_name      varchar(64)  default '' not null comment '用户昵称',
    password       varchar(256) default '' not null comment '密码,密文',
    gender       int(11) default 0 not null comment '1男2女0未知',
    avatar         varchar(256) default '' not null comment '头像地址',
    status         int          default 1  not null comment '启用状态：0->禁用；1->启用',
    sort           int          default 0  not null comment '排序',
    delete_flag    tinyint(1)   default 0  not null comment '1:已删除, 0:正常未删除',
    version        int          default 1  not null comment '版本信息',
    ctime          datetime                not null comment '创建时间',
    utime          datetime                not null comment '最后更新时间',
    cuid           bigint       default 0  not null comment '创建人ID',
    opuid          bigint       default 0  not null comment '更新人ID',
    constraint uni_email
        unique (email, delete_flag)
)
    comment '管理端用户表' row_format = DYNAMIC;

create table sys_dept
(
    id          bigint auto_increment comment '主键ID'
  primary key,
    parent_id   bigint                   null comment '上级部门ID',
    name        varchar(64)   default '' not null comment '角色名称',
    full_path   varchar(8000) default '' not null comment '完整路径',
    status      int           default 1  not null comment '启用状态：0->禁用；1->启用',
    sort        int           default 0  not null comment '排序',
    delete_flag tinyint(1)    default 0  not null comment '1:已删除, 0:正常未删除',
    version     int           default 1  not null comment '版本信息',
    ctime       datetime                 not null comment '创建时间',
    utime       datetime                 not null comment '最后更新时间',
    cuid        bigint        default 0  not null comment '创建人ID',
    opuid       bigint        default 0  not null comment '更新人ID'
)
    comment '部门表' row_format = DYNAMIC;

create table sys_menu
(
    id          bigint auto_increment comment '主键ID'
  primary key,
    parent_id   bigint       default 0  not null comment '父级ID',
    name        varchar(64)  default '' not null comment '菜单或者按钮名称',
    node_type   int          default 2  not null comment '节点类型，1文件夹，2页面，3按钮, 4:子页面或者页面元素',
    icon_url    varchar(256) default '' not null comment '图标地址',
    link_url    varchar(256) default '' not null comment '页面对应的前端地址',
    level       int          default 1  not null comment '层级',
    full_path   varchar(512) default '' not null comment '树id的路径 整个层次上的路径id，逗号分隔',
    status      int          default 1  not null comment '启用状态：0->禁用；1->启用',
    sort        int          default 0  not null comment '排序',
    delete_flag tinyint(1)   default 0  not null comment '1:已删除, 0:正常未删除',
    version     int          default 1  not null comment '版本信息',
    ctime       datetime                not null comment '创建时间',
    utime       datetime                not null comment '最后更新时间',
    cuid        bigint       default 0  not null comment '创建人ID',
    opuid       bigint       default 0  not null comment '更新人ID'
)
    comment '菜单表' row_format = DYNAMIC;

create table sys_role_info
(
    id          bigint auto_increment comment '主键ID'
  primary key,
    code        varchar(64) default '' not null comment '编码,用于处理特殊业务',
    name        varchar(64) default '' not null comment '角色名称',
    role_type   int         default 2  not null comment '0:超级管理员, 1: 管理员 2: 城市合伙人 3:普通用户',
    status      int         default 1  not null comment '启用状态：0->禁用；1->启用',
    sort        int         default 0  not null comment '排序',
    delete_flag tinyint(1)  default 0  not null comment '1:已删除, 0:正常未删除',
    version     int         default 1  not null comment '版本信息',
    ctime       datetime               not null comment '创建时间',
    utime       datetime               not null comment '最后更新时间',
    cuid        bigint      default 0  not null comment '创建人ID',
    opuid       bigint      default 0  not null comment '更新人ID',
    constraint uni_code
        unique (code, delete_flag)
)
    comment '角色表' row_format = DYNAMIC;

create table sys_role_menu_link
(
    id          bigint auto_increment comment '主键ID'
  primary key,
    role_id     bigint     default 0 not null comment '角色ID',
    menu_id     bigint     default 0 not null comment '菜单ID',
    delete_flag tinyint(1) default 0 not null comment '1:已删除, 0:正常未删除',
    version     int        default 1 not null comment '版本信息',
    ctime       datetime             not null comment '创建时间',
    utime       datetime             not null comment '最后更新时间',
    cuid        bigint     default 0 not null comment '创建人ID',
    opuid       bigint     default 0 not null comment '更新人ID'
)
    comment '角色菜单关联表' row_format = DYNAMIC;

create index idx_role
    on sys_role_menu_link (role_id, delete_flag);

create table sys_user_dept_link
(
    id          bigint auto_increment comment '主键ID'
  primary key,
    user_id     bigint     default 0 not null comment '用户ID',
    dept_id     bigint     default 0 not null comment '部门ID',
    delete_flag tinyint(1) default 0 not null comment '1:已删除, 0:正常未删除',
    version     int        default 1 not null comment '版本信息',
    ctime       datetime             not null comment '创建时间',
    utime       datetime             not null comment '最后更新时间',
    cuid        bigint     default 0 not null comment '创建人ID',
    opuid       bigint     default 0 not null comment '更新人ID'
)
    comment '用户部门关联表' row_format = DYNAMIC;

create index idx_dept
    on sys_user_dept_link (dept_id, delete_flag);

create index idx_user
    on sys_user_dept_link (user_id, delete_flag);

create table sys_user_role_link
(
    id          bigint auto_increment comment '主键ID'
  primary key,
    user_id     bigint     default 0 not null comment '用户ID',
    role_id     bigint     default 0 not null comment '角色ID',
    delete_flag tinyint(1) default 0 not null comment '1:已删除, 0:正常未删除',
    version     int        default 1 not null comment '版本信息',
    ctime       datetime             not null comment '创建时间',
    utime       datetime             not null comment '最后更新时间',
    cuid        bigint     default 0 not null comment '创建人ID',
    opuid       bigint     default 0 not null comment '更新人ID'
)
    comment '用户角色关联表' row_format = DYNAMIC;

create index idx_role
    on sys_user_role_link (role_id, delete_flag);

create index idx_user
    on sys_user_role_link (user_id, delete_flag);


