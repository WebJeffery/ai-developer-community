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
INSERT INTO `alembic_version` VALUES ('1fd8807b07f2');
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
  KEY `ix_app_ai_mcp_customer_id` (`customer_id`),
  KEY `ix_app_ai_mcp_created_id` (`created_id`),
  KEY `ix_app_ai_mcp_updated_id` (`updated_id`),
  KEY `ix_app_ai_mcp_tenant_id` (`tenant_id`),
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
  KEY `ix_app_job_customer_id` (`customer_id`),
  KEY `ix_app_job_created_id` (`created_id`),
  KEY `ix_app_job_updated_id` (`updated_id`),
  KEY `ix_app_job_tenant_id` (`tenant_id`),
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
  CONSTRAINT `app_job_log_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  KEY `ix_app_myapp_created_id` (`created_id`),
  KEY `ix_app_myapp_customer_id` (`customer_id`),
  KEY `ix_app_myapp_tenant_id` (`tenant_id`),
  KEY `ix_app_myapp_updated_id` (`updated_id`),
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
  KEY `ix_gen_demo_tenant_id` (`tenant_id`),
  KEY `ix_gen_demo_customer_id` (`customer_id`),
  KEY `ix_gen_demo_created_id` (`created_id`),
  KEY `ix_gen_demo_updated_id` (`updated_id`),
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
  KEY `ix_gen_table_created_id` (`created_id`),
  KEY `ix_gen_table_updated_id` (`updated_id`),
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
  KEY `ix_system_customer_code` (`code`),
  KEY `ix_system_customer_updated_id` (`updated_id`),
  KEY `ix_system_customer_created_id` (`created_id`),
  KEY `ix_system_customer_tenant_id` (`tenant_id`),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dept`
--

/*!40000 ALTER TABLE `system_dept` DISABLE KEYS */;
INSERT INTO `system_dept` VALUES ('集团总公司',1,'GROUP','部门负责人','1582112620','deptadmin@example.com',NULL,1,'4d5fc4b6-d4d6-46e0-9385-9b31e671b653','1','集团总公司','2025-11-26 00:13:01','2025-11-26 00:13:01',1);
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
  CONSTRAINT `system_dict_data_ibfk_1` FOREIGN KEY (`dict_type_id`) REFERENCES `system_dict_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dict_data`
--

/*!40000 ALTER TABLE `system_dict_data` DISABLE KEYS */;
INSERT INTO `system_dict_data` VALUES (1,'男','0','blue',NULL,1,'sys_user_sex',1,1,'f971ecb7-d7f2-46d1-889d-bdd16e379ccf','1','性别男','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'女','1','pink',NULL,0,'sys_user_sex',1,2,'654977b2-610d-467f-af7d-bc54dd88b0bf','1','性别女','2025-11-26 00:13:01','2025-11-26 00:13:01'),(3,'未知','2','red',NULL,0,'sys_user_sex',1,3,'f315059e-a05e-4535-af41-4f57f9e94bd5','1','性别未知','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'是','1','','primary',1,'sys_yes_no',2,4,'08bb24cb-7d3d-4f5c-b728-b71aaca58581','1','是','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'否','0','','danger',0,'sys_yes_no',2,5,'9d1bc4c6-55d3-4413-b7ae-88793a1c53f0','1','否','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'启用','1','','primary',0,'sys_common_status',3,6,'75ecb40e-75a7-47c9-aea4-14798c89e9ce','1','启用状态','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'停用','0','','danger',0,'sys_common_status',3,7,'b2212c63-bce7-43bc-b879-c01ed4f9cbc2','1','停用状态','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'通知','1','blue','warning',1,'sys_notice_type',4,8,'1ca16ce1-39a2-4ce1-98c1-5ef84ada3820','1','通知','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'公告','2','orange','success',0,'sys_notice_type',4,9,'136c9f3f-bb7c-45ff-926a-5c6a6ae3d3b7','1','公告','2025-11-26 00:13:01','2025-11-26 00:13:01'),(99,'其他','0','','info',0,'sys_oper_type',5,10,'369b752a-94d8-41bb-9bbe-b040b8908605','1','其他操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'新增','1','','info',0,'sys_oper_type',5,11,'c89aeaf5-f6be-40e6-8942-aeb8fe1860cb','1','新增操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'修改','2','','info',0,'sys_oper_type',5,12,'cbbcb3a2-8b50-434b-a0d9-b13bf44ac907','1','修改操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(3,'删除','3','','danger',0,'sys_oper_type',5,13,'5bd72c41-222a-4076-bdd0-a71bfd3fca0a','1','删除操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(4,'分配权限','4','','primary',0,'sys_oper_type',5,14,'9233a21f-0b02-4dfb-b5a5-ba6fddd94c52','1','授权操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(5,'导出','5','','warning',0,'sys_oper_type',5,15,'df6e840c-b7f1-4b54-9bfd-5dc7671763d0','1','导出操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(6,'导入','6','','warning',0,'sys_oper_type',5,16,'a57f1bae-e7fe-4105-94f3-23adc7e4685d','1','导入操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(7,'强退','7','','danger',0,'sys_oper_type',5,17,'1c038fb2-f11c-47fd-8d4c-65ee7d798d6e','1','强退操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(8,'生成代码','8','','warning',0,'sys_oper_type',5,18,'e31b2f1c-14ee-4501-a328-6473390dda77','1','生成操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(9,'清空数据','9','','danger',0,'sys_oper_type',5,19,'39bc43b6-2877-4bf6-b7c9-da99e6082488','1','清空操作','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'默认(Memory)','default','',NULL,1,'sys_job_store',6,20,'aabf1aff-f2b3-48e1-80cc-2159c6f79e20','1','默认分组','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'数据库(Sqlalchemy)','sqlalchemy','',NULL,0,'sys_job_store',6,21,'ea64d004-6107-4339-81bf-a8ed576f3416','1','数据库分组','2025-11-26 00:13:01','2025-11-26 00:13:01'),(3,'数据库(Redis)','redis','',NULL,0,'sys_job_store',6,22,'520aed30-6048-44f4-98ab-b8dac059f5e4','1','reids分组','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'线程池','default','',NULL,0,'sys_job_executor',7,23,'0fe384dd-e1dd-4d52-ac74-dca57d5b19d3','1','线程池','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'进程池','processpool','',NULL,0,'sys_job_executor',7,24,'6af10e35-bb7c-414e-b4d1-8b20af3b225a','1','进程池','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'演示函数','scheduler_test.job','',NULL,1,'sys_job_function',8,25,'e5b896c7-d654-4300-a7eb-6a2d2c388e21','1','演示函数','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'指定日期(date)','date','',NULL,1,'sys_job_trigger',9,26,'a9a1d8a2-5377-432d-aabb-1d61fa9771db','1','指定日期任务触发器','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'间隔触发器(interval)','interval','',NULL,0,'sys_job_trigger',9,27,'9b2ce6d5-194b-46bd-be4c-06a9bca38943','1','间隔触发器任务触发器','2025-11-26 00:13:01','2025-11-26 00:13:01'),(3,'cron表达式','cron','',NULL,0,'sys_job_trigger',9,28,'dcbb5589-da75-4274-8dad-ac1c5b6ff5ae','1','间隔触发器任务触发器','2025-11-26 00:13:01','2025-11-26 00:13:01'),(1,'默认(default)','default','',NULL,1,'sys_list_class',10,29,'abd5e802-488d-4ca2-9b70-1e4b3b36eed4','1','默认表格回显样式','2025-11-26 00:13:01','2025-11-26 00:13:01'),(2,'主要(primary)','primary','',NULL,0,'sys_list_class',10,30,'3edc91b7-5682-4cc7-a11f-4c25f0e08e84','1','主要表格回显样式','2025-11-26 00:13:01','2025-11-26 00:13:01'),(3,'成功(success)','success','',NULL,0,'sys_list_class',10,31,'3b4d7b89-ba30-404c-b628-e8cb930672cb','1','成功表格回显样式','2025-11-26 00:13:01','2025-11-26 00:13:01'),(4,'信息(info)','info','',NULL,0,'sys_list_class',10,32,'0667b4f1-28a4-4246-8956-09f87aed138d','1','信息表格回显样式','2025-11-26 00:13:01','2025-11-26 00:13:01'),(5,'警告(warning)','warning','',NULL,0,'sys_list_class',10,33,'0779009c-a967-4eae-bcb8-743af4cdf928','1','警告表格回显样式','2025-11-26 00:13:01','2025-11-26 00:13:01'),(6,'危险(danger)','danger','',NULL,0,'sys_list_class',10,34,'77fe6b6f-cb3a-41b0-b227-954e15b5dca3','1','危险表格回显样式','2025-11-26 00:13:01','2025-11-26 00:13:01');
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
  UNIQUE KEY `dict_type` (`dict_type`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dict_type`
--

/*!40000 ALTER TABLE `system_dict_type` DISABLE KEYS */;
INSERT INTO `system_dict_type` VALUES ('用户性别','sys_user_sex',1,'b0a01f2c-9522-49fc-807b-91a143008932','1','用户性别列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('系统是否','sys_yes_no',2,'be27d7dd-ce8b-4aee-8fe9-17fa0c1ca5b5','1','系统是否列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('系统状态','sys_common_status',3,'09e13ee6-df58-44b2-be1e-4503b7071b1f','1','系统状态','2025-11-26 00:13:01','2025-11-26 00:13:01'),('通知类型','sys_notice_type',4,'9ed50852-3d84-4bd6-a989-383bcded0849','1','通知类型列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('操作类型','sys_oper_type',5,'2f8246c1-6208-49a1-8fbd-e34a710e2bf0','1','操作类型列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('任务存储器','sys_job_store',6,'922f4b8f-16ce-40a9-b269-05f776ed029f','1','任务分组列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('任务执行器','sys_job_executor',7,'8d31812b-7277-4837-8cf5-5cab4b88b751','1','任务执行器列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('任务函数','sys_job_function',8,'76a865aa-3895-40dc-a349-79fdc917a97b','1','任务函数列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('任务触发器','sys_job_trigger',9,'9ace68b0-fbc9-4ca8-910b-164f6af8080a','1','任务触发器列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('表格回显样式','sys_list_class',10,'01dc2581-5e58-4838-933b-159344704646','1','表格回显样式列表','2025-11-26 00:13:01','2025-11-26 00:13:01');
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
INSERT INTO `system_menu` VALUES ('仪表盘',1,1,'','client','Dashboard','/dashboard',NULL,'/dashboard/workplace',0,1,1,'仪表盘','null',0,NULL,1,'be608c73-a954-4f07-ad92-8c5336cbffc7','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('系统管理',1,2,NULL,'system','System','/system',NULL,'/system/menu',0,1,0,'系统管理','null',0,NULL,2,'3437a613-d361-4715-be45-4ef0c416b794','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('应用管理',1,3,NULL,'el-icon-ShoppingBag','Application','/application',NULL,'/application/myapp',0,0,0,'应用管理','null',0,NULL,3,'31ef40c2-e048-4746-99e4-f35523213616','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('监控管理',1,4,NULL,'monitor','Monitor','/monitor',NULL,'/monitor/online',0,0,0,'监控管理','null',0,NULL,4,'129780ba-a598-4e8b-ae0b-9a621f5d4c4f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('代码管理',1,5,NULL,'code','Gencode','/gencode',NULL,'/gencode/backcode',0,0,0,'代码管理','null',0,NULL,5,'f9799323-9de0-4a62-8db5-41194500447d','1','代码管理','2025-11-26 00:13:01','2025-11-26 00:13:01'),('接口管理',1,6,NULL,'document','Common','/common',NULL,'/common/docs',0,0,0,'接口管理','null',0,NULL,6,'384b7ed8-d800-4d50-8f73-047a300f0d3b','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('案例管理',1,7,NULL,'el-icon-ElementPlus','Example','/example',NULL,'/example/demo',0,0,0,'案例管理','null',0,NULL,7,'e1c103d9-70e3-4ae4-b453-278c8682eda4','1','案例管理','2025-11-26 00:13:01','2025-11-26 00:13:01'),('工作台',2,1,'dashboard:workplace:query','el-icon-PieChart','Workplace','/dashboard/workplace','dashboard/workplace',NULL,0,1,0,'工作台','null',0,1,8,'1f0ebcad-d239-46c9-8b61-e4cff22dfd9f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('菜单管理',2,1,'module_system:menu:query','menu','Menu','/system/menu','module_system/menu/index',NULL,0,1,0,'菜单管理','null',0,2,9,'a95bffe1-6b32-444d-833a-d090a2b900c7','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('租户管理',2,3,'module_system:tenant:query','el-icon-Avatar','Tenant','/system/tenant','module_system/tenant/index',NULL,0,1,0,'租户管理','null',0,2,10,'d1821fa1-cefc-4aac-9a83-8ef6fe3e327f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('部门管理',2,2,'module_system:dept:query','tree','Dept','/system/dept','module_system/dept/index',NULL,0,1,0,'部门管理','null',0,2,11,'881c22ca-f4f9-4e6f-a147-774007bf68de','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('岗位管理',2,3,'module_system:position:query','el-icon-Coordinate','Position','/system/position','module_system/position/index',NULL,0,1,0,'岗位管理','null',0,2,12,'848693dc-be9b-4cce-a8fd-a1cc7344365a','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('角色管理',2,4,'module_system:role:query','role','Role','/system/role','module_system/role/index',NULL,0,1,0,'角色管理','null',0,2,13,'4d51685f-65fd-4e37-b46b-5531d2aa1736','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('用户管理',2,5,'module_system:user:query','el-icon-User','User','/system/user','module_system/user/index',NULL,0,1,0,'用户管理','null',0,2,14,'b74229ad-94cc-4f8b-af97-7a8e9c4029f6','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('日志管理',2,6,'module_system:log:query','el-icon-Aim','Log','/system/log','module_system/log/index',NULL,0,1,0,'日志管理','null',0,2,15,'575465af-329b-478f-b1f5-4794027600ca','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('公告管理',2,7,'module_system:notice:query','bell','Notice','/system/notice','module_system/notice/index',NULL,0,1,0,'公告管理','null',0,2,16,'75f34f9e-09e5-47c9-9661-ba53725d29c0','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('参数管理',2,8,'module_system:param:query','setting','Params','/system/param','module_system/param/index',NULL,0,1,0,'参数管理','null',0,2,17,'5786d30d-7989-44fb-be4e-d9acd15ff21d','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('字典管理',2,9,'module_system:dict_type:query','dict','Dict','/system/dict','module_system/dict/index',NULL,0,1,0,'字典管理','null',0,2,18,'bf7cbe60-c0c8-4b30-ac6d-5cc0db6e2953','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('我的应用',2,1,'module_application:myapp:query','el-icon-ShoppingCartFull','MYAPP','/application/myapp','module_application/myapp/index',NULL,0,1,0,'我的应用','null',0,3,19,'4163fdcb-d2fe-468a-8f19-70265758c124','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('任务管理',2,2,'module_application:job:query','el-icon-DataLine','Job','/application/job','module_application/job/index',NULL,0,1,0,'任务管理','null',0,3,20,'540c266d-cb4b-470f-8dc4-5aab964dbaa5','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('AI智能助手',2,3,'module_application:ai:chat','el-icon-ToiletPaper','AI','/application/ai','module_application/ai/index',NULL,0,1,0,'AI智能助手','null',0,3,21,'99125b62-682e-49f4-bfac-022fa0d674aa','1','AI智能助手','2025-11-26 00:13:01','2025-11-26 00:13:01'),('流程管理',2,4,'module_application:workflow:query','el-icon-ShoppingBag','Workflow','/application/workflow','module_application/workflow/index',NULL,0,1,0,'我的流程','null',0,3,22,'a5ae686d-be38-4fed-86e1-2a2965e69f41','1','我的流程','2025-11-26 00:13:01','2025-11-26 00:13:01'),('在线用户',2,1,'module_monitor:online:query','el-icon-Headset','MonitorOnline','/monitor/online','module_monitor/online/index',NULL,0,0,0,'在线用户','null',0,4,23,'2f11bf45-4903-4c05-87e4-a024c7e4f22f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('服务器监控',2,2,'module_monitor:server:query','el-icon-Odometer','MonitorServer','/monitor/server','module_monitor/server/index',NULL,0,0,0,'服务器监控','null',0,4,24,'69ce08d8-63a0-433c-8a07-364d281f7c7a','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('缓存监控',2,3,'module_monitor:cache:query','el-icon-Stopwatch','MonitorCache','/monitor/cache','module_monitor/cache/index',NULL,0,0,0,'缓存监控','null',0,4,25,'6a45334b-80fa-4661-8bf1-da28abeae6d2','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件管理',2,4,'module_monitor:resource:query','el-icon-Files','Resource','/monitor/resource','module_monitor/resource/index',NULL,0,1,0,'文件管理','null',0,4,26,'1a14bff6-ea70-49bc-80b7-38fe7ba00767','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('代码生成',2,1,'module_generator:gencode:query','code','Backcode','/gencode/backcode','module_generator/backcode/index',NULL,0,1,0,'代码生成','null',0,5,27,'662b5941-9375-4c6d-af03-2d53dabfc5b4','1','代码生成','2025-11-26 00:13:01','2025-11-26 00:13:01'),('Swagger文档',4,1,'module_common:docs:query','api','Docs','/common/docs','module_common/docs/index',NULL,0,0,0,'Swagger文档','null',0,6,28,'6b6a571a-1abd-4ded-8921-1a6a88244c24','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('Redoc文档',4,2,'module_common:redoc:query','el-icon-Document','Redoc','/common/redoc','module_common/redoc/index',NULL,0,0,0,'Redoc文档','null',0,6,29,'09807c8d-599c-4215-8b29-0c6d7cd814f4','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('示例管理',2,1,'module_example:demo:query','el-icon-ElementPlus','Demo','/example/demo','module_example/demo/index',NULL,0,1,0,'示例管理','null',0,7,30,'33aedf02-9057-4d27-aa6e-69ab32fc3287','1','示例管理','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建菜单',3,1,'module_system:menu:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建菜单','null',0,9,31,'5f15d843-745a-472a-acb9-c457df4d732c','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改菜单',3,2,'module_system:menu:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改菜单','null',0,9,32,'b41d8165-3dd3-44f5-85f4-cedece271a80','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除菜单',3,3,'module_system:menu:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除菜单','null',0,9,33,'d8d48d04-e5a2-40ad-abdf-8c6d8f874e6b','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改菜单状态',3,4,'module_system:menu:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改菜单状态','null',0,9,34,'c6be8111-a75b-4696-88c9-ed529e46da57','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建租户',3,1,'module_system:tenant:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建租户','null',0,10,35,'ce89f65d-d4b5-42c7-849d-414db24cf669','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('更新租户',3,2,'module_system:tenant:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新租户','null',0,10,36,'793a2b16-3ecd-465e-abf5-f9373ab5bcbc','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除租户',3,3,'module_system:tenant:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除租户','null',0,10,37,'b83be309-0b66-46a1-b7f8-7cd85920eaec','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改租户状态',3,4,'module_system:tenant:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改租户状态','null',0,10,38,'7eccc8e2-e222-4e9a-89e1-927d76142751','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出租户',3,5,'module_system:tenant:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出租户','null',0,10,39,'1230e603-767e-4e1f-b6c6-67754f3599b5','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导入租户',3,6,'module_system:tenant:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入租户','null',0,10,40,'0246b01f-b2d9-4440-8c3c-cf5f41602482','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('下载导入租户模版',3,7,'module_system:tenant:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入租户模版','null',0,10,41,'a02bdc32-a7b7-4a81-9b41-fad832ae8fc9','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建部门',3,1,'module_system:dept:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建部门','null',0,11,42,'529f3d8b-c30c-41ad-b1a1-ecb43a8e74f4','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改部门',3,2,'module_system:dept:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改部门','null',0,11,43,'f03f964b-3a47-4760-8c8e-0803188ceaeb','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除部门',3,3,'module_system:dept:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除部门','null',0,11,44,'d8ec8d7e-9da5-46ac-94c5-5ae3f5569eeb','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改部门状态',3,4,'module_system:dept:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改部门状态','null',0,11,45,'f7b0eecf-968a-464c-a58f-daa218134809','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建岗位',3,1,'module_system:position:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建岗位','null',0,12,46,'ed2bfd48-78ac-4b36-a405-6e5970de8468','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改岗位',3,2,'module_system:position:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改岗位','null',0,12,47,'da35dbc6-d214-444c-a028-828624da6245','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除岗位',3,3,'module_system:position:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改岗位','null',0,12,48,'b6dfd3ec-7873-4943-9f55-91ad4a770ea2','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改岗位状态',3,4,'module_system:position:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改岗位状态','null',0,12,49,'c44a0c05-e5e0-4b02-9719-6d08fd4c1a4f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('岗位导出',3,5,'module_system:position:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'岗位导出','null',0,12,50,'9da2388b-bd65-4cda-972c-f368fa4a135a','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('设置角色权限',3,8,'module_system:role:permission',NULL,NULL,NULL,NULL,NULL,0,1,0,'设置角色权限','null',0,12,51,'05008380-f60e-4a75-8aef-90ffc3ecda1b','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建角色',3,1,'module_system:role:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建角色','null',0,13,52,'40fe979c-2b28-4b0c-881f-73522a14916e','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改角色',3,2,'module_system:role:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改角色','null',0,13,53,'ec1c84ad-8bc9-49c2-aa65-1ddd82002583','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除角色',3,3,'module_system:role:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除角色','null',0,13,54,'38132f18-3d9f-48b1-a529-a45c2a91dcc9','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改角色状态',3,4,'module_system:role:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改角色状态','null',0,13,55,'e10adfa4-698c-4474-82c7-741d1f1daa23','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('角色导出',3,6,'module_system:role:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'角色导出','null',0,13,56,'c0f46d99-10ac-4b6b-bcf6-0c62c1333ec4','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建用户',3,1,'module_system:user:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建用户','null',0,14,57,'b9d9ff17-2f75-4fa4-94fe-292526c7d3c4','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改用户',3,2,'module_system:user:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改用户','null',0,14,58,'7af3c17d-e3d0-426e-9982-af08a7779041','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除用户',3,3,'module_system:user:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除用户','null',0,14,59,'affd0e24-0282-4ad2-9be2-5db80cbf3c11','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改用户状态',3,4,'module_system:user:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改用户状态','null',0,14,60,'c549893d-2516-4e6e-9a8c-a34859abea82','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出用户',3,5,'module_system:user:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出用户','null',0,14,61,'1e62f561-12b3-4d3e-b41b-bfee3c23e276','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导入用户',3,6,'module_system:user:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入用户','null',0,14,62,'fb682540-3abc-4ea2-87f0-ddb5d49a8f1d','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('日志删除',3,1,'module_system:log:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'日志删除','null',0,15,63,'2fb4feaf-3426-41bf-ad8b-5c6a94a69a3a','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('日志导出',3,2,'module_system:log:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'日志导出','null',0,15,64,'38394a93-399a-4260-bb15-bf7633d110a7','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('公告创建',3,1,'module_system:notice:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告创建','null',0,16,65,'172ba16d-72dc-46ef-8df1-ba41bf20c74d','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('公告修改',3,2,'module_system:notice:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改用户','null',0,16,66,'f15bfe37-3d08-43fb-a65f-886d8b693d89','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('公告删除',3,3,'module_system:notice:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告删除','null',0,16,67,'44e36104-71d9-46d3-a333-673b15879336','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('公告导出',3,4,'module_system:notice:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告导出','null',0,16,68,'465bea46-c465-48dc-b5be-ea13533c2fef','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('公告批量修改状态',3,5,'module_system:notice:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'公告批量修改状态','null',0,16,69,'328ce47a-ebb0-4a77-b6b5-229ce485e164','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建参数',3,1,'module_system:param:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建参数','null',0,17,70,'ff3a2152-8694-41c5-872b-c9f27d813db8','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改参数',3,2,'module_system:param:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改参数','null',0,17,71,'b88b6fb0-19de-4876-ba83-e6c040ac3063','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除参数',3,3,'module_system:param:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除参数','null',0,17,72,'52ce1158-068c-4e6c-b09e-12dc270cdea2','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出参数',3,4,'module_system:param:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出参数','null',0,17,73,'d234f95c-9af2-4933-8cd1-4b44b87cfc68','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('参数上传',3,5,'module_system:param:upload',NULL,NULL,NULL,NULL,NULL,0,1,0,'参数上传','null',0,17,74,'50f2512e-cc61-4e2c-a439-5d1d6fc197f1','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建字典类型',3,1,'module_system:dict_type:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建字典类型','null',0,18,75,'0e058494-b6d7-4dbd-a4e9-00bb0756d909','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改字典类型',3,2,'module_system:dict_type:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改字典类型','null',0,18,76,'701cd37c-f906-4c44-a8c6-04c11a4c41d5','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除字典类型',3,3,'module_system:dict_type:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除字典类型','null',0,18,77,'d2977f10-e4c9-47dd-a7ed-21fc82284a73','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出字典类型',3,4,'module_system:dict_type:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典类型','null',0,18,78,'aecff719-382e-4035-98f4-d51ad80ac0d9','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改字典状态',3,5,'module_system:dict_type:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典类型','null',0,18,79,'1a4b586a-a66f-4ea4-8bfc-eacea582d9c3','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('字典数据查询',3,6,'module_system:dict_data:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'字典数据查询','null',0,18,80,'d906cad4-160f-43b1-b33c-074f23b9233f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建字典数据',3,7,'module_system:dict_data:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建字典数据','null',0,18,81,'01ae8fc8-265b-4ec7-a827-a2a0c3ebcc1a','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改字典数据',3,8,'module_system:dict_data:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改字典数据','null',0,18,82,'219ff926-4f47-4390-b31b-f0f382ff24eb','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除字典数据',3,9,'module_system:dict_data:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除字典数据','null',0,18,83,'791e6777-8c54-43a6-a168-5fdadb24ee75','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出字典数据',3,10,'module_system:dict_data:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出字典数据','null',0,18,84,'7350c4d3-b8c7-4e16-b75f-56c6c350c69a','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改字典数据状态',3,11,'module_system:dict_data:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改字典数据状态','null',0,18,85,'d761c1dd-2c11-415c-b72d-c8c7f71340be','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建应用',3,1,'module_application:myapp:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建应用','null',0,19,86,'c63e68c2-cc38-4e48-9717-527ec8f58148','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改应用',3,2,'module_application:myapp:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改应用','null',0,19,87,'8c83fdc7-5e65-48f0-8932-5f747123d3ab','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除应用',3,3,'module_application:myapp:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除应用','null',0,19,88,'8cc95e1d-80ae-490b-ad26-af27d529b149','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改应用状态',3,4,'module_application:myapp:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改应用状态','null',0,19,89,'abb9e3e0-b78e-483f-a32b-45bf97993f52','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建任务',3,1,'module_application:job:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建任务','null',0,20,90,'e3b7f406-089a-4d07-930f-ff2de4c11d7e','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('修改和操作任务',3,2,'module_application:job:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'修改和操作任务','null',0,20,91,'df3d8152-0091-41ad-854a-66edce7da230','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除和清除任务',3,3,'module_application:job:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除和清除任务','null',0,20,92,'a95b6dd0-7ba5-4c23-b851-f19c7dbe0f52','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出定时任务',3,4,'module_application:job:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出定时任务','null',0,20,93,'5e739bd6-c2be-4a5a-8116-cce68b059e05','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('智能对话',3,1,'module_application:ai:chat',NULL,NULL,NULL,NULL,NULL,0,1,0,'智能对话','null',0,21,94,'81cd5b88-971f-4dd5-9ccd-ebbe463722fe','1','智能对话','2025-11-26 00:13:01','2025-11-26 00:13:01'),('在线用户强制下线',3,1,'module_monitor:online:delete',NULL,NULL,NULL,NULL,NULL,0,0,0,'在线用户强制下线','null',0,23,95,'11ffe941-d2b8-45c9-a04f-8d0f7c1eab6d','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('清除缓存',3,1,'module_monitor:cache:delete',NULL,NULL,NULL,NULL,NULL,0,0,0,'清除缓存','null',0,25,96,'9f3cc6f4-7b89-468c-b49c-41788de368c7','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件上传',3,1,'module_monitor:resource:upload',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件上传','null',0,26,97,'02656ff4-043d-4c08-a29b-e84b60d470b5','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件下载',3,2,'module_monitor:resource:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件下载','null',0,26,98,'e4199f66-1425-4c3a-ad0f-2c8cbae91c94','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件删除',3,3,'module_monitor:resource:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件删除','null',0,26,99,'82470ab5-449b-495c-96c1-6ebe423e00ce','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件移动',3,4,'module_monitor:resource:move',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件移动','null',0,26,100,'29907d7b-6ad5-4745-9425-69c72d0e38db','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件复制',3,5,'module_monitor:resource:copy',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件复制','null',0,26,101,'a3512787-5ea5-4144-819f-19500ee7858f','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('文件重命名',3,6,'module_monitor:resource:rename',NULL,NULL,NULL,NULL,NULL,0,1,0,'文件重命名','null',0,26,102,'48b40bcc-c00d-46ed-a905-8aea4792d0ae','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建目录',3,7,'module_monitor:resource:create_dir',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建目录','null',0,26,103,'f9a94421-019d-4057-ba0a-1daebb741be9','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出文件列表',3,9,'module_monitor:resource:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出文件列表','null',0,26,104,'d629abd8-e7d3-48d6-b5a0-4294b21df9eb','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('查询代码生成业务表列表',3,1,'module_generator:gencode:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'查询代码生成业务表列表','null',0,27,105,'19a81561-15aa-425e-a551-b4dddeea70f8','1','查询代码生成业务表列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建表结构',3,2,'module_generator:gencode:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建表结构','null',0,27,106,'381ec268-1e08-4bcf-b3d9-16e3cdcb41ff','1','创建表结构','2025-11-26 00:13:01','2025-11-26 00:13:01'),('编辑业务表信息',3,3,'module_generator:gencode:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'编辑业务表信息','null',0,27,107,'f18a07f0-c8fe-4a70-8a68-38e464003342','1','编辑业务表信息','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除业务表信息',3,4,'module_generator:gencode:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除业务表信息','null',0,27,108,'1cfe0e67-4787-4f14-937c-515a3fd85837','1','删除业务表信息','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导入表结构',3,5,'module_generator:gencode:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入表结构','null',0,27,109,'21036bb8-b9a0-4a67-bded-cd27be4b8318','1','导入表结构','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量生成代码',3,6,'module_generator:gencode:operate',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量生成代码','null',0,27,110,'d11a5839-96aa-40cf-91a5-54fe8297fcfc','1','批量生成代码','2025-11-26 00:13:01','2025-11-26 00:13:01'),('生成代码到指定路径',3,7,'module_generator:gencode:code',NULL,NULL,NULL,NULL,NULL,0,1,0,'生成代码到指定路径','null',0,27,111,'979e8091-11fc-42c8-bc78-32ca85d03cef','1','生成代码到指定路径','2025-11-26 00:13:01','2025-11-26 00:13:01'),('查询数据库表列表',3,8,'module_generator:dblist:query',NULL,NULL,NULL,NULL,NULL,0,1,0,'查询数据库表列表','null',0,27,112,'92289f17-aa68-471e-8ebd-9648d9ad470c','1','查询数据库表列表','2025-11-26 00:13:01','2025-11-26 00:13:01'),('同步数据库',3,9,'module_generator:db:sync',NULL,NULL,NULL,NULL,NULL,0,1,0,'同步数据库','null',0,27,113,'7cbe4b99-4442-4452-97fe-d37e1d629265','1','同步数据库','2025-11-26 00:13:01','2025-11-26 00:13:01'),('创建示例',3,1,'module_example:demo:create',NULL,NULL,NULL,NULL,NULL,0,1,0,'创建示例','null',0,30,114,'7b239f75-2a8b-4f09-be3f-c6620730c864','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('更新示例',3,2,'module_example:demo:update',NULL,NULL,NULL,NULL,NULL,0,1,0,'更新示例','null',0,30,115,'2d397702-cf22-4ee0-9a55-e68e87d25f1c','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('删除示例',3,3,'module_example:demo:delete',NULL,NULL,NULL,NULL,NULL,0,1,0,'删除示例','null',0,30,116,'c7d6e0b3-d70f-491b-9c79-221999182f2e','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('批量修改示例状态',3,4,'module_example:demo:patch',NULL,NULL,NULL,NULL,NULL,0,1,0,'批量修改示例状态','null',0,30,117,'066f47d5-cd0b-4c11-91d8-b157490b5f60','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导出示例',3,5,'module_example:demo:export',NULL,NULL,NULL,NULL,NULL,0,1,0,'导出示例','null',0,30,118,'a42e9275-5e14-4fec-a1d1-3dac7ff9af51','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('导入示例',3,6,'module_example:demo:import',NULL,NULL,NULL,NULL,NULL,0,1,0,'导入示例','null',0,30,119,'f63cc07c-1bad-4a21-a8dd-94f913e7e4de','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('下载导入示例模版',3,7,'module_example:demo:download',NULL,NULL,NULL,NULL,NULL,0,1,0,'下载导入示例模版','null',0,30,120,'c306f3b1-5af2-45ee-ba9c-ac84fbfd2d32','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01');
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
  `customer_id` int DEFAULT NULL COMMENT '所属客户ID(NULL表示租户级数据,>0表示客户级数据)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_system_notice_customer_id` (`customer_id`),
  KEY `ix_system_notice_created_id` (`created_id`),
  KEY `ix_system_notice_updated_id` (`updated_id`),
  KEY `ix_system_notice_tenant_id` (`tenant_id`),
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
INSERT INTO `system_param` VALUES ('网站名称','sys_web_title','FastApiAdmin',1,1,'00e92a69-8467-45c7-a877-f12de7dd3ecb','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('网站描述','sys_web_description','FastApiAdmin 是完全开源的权限管理系统',1,2,'0d8dfde4-038d-425d-b45f-4ac7482dd7a6','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('网页图标','sys_web_favicon','https://service.fastapiadmin.com/api/v1/static/image/favicon.png',1,3,'3ebd7e2a-3863-47ba-aa92-d1f9cf587fb9','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('网站Logo','sys_web_logo','https://service.fastapiadmin.com/api/v1/static/image/logo.png',1,4,'9e2faf69-f19c-440e-8e0e-bbd27213c933','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('登录背景','sys_login_background','https://service.fastapiadmin.com/api/v1/static/image/background.svg',1,5,'098f38d4-ef2d-42ca-93e1-6b2a492f5380','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('版权信息','sys_web_copyright','Copyright © 2025-2026 service.fastapiadmin.com 版权所有',1,6,'0b42e5ca-7106-4cee-8da9-414bc2449b76','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('备案信息','sys_keep_record','陕ICP备2025069493号-1',1,7,'2a4cd724-d8cb-446c-b3cd-4a57067bcc0c','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('帮助文档','sys_help_doc','https://service.fastapiadmin.com',1,8,'798b0745-93db-40ca-8e20-053230eedfb1','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('隐私政策','sys_web_privacy','https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE',1,9,'b382ff13-94cb-40de-b24e-e9bf2bf0a7ab','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('用户协议','sys_web_clause','https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE',1,10,'97d18541-be2b-42d8-a756-750217a263a3','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('源码代码','sys_git_code','https://github.com/1014TaoTao/FastapiAdmin.git',1,11,'1b57a1e8-cfa2-43b7-b73e-ee9d4725292b','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('项目版本','sys_web_version','2.0.0',1,12,'f38fea6b-9654-4a07-807a-722fac77d6fc','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('演示模式启用','demo_enable','false',1,13,'7598232c-f686-413d-a10c-32ba697c51a4','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('演示访问IP白名单','ip_white_list','[\"127.0.0.1\"]',1,14,'e669aec4-7fbb-45f9-b325-fa321bdb5092','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('接口白名单','white_api_list_path','[\"/api/v1/system/auth/login\", \"/api/v1/system/auth/token/refresh\", \"/api/v1/system/auth/captcha/get\", \"/api/v1/system/auth/logout\", \"/api/v1/system/config/info\", \"/api/v1/system/user/current/info\", \"/api/v1/system/notice/available\"]',1,15,'06d1858a-3d4d-4218-9b6a-ef762c22ffdc','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01'),('访问IP黑名单','ip_black_list','[]',1,16,'d69a10ba-ea3d-4777-9951-0966c4a902ad','1','初始化数据','2025-11-26 00:13:01','2025-11-26 00:13:01');
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
  KEY `ix_system_position_tenant_id` (`tenant_id`),
  KEY `ix_system_position_created_id` (`created_id`),
  KEY `ix_system_position_updated_id` (`updated_id`),
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
  KEY `ix_system_role_created_id` (`created_id`),
  KEY `ix_system_role_updated_id` (`updated_id`),
  KEY `ix_system_role_tenant_id` (`tenant_id`),
  CONSTRAINT `system_role_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_role_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_role_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role`
--

/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
INSERT INTO `system_role` VALUES ('管理员角色','ADMIN',1,'4',1,'779babba-5847-493f-8eff-c2c79e2dd01f','1','初始化角色','2025-11-26 00:13:01','2025-11-26 00:13:01',1,1,1);
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
  `max_user_count` int NOT NULL COMMENT '最大用户数量限制',
  `enable_quota_limit` tinyint(1) NOT NULL COMMENT '是否启用配额限制',
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
INSERT INTO `system_tenant` VALUES ('运行管理平台','SYSTEM',NULL,NULL,100,1,1,'28ece3f1-e054-48b4-a56f-17b7f81487f5','1','系统内置租户，用于管理平台全局配置和所有租户','2025-11-26 00:13:01','2025-11-26 00:13:01');
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
  KEY `ix_system_user_customer_id` (`customer_id`),
  KEY `ix_system_user_tenant_id` (`tenant_id`),
  KEY `ix_system_user_updated_id` (`updated_id`),
  KEY `ix_system_user_dept_id` (`dept_id`),
  KEY `ix_system_user_created_id` (`created_id`),
  CONSTRAINT `system_user_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `system_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `system_tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_4` FOREIGN KEY (`dept_id`) REFERENCES `system_dept` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `system_user_ibfk_5` FOREIGN KEY (`created_id`) REFERENCES `system_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user`
--

/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO `system_user` VALUES ('admin','$2b$12$e2IJgS/cvHgJ0H3G7Xa08OXoXnk6N/NX3IZRtubBDElA0VLZhkNOa','超级管理员',NULL,NULL,'0','https://service.fastapiadmin.com/api/v1/static/image/avatar.png',1,NULL,NULL,NULL,NULL,NULL,'0','123456',1,1,'fb1bce20-fc36-408d-ac14-a86929d21420','1','超级管理员','2025-11-26 00:13:01','2025-11-26 00:13:01',NULL,NULL,1,NULL);
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

-- Dump completed on 2025-11-26  0:31:39
