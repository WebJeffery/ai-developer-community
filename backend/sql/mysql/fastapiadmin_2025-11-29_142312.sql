-- MySQL dump 10.13  Distrib 8.4.3, for macos14.5 (arm64)
--
-- Host: 127.0.0.1    Database: fastapiadmin
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_ai_mcp`
--

DROP TABLE IF EXISTS `app_ai_mcp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_ai_mcp` (
  `name` varchar(50) NOT NULL COMMENT 'MCP 名称',
  `type` int NOT NULL COMMENT 'MCP 类型(0:stdio 1:sse)',
  `url` varchar(255) DEFAULT NULL COMMENT '远程 SSE 地址',
  `command` varchar(255) DEFAULT NULL COMMENT 'MCP 命令',
  `args` varchar(255) DEFAULT NULL COMMENT 'MCP 命令参数',
  `env` json DEFAULT NULL COMMENT 'MCP 环境变量',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_app_ai_mcp_tenant_id` (`tenant_id`),
  KEY `ix_app_ai_mcp_customer_id` (`customer_id`),
  KEY `ix_app_ai_mcp_created_id` (`created_id`),
  KEY `ix_app_ai_mcp_updated_id` (`updated_id`),
  CONSTRAINT `app_ai_mcp_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_ai_mcp_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_ai_mcp_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `app_ai_mcp_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MCP 服务器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_ai_mcp`
--

/*!40000 ALTER TABLE `app_ai_mcp` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_ai_mcp` ENABLE KEYS */;

--
-- Table structure for table `app_job`
--

DROP TABLE IF EXISTS `app_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_job` (
  `name` varchar(64) DEFAULT NULL COMMENT '任务名称',
  `jobstore` varchar(64) DEFAULT NULL COMMENT '存储器',
  `executor` varchar(64) DEFAULT NULL COMMENT '执行器:将运行此作业的执行程序的名称',
  `trigger` varchar(64) NOT NULL COMMENT '触发器:控制此作业计划的 trigger 对象',
  `trigger_args` text COMMENT '触发器参数',
  `func` text NOT NULL COMMENT '任务函数',
  `args` text COMMENT '位置参数',
  `kwargs` text COMMENT '关键字参数',
  `coalesce` tinyint(1) DEFAULT NULL COMMENT '是否合并运行:是否在多个运行时间到期时仅运行作业一次',
  `max_instances` int DEFAULT NULL COMMENT '最大实例数:允许的最大并发执行实例数',
  `start_date` varchar(64) DEFAULT NULL COMMENT '开始时间',
  `end_date` varchar(64) DEFAULT NULL COMMENT '结束时间',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_app_job_tenant_id` (`tenant_id`),
  KEY `ix_app_job_customer_id` (`customer_id`),
  KEY `ix_app_job_created_id` (`created_id`),
  KEY `ix_app_job_updated_id` (`updated_id`),
  CONSTRAINT `app_job_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_job_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_job_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `app_job_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_job`
--

/*!40000 ALTER TABLE `app_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_job` ENABLE KEYS */;

--
-- Table structure for table `app_job_log`
--

DROP TABLE IF EXISTS `app_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_job_log` (
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `job_executor` varchar(64) NOT NULL COMMENT '任务执行器',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_args` varchar(255) DEFAULT NULL COMMENT '位置参数',
  `job_kwargs` varchar(255) DEFAULT NULL COMMENT '关键字参数',
  `job_trigger` varchar(255) DEFAULT NULL COMMENT '任务触发器',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `exception_info` varchar(2000) DEFAULT NULL COMMENT '异常信息',
  `job_id` int DEFAULT NULL COMMENT '任务ID',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_app_job_log_tenant_id` (`tenant_id`),
  KEY `ix_app_job_log_job_id` (`job_id`),
  CONSTRAINT `app_job_log_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `app_job` (`id`) ON DELETE CASCADE,
  CONSTRAINT `app_job_log_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_job_log`
--

/*!40000 ALTER TABLE `app_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_job_log` ENABLE KEYS */;

--
-- Table structure for table `app_myapp`
--

DROP TABLE IF EXISTS `app_myapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_myapp` (
  `name` varchar(64) NOT NULL COMMENT '应用名称',
  `access_url` varchar(500) NOT NULL COMMENT '访问地址',
  `icon_url` varchar(300) DEFAULT NULL COMMENT '应用图标URL',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_app_myapp_customer_id` (`customer_id`),
  KEY `ix_app_myapp_tenant_id` (`tenant_id`),
  KEY `ix_app_myapp_updated_id` (`updated_id`),
  KEY `ix_app_myapp_created_id` (`created_id`),
  CONSTRAINT `app_myapp_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_myapp_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_myapp_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `app_myapp_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用系统表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_myapp`
--

/*!40000 ALTER TABLE `app_myapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_myapp` ENABLE KEYS */;

--
-- Table structure for table `apscheduler_jobs`
--

DROP TABLE IF EXISTS `apscheduler_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apscheduler_jobs` (
  `id` varchar(191) NOT NULL,
  `next_run_time` double DEFAULT NULL,
  `job_state` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_apscheduler_jobs_next_run_time` (`next_run_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apscheduler_jobs`
--

/*!40000 ALTER TABLE `apscheduler_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `apscheduler_jobs` ENABLE KEYS */;

--
-- Table structure for table `gen_demo`
--

DROP TABLE IF EXISTS `gen_demo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_demo` (
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_gen_demo_customer_id` (`customer_id`),
  KEY `ix_gen_demo_created_id` (`created_id`),
  KEY `ix_gen_demo_updated_id` (`updated_id`),
  KEY `ix_gen_demo_tenant_id` (`tenant_id`),
  CONSTRAINT `gen_demo_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_demo_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_demo_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gen_demo_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='示例表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_demo`
--

/*!40000 ALTER TABLE `gen_demo` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_demo` ENABLE KEYS */;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_name` varchar(200) NOT NULL COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT NULL COMMENT '表描述',
  `class_name` varchar(100) NOT NULL COMMENT '实体类名称',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(100) DEFAULT NULL COMMENT '生成功能名',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `parent_menu_id` int DEFAULT NULL COMMENT '父菜单ID',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_name` varchar(200) NOT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) NOT NULL COMMENT '列类型',
  `column_length` varchar(50) DEFAULT NULL COMMENT '列长度',
  `column_default` varchar(200) DEFAULT NULL COMMENT '列默认值',
  `is_pk` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否主键',
  `is_increment` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自增',
  `is_nullable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否允许为空',
  `is_unique` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否唯一',
  `python_type` varchar(100) DEFAULT NULL COMMENT 'Python类型',
  `python_field` varchar(200) DEFAULT NULL COMMENT 'Python字段名',
  `is_insert` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否为新增字段',
  `is_edit` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否编辑字段',
  `is_list` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否列表字段',
  `is_query` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否查询字段',
  `query_type` varchar(50) DEFAULT NULL COMMENT '查询方式',
  `html_type` varchar(100) DEFAULT NULL COMMENT '显示类型',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `sort` int NOT NULL COMMENT '排序',
  `table_id` int NOT NULL COMMENT '归属表编号',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_gen_table_column_table_id` (`table_id`),
  CONSTRAINT `gen_table_column_ibfk_1` FOREIGN KEY (`table_id`) REFERENCES `gen_table` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;

--
-- Table structure for table `sys_customer`
--

DROP TABLE IF EXISTS `sys_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_customer` (
  `name` varchar(64) NOT NULL COMMENT '客户名称',
  `code` varchar(20) NOT NULL COMMENT '客户编码',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_customer_updated_id` (`updated_id`),
  KEY `ix_sys_customer_code` (`code`),
  KEY `ix_sys_customer_tenant_id` (`tenant_id`),
  KEY `ix_sys_customer_created_id` (`created_id`),
  CONSTRAINT `sys_customer_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_customer_ibfk_2` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_customer_ibfk_3` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='客户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_customer`
--

/*!40000 ALTER TABLE `sys_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_customer` ENABLE KEYS */;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `name` varchar(40) NOT NULL COMMENT '部门名称',
  `order` int NOT NULL COMMENT '显示排序',
  `code` varchar(20) DEFAULT NULL COMMENT '部门编码',
  `leader` varchar(32) DEFAULT NULL COMMENT '部门负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `parent_id` int DEFAULT NULL COMMENT '父级部门ID',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_dept_parent_id` (`parent_id`),
  KEY `ix_sys_dept_tenant_id` (`tenant_id`),
  KEY `ix_sys_dept_code` (`code`),
  CONSTRAINT `sys_dept_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `sys_dept` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_dept_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES ('集团总公司',1,'GROUP','部门负责人','1582112620','deptadmin@example.com',NULL,1,'0de7119f-b7ea-4d1f-9331-ee3893c577f9','0','集团总公司','2025-11-29 14:22:57','2025-11-29 14:22:57',1);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_sort` int NOT NULL COMMENT '字典排序',
  `dict_label` varchar(255) NOT NULL COMMENT '字典标签',
  `dict_value` varchar(255) NOT NULL COMMENT '字典键值',
  `css_class` varchar(255) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(255) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认（True是 False否）',
  `dict_type` varchar(255) NOT NULL COMMENT '字典类型',
  `dict_type_id` int NOT NULL COMMENT '字典类型ID',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `dict_type_id` (`dict_type_id`),
  CONSTRAINT `sys_dict_data_ibfk_1` FOREIGN KEY (`dict_type_id`) REFERENCES `sys_dict_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,'男','0','blue',NULL,1,'sys_user_sex',1,1,'d28813ff-0061-4fe6-8c56-0421255ec92f','0','性别男','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'女','1','pink',NULL,0,'sys_user_sex',1,2,'10d6c517-bba7-4031-bbf8-b291c8913da4','0','性别女','2025-11-29 14:22:57','2025-11-29 14:22:57'),(3,'未知','2','red',NULL,0,'sys_user_sex',1,3,'ccba3cdf-ca86-461a-8a84-3823ec423d35','0','性别未知','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'是','1','','primary',1,'sys_yes_no',2,4,'454dd8b1-0522-4eac-ba36-32a91cfa7a81','0','是','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'否','0','','danger',0,'sys_yes_no',2,5,'c4c0c85c-5649-4f5b-b36c-527fe4c147dd','0','否','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'启用','1','','primary',0,'sys_common_status',3,6,'0ca3f4e8-d0b5-45d2-9753-d49de5dcfbf4','0','启用状态','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'停用','0','','danger',0,'sys_common_status',3,7,'005db216-154f-480c-913a-1b1916f050db','0','停用状态','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'通知','1','blue','warning',1,'sys_notice_type',4,8,'c386f6b9-35da-4072-ba1a-57e6e6265261','0','通知','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'公告','2','orange','success',0,'sys_notice_type',4,9,'60dc1426-95ab-46df-b4cf-06d87c1b95f5','0','公告','2025-11-29 14:22:57','2025-11-29 14:22:57'),(99,'其他','0','','info',0,'sys_oper_type',5,10,'d456d193-440a-41a1-9e58-edf2f39340d5','0','其他操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'新增','1','','info',0,'sys_oper_type',5,11,'06227a10-6eea-4dfb-8e0e-ec1e30f55e02','0','新增操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'修改','2','','info',0,'sys_oper_type',5,12,'f597edad-2868-4042-843c-f1486b720952','0','修改操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(3,'删除','3','','danger',0,'sys_oper_type',5,13,'5fa32e55-d97d-4f02-ac72-755cd8d6f879','0','删除操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(4,'分配权限','4','','primary',0,'sys_oper_type',5,14,'21faa4fc-932e-414f-a360-173ed9903bf2','0','授权操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(5,'导出','5','','warning',0,'sys_oper_type',5,15,'a5f09dc6-8a80-4404-8e79-5bdf1436b5be','0','导出操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(6,'导入','6','','warning',0,'sys_oper_type',5,16,'97b67c8b-4667-4d26-8988-5c4ba896e9c2','0','导入操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(7,'强退','7','','danger',0,'sys_oper_type',5,17,'2f3e6bea-ee85-41de-84a6-69197ded8b41','0','强退操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(8,'生成代码','8','','warning',0,'sys_oper_type',5,18,'cc38c812-8683-49a0-a8d6-a6ead9833597','0','生成操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(9,'清空数据','9','','danger',0,'sys_oper_type',5,19,'59aa0c03-ea53-4ba6-9ec3-adb556628f64','0','清空操作','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'默认(Memory)','default','',NULL,1,'sys_job_store',6,20,'fec28128-2d3d-43cf-b772-a3d239cdd184','0','默认分组','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'数据库(Sqlalchemy)','sqlalchemy','',NULL,0,'sys_job_store',6,21,'4c25fa7e-1a58-422a-af3d-a3abc90ec298','0','数据库分组','2025-11-29 14:22:57','2025-11-29 14:22:57'),(3,'数据库(Redis)','redis','',NULL,0,'sys_job_store',6,22,'d4e0fb02-f59b-4f55-aba7-c9e4695fbb8d','0','reids分组','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'线程池','default','',NULL,0,'sys_job_executor',7,23,'b4ce3923-9407-4d40-a830-3d435374a068','0','线程池','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'进程池','processpool','',NULL,0,'sys_job_executor',7,24,'a00f1f1d-1a81-4a88-a13e-8e3f1a6bd8d8','0','进程池','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'演示函数','scheduler_test.job','',NULL,1,'sys_job_function',8,25,'2b0ff9ec-4e9d-4470-ad84-8211ef47b3c2','0','演示函数','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'指定日期(date)','date','',NULL,1,'sys_job_trigger',9,26,'dfc48192-b4de-42d4-9942-1f4751a646c2','0','指定日期任务触发器','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'间隔触发器(interval)','interval','',NULL,0,'sys_job_trigger',9,27,'338b5258-e4df-4923-8e34-8d216ff153a3','0','间隔触发器任务触发器','2025-11-29 14:22:57','2025-11-29 14:22:57'),(3,'cron表达式','cron','',NULL,0,'sys_job_trigger',9,28,'4679b9ec-76fd-480f-aa8f-23c1791d9eb2','0','间隔触发器任务触发器','2025-11-29 14:22:57','2025-11-29 14:22:57'),(1,'默认(default)','default','',NULL,1,'sys_list_class',10,29,'886a2cab-7a93-45db-9eea-13e525530222','0','默认表格回显样式','2025-11-29 14:22:57','2025-11-29 14:22:57'),(2,'主要(primary)','primary','',NULL,0,'sys_list_class',10,30,'17fa756e-b561-49c1-afc5-d6852382d4b7','0','主要表格回显样式','2025-11-29 14:22:57','2025-11-29 14:22:57'),(3,'成功(success)','success','',NULL,0,'sys_list_class',10,31,'e6d8a103-236a-4fe8-b8b9-3c5444e71159','0','成功表格回显样式','2025-11-29 14:22:57','2025-11-29 14:22:57'),(4,'信息(info)','info','',NULL,0,'sys_list_class',10,32,'13997491-854d-4e6e-b8a1-edd74f25a404','0','信息表格回显样式','2025-11-29 14:22:57','2025-11-29 14:22:57'),(5,'警告(warning)','warning','',NULL,0,'sys_list_class',10,33,'63b15da5-cade-4b77-bfef-642db271125f','0','警告表格回显样式','2025-11-29 14:22:57','2025-11-29 14:22:57'),(6,'危险(danger)','danger','',NULL,0,'sys_list_class',10,34,'f551d922-dedb-4f0d-8a03-a4a07b59ff4a','0','危险表格回显样式','2025-11-29 14:22:57','2025-11-29 14:22:57');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_name` varchar(255) NOT NULL COMMENT '字典名称',
  `dict_type` varchar(255) NOT NULL COMMENT '字典类型',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dict_type` (`dict_type`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES ('用户性别','sys_user_sex',1,'e0d15aa3-d1de-4cff-ae20-6e36748f66d3','0','用户性别列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('系统是否','sys_yes_no',2,'d8a98556-25ef-498a-a9aa-231ea4274611','0','系统是否列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('系统状态','sys_common_status',3,'d7831abb-a7db-46d6-b3df-98f5a6d1d7fc','0','系统状态','2025-11-29 14:22:57','2025-11-29 14:22:57'),('通知类型','sys_notice_type',4,'035e918d-102d-4d7b-acc9-906e5be1cd80','0','通知类型列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('操作类型','sys_oper_type',5,'9c4a63fc-0e50-43a6-9510-d629e47947fa','0','操作类型列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('任务存储器','sys_job_store',6,'422e9184-3958-4910-972f-d0bb10c96858','0','任务分组列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('任务执行器','sys_job_executor',7,'961dd724-bb43-4350-ba28-c380922278c7','0','任务执行器列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('任务函数','sys_job_function',8,'9a3f12c1-ba47-4bf6-9155-36a1d1c3836f','0','任务函数列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('任务触发器','sys_job_trigger',9,'89df7943-da4f-45e7-a99c-a8305732ce0b','0','任务触发器列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('表格回显样式','sys_list_class',10,'f5dfe92a-967c-4438-ae55-79ece57ace1e','0','表格回显样式列表','2025-11-29 14:22:57','2025-11-29 14:22:57');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_log` (
  `type` int NOT NULL COMMENT '日志类型(1登录日志 2操作日志)',
  `request_path` varchar(255) NOT NULL COMMENT '请求路径',
  `request_method` varchar(10) NOT NULL COMMENT '请求方式',
  `request_payload` text COMMENT '请求体',
  `request_ip` varchar(50) DEFAULT NULL COMMENT '请求IP地址',
  `login_location` varchar(255) DEFAULT NULL COMMENT '登录位置',
  `request_os` varchar(64) DEFAULT NULL COMMENT '操作系统',
  `request_browser` varchar(64) DEFAULT NULL COMMENT '浏览器',
  `response_code` int NOT NULL COMMENT '响应状态码',
  `response_json` text COMMENT '响应体',
  `process_time` varchar(20) DEFAULT NULL COMMENT '处理时间',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_log_customer_id` (`customer_id`),
  KEY `ix_sys_log_tenant_id` (`tenant_id`),
  KEY `ix_sys_log_updated_id` (`updated_id`),
  KEY `ix_sys_log_created_id` (`created_id`),
  CONSTRAINT `sys_log_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_log_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_log_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_log_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `type` int NOT NULL COMMENT '菜单类型(1:目录 2:菜单 3:按钮/权限 4:链接)',
  `order` int NOT NULL COMMENT '显示排序',
  `permission` varchar(100) DEFAULT NULL COMMENT '权限标识(如:module_system:user:list)',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `route_name` varchar(100) DEFAULT NULL COMMENT '路由名称',
  `route_path` varchar(200) DEFAULT NULL COMMENT '路由路径',
  `component_path` varchar(200) DEFAULT NULL COMMENT '组件路径',
  `redirect` varchar(200) DEFAULT NULL COMMENT '重定向地址',
  `hidden` tinyint(1) NOT NULL COMMENT '是否隐藏(True:隐藏 False:显示)',
  `keep_alive` tinyint(1) NOT NULL COMMENT '是否缓存(True:是 False:否)',
  `always_show` tinyint(1) NOT NULL COMMENT '是否始终显示(True:是 False:否)',
  `title` varchar(50) DEFAULT NULL COMMENT '菜单标题',
  `params` json DEFAULT NULL COMMENT '路由参数(JSON对象)',
  `affix` tinyint(1) NOT NULL COMMENT '是否固定标签页(True:是 False:否)',
  `parent_id` int DEFAULT NULL COMMENT '父菜单ID',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_menu_parent_id` (`parent_id`),
  CONSTRAINT `sys_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `sys_menu` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES ('仪表盘',1,1,'','client','Dashboard','/dashboard',NULL,'/dashboard/workplace',0,1,1,'仪表盘','null',0,NULL,1,'52bee14d-c12c-47a4-a7aa-29467f0bb31f','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('系统管理',1,2,NULL,'system','System','/system',NULL,'/system/menu',0,1,0,'系统管理','null',0,NULL,2,'fe06901f-c19c-436b-90ee-870bbc8b707d','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('应用管理',1,3,NULL,'el-icon-ShoppingBag','Application','/application',NULL,'/application/myapp',0,0,0,'应用管理','null',0,NULL,3,'b8da2227-ecdc-4608-99ce-cc4efc414199','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('监控管理',1,4,NULL,'monitor','Monitor','/monitor',NULL,'/monitor/online',0,0,0,'监控管理','null',0,NULL,4,'7a9fd33f-099a-4016-b133-d19d0c825925','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('代码管理',1,5,NULL,'code','Gencode','/gencode',NULL,'/gencode/backcode',0,0,0,'代码管理','null',0,NULL,5,'ea1bab65-4bbc-4030-b347-aacaf020d8bf','0','代码管理','2025-11-29 14:22:57','2025-11-29 14:22:57'),('接口管理',1,6,NULL,'document','Common','/common',NULL,'/common/docs',0,0,0,'接口管理','null',0,NULL,6,'94e28cb7-446a-4808-ac6b-8d9e056dc46a','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('案例管理',1,7,NULL,'el-icon-ElementPlus','Example','/example',NULL,'/example/demo',0,0,0,'案例管理','null',0,NULL,7,'e2315e80-4ca5-4420-a48b-9ee3f0e1af9c','0','案例管理','2025-11-29 14:22:57','2025-11-29 14:22:57'),('工作台',2,1,'dashboard:workplace:query','el-icon-PieChart','Workplace','/dashboard/workplace','dashboard/workplace',NULL,0,1,0,'工作台','null',0,1,8,'c4337e0d-3fd0-4cb5-956e-8f3ffb0d9bfe','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('菜单管理',2,1,'module_system:menu:query','menu','Menu','/system/menu','module_system/menu/index',NULL,0,1,0,'菜单管理','null',0,2,9,'ee87f484-46eb-492f-abc2-b2b75ab19ef0','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('部门管理',2,2,'module_system:dept:query','tree','Dept','/system/dept','module_system/dept/index',NULL,0,1,0,'部门管理','null',0,2,10,'9799b763-d03d-465c-b332-6f0ad67e92c1','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('租户管理',2,3,'module_system:tenant:query','el-icon-Avatar','Tenant','/system/tenant','module_system/tenant/index',NULL,0,1,0,'租户管理','null',0,2,11,'69b7b1a5-7b21-4622-9f6f-56c05f12a239','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('客户管理',2,3,'module_system:customer:query','el-icon-Avatar','Customer','/system/customer','module_system/customer/index',NULL,0,1,0,'客户管理','null',0,2,12,'529cc54c-c576-418e-b301-26cb6ce22669','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('岗位管理',2,3,'module_system:position:query','el-icon-Coordinate','Position','/system/position','module_system/position/index',NULL,0,1,0,'岗位管理','null',0,2,13,'8eeea8e3-9101-46ea-a8a5-9fa7fa442487','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('角色管理',2,4,'module_system:role:query','role','Role','/system/role','module_system/role/index',NULL,0,1,0,'角色管理','null',0,2,14,'62bf22cb-b587-4710-a3d4-0a80fc1e1d9b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('用户管理',2,5,'module_system:user:query','el-icon-User','User','/system/user','module_system/user/index',NULL,0,1,0,'用户管理','null',0,2,15,'364eed06-e5d9-4a8b-9471-39928f308e2e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('日志管理',2,6,'module_system:log:query','el-icon-Aim','Log','/system/log','module_system/log/index',NULL,0,1,0,'日志管理','null',0,2,16,'484b3f65-e217-49a0-ad81-37f9c77f27dd','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('公告管理',2,7,'module_system:notice:query','bell','Notice','/system/notice','module_system/notice/index',NULL,0,1,0,'公告管理','null',0,2,17,'89037624-91e8-46dc-a173-ae02e4e6c5e8','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('参数管理',2,8,'module_system:param:query','setting','Params','/system/param','module_system/param/index',NULL,0,1,0,'参数管理','null',0,2,18,'e81f0f1f-f6b8-4242-af36-e20d42c42eb2','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('字典管理',2,9,'module_system:dict_type:query','dict','Dict','/system/dict','module_system/dict/index',NULL,0,1,0,'字典管理','null',0,2,19,'78a41e5b-4dd4-4a5e-80f4-6c46df072862','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('我的应用',2,1,'module_application:myapp:query','el-icon-ShoppingCartFull','MYAPP','/application/myapp','module_application/myapp/index',NULL,0,1,0,'我的应用','null',0,3,20,'d8d2d746-6755-4afc-8b32-4b4c4dbb8361','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('任务管理',2,2,'module_application:job:query','el-icon-DataLine','Job','/application/job','module_application/job/index',NULL,0,1,0,'任务管理','null',0,3,21,'7cd0f94c-fb95-476d-be73-89fa5cdb7be1','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('AI智能助手',2,3,'module_application:ai:chat','el-icon-ToiletPaper','AI','/application/ai','module_application/ai/index',NULL,0,1,0,'AI智能助手','null',0,3,22,'01637027-fd20-4ff3-aa2b-52431b552261','0','AI智能助手','2025-11-29 14:22:57','2025-11-29 14:22:57'),('流程管理',2,4,'module_application:workflow:query','el-icon-ShoppingBag','Workflow','/application/workflow','module_application/workflow/index',NULL,0,1,0,'我的流程','null',0,3,23,'85a7bf8b-f167-4068-a144-99356157ca98','0','我的流程','2025-11-29 14:22:57','2025-11-29 14:22:57'),('在线用户',2,1,'module_monitor:online:query','el-icon-Headset','MonitorOnline','/monitor/online','module_monitor/online/index',NULL,0,0,0,'在线用户','null',0,4,24,'a8da73ba-0e9a-481e-86de-3ffde76a40d7','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('服务器监控',2,2,'module_monitor:server:query','el-icon-Odometer','MonitorServer','/monitor/server','module_monitor/server/index',NULL,0,0,0,'服务器监控','null',0,4,25,'2c291d97-66b5-49f3-84e7-740ddea51f7e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('缓存监控',2,3,'module_monitor:cache:query','el-icon-Stopwatch','MonitorCache','/monitor/cache','module_monitor/cache/index',NULL,0,0,0,'缓存监控','null',0,4,26,'a244f214-0450-49ea-b769-5e464adba7a8','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件管理',2,4,'module_monitor:resource:query','el-icon-Files','Resource','/monitor/resource','module_monitor/resource/index',NULL,0,1,0,'文件管理','null',0,4,27,'f3b48295-82dc-47b4-92fc-d0bf9c5bd8b4','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('代码生成',2,1,'module_generator:gencode:query','code','Backcode','/gencode/backcode','module_generator/backcode/index',NULL,0,1,0,'代码生成','null',0,5,28,'3190f6f8-2c7d-4444-bd39-d34b10c68d74','0','代码生成','2025-11-29 14:22:57','2025-11-29 14:22:57'),('Swagger文档',4,1,'module_common:docs:query','api','Docs','/common/docs','module_common/docs/index',NULL,0,0,0,'Swagger文档','null',0,6,29,'68e9ece5-719f-439a-9059-b33c82d7fb9c','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('Redoc文档',4,2,'module_common:redoc:query','el-icon-Document','Redoc','/common/redoc','module_common/redoc/index',NULL,0,0,0,'Redoc文档','null',0,6,30,'64ceb6b2-5cab-4030-8720-40cb89cf752e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('示例管理',2,1,'module_example:demo:query','el-icon-ElementPlus','Demo','/example/demo','module_example/demo/index',NULL,0,1,0,'示例管理','null',0,7,31,'aa7fffe6-89a1-4baf-a1f3-9ddbf7a9eb30','0','示例管理','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建菜单',3,1,'module_system:menu:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建菜单','null',0,9,32,'b9135a88-5323-4d04-810f-4ababbd4f0c5','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改菜单',3,2,'module_system:menu:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改菜单','null',0,9,33,'360d3539-f213-4ffd-b24d-8c0289b77191','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除菜单',3,3,'module_system:menu:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除菜单','null',0,9,34,'228fda70-8c29-4eec-ab1d-7d51912fc649','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改菜单状态',3,4,'module_system:menu:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改菜单状态','null',0,9,35,'e15f8e83-056f-46ef-a70a-a9157f70d79a','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建部门',3,1,'module_system:dept:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建部门','null',0,10,36,'81416bc8-8c2f-41d7-9b8f-e0793b891b63','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改部门',3,2,'module_system:dept:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改部门','null',0,10,37,'26ca0b6e-cdbb-47cb-8018-7db6a3201e38','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除部门',3,3,'module_system:dept:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除部门','null',0,10,38,'0526bfca-528c-42d5-8a72-762feb5e3a6b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改部门状态',3,4,'module_system:dept:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改部门状态','null',0,10,39,'784d9c33-94c0-4842-b1c4-0f2658234b76','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建租户',3,1,'module_system:tenant:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建租户','null',0,11,40,'d7ad507d-9864-4f50-80be-107f324258bb','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('更新租户',3,2,'module_system:tenant:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新租户','null',0,11,41,'f9244339-a2dc-4106-81a0-47116ab3034e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除租户',3,3,'module_system:tenant:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除租户','null',0,11,42,'2eaeea28-286b-4c04-ae39-f01cd3d8b1be','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改租户状态',3,4,'module_system:tenant:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改租户状态','null',0,11,43,'bd36ddd0-2da3-48d1-b445-777618138c56','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出租户',3,5,'module_system:tenant:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出租户','null',0,11,44,'b30e7a94-4b09-4ee6-84a1-10254e77a36c','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导入租户',3,6,'module_system:tenant:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入租户','null',0,11,45,'d061f69a-d3db-419f-ad70-0d55bfe207ae','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('下载导入租户模版',3,7,'module_system:tenant:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入租户模版','null',0,11,46,'73a3310c-b9aa-4131-8b43-a6459bc7f10b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建客户',3,1,'module_system:customer:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建客户','null',0,12,47,'8849d9c7-bbb8-44a6-9369-dde7a37d5a84','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('更新客户',3,2,'module_system:customer:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新客户','null',0,12,48,'fcb3db0c-9dfc-49a5-a99f-b059f0d8749b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除客户',3,3,'module_system:customer:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除客户','null',0,12,49,'18d2ff4e-d233-4dad-ab4f-837640df7369','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改客户状态',3,4,'module_system:customer:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改客户状态','null',0,12,50,'5e3e1bfa-bb97-4ba2-acf1-25876333f78f','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出客户',3,5,'module_system:customer:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出客户','null',0,12,51,'05c6b71e-9990-47b1-aa88-a09c8c7d2e00','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导入客户',3,6,'module_system:customer:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入客户','null',0,12,52,'e78ef9b9-5b3d-4f87-99aa-73e8ece3c9f1','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('下载导入客户模版',3,7,'module_system:customer:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入客户模版','null',0,12,53,'42052351-e102-42b4-b78f-9a89c45f4118','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建岗位',3,1,'module_system:position:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建岗位','null',0,13,54,'07df3acb-b133-4e23-a84a-0a10fcede52c','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改岗位',3,2,'module_system:position:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改岗位','null',0,13,55,'ee9e6df3-19f7-4c07-991b-967ce2d80356','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除岗位',3,3,'module_system:position:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改岗位','null',0,13,56,'ac2a08f8-4e87-4faf-a49b-f60e69613030','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改岗位状态',3,4,'module_system:position:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改岗位状态','null',0,13,57,'af49f2e2-54d3-4db2-8568-8440aacfdd82','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('岗位导出',3,5,'module_system:position:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'岗位导出','null',0,13,58,'5fa4dc60-e09a-45d6-a0f1-92a0252f029f','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('设置角色权限',3,8,'module_system:role:permission',NULL,NULL,NULL,NULL,NULL,0,1,0,'设置角色权限','null',0,13,59,'a6ca3ab4-8f39-499c-bd14-10aaa17c3d5b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建角色',3,1,'module_system:role:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建角色','null',0,14,60,'e841abee-ade7-4977-84c5-b69139563b6e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改角色',3,2,'module_system:role:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改角色','null',0,14,61,'3f2a2b7d-62db-4ff5-816a-458492f4fdbb','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除角色',3,3,'module_system:role:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除角色','null',0,14,62,'1659b9cb-a6e2-4cba-b826-b0bb565fd25d','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改角色状态',3,4,'module_system:role:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改角色状态','null',0,14,63,'dcd57c8f-2bb1-410b-bc3e-70a50a72d4df','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('角色导出',3,6,'module_system:role:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'角色导出','null',0,14,64,'9bb94df1-0553-4e2f-a206-4df571fdfc8e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建用户',3,1,'module_system:user:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建用户','null',0,15,65,'cce2e771-e41a-4b78-8df1-04991bd9a9d1','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改用户',3,2,'module_system:user:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改用户','null',0,15,66,'3c46e0c0-66fb-4b11-9213-59ba1491a5d6','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除用户',3,3,'module_system:user:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除用户','null',0,15,67,'6c51ca1a-5508-4773-befd-e85d80812e67','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改用户状态',3,4,'module_system:user:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改用户状态','null',0,15,68,'dafdebfb-324b-4077-9097-f8f0311e474a','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出用户',3,5,'module_system:user:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出用户','null',0,15,69,'159699b4-a1bc-4494-8a8f-8015b9b42173','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导入用户',3,6,'module_system:user:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入用户','null',0,15,70,'c54c1fe8-a40b-4802-b751-157253e005be','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('日志删除',3,1,'module_system:log:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'日志删除','null',0,16,71,'94d54b94-8e5f-4058-8930-57e5b827a3ed','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('日志导出',3,2,'module_system:log:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'日志导出','null',0,16,72,'bdbc6679-1634-43e0-8d44-978c55729a55','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('公告创建',3,1,'module_system:notice:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告创建','null',0,17,73,'05d1968d-e3ab-4155-a6e0-9e5fad5cac8d','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('公告修改',3,2,'module_system:notice:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改用户','null',0,17,74,'7b064fa8-f46e-4e11-946d-f015d9312631','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('公告删除',3,3,'module_system:notice:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告删除','null',0,17,75,'be3761cf-4a1b-452a-8a50-dfc4291855a7','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('公告导出',3,4,'module_system:notice:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告导出','null',0,17,76,'03192342-0cfd-48e6-9d3c-60b8c16c8b39','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('公告批量修改状态',3,5,'module_system:notice:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告批量修改状态','null',0,17,77,'e03f3aab-0448-41e0-8091-1703d05f365b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建参数',3,1,'module_system:param:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建参数','null',0,18,78,'0863a7a4-32d0-40f9-b40c-067d86deb4a7','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改参数',3,2,'module_system:param:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改参数','null',0,18,79,'940e638f-443d-4701-abbd-b701c9a52152','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除参数',3,3,'module_system:param:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除参数','null',0,18,80,'70fabed6-d669-4bf2-98de-09551b4f956a','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出参数',3,4,'module_system:param:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出参数','null',0,18,81,'201dff9d-5749-40b0-968c-f7826c1a3eca','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('参数上传',3,5,'module_system:param:upload',NULL,NULL,NULL,NULL,NULL,0,1,0,'参数上传','null',0,18,82,'819cf97e-a305-49d2-a5db-98158c3ea94c','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建字典类型',3,1,'module_system:dict_type:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建字典类型','null',0,19,83,'01c5ba1f-a084-4a99-bc39-597d3caaa650','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改字典类型',3,2,'module_system:dict_type:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改字典类型','null',0,19,84,'233b2624-f8b7-4653-9ede-3d2fa4799baf','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除字典类型',3,3,'module_system:dict_type:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除字典类型','null',0,19,85,'7b76dda5-ebc6-45b0-803b-79b7ca61a814','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出字典类型',3,4,'module_system:dict_type:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典类型','null',0,19,86,'fd506189-52f9-4684-bb29-63e3ed6525af','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改字典状态',3,5,'module_system:dict_type:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典类型','null',0,19,87,'4709e179-1203-440e-896b-c12afe57a9aa','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('字典数据查询',3,6,'module_system:dict_data:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'字典数据查询','null',0,19,88,'3a7179bb-5e41-4140-a86e-34d1dfdd899a','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建字典数据',3,7,'module_system:dict_data:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建字典数据','null',0,19,89,'190652d0-ede2-4ea3-8294-c1a860c878d5','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改字典数据',3,8,'module_system:dict_data:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改字典数据','null',0,19,90,'4f499ab4-87ab-4e24-b922-3ba911541898','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除字典数据',3,9,'module_system:dict_data:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除字典数据','null',0,19,91,'a206eb8a-8eec-48ef-99c4-ef4a797aff56','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出字典数据',3,10,'module_system:dict_data:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典数据','null',0,19,92,'4041bff8-3aa1-4bfb-9c04-c35c77ba9ead','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改字典数据状态',3,11,'module_system:dict_data:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改字典数据状态','null',0,19,93,'dd12ca7e-a517-4cce-b9c5-526140aadab6','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建应用',3,1,'module_application:myapp:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建应用','null',0,20,94,'e9e99d58-6659-4f73-b1c8-604956450037','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改应用',3,2,'module_application:myapp:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改应用','null',0,20,95,'150f613b-b531-487e-a444-87682d65c317','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除应用',3,3,'module_application:myapp:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除应用','null',0,20,96,'b68c96c3-b6fd-43e6-a243-78a26aedf0d9','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改应用状态',3,4,'module_application:myapp:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改应用状态','null',0,20,97,'f5572189-03f4-4952-9f38-ec3fbcb79e51','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建任务',3,1,'module_application:job:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建任务','null',0,21,98,'822a1062-3dfb-40f1-b6b4-8f9cb0369dfe','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('修改和操作任务',3,2,'module_application:job:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改和操作任务','null',0,21,99,'fd9c35a8-8d59-4769-948d-4894cbbdd48d','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除和清除任务',3,3,'module_application:job:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除和清除任务','null',0,21,100,'463b381e-81e5-4126-a218-f57611199938','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出定时任务',3,4,'module_application:job:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出定时任务','null',0,21,101,'e034c007-c1c4-48c5-aa33-b69206e4b24f','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('智能对话',3,1,'module_application:ai:chat',NULL,NULL,NULL,NULL,NULL,0,1,0,'智能对话','null',0,22,102,'4d6b25b4-7860-4fa2-b5f6-1934a414693c','0','智能对话','2025-11-29 14:22:57','2025-11-29 14:22:57'),('在线用户强制下线',3,1,'module_monitor:online:delete',NULL,NULL,NULL,NULL,NULL,0,0,0,'在线用户强制下线','null',0,24,103,'c545e044-0741-4bf3-8018-f86e9b223bcf','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('清除缓存',3,1,'module_monitor:cache:delete',NULL,NULL,NULL,NULL,NULL,0,0,0,'清除缓存','null',0,26,104,'b20270b0-e89d-45c9-b453-3f6e98bda0cd','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件上传',3,1,'module_monitor:resource:upload',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件上传','null',0,27,105,'dc4c81cc-0966-421e-a994-9c975b8944bc','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件下载',3,2,'module_monitor:resource:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件下载','null',0,27,106,'e22c08f0-6218-4ea9-bd0c-fcd09f541fc5','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件删除',3,3,'module_monitor:resource:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件删除','null',0,27,107,'165d233f-a66f-41f9-b6ba-02f7883500b8','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件移动',3,4,'module_monitor:resource:move',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件移动','null',0,27,108,'ca69c004-8033-4bb2-8e92-56e67af0c009','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件复制',3,5,'module_monitor:resource:copy',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件复制','null',0,27,109,'0c520223-ae3b-4fba-960d-f1f087256574','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('文件重命名',3,6,'module_monitor:resource:rename',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件重命名','null',0,27,110,'ef1f43a6-5a69-48fc-bbca-526332b8d6f5','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建目录',3,7,'module_monitor:resource:create_dir',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建目录','null',0,27,111,'f89e8160-8b94-49c2-988e-2f0ada2ade3d','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出文件列表',3,9,'module_monitor:resource:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出文件列表','null',0,27,112,'2525c83a-0ef3-409c-aa6b-262c904e8ea1','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('查询代码生成业务表列表',3,1,'module_generator:gencode:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'查询代码生成业务表列表','null',0,28,113,'760e7dee-3ca4-4f02-a8ad-8402a086eaf5','0','查询代码生成业务表列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建表结构',3,2,'module_generator:gencode:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建表结构','null',0,28,114,'289f1509-c255-4d0f-957b-30d3320f3077','0','创建表结构','2025-11-29 14:22:57','2025-11-29 14:22:57'),('编辑业务表信息',3,3,'module_generator:gencode:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'编辑业务表信息','null',0,28,115,'a0af6cc9-ef7b-4a24-9078-99deb00034df','0','编辑业务表信息','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除业务表信息',3,4,'module_generator:gencode:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除业务表信息','null',0,28,116,'c711f269-f592-435a-a74b-1247ff2db404','0','删除业务表信息','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导入表结构',3,5,'module_generator:gencode:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入表结构','null',0,28,117,'33945bc5-a2ee-45b6-a36c-49b85eee7487','0','导入表结构','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量生成代码',3,6,'module_generator:gencode:operate',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量生成代码','null',0,28,118,'4d1839d6-51b1-44fb-ba66-7c1b887e6899','0','批量生成代码','2025-11-29 14:22:57','2025-11-29 14:22:57'),('生成代码到指定路径',3,7,'module_generator:gencode:code',NULL,NULL,NULL,NULL,NULL,0,1,0,'生成代码到指定路径','null',0,28,119,'0dda0065-871a-4d5d-b73f-be4598b889c1','0','生成代码到指定路径','2025-11-29 14:22:57','2025-11-29 14:22:57'),('查询数据库表列表',3,8,'module_generator:dblist:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'查询数据库表列表','null',0,28,120,'bc3a6032-60bf-4de1-b166-4bf4c3e8229a','0','查询数据库表列表','2025-11-29 14:22:57','2025-11-29 14:22:57'),('同步数据库',3,9,'module_generator:db:sync',NULL,NULL,NULL,NULL,NULL,0,1,0,'同步数据库','null',0,28,121,'0621e9ed-f781-4f89-83e1-30ecba5e790e','0','同步数据库','2025-11-29 14:22:57','2025-11-29 14:22:57'),('创建示例',3,1,'module_example:demo:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建示例','null',0,31,122,'5b8405f7-09b3-45ea-a78e-69e489601aff','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('更新示例',3,2,'module_example:demo:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新示例','null',0,31,123,'29d19c9d-e09d-4957-8882-65c040b2cdee','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('删除示例',3,3,'module_example:demo:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除示例','null',0,31,124,'9db77833-08f4-41d9-8422-cdf95bd78aa9','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('批量修改示例状态',3,4,'module_example:demo:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改示例状态','null',0,31,125,'ca696354-1c79-4e44-8ea0-4012c5a2a018','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导出示例',3,5,'module_example:demo:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出示例','null',0,31,126,'56d927fa-ff0b-43b4-b3a2-c875228c41a6','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('导入示例',3,6,'module_example:demo:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入示例','null',0,31,127,'34be3df8-49a9-4621-81a2-c9e3e2aeb59c','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('下载导入示例模版',3,7,'module_example:demo:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入示例模版','null',0,31,128,'264df0fe-1bb0-4ffe-aa9a-7ba0d4591807','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` varchar(50) NOT NULL COMMENT '公告类型(1通知 2公告)',
  `notice_content` text COMMENT '公告内容',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_notice_created_id` (`created_id`),
  KEY `ix_sys_notice_customer_id` (`customer_id`),
  KEY `ix_sys_notice_tenant_id` (`tenant_id`),
  KEY `ix_sys_notice_updated_id` (`updated_id`),
  CONSTRAINT `sys_notice_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_notice_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_notice_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_notice_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;

--
-- Table structure for table `sys_param`
--

DROP TABLE IF EXISTS `sys_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_param` (
  `config_name` varchar(500) NOT NULL COMMENT '参数名称',
  `config_key` varchar(500) NOT NULL COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT NULL COMMENT '参数键值',
  `config_type` tinyint(1) DEFAULT NULL COMMENT '系统内置(True:是 False:否)',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_param`
--

/*!40000 ALTER TABLE `sys_param` DISABLE KEYS */;
INSERT INTO `sys_param` VALUES ('网站名称','sys_web_title','FastApiAdmin',1,1,'3f11d81d-5a09-47d8-8ae5-f5d00b83852b','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('网站描述','sys_web_description','FastApiAdmin 是完全开源的权限管理系统',1,2,'17d4c3ad-8cb2-4512-a893-41f856085985','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('网页图标','sys_web_favicon','https://service.fastapiadmin.com/api/v1/static/image/favicon.png',1,3,'922929ef-0c75-4862-a002-97f8fdb210f6','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('网站Logo','sys_web_logo','https://service.fastapiadmin.com/api/v1/static/image/logo.png',1,4,'25b39dde-8f58-49af-a0b4-0d9e90f7edb7','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('登录背景','sys_login_background','https://service.fastapiadmin.com/api/v1/static/image/background.svg',1,5,'bb68438c-9731-45c8-8409-a0f9e2daac9e','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('版权信息','sys_web_copyright','Copyright © 2025-2026 service.fastapiadmin.com 版权所有',1,6,'158ad7bb-cb2c-4800-97b3-37055ecade85','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('备案信息','sys_keep_record','陕ICP备2025069493号-1',1,7,'b6432848-efca-4ff8-b9d3-f7cdb6a133dd','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('帮助文档','sys_help_doc','https://service.fastapiadmin.com',1,8,'0b7137c3-75ec-44dd-b333-33a11732d5c2','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('隐私政策','sys_web_privacy','https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE',1,9,'ea110687-e0e2-4bae-8f0a-25fb1c76b588','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('用户协议','sys_web_clause','https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE',1,10,'1a751f3d-b877-4539-9138-04a72b92e327','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('源码代码','sys_git_code','https://github.com/1014TaoTao/FastapiAdmin.git',1,11,'50007973-bb66-477d-94f3-9cf612368ce0','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('项目版本','sys_web_version','2.0.0',1,12,'f197e4d9-8f88-4d22-8eaa-e464323be170','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('演示模式启用','demo_enable','false',1,13,'75d7b7ef-1c3b-4f31-9409-408829be61d0','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('演示访问IP白名单','ip_white_list','[\"127.0.0.1\"]',1,14,'cbfb6b36-1e87-4e7a-98f3-d31f3643d1a5','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('接口白名单','white_api_list_path','[\"/api/v1/system/auth/login\", \"/api/v1/system/auth/token/refresh\", \"/api/v1/system/auth/captcha/get\", \"/api/v1/system/auth/logout\", \"/api/v1/system/config/info\", \"/api/v1/system/user/current/info\", \"/api/v1/system/notice/available\"]',1,15,'2ea596a1-0775-431c-a492-1ded89e56907','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57'),('访问IP黑名单','ip_black_list','[]',1,16,'56146e39-11af-4c3f-9000-d74b50ebba14','0','初始化数据','2025-11-29 14:22:57','2025-11-29 14:22:57');
/*!40000 ALTER TABLE `sys_param` ENABLE KEYS */;

--
-- Table structure for table `sys_position`
--

DROP TABLE IF EXISTS `sys_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_position` (
  `name` varchar(40) NOT NULL COMMENT '岗位名称',
  `order` int NOT NULL COMMENT '显示排序',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_position_created_id` (`created_id`),
  KEY `ix_sys_position_updated_id` (`updated_id`),
  KEY `ix_sys_position_tenant_id` (`tenant_id`),
  CONSTRAINT `sys_position_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_position_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_position_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_position`
--

/*!40000 ALTER TABLE `sys_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_position` ENABLE KEYS */;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `name` varchar(40) NOT NULL COMMENT '角色名称',
  `code` varchar(20) DEFAULT NULL COMMENT '角色编码',
  `order` int NOT NULL COMMENT '显示排序',
  `data_scope` varchar(10) DEFAULT NULL COMMENT '数据权限范围(1:仅本人 2:本部门 3:本部门及以下 4:全部 5:自定义)',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_sys_role_tenant_id` (`tenant_id`),
  KEY `ix_sys_role_created_id` (`created_id`),
  KEY `ix_sys_role_code` (`code`),
  KEY `ix_sys_role_updated_id` (`updated_id`),
  CONSTRAINT `sys_role_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_role_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_role_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('管理员角色','ADMIN',1,'4',1,'1d0fd634-3faa-40e2-aedf-5ad6d1fca647','0','初始化角色','2025-11-29 14:22:57','2025-11-29 14:22:57',1,1,1);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;

--
-- Table structure for table `sys_role_depts`
--

DROP TABLE IF EXISTS `sys_role_depts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_depts` (
  `role_id` int NOT NULL COMMENT '角色ID',
  `dept_id` int NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `sys_role_depts_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_depts_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_depts`
--

/*!40000 ALTER TABLE `sys_role_depts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_depts` ENABLE KEYS */;

--
-- Table structure for table `sys_role_menus`
--

DROP TABLE IF EXISTS `sys_role_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menus` (
  `role_id` int NOT NULL COMMENT '角色ID',
  `menu_id` int NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `sys_role_menus_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_menus_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menus`
--

/*!40000 ALTER TABLE `sys_role_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_menus` ENABLE KEYS */;

--
-- Table structure for table `sys_tenant`
--

DROP TABLE IF EXISTS `sys_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant` (
  `name` varchar(100) NOT NULL COMMENT '租户名称',
  `code` varchar(100) NOT NULL COMMENT '租户编码',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant`
--

/*!40000 ALTER TABLE `sys_tenant` DISABLE KEYS */;
INSERT INTO `sys_tenant` VALUES ('运行管理平台','SYSTEM',NULL,NULL,1,'ea56ab5e-11cb-452d-b6d5-3d46b6f311ff','0','系统内置租户，用于管理平台全局配置和所有租户','2025-11-29 14:22:57','2025-11-29 14:22:57');
/*!40000 ALTER TABLE `sys_tenant` ENABLE KEYS */;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `username` varchar(32) NOT NULL COMMENT '用户名/登录账号',
  `password` varchar(255) NOT NULL COMMENT '密码哈希',
  `name` varchar(32) NOT NULL COMMENT '昵称',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `gender` varchar(1) DEFAULT NULL COMMENT '性别(0:男 1:女 2:未知)',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像URL地址',
  `is_superuser` tinyint(1) NOT NULL COMMENT '是否超管',
  `last_login` datetime DEFAULT NULL COMMENT '最后登录时间',
  `gitee_login` varchar(32) DEFAULT NULL COMMENT 'Gitee登录',
  `github_login` varchar(32) DEFAULT NULL COMMENT 'Github登录',
  `wx_login` varchar(32) DEFAULT NULL COMMENT '微信登录',
  `qq_login` varchar(32) DEFAULT NULL COMMENT 'QQ登录',
  `user_type` varchar(32) NOT NULL COMMENT '用户类型(0:系统用户 1:租户用户 2:客户用户)',
  `salt` varchar(255) DEFAULT NULL COMMENT '加密盐',
  `dept_id` int DEFAULT NULL COMMENT '部门ID',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `email` (`email`),
  KEY `ix_sys_user_customer_id` (`customer_id`),
  KEY `ix_sys_user_tenant_id` (`tenant_id`),
  KEY `ix_sys_user_updated_id` (`updated_id`),
  KEY `ix_sys_user_dept_id` (`dept_id`),
  KEY `ix_sys_user_created_id` (`created_id`),
  CONSTRAINT `sys_user_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_user_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sys_user_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `sys_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `sys_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_ibfk_5` FOREIGN KEY (`created_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES ('admin','$2b$12$e2IJgS/cvHgJ0H3G7Xa08OXoXnk6N/NX3IZRtubBDElA0VLZhkNOa','超级管理员',NULL,NULL,'0','https://service.fastapiadmin.com/api/v1/static/image/avatar.png',1,NULL,NULL,NULL,NULL,NULL,'0','123456',1,1,'3f67a36b-40eb-4c7c-8f85-3d7f0a2d4736','0','超级管理员','2025-11-29 14:22:57','2025-11-29 14:22:57',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;

--
-- Table structure for table `sys_user_positions`
--

DROP TABLE IF EXISTS `sys_user_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_positions` (
  `user_id` int NOT NULL COMMENT '用户ID',
  `position_id` int NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`position_id`),
  KEY `position_id` (`position_id`),
  CONSTRAINT `sys_user_positions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_positions_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `sys_position` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_positions`
--

/*!40000 ALTER TABLE `sys_user_positions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_positions` ENABLE KEYS */;

--
-- Table structure for table `sys_user_roles`
--

DROP TABLE IF EXISTS `sys_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_roles` (
  `user_id` int NOT NULL COMMENT '用户ID',
  `role_id` int NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `sys_user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_roles`
--

/*!40000 ALTER TABLE `sys_user_roles` DISABLE KEYS */;
INSERT INTO `sys_user_roles` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_roles` ENABLE KEYS */;

--
-- Dumping routines for database 'fastapiadmin'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-29 14:23:15
