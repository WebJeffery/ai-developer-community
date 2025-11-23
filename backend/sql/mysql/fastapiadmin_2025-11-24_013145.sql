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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('c3d2c711c360');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;

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
  KEY `ix_app_ai_mcp_updated_id` (`updated_id`),
  KEY `ix_app_ai_mcp_tenant_id` (`tenant_id`),
  KEY `ix_app_ai_mcp_customer_id` (`customer_id`),
  KEY `ix_app_ai_mcp_created_id` (`created_id`),
  CONSTRAINT `app_ai_mcp_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_ai_mcp_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_ai_mcp_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `app_ai_mcp_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  KEY `ix_app_job_created_id` (`created_id`),
  KEY `ix_app_job_updated_id` (`updated_id`),
  KEY `ix_app_job_customer_id` (`customer_id`),
  CONSTRAINT `app_job_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_job_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_job_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `app_job_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `status` varchar(10) NOT NULL COMMENT '执行状态(0:成功 1:失败)',
  `description` text COMMENT '备注/描述',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `job_executor` varchar(64) NOT NULL COMMENT '任务执行器',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_args` varchar(255) DEFAULT NULL COMMENT '位置参数',
  `job_kwargs` varchar(255) DEFAULT NULL COMMENT '关键字参数',
  `job_trigger` varchar(255) DEFAULT NULL COMMENT '任务触发器',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `exception_info` varchar(2000) DEFAULT NULL COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `job_id` int DEFAULT NULL COMMENT '任务ID',
  PRIMARY KEY (`id`),
  KEY `ix_app_job_log_job_id` (`job_id`),
  CONSTRAINT `app_job_log_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `app_job` (`id`) ON DELETE CASCADE
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
  KEY `ix_app_myapp_updated_id` (`updated_id`),
  KEY `ix_app_myapp_created_id` (`created_id`),
  KEY `ix_app_myapp_customer_id` (`customer_id`),
  KEY `ix_app_myapp_tenant_id` (`tenant_id`),
  CONSTRAINT `app_myapp_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_myapp_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `app_myapp_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `app_myapp_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  CONSTRAINT `gen_demo_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_demo_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_demo_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gen_demo_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_gen_table_tenant_id` (`tenant_id`),
  KEY `ix_gen_table_updated_id` (`updated_id`),
  KEY `ix_gen_table_created_id` (`created_id`),
  CONSTRAINT `gen_table_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_table_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_table_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `created_id` int DEFAULT NULL COMMENT '创建人ID',
  `updated_id` int DEFAULT NULL COMMENT '更新人ID',
  `tenant_id` int NOT NULL COMMENT '所属租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_gen_table_column_created_id` (`created_id`),
  KEY `ix_gen_table_column_updated_id` (`updated_id`),
  KEY `ix_gen_table_column_table_id` (`table_id`),
  KEY `ix_gen_table_column_tenant_id` (`tenant_id`),
  CONSTRAINT `gen_table_column_ibfk_1` FOREIGN KEY (`table_id`) REFERENCES `gen_table` (`id`) ON DELETE CASCADE,
  CONSTRAINT `gen_table_column_ibfk_2` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_table_column_ibfk_3` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gen_table_column_ibfk_4` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;

--
-- Table structure for table `system_customer`
--

DROP TABLE IF EXISTS `system_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_customer` (
  `name` varchar(64) NOT NULL COMMENT '客户名称',
  `code` varchar(20) NOT NULL COMMENT '客户编码',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
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
  KEY `ix_system_customer_tenant_id` (`tenant_id`),
  KEY `ix_system_customer_code` (`code`),
  KEY `ix_system_customer_created_id` (`created_id`),
  KEY `ix_system_customer_updated_id` (`updated_id`),
  CONSTRAINT `system_customer_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_customer_ibfk_2` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_customer_ibfk_3` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='客户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_customer`
--

/*!40000 ALTER TABLE `system_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_customer` ENABLE KEYS */;

--
-- Table structure for table `system_dept`
--

DROP TABLE IF EXISTS `system_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dept` (
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
  KEY `ix_system_dept_parent_id` (`parent_id`),
  KEY `ix_system_dept_tenant_id` (`tenant_id`),
  KEY `ix_system_dept_code` (`code`),
  CONSTRAINT `system_dept_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `system_dept` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_dept_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dept`
--

/*!40000 ALTER TABLE `system_dept` DISABLE KEYS */;
INSERT INTO `system_dept` VALUES ('集团总公司',1,'GROUP','超级管理员','13800138000','admin@example.com',NULL,1,'5515a3c9-e15d-4e4a-aec6-a8b6830bfb84','1','集团总公司','2025-11-24 00:54:18','2025-11-24 00:54:18',1),('北京分公司',1,'BJ','分公司经理','13900139000','manager@example.com',1,2,'f799a861-c09e-4921-89bf-84cda5b074a7','1','北京分公司','2025-11-24 00:54:18','2025-11-24 00:54:18',1),('软件部',1,'TECH','技术总监','13700137000','tech@example.com',2,3,'4b4ce1b6-f034-42bb-b20d-75cbf627b9f2','1','软件部','2025-11-24 00:54:18','2025-11-24 00:54:18',1),('开发组',1,'DEV','开发主管','13600136000','dev@example.com',3,4,'fcdc2725-c7c4-448a-8850-60977a5d2dbb','1','开发组','2025-11-24 00:54:18','2025-11-24 00:54:18',1);
/*!40000 ALTER TABLE `system_dept` ENABLE KEYS */;

--
-- Table structure for table `system_dict_data`
--

DROP TABLE IF EXISTS `system_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dict_data` (
  `dict_sort` int NOT NULL COMMENT '字典排序',
  `dict_label` varchar(255) NOT NULL COMMENT '字典标签',
  `dict_value` varchar(255) NOT NULL COMMENT '字典键值',
  `css_class` varchar(255) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(255) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` tinyint(1) NOT NULL COMMENT '是否默认（True是 False否）',
  `dict_type` varchar(255) DEFAULT NULL COMMENT '字典类型',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dict_data`
--

/*!40000 ALTER TABLE `system_dict_data` DISABLE KEYS */;
INSERT INTO `system_dict_data` VALUES (1,'男','0','blue',NULL,1,'sys_user_sex',1,'ce84e75b-f943-4b72-9ce3-2a38757d7f22','1','性别男','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'女','1','pink',NULL,0,'sys_user_sex',2,'e8b4ffbc-6e43-4ea1-ae41-4e4ce27d3b3f','1','性别女','2025-11-24 00:54:18','2025-11-24 00:54:18'),(3,'未知','2','red',NULL,0,'sys_user_sex',3,'f504240e-3983-4b0b-87a0-df035ee72e7e','1','性别未知','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'启用','1','','primary',0,'sys_common_status',4,'175b8308-5169-40df-b4d8-38939374772c','1','启用状态','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'停用','0','','danger',0,'sys_common_status',5,'3a32f95d-738d-474c-a6e3-493814b45f85','1','停用状态','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'是','1','','primary',1,'sys_yes_no',6,'9cbabe4b-736e-41ab-be22-49d2b7e3106d','1','是','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'否','0','','danger',0,'sys_yes_no',7,'4dc596d5-d579-4265-9484-f0bbb7cd1a97','1','否','2025-11-24 00:54:18','2025-11-24 00:54:18'),(99,'其他','0','','info',0,'sys_oper_type',8,'58df7b92-df65-4864-9c93-27c3b0f13c75','1','其他操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'新增','1','','info',0,'sys_oper_type',9,'91eda46e-2ffa-421b-b050-ab41e52dab64','1','新增操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'修改','2','','info',0,'sys_oper_type',10,'56264648-2be8-44bd-ac42-74965e8ebd0f','1','修改操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(3,'删除','3','','danger',0,'sys_oper_type',11,'e16e6151-6950-446a-974d-b8fc50bc5dd7','1','删除操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(4,'分配权限','4','','primary',0,'sys_oper_type',12,'2276b370-6862-40e3-869e-621f7050c0f7','1','授权操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(5,'导出','5','','warning',0,'sys_oper_type',13,'f36b10f2-ba6a-449a-9d0f-a306a51a8500','1','导出操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(6,'导入','6','','warning',0,'sys_oper_type',14,'2343e3c6-381f-4941-8af8-a452aaaf5025','1','导入操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(7,'强退','7','','danger',0,'sys_oper_type',15,'ac3c93ce-101f-442a-ae6c-2a0492a7f8c3','1','强退操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(8,'生成代码','8','','warning',0,'sys_oper_type',16,'76c88eaa-291e-470b-ac5b-f9efa6199775','1','生成操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(9,'清空数据','9','','danger',0,'sys_oper_type',17,'bb326da6-1b45-44fa-abef-a075ceec6adc','1','清空操作','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'通知','1','blue','warning',1,'sys_notice_type',18,'b2ca987b-d144-4302-a426-3f3cdd884e7f','1','通知','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'公告','2','orange','success',0,'sys_notice_type',19,'834864fc-b92f-4751-9f40-26832ca50699','1','公告','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'默认(Memory)','default','',NULL,1,'sys_job_store',20,'3d3d3602-d4b5-4b46-bab6-c04b7fa7e0f8','1','默认分组','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'数据库(Sqlalchemy)','sqlalchemy','',NULL,0,'sys_job_store',21,'4a6c4a94-d813-4405-9d8a-1d68ed4eb50a','1','数据库分组','2025-11-24 00:54:18','2025-11-24 00:54:18'),(3,'数据库(Redis)','redis','',NULL,0,'sys_job_store',22,'8584e18b-7244-47e4-9646-91022b0a2887','1','reids分组','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'线程池','default','',NULL,0,'sys_job_executor',23,'3f50a89d-25aa-4364-a313-899f12b458df','1','线程池','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'进程池','processpool','',NULL,0,'sys_job_executor',24,'0d75e1ff-690b-4f71-b298-53cd6fe24eb2','1','进程池','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'演示函数','scheduler_test.job','',NULL,1,'sys_job_function',25,'811e8154-4c80-402e-b878-21248d2c8d1e','1','演示函数','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'指定日期(date)','date','',NULL,1,'sys_job_trigger',26,'75595411-f583-4fa6-85f0-08690e5eb443','1','指定日期任务触发器','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'间隔触发器(interval)','interval','',NULL,0,'sys_job_trigger',27,'7d223921-33f7-455e-8b3f-64d336f9137d','1','间隔触发器任务触发器','2025-11-24 00:54:18','2025-11-24 00:54:18'),(3,'cron表达式','cron','',NULL,0,'sys_job_trigger',28,'d0c861f6-c972-44e5-a9fa-4db83bd16969','1','间隔触发器任务触发器','2025-11-24 00:54:18','2025-11-24 00:54:18'),(1,'默认(default)','default','',NULL,1,'sys_list_class',29,'02a19cb2-961d-43e7-b775-a5b12a27c0bd','1','默认表格回显样式','2025-11-24 00:54:18','2025-11-24 00:54:18'),(2,'主要(primary)','primary','',NULL,0,'sys_list_class',30,'7027e87f-9fd0-443f-bcfd-a9c5d88f6ae0','1','主要表格回显样式','2025-11-24 00:54:18','2025-11-24 00:54:18'),(3,'成功(success)','success','',NULL,0,'sys_list_class',31,'2d14728c-92cc-4969-a676-057e8600989b','1','成功表格回显样式','2025-11-24 00:54:18','2025-11-24 00:54:18'),(4,'信息(info)','info','',NULL,0,'sys_list_class',32,'f2f19d11-b6b3-4722-b475-b0195f422a41','1','信息表格回显样式','2025-11-24 00:54:18','2025-11-24 00:54:18'),(5,'警告(warning)','warning','',NULL,0,'sys_list_class',33,'3f148b17-8757-473b-b879-9124fc88f49a','1','警告表格回显样式','2025-11-24 00:54:18','2025-11-24 00:54:18'),(6,'危险(danger)','danger','',NULL,0,'sys_list_class',34,'7871b05d-8f57-421c-8c92-142c826031c8','1','危险表格回显样式','2025-11-24 00:54:18','2025-11-24 00:54:18');
/*!40000 ALTER TABLE `system_dict_data` ENABLE KEYS */;

--
-- Table structure for table `system_dict_type`
--

DROP TABLE IF EXISTS `system_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dict_type` (
  `dict_name` varchar(255) NOT NULL COMMENT '字典名称',
  `dict_type` varchar(255) NOT NULL COMMENT '字典类型',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(64) NOT NULL COMMENT 'UUID全局唯一标识',
  `status` varchar(10) NOT NULL COMMENT '是否启用(0:启用 1:禁用)',
  `description` text COMMENT '备注/描述',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dict_type`
--

/*!40000 ALTER TABLE `system_dict_type` DISABLE KEYS */;
INSERT INTO `system_dict_type` VALUES ('用户性别','sys_user_sex',1,'6501b09c-2ff3-4064-866f-13b90d01f6d9','1','用户性别列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('系统是否','sys_yes_no',2,'8cf507aa-affa-4715-b9b1-4779d65edac0','1','系统是否列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('系统状态','sys_common_status',3,'266c5e5a-206b-4064-9079-c5a5b44fc267','1','系统状态','2025-11-24 00:54:18','2025-11-24 00:54:18'),('通知类型','sys_notice_type',4,'c6bdecc5-b420-4aa1-8cee-bbb84a4dfe1c','1','通知类型列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('操作类型','sys_oper_type',5,'9594e6d6-0906-4c93-9f27-b456ac6c1a95','1','操作类型列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('任务存储器','sys_job_store',6,'0da1edc9-64bb-4d30-9922-6d85751ec03b','1','任务分组列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('任务执行器','sys_job_executor',7,'e4c56b13-ed3e-4181-aa12-5d3c082d51bd','1','任务执行器列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('任务函数','sys_job_function',8,'55ba72ce-2011-4a28-932c-d015e9252e84','1','任务函数列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('任务触发器','sys_job_trigger',9,'95b0f462-6eea-41b2-b222-cbfce64b142a','1','任务触发器列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('表格回显样式','sys_list_class',10,'d2112f4c-bd90-41b9-9c96-f0acc16760a8','1','表格回显样式列表','2025-11-24 00:54:18','2025-11-24 00:54:18');
/*!40000 ALTER TABLE `system_dict_type` ENABLE KEYS */;

--
-- Table structure for table `system_log`
--

DROP TABLE IF EXISTS `system_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_log` (
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
  KEY `ix_system_log_created_id` (`created_id`),
  KEY `ix_system_log_updated_id` (`updated_id`),
  KEY `ix_system_log_tenant_id` (`tenant_id`),
  KEY `ix_system_log_customer_id` (`customer_id`),
  CONSTRAINT `system_log_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_log_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_log_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_log_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_log`
--

/*!40000 ALTER TABLE `system_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_log` ENABLE KEYS */;

--
-- Table structure for table `system_menu`
--

DROP TABLE IF EXISTS `system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_menu` (
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
  KEY `ix_system_menu_parent_id` (`parent_id`),
  CONSTRAINT `system_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `system_menu` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_menu`
--

/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
INSERT INTO `system_menu` VALUES ('仪表盘',1,1,'','client','Dashboard','/dashboard',NULL,'/dashboard/workplace',0,1,1,'仪表盘','null',0,NULL,1,'72496c6d-70ae-4ae8-b3c2-a4436b488680','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('系统管理',1,2,NULL,'system','System','/system',NULL,'/system/menu',0,1,0,'系统管理','null',0,NULL,2,'d8c3e087-a46e-480b-8fad-d370ed66deae','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('应用管理',1,3,NULL,'el-icon-ShoppingBag','Application','/application',NULL,'/application/myapp',0,0,0,'应用管理','null',0,NULL,3,'0995d88e-7b12-48b5-bed8-bbdbc7a6ad84','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('监控管理',1,4,NULL,'monitor','Monitor','/monitor',NULL,'/monitor/online',0,0,0,'监控管理','null',0,NULL,4,'ccd530a4-09ea-4c1b-b930-5dcd3f446510','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('代码管理',1,5,NULL,'code','Gencode','/gencode',NULL,'/gencode/backcode',0,0,0,'代码管理','null',0,NULL,5,'25e28119-a66a-45fc-a764-e872c721372e','1','代码管理','2025-11-24 00:54:18','2025-11-24 00:54:18'),('接口管理',1,6,NULL,'document','Common','/common',NULL,'/common/docs',0,0,0,'接口管理','null',0,NULL,6,'e7dc9578-acdb-44da-9c17-9166ca4b3a45','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('案例管理',1,7,NULL,'el-icon-ElementPlus','Example','/example',NULL,'/example/demo',0,0,0,'案例管理','null',0,NULL,7,'ad448ac7-fef5-4ef8-b2a5-6c624057cd73','1','案例管理','2025-11-24 00:54:18','2025-11-24 00:54:18'),('工作台',2,1,'dashboard:workplace:query','el-icon-PieChart','Workplace','/dashboard/workplace','dashboard/workplace',NULL,0,1,0,'工作台','null',0,1,8,'c538b66d-99d1-44fd-ab58-8a1736179d30','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('菜单管理',2,1,'module_system:menu:query','menu','Menu','/system/menu','module_system/menu/index',NULL,0,1,0,'菜单管理','null',0,2,9,'80b4ce44-d13a-45bf-80af-4338a6c49737','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('租户管理',2,3,'module_system:tenant:query','el-icon-Avatar','Tenant','/system/tenant','module_system/tenant/index',NULL,0,1,0,'租户管理','null',0,2,10,'bf28b018-8681-4e93-badb-98650817d30f','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('部门管理',2,2,'module_system:dept:query','tree','Dept','/system/dept','module_system/dept/index',NULL,0,1,0,'部门管理','null',0,2,11,'38683b50-8926-4063-b13e-ac08ccc95d65','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('岗位管理',2,3,'module_system:position:query','el-icon-Coordinate','Position','/system/position','module_system/position/index',NULL,0,1,0,'岗位管理','null',0,2,12,'b9d3da07-38c8-4b12-9e8e-ad62ccd0a15a','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('角色管理',2,4,'module_system:role:query','role','Role','/system/role','module_system/role/index',NULL,0,1,0,'角色管理','null',0,2,13,'8193147e-3060-4b22-a9cc-74fba7cf8a86','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('用户管理',2,5,'module_system:user:query','el-icon-User','User','/system/user','module_system/user/index',NULL,0,1,0,'用户管理','null',0,2,14,'ea574f19-22a8-442c-9e95-9a171d287ffe','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('日志管理',2,6,'module_system:log:query','el-icon-Aim','Log','/system/log','module_system/log/index',NULL,0,1,0,'日志管理','null',0,2,15,'e9ba3e3b-b338-4225-9796-f31705eb1ad6','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('公告管理',2,7,'module_system:notice:query','bell','Notice','/system/notice','module_system/notice/index',NULL,0,1,0,'公告管理','null',0,2,16,'aa24dfb5-1b20-48a8-8ee9-dd50af60c7dd','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('参数管理',2,8,'module_system:param:query','setting','Params','/system/param','module_system/param/index',NULL,0,1,0,'参数管理','null',0,2,17,'19624f4f-2c83-43cc-b895-04d1e327276d','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('字典管理',2,9,'module_system:dict_type:query','dict','Dict','/system/dict','module_system/dict/index',NULL,0,1,0,'字典管理','null',0,2,18,'252dafff-8852-470c-9ed3-a04689af20e9','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('我的应用',2,1,'module_application:myapp:query','el-icon-ShoppingCartFull','MYAPP','/application/myapp','module_application/myapp/index',NULL,0,1,0,'我的应用','null',0,3,19,'e0cadb23-2598-42dd-ae75-3fbb9102dd09','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('任务管理',2,2,'module_application:job:query','el-icon-DataLine','Job','/application/job','module_application/job/index',NULL,0,1,0,'任务管理','null',0,3,20,'33534aca-5e21-4300-9abb-53a526d2f62e','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('AI智能助手',2,3,'module_application:ai:chat','el-icon-ToiletPaper','AI','/application/ai','module_application/ai/index',NULL,0,1,0,'AI智能助手','null',0,3,21,'eafb5b2a-33ed-4dc9-a046-092fe65fcd09','1','AI智能助手','2025-11-24 00:54:18','2025-11-24 00:54:18'),('流程管理',2,4,'module_application:workflow:query','el-icon-ShoppingBag','Workflow','/application/workflow','module_application/workflow/index',NULL,0,1,0,'我的流程','null',0,3,22,'f984f9ab-6b63-4c56-8ee5-2944fbda3481','1','我的流程','2025-11-24 00:54:18','2025-11-24 00:54:18'),('在线用户',2,1,'module_monitor:online:query','el-icon-Headset','MonitorOnline','/monitor/online','module_monitor/online/index',NULL,0,0,0,'在线用户','null',0,4,23,'a1fba339-c0f3-468a-b739-ca82382f990c','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('服务器监控',2,2,'module_monitor:server:query','el-icon-Odometer','MonitorServer','/monitor/server','module_monitor/server/index',NULL,0,0,0,'服务器监控','null',0,4,24,'6d30138c-2b48-496b-b996-21b3f9afb5cb','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('缓存监控',2,3,'module_monitor:cache:query','el-icon-Stopwatch','MonitorCache','/monitor/cache','module_monitor/cache/index',NULL,0,0,0,'缓存监控','null',0,4,25,'238b231c-b394-450a-b8a7-a8d102a8e586','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件管理',2,4,'module_monitor:resource:query','el-icon-Files','Resource','/monitor/resource','module_monitor/resource/index',NULL,0,1,0,'文件管理','null',0,4,26,'ff62f0f6-8665-4c31-9683-bdffb2488f41','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('代码生成',2,1,'module_generator:gencode:query','code','Backcode','/gencode/backcode','module_generator/backcode/index',NULL,0,1,0,'代码生成','null',0,5,27,'4dfba46e-1983-4c26-baef-b57f437c7dec','1','代码生成','2025-11-24 00:54:18','2025-11-24 00:54:18'),('Swagger文档',4,1,'module_common:docs:query','api','Docs','/common/docs','module_common/docs/index',NULL,0,0,0,'Swagger文档','null',0,6,28,'7203e22b-d76c-4230-8a1f-052ccd8acc51','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('Redoc文档',4,2,'module_common:redoc:query','el-icon-Document','Redoc','/common/redoc','module_common/redoc/index',NULL,0,0,0,'Redoc文档','null',0,6,29,'1ede5784-3047-4455-aed6-cbb1a10c7576','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('示例管理',2,1,'module_example:demo:query','el-icon-ElementPlus','Demo','/example/demo','module_example/demo/index',NULL,0,1,0,'示例管理','null',0,7,30,'a0283bd5-ff5e-4f57-a8d5-4d099d3940c5','1','示例管理','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建菜单',3,1,'module_system:menu:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建菜单','null',0,9,31,'a6be10ff-e3d0-46cf-bc37-3e31eff8c018','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改菜单',3,2,'module_system:menu:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改菜单','null',0,9,32,'282328dc-82e7-4e51-a1dd-5711782a8c5b','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除菜单',3,3,'module_system:menu:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除菜单','null',0,9,33,'ebffe55d-fa81-49ef-889f-6c42d6931fdc','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改菜单状态',3,4,'module_system:menu:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改菜单状态','null',0,9,34,'c3c6bf38-37cf-4470-97ec-e60194797dec','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建租户',3,1,'module_system:tenant:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建租户','null',0,10,35,'1266ecdb-e772-4da6-84fc-c6408f8e34d9','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('更新租户',3,2,'module_system:tenant:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新租户','null',0,10,36,'33b42bde-5528-479d-a7b7-d5ca2fec8d9f','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除租户',3,3,'module_system:tenant:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除租户','null',0,10,37,'54bcc24d-72e3-40cd-9138-d72a9cbd94cc','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改租户状态',3,4,'module_system:tenant:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改租户状态','null',0,10,38,'7357773b-e194-42e9-a871-1a52ce1cd5f2','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出租户',3,5,'module_system:tenant:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出租户','null',0,10,39,'c6c3ee50-2931-47fe-a410-0d2843caad67','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导入租户',3,6,'module_system:tenant:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入租户','null',0,10,40,'898c1ce4-cecf-46a7-ad06-7455eb14f1eb','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('下载导入租户模版',3,7,'module_system:tenant:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入租户模版','null',0,10,41,'902ed52c-dca2-4336-a6df-15b42b3d7484','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建部门',3,1,'module_system:dept:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建部门','null',0,11,42,'06c979fc-2790-4581-8055-b99864bc625f','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改部门',3,2,'module_system:dept:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改部门','null',0,11,43,'84955c73-daa8-4275-903c-2e1a4831cba7','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除部门',3,3,'module_system:dept:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除部门','null',0,11,44,'80f1a6e2-06d5-4cf0-92e6-3f17339fcda8','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改部门状态',3,4,'module_system:dept:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改部门状态','null',0,11,45,'987bf7ed-09c4-4baf-8b16-b0a0a54cd9b7','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建岗位',3,1,'module_system:position:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建岗位','null',0,12,46,'42fd6539-b134-4efa-8f26-84860f1e8865','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改岗位',3,2,'module_system:position:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改岗位','null',0,12,47,'e8d0aa08-0063-4140-9a8b-826b227cacab','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除岗位',3,3,'module_system:position:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改岗位','null',0,12,48,'b095a06e-8d86-45d3-8a21-f79c50eef548','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改岗位状态',3,4,'module_system:position:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改岗位状态','null',0,12,49,'b21a1b4d-b297-43ce-9f61-2e738fbb1955','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('岗位导出',3,5,'module_system:position:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'岗位导出','null',0,12,50,'308a97a0-9484-4437-95cf-721f2b1cd112','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('设置角色权限',3,8,'module_system:role:permission',NULL,NULL,NULL,NULL,NULL,0,1,0,'设置角色权限','null',0,12,51,'d50b2f22-b1b3-463a-8034-3a2c69ac0aab','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建角色',3,1,'module_system:role:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建角色','null',0,13,52,'74c90df7-0804-4a70-8dd4-746321d120e6','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改角色',3,2,'module_system:role:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改角色','null',0,13,53,'942c20bf-f11e-4023-98f9-f7ff4bdf7f63','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除角色',3,3,'module_system:role:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除角色','null',0,13,54,'8aa9f306-643d-4837-a393-0057976670b1','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改角色状态',3,4,'module_system:role:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改角色状态','null',0,13,55,'e32754d7-5054-4c0a-a793-2be9fc5b4ed2','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('角色导出',3,6,'module_system:role:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'角色导出','null',0,13,56,'31cc477f-1545-41d7-a160-715b7533c49c','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建用户',3,1,'module_system:user:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建用户','null',0,14,57,'adc988fd-9356-403a-b532-bb37d4b2ca42','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改用户',3,2,'module_system:user:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改用户','null',0,14,58,'fab53df5-7331-49f3-90e9-c574efca4aba','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除用户',3,3,'module_system:user:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除用户','null',0,14,59,'873d7d8d-da60-408a-96c7-7764d0e7b122','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改用户状态',3,4,'module_system:user:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改用户状态','null',0,14,60,'f5854305-239d-4a09-aa79-4fa366f555d5','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出用户',3,5,'module_system:user:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出用户','null',0,14,61,'e87455c0-9e90-4a21-968c-e4c9b2e10132','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导入用户',3,6,'module_system:user:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入用户','null',0,14,62,'7c76db53-7467-4535-9210-eb544073f26b','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('日志删除',3,1,'module_system:log:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'日志删除','null',0,15,63,'a43d701c-0cf6-4e77-aa94-206846494fac','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('日志导出',3,2,'module_system:log:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'日志导出','null',0,15,64,'ff7d5a64-37f1-4958-aa58-baf7b6d607c6','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('公告创建',3,1,'module_system:notice:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告创建','null',0,16,65,'b7c4b797-a66f-407f-8e51-d922ec1e0e13','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('公告修改',3,2,'module_system:notice:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改用户','null',0,16,66,'6f122107-3c4b-43e1-8e76-127c39555245','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('公告删除',3,3,'module_system:notice:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告删除','null',0,16,67,'4deeca06-fafd-4bc7-8406-e53aed99a2be','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('公告导出',3,4,'module_system:notice:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告导出','null',0,16,68,'b955b32b-0c47-44ea-b085-58ec997f565e','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('公告批量修改状态',3,5,'module_system:notice:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告批量修改状态','null',0,16,69,'3e39f6ad-e8a0-4133-9a7e-d82836bd8259','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建参数',3,1,'module_system:param:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建参数','null',0,17,70,'07fa0da7-b681-44ed-a350-1753f74d3318','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改参数',3,2,'module_system:param:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改参数','null',0,17,71,'c2268948-db4b-485b-b83e-59dc60f11a1c','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除参数',3,3,'module_system:param:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除参数','null',0,17,72,'e0c68fc3-76cd-42d0-9705-a8b5285118ca','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出参数',3,4,'module_system:param:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出参数','null',0,17,73,'713b00c5-bb87-4a00-988c-1ebbd49a5ce1','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('参数上传',3,5,'module_system:param:upload',NULL,NULL,NULL,NULL,NULL,0,1,0,'参数上传','null',0,17,74,'19228b72-0012-4089-882f-e762d6ca87c4','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建字典类型',3,1,'module_system:dict_type:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建字典类型','null',0,18,75,'569655ba-925c-4115-b881-bdf5f96174fd','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改字典类型',3,2,'module_system:dict_type:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改字典类型','null',0,18,76,'77380be6-0731-4e3c-a128-38760b6f7de1','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除字典类型',3,3,'module_system:dict_type:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除字典类型','null',0,18,77,'a2d3cd1a-d9e2-4fb5-8656-23e6292db6e5','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出字典类型',3,4,'module_system:dict_type:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典类型','null',0,18,78,'1b27f2a4-2d54-45e9-8e5d-7000aba5a538','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改字典状态',3,5,'module_system:dict_type:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典类型','null',0,18,79,'1793ca56-efec-4185-abe4-0241b42d7d4d','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('字典数据查询',3,6,'module_system:dict_data:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'字典数据查询','null',0,18,80,'f2f2bb91-f9bd-4f9f-8252-0988dcebc386','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建字典数据',3,7,'module_system:dict_data:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建字典数据','null',0,18,81,'af73bb08-2c71-4d3d-9f7e-7a2006aa6d54','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改字典数据',3,8,'module_system:dict_data:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改字典数据','null',0,18,82,'a56e84b4-6acd-422b-b549-4d589f8ef1cd','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除字典数据',3,9,'module_system:dict_data:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除字典数据','null',0,18,83,'c7e82c63-6791-49ca-9098-15be084f8bef','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出字典数据',3,10,'module_system:dict_data:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典数据','null',0,18,84,'1aad287e-9542-40a0-9a13-dd8e4db2a433','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改字典数据状态',3,11,'module_system:dict_data:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改字典数据状态','null',0,18,85,'979c708f-d6e4-4673-849f-9c63e9e3abe7','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建应用',3,1,'module_application:myapp:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建应用','null',0,19,86,'0c0b1565-1053-4602-afd0-fdde0b4d3237','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改应用',3,2,'module_application:myapp:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改应用','null',0,19,87,'13141c31-5044-440e-adaa-05a9a17d6b34','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除应用',3,3,'module_application:myapp:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除应用','null',0,19,88,'2419f454-5fdf-440a-b139-a655d554044f','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改应用状态',3,4,'module_application:myapp:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改应用状态','null',0,19,89,'df8b688c-a53b-41e5-b228-bda5691ca9a3','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建任务',3,1,'module_application:job:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建任务','null',0,20,90,'1be32b6d-2799-43e4-ae92-8f6ad00a25e6','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('修改和操作任务',3,2,'module_application:job:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改和操作任务','null',0,20,91,'042de909-4db2-4861-aa0f-5c8fbc4a861e','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除和清除任务',3,3,'module_application:job:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除和清除任务','null',0,20,92,'c330f88a-bac0-431c-afd7-d6c2948d6c14','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出定时任务',3,4,'module_application:job:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出定时任务','null',0,20,93,'903a01d0-9749-4e5b-9648-ede5984316fd','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('智能对话',3,1,'module_application:ai:chat',NULL,NULL,NULL,NULL,NULL,0,1,0,'智能对话','null',0,21,94,'386194bc-ab32-4cbc-9719-9e39edcb24f8','1','智能对话','2025-11-24 00:54:18','2025-11-24 00:54:18'),('在线用户强制下线',3,1,'module_monitor:online:delete',NULL,NULL,NULL,NULL,NULL,0,0,0,'在线用户强制下线','null',0,23,95,'6f381ae8-d562-4667-a1bc-c1533065fd80','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('清除缓存',3,1,'module_monitor:cache:delete',NULL,NULL,NULL,NULL,NULL,0,0,0,'清除缓存','null',0,25,96,'a9f0fe9f-77c3-4c62-9926-258a48cc9cd0','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件上传',3,1,'module_monitor:resource:upload',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件上传','null',0,26,97,'cfb16ca7-8359-4591-8116-e3895e700a2c','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件下载',3,2,'module_monitor:resource:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件下载','null',0,26,98,'60266ea4-f3a1-40f5-9a19-58188b011a31','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件删除',3,3,'module_monitor:resource:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件删除','null',0,26,99,'9fb6f605-553f-480b-b81b-e93fd9d13b47','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件移动',3,4,'module_monitor:resource:move',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件移动','null',0,26,100,'0b7b0dce-e119-4618-9698-344424d93db6','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件复制',3,5,'module_monitor:resource:copy',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件复制','null',0,26,101,'da78a0ce-8e7f-4288-8a39-3bd9fb81d0d0','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('文件重命名',3,6,'module_monitor:resource:rename',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件重命名','null',0,26,102,'c8b1022d-398d-48dc-8645-56f698ebcbfe','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建目录',3,7,'module_monitor:resource:create_dir',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建目录','null',0,26,103,'1be113ee-7d6a-4230-b92d-7a505fe47e24','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出文件列表',3,9,'module_monitor:resource:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出文件列表','null',0,26,104,'697842bb-0721-4710-8d9a-724151ad4d09','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('查询代码生成业务表列表',3,1,'module_generator:gencode:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'查询代码生成业务表列表','null',0,27,105,'be95bc6d-2075-4279-8f31-8301d57606eb','1','查询代码生成业务表列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建表结构',3,2,'module_generator:gencode:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建表结构','null',0,27,106,'e7f0d72d-6275-4348-98ce-d9b23c93ad7d','1','创建表结构','2025-11-24 00:54:18','2025-11-24 00:54:18'),('编辑业务表信息',3,3,'module_generator:gencode:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'编辑业务表信息','null',0,27,107,'fe2b02d4-bf92-424a-b9eb-26c920073b34','1','编辑业务表信息','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除业务表信息',3,4,'module_generator:gencode:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除业务表信息','null',0,27,108,'86ebcea8-d4f7-4896-85f2-b32346f6f810','1','删除业务表信息','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导入表结构',3,5,'module_generator:gencode:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入表结构','null',0,27,109,'addcd178-308b-4e96-8bf5-c2c1160e3095','1','导入表结构','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量生成代码',3,6,'module_generator:gencode:operate',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量生成代码','null',0,27,110,'9fb474b5-c788-4ee5-807b-73ed3fb39fe7','1','批量生成代码','2025-11-24 00:54:18','2025-11-24 00:54:18'),('生成代码到指定路径',3,7,'module_generator:gencode:code',NULL,NULL,NULL,NULL,NULL,0,1,0,'生成代码到指定路径','null',0,27,111,'b481d783-8e04-451f-a1c7-5a98a33f1baa','1','生成代码到指定路径','2025-11-24 00:54:18','2025-11-24 00:54:18'),('查询数据库表列表',3,8,'module_generator:dblist:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'查询数据库表列表','null',0,27,112,'76b97d9b-6710-4b9c-9fb5-8c51a6318c0b','1','查询数据库表列表','2025-11-24 00:54:18','2025-11-24 00:54:18'),('同步数据库',3,9,'module_generator:db:sync',NULL,NULL,NULL,NULL,NULL,0,1,0,'同步数据库','null',0,27,113,'b429b922-4a40-4aed-831b-47bce588aa60','1','同步数据库','2025-11-24 00:54:18','2025-11-24 00:54:18'),('创建示例',3,1,'module_example:demo:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建示例','null',0,30,114,'7e09f52e-8f89-4bc3-acf8-a7a17cbe7534','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('更新示例',3,2,'module_example:demo:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新示例','null',0,30,115,'69524806-0fcf-473a-9c87-55af414ed9c1','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('删除示例',3,3,'module_example:demo:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除示例','null',0,30,116,'2a506e2c-f8d4-42ae-8e41-d58a73d8ed06','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('批量修改示例状态',3,4,'module_example:demo:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改示例状态','null',0,30,117,'abb73922-f812-4a8a-aa6d-7c8c5c35cc5a','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导出示例',3,5,'module_example:demo:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出示例','null',0,30,118,'295dc769-aa81-4756-bfde-dec11fa5d55a','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('导入示例',3,6,'module_example:demo:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入示例','null',0,30,119,'2e92773b-7bbb-48cc-8027-2ff44eee148a','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('下载导入示例模版',3,7,'module_example:demo:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入示例模版','null',0,30,120,'9cbf57bd-4b9c-461f-a2cf-8e0c0785663e','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18');
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;

--
-- Table structure for table `system_notice`
--

DROP TABLE IF EXISTS `system_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notice` (
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
  KEY `ix_system_notice_created_id` (`created_id`),
  KEY `ix_system_notice_customer_id` (`customer_id`),
  KEY `ix_system_notice_tenant_id` (`tenant_id`),
  KEY `ix_system_notice_updated_id` (`updated_id`),
  CONSTRAINT `system_notice_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_notice_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_notice_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_notice_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notice`
--

/*!40000 ALTER TABLE `system_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notice` ENABLE KEYS */;

--
-- Table structure for table `system_param`
--

DROP TABLE IF EXISTS `system_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_param` (
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
-- Dumping data for table `system_param`
--

/*!40000 ALTER TABLE `system_param` DISABLE KEYS */;
INSERT INTO `system_param` VALUES ('网站名称','sys_web_title','FastApiAdmin',1,1,'1b03161b-98a4-48a6-bbe5-df0fd3ca5d8f','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('网站描述','sys_web_description','FastApiAdmin 是完全开源的权限管理系统',1,2,'8e267f32-7bf6-471a-a542-05ede0e3aff7','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('网页图标','sys_web_favicon','https://service.fastapiadmin.com/api/v1/static/image/favicon.png',1,3,'e96ec1ff-0f72-4591-b6d6-11e62a7ca775','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('网站Logo','sys_web_logo','https://service.fastapiadmin.com/api/v1/static/image/logo.png',1,4,'30823b07-b026-4cc9-ae74-74f5c65d0645','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('登录背景','sys_login_background','https://service.fastapiadmin.com/api/v1/static/image/background.svg',1,5,'e2ca1ff9-e1dd-4894-b801-32db357e7f67','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('版权信息','sys_web_copyright','Copyright © 2025-2026 service.fastapiadmin.com 版权所有',1,6,'69ac4553-e6bd-4b62-ad7e-95a095cd5058','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('备案信息','sys_keep_record','陕ICP备2025069493号-1',1,7,'d9c42f7f-cf44-497c-944e-a3edaab94889','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('帮助文档','sys_help_doc','https://service.fastapiadmin.com',1,8,'18a12d92-d5f5-4863-9c3f-9c415f58e3d7','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('隐私政策','sys_web_privacy','https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE',1,9,'541e865e-cc1a-462c-958c-5df710a9b201','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('用户协议','sys_web_clause','https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE',1,10,'e11c08e1-1a6e-4f06-9af7-0eeb5811a6c5','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('源码代码','sys_git_code','https://github.com/1014TaoTao/FastapiAdmin.git',1,11,'3e25e335-9812-45b3-8c9c-68019c6ab91b','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('项目版本','sys_web_version','2.0.0',1,12,'e06a4ec1-9469-48bf-a702-69049b06e17d','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('演示模式启用','demo_enable','false',1,13,'07d08def-44c7-475e-bd48-513a31d6845a','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('演示访问IP白名单','ip_white_list','[\"127.0.0.1\"]',1,14,'ce985efe-a9b1-4ff7-83de-5ec031b54fea','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('接口白名单','white_api_list_path','[\"/api/v1/system/auth/login\", \"/api/v1/system/auth/token/refresh\", \"/api/v1/system/auth/captcha/get\", \"/api/v1/system/auth/logout\", \"/api/v1/system/config/info\", \"/api/v1/system/user/current/info\", \"/api/v1/system/notice/available\"]',1,15,'af780363-2cd8-49e7-86bc-be32d8cb1fa3','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18'),('访问IP黑名单','ip_black_list','[]',1,16,'bb35ec7b-1ccf-4628-908d-62ca49d7203b','1','初始化数据','2025-11-24 00:54:18','2025-11-24 00:54:18');
/*!40000 ALTER TABLE `system_param` ENABLE KEYS */;

--
-- Table structure for table `system_position`
--

DROP TABLE IF EXISTS `system_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_position` (
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
  KEY `ix_system_position_created_id` (`created_id`),
  KEY `ix_system_position_updated_id` (`updated_id`),
  KEY `ix_system_position_tenant_id` (`tenant_id`),
  CONSTRAINT `system_position_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_position_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_position_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_position`
--

/*!40000 ALTER TABLE `system_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_position` ENABLE KEYS */;

--
-- Table structure for table `system_role`
--

DROP TABLE IF EXISTS `system_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role` (
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
  KEY `ix_system_role_code` (`code`),
  KEY `ix_system_role_tenant_id` (`tenant_id`),
  KEY `ix_system_role_created_id` (`created_id`),
  KEY `ix_system_role_updated_id` (`updated_id`),
  CONSTRAINT `system_role_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_role_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_role_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role`
--

/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
INSERT INTO `system_role` VALUES ('管理员角色','ADMIN',1,'4',1,'6d22552d-71c0-41c2-85e9-0d3cb0b7fde2','1','初始化角色','2025-11-24 00:54:18','2025-11-24 00:54:18',1,1,1);
/*!40000 ALTER TABLE `system_role` ENABLE KEYS */;

--
-- Table structure for table `system_role_depts`
--

DROP TABLE IF EXISTS `system_role_depts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role_depts` (
  `role_id` int NOT NULL COMMENT '角色ID',
  `dept_id` int NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `system_role_depts_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `system_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_role_depts_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `system_dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role_depts`
--

/*!40000 ALTER TABLE `system_role_depts` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_role_depts` ENABLE KEYS */;

--
-- Table structure for table `system_role_menus`
--

DROP TABLE IF EXISTS `system_role_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role_menus` (
  `role_id` int NOT NULL COMMENT '角色ID',
  `menu_id` int NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `system_role_menus_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `system_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_role_menus_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `system_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role_menus`
--

/*!40000 ALTER TABLE `system_role_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_role_menus` ENABLE KEYS */;

--
-- Table structure for table `system_tenant`
--

DROP TABLE IF EXISTS `system_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_tenant` (
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
-- Dumping data for table `system_tenant`
--

/*!40000 ALTER TABLE `system_tenant` DISABLE KEYS */;
INSERT INTO `system_tenant` VALUES ('运行管理平台','SYSTEM',NULL,NULL,1,'07f0eff6-9f68-4c4a-9b37-4445bcb8d4a0','1','系统内置租户，用于管理平台全局配置和所有租户','2025-11-24 00:54:18','2025-11-24 00:54:18');
/*!40000 ALTER TABLE `system_tenant` ENABLE KEYS */;

--
-- Table structure for table `system_user`
--

DROP TABLE IF EXISTS `system_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user` (
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
  `user_type` int NOT NULL COMMENT '用户类型(0:系统用户 1:租户用户 2:客户用户)',
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
  KEY `ix_system_user_updated_id` (`updated_id`),
  KEY `ix_system_user_tenant_id` (`tenant_id`),
  KEY `ix_system_user_created_id` (`created_id`),
  KEY `ix_system_user_customer_id` (`customer_id`),
  KEY `ix_system_user_dept_id` (`dept_id`),
  CONSTRAINT `system_user_ibfk_1` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_2` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_4` FOREIGN KEY (`dept_id`) REFERENCES `system_dept` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user`
--

/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO `system_user` VALUES ('admin','$2b$12$e2IJgS/cvHgJ0H3G7Xa08OXoXnk6N/NX3IZRtubBDElA0VLZhkNOa','超级管理员',NULL,NULL,'0','https://service.fastapiadmin.com/api/v1/static/image/avatar.png',1,'2025-11-24 01:30:40',NULL,NULL,NULL,NULL,0,'123456',1,1,'0bf97ad8-bea6-46bc-ba3c-e00eca56f5e8','1','超级管理员','2025-11-24 00:54:18','2025-11-24 01:30:40',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;

--
-- Table structure for table `system_user_positions`
--

DROP TABLE IF EXISTS `system_user_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_positions` (
  `user_id` int NOT NULL COMMENT '用户ID',
  `position_id` int NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`position_id`),
  KEY `position_id` (`position_id`),
  CONSTRAINT `system_user_positions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_user_positions_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `system_position` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user_positions`
--

/*!40000 ALTER TABLE `system_user_positions` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_user_positions` ENABLE KEYS */;

--
-- Table structure for table `system_user_roles`
--

DROP TABLE IF EXISTS `system_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_roles` (
  `user_id` int NOT NULL COMMENT '用户ID',
  `role_id` int NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `system_user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `system_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user_roles`
--

/*!40000 ALTER TABLE `system_user_roles` DISABLE KEYS */;
INSERT INTO `system_user_roles` VALUES (1,1);
/*!40000 ALTER TABLE `system_user_roles` ENABLE KEYS */;

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

-- Dump completed on 2025-11-24  1:31:50
