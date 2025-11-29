--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (ServBay)
-- Dumped by pg_dump version 17.5 (ServBay)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: app_ai_mcp; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.app_ai_mcp (
    name character varying(50) NOT NULL,
    type integer NOT NULL,
    url character varying(255),
    command character varying(255),
    args character varying(255),
    env json,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.app_ai_mcp OWNER TO tao;

--
-- Name: TABLE app_ai_mcp; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.app_ai_mcp IS 'MCP 服务器表';


--
-- Name: COLUMN app_ai_mcp.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.name IS 'MCP 名称';


--
-- Name: COLUMN app_ai_mcp.type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.type IS 'MCP 类型(0:stdio 1:sse)';


--
-- Name: COLUMN app_ai_mcp.url; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.url IS '远程 SSE 地址';


--
-- Name: COLUMN app_ai_mcp.command; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.command IS 'MCP 命令';


--
-- Name: COLUMN app_ai_mcp.args; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.args IS 'MCP 命令参数';


--
-- Name: COLUMN app_ai_mcp.env; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.env IS 'MCP 环境变量';


--
-- Name: COLUMN app_ai_mcp.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.id IS '主键ID';


--
-- Name: COLUMN app_ai_mcp.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN app_ai_mcp.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN app_ai_mcp.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.description IS '备注/描述';


--
-- Name: COLUMN app_ai_mcp.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.created_time IS '创建时间';


--
-- Name: COLUMN app_ai_mcp.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.updated_time IS '更新时间';


--
-- Name: COLUMN app_ai_mcp.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.created_id IS '创建人ID';


--
-- Name: COLUMN app_ai_mcp.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.updated_id IS '更新人ID';


--
-- Name: COLUMN app_ai_mcp.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.tenant_id IS '所属租户ID';


--
-- Name: COLUMN app_ai_mcp.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_ai_mcp.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: app_ai_mcp_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.app_ai_mcp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_ai_mcp_id_seq OWNER TO tao;

--
-- Name: app_ai_mcp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.app_ai_mcp_id_seq OWNED BY public.app_ai_mcp.id;


--
-- Name: app_job; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.app_job (
    name character varying(64),
    jobstore character varying(64),
    executor character varying(64),
    trigger character varying(64) NOT NULL,
    trigger_args text,
    func text NOT NULL,
    args text,
    kwargs text,
    "coalesce" boolean,
    max_instances integer,
    start_date character varying(64),
    end_date character varying(64),
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.app_job OWNER TO tao;

--
-- Name: TABLE app_job; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.app_job IS '定时任务调度表';


--
-- Name: COLUMN app_job.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.name IS '任务名称';


--
-- Name: COLUMN app_job.jobstore; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.jobstore IS '存储器';


--
-- Name: COLUMN app_job.executor; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.executor IS '执行器:将运行此作业的执行程序的名称';


--
-- Name: COLUMN app_job.trigger; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.trigger IS '触发器:控制此作业计划的 trigger 对象';


--
-- Name: COLUMN app_job.trigger_args; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.trigger_args IS '触发器参数';


--
-- Name: COLUMN app_job.func; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.func IS '任务函数';


--
-- Name: COLUMN app_job.args; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.args IS '位置参数';


--
-- Name: COLUMN app_job.kwargs; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.kwargs IS '关键字参数';


--
-- Name: COLUMN app_job."coalesce"; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job."coalesce" IS '是否合并运行:是否在多个运行时间到期时仅运行作业一次';


--
-- Name: COLUMN app_job.max_instances; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.max_instances IS '最大实例数:允许的最大并发执行实例数';


--
-- Name: COLUMN app_job.start_date; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.start_date IS '开始时间';


--
-- Name: COLUMN app_job.end_date; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.end_date IS '结束时间';


--
-- Name: COLUMN app_job.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.id IS '主键ID';


--
-- Name: COLUMN app_job.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN app_job.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN app_job.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.description IS '备注/描述';


--
-- Name: COLUMN app_job.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.created_time IS '创建时间';


--
-- Name: COLUMN app_job.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.updated_time IS '更新时间';


--
-- Name: COLUMN app_job.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.created_id IS '创建人ID';


--
-- Name: COLUMN app_job.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.updated_id IS '更新人ID';


--
-- Name: COLUMN app_job.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.tenant_id IS '所属租户ID';


--
-- Name: COLUMN app_job.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: app_job_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.app_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_job_id_seq OWNER TO tao;

--
-- Name: app_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.app_job_id_seq OWNED BY public.app_job.id;


--
-- Name: app_job_log; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.app_job_log (
    job_name character varying(64) NOT NULL,
    job_group character varying(64) NOT NULL,
    job_executor character varying(64) NOT NULL,
    invoke_target character varying(500) NOT NULL,
    job_args character varying(255),
    job_kwargs character varying(255),
    job_trigger character varying(255),
    job_message character varying(500),
    exception_info character varying(2000),
    job_id integer,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.app_job_log OWNER TO tao;

--
-- Name: TABLE app_job_log; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.app_job_log IS '定时任务调度日志表';


--
-- Name: COLUMN app_job_log.job_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_name IS '任务名称';


--
-- Name: COLUMN app_job_log.job_group; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_group IS '任务组名';


--
-- Name: COLUMN app_job_log.job_executor; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_executor IS '任务执行器';


--
-- Name: COLUMN app_job_log.invoke_target; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.invoke_target IS '调用目标字符串';


--
-- Name: COLUMN app_job_log.job_args; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_args IS '位置参数';


--
-- Name: COLUMN app_job_log.job_kwargs; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_kwargs IS '关键字参数';


--
-- Name: COLUMN app_job_log.job_trigger; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_trigger IS '任务触发器';


--
-- Name: COLUMN app_job_log.job_message; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_message IS '日志信息';


--
-- Name: COLUMN app_job_log.exception_info; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.exception_info IS '异常信息';


--
-- Name: COLUMN app_job_log.job_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.job_id IS '任务ID';


--
-- Name: COLUMN app_job_log.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.id IS '主键ID';


--
-- Name: COLUMN app_job_log.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN app_job_log.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN app_job_log.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.description IS '备注/描述';


--
-- Name: COLUMN app_job_log.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.created_time IS '创建时间';


--
-- Name: COLUMN app_job_log.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.updated_time IS '更新时间';


--
-- Name: COLUMN app_job_log.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_job_log.tenant_id IS '所属租户ID';


--
-- Name: app_job_log_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.app_job_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_job_log_id_seq OWNER TO tao;

--
-- Name: app_job_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.app_job_log_id_seq OWNED BY public.app_job_log.id;


--
-- Name: app_myapp; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.app_myapp (
    name character varying(64) NOT NULL,
    access_url character varying(500) NOT NULL,
    icon_url character varying(300),
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.app_myapp OWNER TO tao;

--
-- Name: TABLE app_myapp; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.app_myapp IS '应用系统表';


--
-- Name: COLUMN app_myapp.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.name IS '应用名称';


--
-- Name: COLUMN app_myapp.access_url; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.access_url IS '访问地址';


--
-- Name: COLUMN app_myapp.icon_url; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.icon_url IS '应用图标URL';


--
-- Name: COLUMN app_myapp.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.id IS '主键ID';


--
-- Name: COLUMN app_myapp.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN app_myapp.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN app_myapp.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.description IS '备注/描述';


--
-- Name: COLUMN app_myapp.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.created_time IS '创建时间';


--
-- Name: COLUMN app_myapp.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.updated_time IS '更新时间';


--
-- Name: COLUMN app_myapp.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.created_id IS '创建人ID';


--
-- Name: COLUMN app_myapp.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.updated_id IS '更新人ID';


--
-- Name: COLUMN app_myapp.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.tenant_id IS '所属租户ID';


--
-- Name: COLUMN app_myapp.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.app_myapp.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: app_myapp_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.app_myapp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_myapp_id_seq OWNER TO tao;

--
-- Name: app_myapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.app_myapp_id_seq OWNED BY public.app_myapp.id;


--
-- Name: apscheduler_jobs; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.apscheduler_jobs (
    id character varying(191) NOT NULL,
    next_run_time double precision,
    job_state bytea NOT NULL
);


ALTER TABLE public.apscheduler_jobs OWNER TO tao;

--
-- Name: gen_demo; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.gen_demo (
    name character varying(64),
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.gen_demo OWNER TO tao;

--
-- Name: TABLE gen_demo; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.gen_demo IS '示例表';


--
-- Name: COLUMN gen_demo.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.name IS '名称';


--
-- Name: COLUMN gen_demo.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.id IS '主键ID';


--
-- Name: COLUMN gen_demo.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN gen_demo.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN gen_demo.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.description IS '备注/描述';


--
-- Name: COLUMN gen_demo.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.created_time IS '创建时间';


--
-- Name: COLUMN gen_demo.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.updated_time IS '更新时间';


--
-- Name: COLUMN gen_demo.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.created_id IS '创建人ID';


--
-- Name: COLUMN gen_demo.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.updated_id IS '更新人ID';


--
-- Name: COLUMN gen_demo.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.tenant_id IS '所属租户ID';


--
-- Name: COLUMN gen_demo.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_demo.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: gen_demo_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.gen_demo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gen_demo_id_seq OWNER TO tao;

--
-- Name: gen_demo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.gen_demo_id_seq OWNED BY public.gen_demo.id;


--
-- Name: gen_table; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.gen_table (
    table_name character varying(200) NOT NULL,
    table_comment character varying(500),
    class_name character varying(100) NOT NULL,
    package_name character varying(100),
    module_name character varying(30),
    business_name character varying(30),
    function_name character varying(100),
    sub_table_name character varying(64) DEFAULT NULL::character varying,
    sub_table_fk_name character varying(64) DEFAULT NULL::character varying,
    parent_menu_id integer,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.gen_table OWNER TO tao;

--
-- Name: TABLE gen_table; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.gen_table IS '代码生成表';


--
-- Name: COLUMN gen_table.table_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.table_name IS '表名称';


--
-- Name: COLUMN gen_table.table_comment; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.table_comment IS '表描述';


--
-- Name: COLUMN gen_table.class_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.class_name IS '实体类名称';


--
-- Name: COLUMN gen_table.package_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.package_name IS '生成包路径';


--
-- Name: COLUMN gen_table.module_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.module_name IS '生成模块名';


--
-- Name: COLUMN gen_table.business_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.business_name IS '生成业务名';


--
-- Name: COLUMN gen_table.function_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.function_name IS '生成功能名';


--
-- Name: COLUMN gen_table.sub_table_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.sub_table_name IS '关联子表的表名';


--
-- Name: COLUMN gen_table.sub_table_fk_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.sub_table_fk_name IS '子表关联的外键名';


--
-- Name: COLUMN gen_table.parent_menu_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.parent_menu_id IS '父菜单ID';


--
-- Name: COLUMN gen_table.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.id IS '主键ID';


--
-- Name: COLUMN gen_table.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN gen_table.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN gen_table.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.description IS '备注/描述';


--
-- Name: COLUMN gen_table.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.created_time IS '创建时间';


--
-- Name: COLUMN gen_table.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table.updated_time IS '更新时间';


--
-- Name: gen_table_column; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.gen_table_column (
    column_name character varying(200) NOT NULL,
    column_comment character varying(500),
    column_type character varying(100) NOT NULL,
    column_length character varying(50),
    column_default character varying(200),
    is_pk boolean DEFAULT false NOT NULL,
    is_increment boolean DEFAULT false NOT NULL,
    is_nullable boolean DEFAULT true NOT NULL,
    is_unique boolean DEFAULT false NOT NULL,
    python_type character varying(100),
    python_field character varying(200),
    is_insert boolean DEFAULT true NOT NULL,
    is_edit boolean DEFAULT true NOT NULL,
    is_list boolean DEFAULT true NOT NULL,
    is_query boolean DEFAULT false NOT NULL,
    query_type character varying(50),
    html_type character varying(100),
    dict_type character varying(200),
    sort integer NOT NULL,
    table_id integer NOT NULL,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.gen_table_column OWNER TO tao;

--
-- Name: TABLE gen_table_column; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.gen_table_column IS '代码生成表字段';


--
-- Name: COLUMN gen_table_column.column_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.column_name IS '列名称';


--
-- Name: COLUMN gen_table_column.column_comment; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.column_comment IS '列描述';


--
-- Name: COLUMN gen_table_column.column_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.column_type IS '列类型';


--
-- Name: COLUMN gen_table_column.column_length; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.column_length IS '列长度';


--
-- Name: COLUMN gen_table_column.column_default; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.column_default IS '列默认值';


--
-- Name: COLUMN gen_table_column.is_pk; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_pk IS '是否主键';


--
-- Name: COLUMN gen_table_column.is_increment; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_increment IS '是否自增';


--
-- Name: COLUMN gen_table_column.is_nullable; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_nullable IS '是否允许为空';


--
-- Name: COLUMN gen_table_column.is_unique; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_unique IS '是否唯一';


--
-- Name: COLUMN gen_table_column.python_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.python_type IS 'Python类型';


--
-- Name: COLUMN gen_table_column.python_field; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.python_field IS 'Python字段名';


--
-- Name: COLUMN gen_table_column.is_insert; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_insert IS '是否为新增字段';


--
-- Name: COLUMN gen_table_column.is_edit; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_edit IS '是否编辑字段';


--
-- Name: COLUMN gen_table_column.is_list; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_list IS '是否列表字段';


--
-- Name: COLUMN gen_table_column.is_query; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.is_query IS '是否查询字段';


--
-- Name: COLUMN gen_table_column.query_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.query_type IS '查询方式';


--
-- Name: COLUMN gen_table_column.html_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.html_type IS '显示类型';


--
-- Name: COLUMN gen_table_column.dict_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.dict_type IS '字典类型';


--
-- Name: COLUMN gen_table_column.sort; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.sort IS '排序';


--
-- Name: COLUMN gen_table_column.table_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.table_id IS '归属表编号';


--
-- Name: COLUMN gen_table_column.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.id IS '主键ID';


--
-- Name: COLUMN gen_table_column.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN gen_table_column.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN gen_table_column.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.description IS '备注/描述';


--
-- Name: COLUMN gen_table_column.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.created_time IS '创建时间';


--
-- Name: COLUMN gen_table_column.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.gen_table_column.updated_time IS '更新时间';


--
-- Name: gen_table_column_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.gen_table_column_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gen_table_column_id_seq OWNER TO tao;

--
-- Name: gen_table_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.gen_table_column_id_seq OWNED BY public.gen_table_column.id;


--
-- Name: gen_table_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.gen_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gen_table_id_seq OWNER TO tao;

--
-- Name: gen_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.gen_table_id_seq OWNED BY public.gen_table.id;


--
-- Name: sys_customer; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_customer (
    name character varying(64) NOT NULL,
    code character varying(20) NOT NULL,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.sys_customer OWNER TO tao;

--
-- Name: TABLE sys_customer; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_customer IS '客户表';


--
-- Name: COLUMN sys_customer.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.name IS '客户名称';


--
-- Name: COLUMN sys_customer.code; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.code IS '客户编码';


--
-- Name: COLUMN sys_customer.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.id IS '主键ID';


--
-- Name: COLUMN sys_customer.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_customer.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_customer.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.description IS '备注/描述';


--
-- Name: COLUMN sys_customer.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.created_time IS '创建时间';


--
-- Name: COLUMN sys_customer.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.updated_time IS '更新时间';


--
-- Name: COLUMN sys_customer.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.created_id IS '创建人ID';


--
-- Name: COLUMN sys_customer.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.updated_id IS '更新人ID';


--
-- Name: COLUMN sys_customer.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_customer.tenant_id IS '所属租户ID';


--
-- Name: sys_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_customer_id_seq OWNER TO tao;

--
-- Name: sys_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_customer_id_seq OWNED BY public.sys_customer.id;


--
-- Name: sys_dept; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_dept (
    name character varying(40) NOT NULL,
    "order" integer NOT NULL,
    code character varying(20),
    leader character varying(32),
    phone character varying(11),
    email character varying(64),
    parent_id integer,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.sys_dept OWNER TO tao;

--
-- Name: TABLE sys_dept; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_dept IS '部门表';


--
-- Name: COLUMN sys_dept.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.name IS '部门名称';


--
-- Name: COLUMN sys_dept."order"; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept."order" IS '显示排序';


--
-- Name: COLUMN sys_dept.code; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.code IS '部门编码';


--
-- Name: COLUMN sys_dept.leader; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.leader IS '部门负责人';


--
-- Name: COLUMN sys_dept.phone; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.phone IS '手机';


--
-- Name: COLUMN sys_dept.email; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.email IS '邮箱';


--
-- Name: COLUMN sys_dept.parent_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.parent_id IS '父级部门ID';


--
-- Name: COLUMN sys_dept.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.id IS '主键ID';


--
-- Name: COLUMN sys_dept.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_dept.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_dept.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.description IS '备注/描述';


--
-- Name: COLUMN sys_dept.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.created_time IS '创建时间';


--
-- Name: COLUMN sys_dept.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.updated_time IS '更新时间';


--
-- Name: COLUMN sys_dept.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dept.tenant_id IS '所属租户ID';


--
-- Name: sys_dept_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_dept_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_dept_id_seq OWNER TO tao;

--
-- Name: sys_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_dept_id_seq OWNED BY public.sys_dept.id;


--
-- Name: sys_dict_data; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_dict_data (
    dict_sort integer NOT NULL,
    dict_label character varying(255) NOT NULL,
    dict_value character varying(255) NOT NULL,
    css_class character varying(255),
    list_class character varying(255),
    is_default boolean NOT NULL,
    dict_type character varying(255) NOT NULL,
    dict_type_id integer NOT NULL,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.sys_dict_data OWNER TO tao;

--
-- Name: TABLE sys_dict_data; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_dict_data IS '字典数据表';


--
-- Name: COLUMN sys_dict_data.dict_sort; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.dict_sort IS '字典排序';


--
-- Name: COLUMN sys_dict_data.dict_label; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.dict_label IS '字典标签';


--
-- Name: COLUMN sys_dict_data.dict_value; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.dict_value IS '字典键值';


--
-- Name: COLUMN sys_dict_data.css_class; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.css_class IS '样式属性（其他样式扩展）';


--
-- Name: COLUMN sys_dict_data.list_class; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.list_class IS '表格回显样式';


--
-- Name: COLUMN sys_dict_data.is_default; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.is_default IS '是否默认（True是 False否）';


--
-- Name: COLUMN sys_dict_data.dict_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.dict_type IS '字典类型';


--
-- Name: COLUMN sys_dict_data.dict_type_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.dict_type_id IS '字典类型ID';


--
-- Name: COLUMN sys_dict_data.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.id IS '主键ID';


--
-- Name: COLUMN sys_dict_data.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_dict_data.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_dict_data.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.description IS '备注/描述';


--
-- Name: COLUMN sys_dict_data.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.created_time IS '创建时间';


--
-- Name: COLUMN sys_dict_data.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_data.updated_time IS '更新时间';


--
-- Name: sys_dict_data_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_dict_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_dict_data_id_seq OWNER TO tao;

--
-- Name: sys_dict_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_dict_data_id_seq OWNED BY public.sys_dict_data.id;


--
-- Name: sys_dict_type; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_dict_type (
    dict_name character varying(255) NOT NULL,
    dict_type character varying(255) NOT NULL,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.sys_dict_type OWNER TO tao;

--
-- Name: TABLE sys_dict_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_dict_type IS '字典类型表';


--
-- Name: COLUMN sys_dict_type.dict_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.dict_name IS '字典名称';


--
-- Name: COLUMN sys_dict_type.dict_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.dict_type IS '字典类型';


--
-- Name: COLUMN sys_dict_type.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.id IS '主键ID';


--
-- Name: COLUMN sys_dict_type.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_dict_type.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_dict_type.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.description IS '备注/描述';


--
-- Name: COLUMN sys_dict_type.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.created_time IS '创建时间';


--
-- Name: COLUMN sys_dict_type.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_dict_type.updated_time IS '更新时间';


--
-- Name: sys_dict_type_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_dict_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_dict_type_id_seq OWNER TO tao;

--
-- Name: sys_dict_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_dict_type_id_seq OWNED BY public.sys_dict_type.id;


--
-- Name: sys_log; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_log (
    type integer NOT NULL,
    request_path character varying(255) NOT NULL,
    request_method character varying(10) NOT NULL,
    request_payload text,
    request_ip character varying(50),
    login_location character varying(255),
    request_os character varying(64),
    request_browser character varying(64),
    response_code integer NOT NULL,
    response_json text,
    process_time character varying(20),
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.sys_log OWNER TO tao;

--
-- Name: TABLE sys_log; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_log IS '系统日志表';


--
-- Name: COLUMN sys_log.type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.type IS '日志类型(1登录日志 2操作日志)';


--
-- Name: COLUMN sys_log.request_path; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.request_path IS '请求路径';


--
-- Name: COLUMN sys_log.request_method; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.request_method IS '请求方式';


--
-- Name: COLUMN sys_log.request_payload; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.request_payload IS '请求体';


--
-- Name: COLUMN sys_log.request_ip; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.request_ip IS '请求IP地址';


--
-- Name: COLUMN sys_log.login_location; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.login_location IS '登录位置';


--
-- Name: COLUMN sys_log.request_os; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.request_os IS '操作系统';


--
-- Name: COLUMN sys_log.request_browser; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.request_browser IS '浏览器';


--
-- Name: COLUMN sys_log.response_code; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.response_code IS '响应状态码';


--
-- Name: COLUMN sys_log.response_json; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.response_json IS '响应体';


--
-- Name: COLUMN sys_log.process_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.process_time IS '处理时间';


--
-- Name: COLUMN sys_log.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.id IS '主键ID';


--
-- Name: COLUMN sys_log.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_log.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_log.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.description IS '备注/描述';


--
-- Name: COLUMN sys_log.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.created_time IS '创建时间';


--
-- Name: COLUMN sys_log.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.updated_time IS '更新时间';


--
-- Name: COLUMN sys_log.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.created_id IS '创建人ID';


--
-- Name: COLUMN sys_log.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.updated_id IS '更新人ID';


--
-- Name: COLUMN sys_log.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.tenant_id IS '所属租户ID';


--
-- Name: COLUMN sys_log.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_log.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: sys_log_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_log_id_seq OWNER TO tao;

--
-- Name: sys_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_log_id_seq OWNED BY public.sys_log.id;


--
-- Name: sys_menu; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_menu (
    name character varying(50) NOT NULL,
    type integer NOT NULL,
    "order" integer NOT NULL,
    permission character varying(100),
    icon character varying(50),
    route_name character varying(100),
    route_path character varying(200),
    component_path character varying(200),
    redirect character varying(200),
    hidden boolean NOT NULL,
    keep_alive boolean NOT NULL,
    always_show boolean NOT NULL,
    title character varying(50),
    params json,
    affix boolean NOT NULL,
    parent_id integer,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.sys_menu OWNER TO tao;

--
-- Name: TABLE sys_menu; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_menu IS '菜单表';


--
-- Name: COLUMN sys_menu.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.name IS '菜单名称';


--
-- Name: COLUMN sys_menu.type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.type IS '菜单类型(1:目录 2:菜单 3:按钮/权限 4:链接)';


--
-- Name: COLUMN sys_menu."order"; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu."order" IS '显示排序';


--
-- Name: COLUMN sys_menu.permission; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.permission IS '权限标识(如:module_system:user:list)';


--
-- Name: COLUMN sys_menu.icon; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.icon IS '菜单图标';


--
-- Name: COLUMN sys_menu.route_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.route_name IS '路由名称';


--
-- Name: COLUMN sys_menu.route_path; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.route_path IS '路由路径';


--
-- Name: COLUMN sys_menu.component_path; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.component_path IS '组件路径';


--
-- Name: COLUMN sys_menu.redirect; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.redirect IS '重定向地址';


--
-- Name: COLUMN sys_menu.hidden; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.hidden IS '是否隐藏(True:隐藏 False:显示)';


--
-- Name: COLUMN sys_menu.keep_alive; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.keep_alive IS '是否缓存(True:是 False:否)';


--
-- Name: COLUMN sys_menu.always_show; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.always_show IS '是否始终显示(True:是 False:否)';


--
-- Name: COLUMN sys_menu.title; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.title IS '菜单标题';


--
-- Name: COLUMN sys_menu.params; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.params IS '路由参数(JSON对象)';


--
-- Name: COLUMN sys_menu.affix; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.affix IS '是否固定标签页(True:是 False:否)';


--
-- Name: COLUMN sys_menu.parent_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.parent_id IS '父菜单ID';


--
-- Name: COLUMN sys_menu.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.id IS '主键ID';


--
-- Name: COLUMN sys_menu.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_menu.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_menu.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.description IS '备注/描述';


--
-- Name: COLUMN sys_menu.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.created_time IS '创建时间';


--
-- Name: COLUMN sys_menu.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_menu.updated_time IS '更新时间';


--
-- Name: sys_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_menu_id_seq OWNER TO tao;

--
-- Name: sys_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_menu_id_seq OWNED BY public.sys_menu.id;


--
-- Name: sys_notice; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_notice (
    notice_title character varying(50) NOT NULL,
    notice_type character varying(50) NOT NULL,
    notice_content text,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.sys_notice OWNER TO tao;

--
-- Name: TABLE sys_notice; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_notice IS '通知公告表';


--
-- Name: COLUMN sys_notice.notice_title; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.notice_title IS '公告标题';


--
-- Name: COLUMN sys_notice.notice_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.notice_type IS '公告类型(1通知 2公告)';


--
-- Name: COLUMN sys_notice.notice_content; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.notice_content IS '公告内容';


--
-- Name: COLUMN sys_notice.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.id IS '主键ID';


--
-- Name: COLUMN sys_notice.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_notice.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_notice.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.description IS '备注/描述';


--
-- Name: COLUMN sys_notice.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.created_time IS '创建时间';


--
-- Name: COLUMN sys_notice.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.updated_time IS '更新时间';


--
-- Name: COLUMN sys_notice.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.created_id IS '创建人ID';


--
-- Name: COLUMN sys_notice.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.updated_id IS '更新人ID';


--
-- Name: COLUMN sys_notice.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.tenant_id IS '所属租户ID';


--
-- Name: COLUMN sys_notice.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_notice.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: sys_notice_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_notice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_notice_id_seq OWNER TO tao;

--
-- Name: sys_notice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_notice_id_seq OWNED BY public.sys_notice.id;


--
-- Name: sys_param; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_param (
    config_name character varying(500) NOT NULL,
    config_key character varying(500) NOT NULL,
    config_value character varying(500),
    config_type boolean,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.sys_param OWNER TO tao;

--
-- Name: TABLE sys_param; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_param IS '系统参数表';


--
-- Name: COLUMN sys_param.config_name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.config_name IS '参数名称';


--
-- Name: COLUMN sys_param.config_key; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.config_key IS '参数键名';


--
-- Name: COLUMN sys_param.config_value; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.config_value IS '参数键值';


--
-- Name: COLUMN sys_param.config_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.config_type IS '系统内置(True:是 False:否)';


--
-- Name: COLUMN sys_param.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.id IS '主键ID';


--
-- Name: COLUMN sys_param.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_param.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_param.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.description IS '备注/描述';


--
-- Name: COLUMN sys_param.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.created_time IS '创建时间';


--
-- Name: COLUMN sys_param.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_param.updated_time IS '更新时间';


--
-- Name: sys_param_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_param_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_param_id_seq OWNER TO tao;

--
-- Name: sys_param_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_param_id_seq OWNED BY public.sys_param.id;


--
-- Name: sys_position; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_position (
    name character varying(40) NOT NULL,
    "order" integer NOT NULL,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.sys_position OWNER TO tao;

--
-- Name: TABLE sys_position; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_position IS '岗位表';


--
-- Name: COLUMN sys_position.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.name IS '岗位名称';


--
-- Name: COLUMN sys_position."order"; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position."order" IS '显示排序';


--
-- Name: COLUMN sys_position.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.id IS '主键ID';


--
-- Name: COLUMN sys_position.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_position.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_position.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.description IS '备注/描述';


--
-- Name: COLUMN sys_position.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.created_time IS '创建时间';


--
-- Name: COLUMN sys_position.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.updated_time IS '更新时间';


--
-- Name: COLUMN sys_position.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.created_id IS '创建人ID';


--
-- Name: COLUMN sys_position.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.updated_id IS '更新人ID';


--
-- Name: COLUMN sys_position.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_position.tenant_id IS '所属租户ID';


--
-- Name: sys_position_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_position_id_seq OWNER TO tao;

--
-- Name: sys_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_position_id_seq OWNED BY public.sys_position.id;


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_role (
    name character varying(40) NOT NULL,
    code character varying(20),
    "order" integer NOT NULL,
    data_scope character varying(10),
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.sys_role OWNER TO tao;

--
-- Name: TABLE sys_role; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_role IS '角色表';


--
-- Name: COLUMN sys_role.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.name IS '角色名称';


--
-- Name: COLUMN sys_role.code; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.code IS '角色编码';


--
-- Name: COLUMN sys_role."order"; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role."order" IS '显示排序';


--
-- Name: COLUMN sys_role.data_scope; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.data_scope IS '数据权限范围(1:仅本人 2:本部门 3:本部门及以下 4:全部 5:自定义)';


--
-- Name: COLUMN sys_role.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.id IS '主键ID';


--
-- Name: COLUMN sys_role.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_role.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_role.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.description IS '备注/描述';


--
-- Name: COLUMN sys_role.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.created_time IS '创建时间';


--
-- Name: COLUMN sys_role.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.updated_time IS '更新时间';


--
-- Name: COLUMN sys_role.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.created_id IS '创建人ID';


--
-- Name: COLUMN sys_role.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.updated_id IS '更新人ID';


--
-- Name: COLUMN sys_role.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role.tenant_id IS '所属租户ID';


--
-- Name: sys_role_depts; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_role_depts (
    role_id integer NOT NULL,
    dept_id integer NOT NULL
);


ALTER TABLE public.sys_role_depts OWNER TO tao;

--
-- Name: TABLE sys_role_depts; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_role_depts IS '角色部门关联表';


--
-- Name: COLUMN sys_role_depts.role_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role_depts.role_id IS '角色ID';


--
-- Name: COLUMN sys_role_depts.dept_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role_depts.dept_id IS '部门ID';


--
-- Name: sys_role_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_role_id_seq OWNER TO tao;

--
-- Name: sys_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_role_id_seq OWNED BY public.sys_role.id;


--
-- Name: sys_role_menus; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_role_menus (
    role_id integer NOT NULL,
    menu_id integer NOT NULL
);


ALTER TABLE public.sys_role_menus OWNER TO tao;

--
-- Name: TABLE sys_role_menus; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_role_menus IS '角色菜单关联表';


--
-- Name: COLUMN sys_role_menus.role_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role_menus.role_id IS '角色ID';


--
-- Name: COLUMN sys_role_menus.menu_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_role_menus.menu_id IS '菜单ID';


--
-- Name: sys_tenant; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_tenant (
    name character varying(100) NOT NULL,
    code character varying(100) NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.sys_tenant OWNER TO tao;

--
-- Name: TABLE sys_tenant; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_tenant IS '租户表';


--
-- Name: COLUMN sys_tenant.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.name IS '租户名称';


--
-- Name: COLUMN sys_tenant.code; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.code IS '租户编码';


--
-- Name: COLUMN sys_tenant.start_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.start_time IS '开始时间';


--
-- Name: COLUMN sys_tenant.end_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.end_time IS '结束时间';


--
-- Name: COLUMN sys_tenant.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.id IS '主键ID';


--
-- Name: COLUMN sys_tenant.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_tenant.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_tenant.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.description IS '备注/描述';


--
-- Name: COLUMN sys_tenant.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.created_time IS '创建时间';


--
-- Name: COLUMN sys_tenant.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_tenant.updated_time IS '更新时间';


--
-- Name: sys_tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_tenant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_tenant_id_seq OWNER TO tao;

--
-- Name: sys_tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_tenant_id_seq OWNED BY public.sys_tenant.id;


--
-- Name: sys_user; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_user (
    username character varying(32) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(32) NOT NULL,
    mobile character varying(11),
    email character varying(64),
    gender character varying(1),
    avatar character varying(255),
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone,
    gitee_login character varying(32),
    github_login character varying(32),
    wx_login character varying(32),
    qq_login character varying(32),
    user_type character varying(32) NOT NULL,
    salt character varying(255),
    dept_id integer,
    id integer NOT NULL,
    uuid character varying(64) NOT NULL,
    status character varying(10) NOT NULL,
    description text,
    created_time timestamp without time zone NOT NULL,
    updated_time timestamp without time zone NOT NULL,
    created_id integer,
    updated_id integer,
    tenant_id integer NOT NULL,
    customer_id integer
);


ALTER TABLE public.sys_user OWNER TO tao;

--
-- Name: TABLE sys_user; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_user IS '用户表';


--
-- Name: COLUMN sys_user.username; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.username IS '用户名/登录账号';


--
-- Name: COLUMN sys_user.password; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.password IS '密码哈希';


--
-- Name: COLUMN sys_user.name; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.name IS '昵称';


--
-- Name: COLUMN sys_user.mobile; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.mobile IS '手机号';


--
-- Name: COLUMN sys_user.email; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.email IS '邮箱';


--
-- Name: COLUMN sys_user.gender; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.gender IS '性别(0:男 1:女 2:未知)';


--
-- Name: COLUMN sys_user.avatar; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.avatar IS '头像URL地址';


--
-- Name: COLUMN sys_user.is_superuser; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.is_superuser IS '是否超管';


--
-- Name: COLUMN sys_user.last_login; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.last_login IS '最后登录时间';


--
-- Name: COLUMN sys_user.gitee_login; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.gitee_login IS 'Gitee登录';


--
-- Name: COLUMN sys_user.github_login; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.github_login IS 'Github登录';


--
-- Name: COLUMN sys_user.wx_login; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.wx_login IS '微信登录';


--
-- Name: COLUMN sys_user.qq_login; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.qq_login IS 'QQ登录';


--
-- Name: COLUMN sys_user.user_type; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.user_type IS '用户类型(0:系统用户 1:租户用户 2:客户用户)';


--
-- Name: COLUMN sys_user.salt; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.salt IS '加密盐';


--
-- Name: COLUMN sys_user.dept_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.dept_id IS '部门ID';


--
-- Name: COLUMN sys_user.id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.id IS '主键ID';


--
-- Name: COLUMN sys_user.uuid; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.uuid IS 'UUID全局唯一标识';


--
-- Name: COLUMN sys_user.status; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.status IS '是否启用(0:启用 1:禁用)';


--
-- Name: COLUMN sys_user.description; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.description IS '备注/描述';


--
-- Name: COLUMN sys_user.created_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.created_time IS '创建时间';


--
-- Name: COLUMN sys_user.updated_time; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.updated_time IS '更新时间';


--
-- Name: COLUMN sys_user.created_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.created_id IS '创建人ID';


--
-- Name: COLUMN sys_user.updated_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.updated_id IS '更新人ID';


--
-- Name: COLUMN sys_user.tenant_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.tenant_id IS '所属租户ID';


--
-- Name: COLUMN sys_user.customer_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user.customer_id IS '所属客户ID(NULL表示租户级数据,>0表示客户级数据)';


--
-- Name: sys_user_id_seq; Type: SEQUENCE; Schema: public; Owner: tao
--

CREATE SEQUENCE public.sys_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_user_id_seq OWNER TO tao;

--
-- Name: sys_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tao
--

ALTER SEQUENCE public.sys_user_id_seq OWNED BY public.sys_user.id;


--
-- Name: sys_user_positions; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_user_positions (
    user_id integer NOT NULL,
    position_id integer NOT NULL
);


ALTER TABLE public.sys_user_positions OWNER TO tao;

--
-- Name: TABLE sys_user_positions; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_user_positions IS '用户岗位关联表';


--
-- Name: COLUMN sys_user_positions.user_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user_positions.user_id IS '用户ID';


--
-- Name: COLUMN sys_user_positions.position_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user_positions.position_id IS '岗位ID';


--
-- Name: sys_user_roles; Type: TABLE; Schema: public; Owner: tao
--

CREATE TABLE public.sys_user_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.sys_user_roles OWNER TO tao;

--
-- Name: TABLE sys_user_roles; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON TABLE public.sys_user_roles IS '用户角色关联表';


--
-- Name: COLUMN sys_user_roles.user_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user_roles.user_id IS '用户ID';


--
-- Name: COLUMN sys_user_roles.role_id; Type: COMMENT; Schema: public; Owner: tao
--

COMMENT ON COLUMN public.sys_user_roles.role_id IS '角色ID';


--
-- Name: app_ai_mcp id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp ALTER COLUMN id SET DEFAULT nextval('public.app_ai_mcp_id_seq'::regclass);


--
-- Name: app_job id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job ALTER COLUMN id SET DEFAULT nextval('public.app_job_id_seq'::regclass);


--
-- Name: app_job_log id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job_log ALTER COLUMN id SET DEFAULT nextval('public.app_job_log_id_seq'::regclass);


--
-- Name: app_myapp id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp ALTER COLUMN id SET DEFAULT nextval('public.app_myapp_id_seq'::regclass);


--
-- Name: gen_demo id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo ALTER COLUMN id SET DEFAULT nextval('public.gen_demo_id_seq'::regclass);


--
-- Name: gen_table id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table ALTER COLUMN id SET DEFAULT nextval('public.gen_table_id_seq'::regclass);


--
-- Name: gen_table_column id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table_column ALTER COLUMN id SET DEFAULT nextval('public.gen_table_column_id_seq'::regclass);


--
-- Name: sys_customer id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_customer ALTER COLUMN id SET DEFAULT nextval('public.sys_customer_id_seq'::regclass);


--
-- Name: sys_dept id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dept ALTER COLUMN id SET DEFAULT nextval('public.sys_dept_id_seq'::regclass);


--
-- Name: sys_dict_data id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_data ALTER COLUMN id SET DEFAULT nextval('public.sys_dict_data_id_seq'::regclass);


--
-- Name: sys_dict_type id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_type ALTER COLUMN id SET DEFAULT nextval('public.sys_dict_type_id_seq'::regclass);


--
-- Name: sys_log id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log ALTER COLUMN id SET DEFAULT nextval('public.sys_log_id_seq'::regclass);


--
-- Name: sys_menu id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_menu ALTER COLUMN id SET DEFAULT nextval('public.sys_menu_id_seq'::regclass);


--
-- Name: sys_notice id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice ALTER COLUMN id SET DEFAULT nextval('public.sys_notice_id_seq'::regclass);


--
-- Name: sys_param id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_param ALTER COLUMN id SET DEFAULT nextval('public.sys_param_id_seq'::regclass);


--
-- Name: sys_position id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_position ALTER COLUMN id SET DEFAULT nextval('public.sys_position_id_seq'::regclass);


--
-- Name: sys_role id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN id SET DEFAULT nextval('public.sys_role_id_seq'::regclass);


--
-- Name: sys_tenant id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_tenant ALTER COLUMN id SET DEFAULT nextval('public.sys_tenant_id_seq'::regclass);


--
-- Name: sys_user id; Type: DEFAULT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN id SET DEFAULT nextval('public.sys_user_id_seq'::regclass);


--
-- Data for Name: app_ai_mcp; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.app_ai_mcp (name, type, url, command, args, env, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
\.


--
-- Data for Name: app_job; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.app_job (name, jobstore, executor, trigger, trigger_args, func, args, kwargs, "coalesce", max_instances, start_date, end_date, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
\.


--
-- Data for Name: app_job_log; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.app_job_log (job_name, job_group, job_executor, invoke_target, job_args, job_kwargs, job_trigger, job_message, exception_info, job_id, id, uuid, status, description, created_time, updated_time, tenant_id) FROM stdin;
\.


--
-- Data for Name: app_myapp; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.app_myapp (name, access_url, icon_url, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
\.


--
-- Data for Name: apscheduler_jobs; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.apscheduler_jobs (id, next_run_time, job_state) FROM stdin;
\.


--
-- Data for Name: gen_demo; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.gen_demo (name, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
\.


--
-- Data for Name: gen_table; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.gen_table (table_name, table_comment, class_name, package_name, module_name, business_name, function_name, sub_table_name, sub_table_fk_name, parent_menu_id, id, uuid, status, description, created_time, updated_time) FROM stdin;
\.


--
-- Data for Name: gen_table_column; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.gen_table_column (column_name, column_comment, column_type, column_length, column_default, is_pk, is_increment, is_nullable, is_unique, python_type, python_field, is_insert, is_edit, is_list, is_query, query_type, html_type, dict_type, sort, table_id, id, uuid, status, description, created_time, updated_time) FROM stdin;
\.


--
-- Data for Name: sys_customer; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_customer (name, code, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id) FROM stdin;
\.


--
-- Data for Name: sys_dept; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_dept (name, "order", code, leader, phone, email, parent_id, id, uuid, status, description, created_time, updated_time, tenant_id) FROM stdin;
集团总公司	1	GROUP	部门负责人	1582112620	deptadmin@example.com	\N	1	547f368b-ca8d-4119-9cd7-0d49621f0242	0	集团总公司	2025-11-29 14:16:23.96045	2025-11-29 14:16:23.960451	1
\.


--
-- Data for Name: sys_dict_data; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_dict_data (dict_sort, dict_label, dict_value, css_class, list_class, is_default, dict_type, dict_type_id, id, uuid, status, description, created_time, updated_time) FROM stdin;
1	男	0	blue	\N	t	sys_user_sex	1	1	bb2cac0a-2e7b-48aa-81a8-cc9d81b4d9cf	0	性别男	2025-11-29 14:16:23.95647	2025-11-29 14:16:23.956472
2	女	1	pink	\N	f	sys_user_sex	1	2	bc68aafd-2712-413e-9e17-7d033c1fc05d	0	性别女	2025-11-29 14:16:23.956476	2025-11-29 14:16:23.956476
3	未知	2	red	\N	f	sys_user_sex	1	3	aa31e882-29de-4902-b444-5b851bd48e6f	0	性别未知	2025-11-29 14:16:23.956479	2025-11-29 14:16:23.95648
1	是	1		primary	t	sys_yes_no	2	4	9bb23b68-420e-4818-ab31-3736b9b61b1f	0	是	2025-11-29 14:16:23.956482	2025-11-29 14:16:23.956483
2	否	0		danger	f	sys_yes_no	2	5	79396648-d229-4425-b909-85b4cf427199	0	否	2025-11-29 14:16:23.956486	2025-11-29 14:16:23.956486
1	启用	1		primary	f	sys_common_status	3	6	fe1f796a-c681-4ec9-a18d-5b28f304946c	0	启用状态	2025-11-29 14:16:23.956489	2025-11-29 14:16:23.956489
2	停用	0		danger	f	sys_common_status	3	7	209d909c-725c-4809-9c06-24be2f04dbbe	0	停用状态	2025-11-29 14:16:23.956492	2025-11-29 14:16:23.956492
1	通知	1	blue	warning	t	sys_notice_type	4	8	32b79759-782f-4c75-b4bb-eb3426218db0	0	通知	2025-11-29 14:16:23.956495	2025-11-29 14:16:23.956496
2	公告	2	orange	success	f	sys_notice_type	4	9	468502af-87b4-41cb-a02c-2a4f8d5f3c76	0	公告	2025-11-29 14:16:23.956498	2025-11-29 14:16:23.956499
99	其他	0		info	f	sys_oper_type	5	10	8d7ed026-379c-43a1-8e3f-a9f3484a1d38	0	其他操作	2025-11-29 14:16:23.956502	2025-11-29 14:16:23.956502
1	新增	1		info	f	sys_oper_type	5	11	f4d25e17-526f-4a94-9be7-6162f2163fac	0	新增操作	2025-11-29 14:16:23.956505	2025-11-29 14:16:23.956505
2	修改	2		info	f	sys_oper_type	5	12	bb023c55-0e09-4e8d-b98a-3f41dab2a049	0	修改操作	2025-11-29 14:16:23.956508	2025-11-29 14:16:23.956508
3	删除	3		danger	f	sys_oper_type	5	13	0ac47345-e34b-41a1-af1d-4fe33bcba094	0	删除操作	2025-11-29 14:16:23.956511	2025-11-29 14:16:23.956512
4	分配权限	4		primary	f	sys_oper_type	5	14	2476f805-91c4-4e69-bb32-3c485aa7ca19	0	授权操作	2025-11-29 14:16:23.956515	2025-11-29 14:16:23.956515
5	导出	5		warning	f	sys_oper_type	5	15	dec5ee10-ba9e-4749-acd7-90568b2ea70c	0	导出操作	2025-11-29 14:16:23.956518	2025-11-29 14:16:23.956518
6	导入	6		warning	f	sys_oper_type	5	16	1c3c270c-8c3d-48a9-87a5-4909669dca42	0	导入操作	2025-11-29 14:16:23.956521	2025-11-29 14:16:23.956521
7	强退	7		danger	f	sys_oper_type	5	17	11a30dac-f37e-47ee-a442-0e08bc61ae9d	0	强退操作	2025-11-29 14:16:23.956524	2025-11-29 14:16:23.956524
8	生成代码	8		warning	f	sys_oper_type	5	18	2b08fbe5-8038-49ef-9871-2ffc0b71dfa1	0	生成操作	2025-11-29 14:16:23.956527	2025-11-29 14:16:23.956528
9	清空数据	9		danger	f	sys_oper_type	5	19	2042c8f0-e18d-464f-8285-712dd04d4c12	0	清空操作	2025-11-29 14:16:23.95653	2025-11-29 14:16:23.956531
1	默认(Memory)	default		\N	t	sys_job_store	6	20	e21029a6-40e9-474a-b241-1dafe3754c06	0	默认分组	2025-11-29 14:16:23.956533	2025-11-29 14:16:23.956534
2	数据库(Sqlalchemy)	sqlalchemy		\N	f	sys_job_store	6	21	56f8d26f-2732-40a6-b573-1d4616fff8e6	0	数据库分组	2025-11-29 14:16:23.956536	2025-11-29 14:16:23.956537
3	数据库(Redis)	redis		\N	f	sys_job_store	6	22	51b1f7d2-3fc2-4843-8b26-525ca28a6bdd	0	reids分组	2025-11-29 14:16:23.95654	2025-11-29 14:16:23.95654
1	线程池	default		\N	f	sys_job_executor	7	23	3cc7cd2c-9ce9-4685-9efb-3c43db9bf515	0	线程池	2025-11-29 14:16:23.956543	2025-11-29 14:16:23.956543
2	进程池	processpool		\N	f	sys_job_executor	7	24	cfb4be13-ceb7-45cb-abc9-e478a5d63b14	0	进程池	2025-11-29 14:16:23.956546	2025-11-29 14:16:23.956546
1	演示函数	scheduler_test.job		\N	t	sys_job_function	8	25	590c172c-b6d1-42c3-9309-88a47d9d79d3	0	演示函数	2025-11-29 14:16:23.956549	2025-11-29 14:16:23.956549
1	指定日期(date)	date		\N	t	sys_job_trigger	9	26	63a97cda-167d-496e-a412-7c51d037b7ae	0	指定日期任务触发器	2025-11-29 14:16:23.956552	2025-11-29 14:16:23.956552
2	间隔触发器(interval)	interval		\N	f	sys_job_trigger	9	27	d8342b88-8bf4-43f2-8ef7-7f306b2e0057	0	间隔触发器任务触发器	2025-11-29 14:16:23.956555	2025-11-29 14:16:23.956556
3	cron表达式	cron		\N	f	sys_job_trigger	9	28	7d74993e-dd19-4657-86d1-a0ce6041c8b1	0	间隔触发器任务触发器	2025-11-29 14:16:23.956558	2025-11-29 14:16:23.956559
1	默认(default)	default		\N	t	sys_list_class	10	29	7083c8f6-1136-48fb-9320-c6dd2301f9c2	0	默认表格回显样式	2025-11-29 14:16:23.956561	2025-11-29 14:16:23.956562
2	主要(primary)	primary		\N	f	sys_list_class	10	30	fda04b01-310c-4171-ae33-331184a672e1	0	主要表格回显样式	2025-11-29 14:16:23.956564	2025-11-29 14:16:23.956565
3	成功(success)	success		\N	f	sys_list_class	10	31	5f938778-7442-4221-8789-df529a42f988	0	成功表格回显样式	2025-11-29 14:16:23.956568	2025-11-29 14:16:23.956568
4	信息(info)	info		\N	f	sys_list_class	10	32	54117d4c-d6d1-491e-b77b-d3b425fc4808	0	信息表格回显样式	2025-11-29 14:16:23.956571	2025-11-29 14:16:23.956571
5	警告(warning)	warning		\N	f	sys_list_class	10	33	266ef543-a594-4ec7-8a0f-afa11872cf8e	0	警告表格回显样式	2025-11-29 14:16:23.956574	2025-11-29 14:16:23.956574
6	危险(danger)	danger		\N	f	sys_list_class	10	34	3fa88eb3-5ebb-426e-bb63-15c3acd58ab3	0	危险表格回显样式	2025-11-29 14:16:23.956577	2025-11-29 14:16:23.956577
\.


--
-- Data for Name: sys_dict_type; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_dict_type (dict_name, dict_type, id, uuid, status, description, created_time, updated_time) FROM stdin;
用户性别	sys_user_sex	1	44926587-725e-4b70-9e68-0da131093d61	0	用户性别列表	2025-11-29 14:16:23.952884	2025-11-29 14:16:23.952885
系统是否	sys_yes_no	2	d0b80ed7-9bf4-498c-a775-06a86ed2a22a	0	系统是否列表	2025-11-29 14:16:23.952889	2025-11-29 14:16:23.952889
系统状态	sys_common_status	3	9ba9d2ab-4e22-4dc7-8213-070d8e9a8b48	0	系统状态	2025-11-29 14:16:23.952892	2025-11-29 14:16:23.952892
通知类型	sys_notice_type	4	41f912ce-3a17-481c-932c-a6d54bd86370	0	通知类型列表	2025-11-29 14:16:23.952895	2025-11-29 14:16:23.952895
操作类型	sys_oper_type	5	f6cd3a92-d8bd-4bf3-a17c-a601e53a8527	0	操作类型列表	2025-11-29 14:16:23.952898	2025-11-29 14:16:23.952899
任务存储器	sys_job_store	6	a6e9f3cd-07ec-4a59-a06a-212b1a41d234	0	任务分组列表	2025-11-29 14:16:23.952901	2025-11-29 14:16:23.952902
任务执行器	sys_job_executor	7	7faeebca-ed7d-4e1d-96c9-3537e6b99407	0	任务执行器列表	2025-11-29 14:16:23.952904	2025-11-29 14:16:23.952905
任务函数	sys_job_function	8	97202b52-07ab-4070-b9ae-c7cac1becf33	0	任务函数列表	2025-11-29 14:16:23.952907	2025-11-29 14:16:23.952908
任务触发器	sys_job_trigger	9	cb3bdb00-9fb3-4781-8427-9bc7d5959a43	0	任务触发器列表	2025-11-29 14:16:23.95291	2025-11-29 14:16:23.952911
表格回显样式	sys_list_class	10	c50bdf25-8ea9-4148-b779-9935deecef8c	0	表格回显样式列表	2025-11-29 14:16:23.952913	2025-11-29 14:16:23.952914
\.


--
-- Data for Name: sys_log; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_log (type, request_path, request_method, request_payload, request_ip, login_location, request_os, request_browser, response_code, response_json, process_time, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
\.


--
-- Data for Name: sys_menu; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_menu (name, type, "order", permission, icon, route_name, route_path, component_path, redirect, hidden, keep_alive, always_show, title, params, affix, parent_id, id, uuid, status, description, created_time, updated_time) FROM stdin;
仪表盘	1	1		client	Dashboard	/dashboard	\N	/dashboard/workplace	f	t	t	仪表盘	null	f	\N	1	4657cd9d-5677-4bef-b16a-7e4679fc479d	0	初始化数据	2025-11-29 14:16:23.936944	2025-11-29 14:16:23.936946
系统管理	1	2	\N	system	System	/system	\N	/system/menu	f	t	f	系统管理	null	f	\N	2	6f79c158-9adb-42c1-9e00-587a097c4d5e	0	初始化数据	2025-11-29 14:16:23.93695	2025-11-29 14:16:23.93695
应用管理	1	3	\N	el-icon-ShoppingBag	Application	/application	\N	/application/myapp	f	f	f	应用管理	null	f	\N	3	3ed9440f-76da-4100-92ea-8ab100fdcea5	0	初始化数据	2025-11-29 14:16:23.936954	2025-11-29 14:16:23.936954
监控管理	1	4	\N	monitor	Monitor	/monitor	\N	/monitor/online	f	f	f	监控管理	null	f	\N	4	dd314791-f4e0-4dba-bf62-87472f736f12	0	初始化数据	2025-11-29 14:16:23.936957	2025-11-29 14:16:23.936957
代码管理	1	5	\N	code	Gencode	/gencode	\N	/gencode/backcode	f	f	f	代码管理	null	f	\N	5	0723bece-7088-446a-9ef4-2b9c1704c7c4	0	代码管理	2025-11-29 14:16:23.93696	2025-11-29 14:16:23.936961
接口管理	1	6	\N	document	Common	/common	\N	/common/docs	f	f	f	接口管理	null	f	\N	6	b2bcb85b-dc04-4d5d-9c77-beeaef040357	0	初始化数据	2025-11-29 14:16:23.936964	2025-11-29 14:16:23.936964
案例管理	1	7	\N	el-icon-ElementPlus	Example	/example	\N	/example/demo	f	f	f	案例管理	null	f	\N	7	093b931f-7e0a-46c2-8316-37d22888eee9	0	案例管理	2025-11-29 14:16:23.936967	2025-11-29 14:16:23.936967
工作台	2	1	dashboard:workplace:query	el-icon-PieChart	Workplace	/dashboard/workplace	dashboard/workplace	\N	f	t	f	工作台	null	f	1	8	fae598aa-3fb3-4889-b8b2-44c7aec3daea	0	初始化数据	2025-11-29 14:16:23.9394	2025-11-29 14:16:23.939402
菜单管理	2	1	module_system:menu:query	menu	Menu	/system/menu	module_system/menu/index	\N	f	t	f	菜单管理	null	f	2	9	8a93b80a-eb04-470a-906f-946f2c9c016b	0	初始化数据	2025-11-29 14:16:23.939406	2025-11-29 14:16:23.939406
部门管理	2	2	module_system:dept:query	tree	Dept	/system/dept	module_system/dept/index	\N	f	t	f	部门管理	null	f	2	10	c6aaed4e-8534-4fbe-a99d-8fd755660463	0	初始化数据	2025-11-29 14:16:23.939409	2025-11-29 14:16:23.93941
租户管理	2	3	module_system:tenant:query	el-icon-Avatar	Tenant	/system/tenant	module_system/tenant/index	\N	f	t	f	租户管理	null	f	2	11	13c36a65-50b8-444d-8c20-090a7f2baa18	0	初始化数据	2025-11-29 14:16:23.939412	2025-11-29 14:16:23.939413
客户管理	2	3	module_system:customer:query	el-icon-Avatar	Customer	/system/customer	module_system/customer/index	\N	f	t	f	客户管理	null	f	2	12	311181cb-9866-47d5-9525-61ea6b123a89	0	初始化数据	2025-11-29 14:16:23.939416	2025-11-29 14:16:23.939416
岗位管理	2	3	module_system:position:query	el-icon-Coordinate	Position	/system/position	module_system/position/index	\N	f	t	f	岗位管理	null	f	2	13	1e50a69f-52a8-4950-abed-bcbe8cbb5410	0	初始化数据	2025-11-29 14:16:23.939419	2025-11-29 14:16:23.939419
角色管理	2	4	module_system:role:query	role	Role	/system/role	module_system/role/index	\N	f	t	f	角色管理	null	f	2	14	69879245-938b-49e3-becd-113ca6d67e23	0	初始化数据	2025-11-29 14:16:23.939422	2025-11-29 14:16:23.939422
用户管理	2	5	module_system:user:query	el-icon-User	User	/system/user	module_system/user/index	\N	f	t	f	用户管理	null	f	2	15	f16c21b9-6aaf-4812-8665-4229049288ba	0	初始化数据	2025-11-29 14:16:23.939425	2025-11-29 14:16:23.939426
日志管理	2	6	module_system:log:query	el-icon-Aim	Log	/system/log	module_system/log/index	\N	f	t	f	日志管理	null	f	2	16	a4eaff40-c461-4ddf-9e1d-104ba04bb2e2	0	初始化数据	2025-11-29 14:16:23.939428	2025-11-29 14:16:23.939429
公告管理	2	7	module_system:notice:query	bell	Notice	/system/notice	module_system/notice/index	\N	f	t	f	公告管理	null	f	2	17	d3991e02-3111-455e-8ed7-718ca66d2e12	0	初始化数据	2025-11-29 14:16:23.939432	2025-11-29 14:16:23.939432
参数管理	2	8	module_system:param:query	setting	Params	/system/param	module_system/param/index	\N	f	t	f	参数管理	null	f	2	18	a7932a32-ed63-43f8-9cf9-e93c965b810d	0	初始化数据	2025-11-29 14:16:23.939435	2025-11-29 14:16:23.939435
字典管理	2	9	module_system:dict_type:query	dict	Dict	/system/dict	module_system/dict/index	\N	f	t	f	字典管理	null	f	2	19	0ccda89e-029a-4357-851f-27bd3decab69	0	初始化数据	2025-11-29 14:16:23.939438	2025-11-29 14:16:23.939438
我的应用	2	1	module_application:myapp:query	el-icon-ShoppingCartFull	MYAPP	/application/myapp	module_application/myapp/index	\N	f	t	f	我的应用	null	f	3	20	daa46d9d-fb7e-4035-ac24-3f438c4cc636	0	初始化数据	2025-11-29 14:16:23.939441	2025-11-29 14:16:23.939442
任务管理	2	2	module_application:job:query	el-icon-DataLine	Job	/application/job	module_application/job/index	\N	f	t	f	任务管理	null	f	3	21	a659669f-8fdc-4b68-9933-71c5cbd00250	0	初始化数据	2025-11-29 14:16:23.939444	2025-11-29 14:16:23.939445
AI智能助手	2	3	module_application:ai:chat	el-icon-ToiletPaper	AI	/application/ai	module_application/ai/index	\N	f	t	f	AI智能助手	null	f	3	22	f4ad6ff7-7c70-4019-a88a-9d00bbd1f2b5	0	AI智能助手	2025-11-29 14:16:23.939447	2025-11-29 14:16:23.939448
流程管理	2	4	module_application:workflow:query	el-icon-ShoppingBag	Workflow	/application/workflow	module_application/workflow/index	\N	f	t	f	我的流程	null	f	3	23	2e8c4d8e-1fff-4f7a-aa1c-bfe65b539df1	0	我的流程	2025-11-29 14:16:23.93945	2025-11-29 14:16:23.939451
在线用户	2	1	module_monitor:online:query	el-icon-Headset	MonitorOnline	/monitor/online	module_monitor/online/index	\N	f	f	f	在线用户	null	f	4	24	fc40d87e-e8f4-4df0-a731-56c7508c5e2d	0	初始化数据	2025-11-29 14:16:23.939453	2025-11-29 14:16:23.939454
服务器监控	2	2	module_monitor:server:query	el-icon-Odometer	MonitorServer	/monitor/server	module_monitor/server/index	\N	f	f	f	服务器监控	null	f	4	25	315067e2-65da-4f26-8268-1bee7bc4cc3c	0	初始化数据	2025-11-29 14:16:23.939456	2025-11-29 14:16:23.939457
缓存监控	2	3	module_monitor:cache:query	el-icon-Stopwatch	MonitorCache	/monitor/cache	module_monitor/cache/index	\N	f	f	f	缓存监控	null	f	4	26	109c4c54-1929-4f2f-8ea8-6aca0ca60e38	0	初始化数据	2025-11-29 14:16:23.93946	2025-11-29 14:16:23.93946
文件管理	2	4	module_monitor:resource:query	el-icon-Files	Resource	/monitor/resource	module_monitor/resource/index	\N	f	t	f	文件管理	null	f	4	27	61637b66-60c0-4fb7-beeb-d7e8bd3a7b55	0	初始化数据	2025-11-29 14:16:23.939463	2025-11-29 14:16:23.939463
代码生成	2	1	module_generator:gencode:query	code	Backcode	/gencode/backcode	module_generator/backcode/index	\N	f	t	f	代码生成	null	f	5	28	265feebd-b7d1-41ae-85e9-99e145732588	0	代码生成	2025-11-29 14:16:23.939466	2025-11-29 14:16:23.939466
Swagger文档	4	1	module_common:docs:query	api	Docs	/common/docs	module_common/docs/index	\N	f	f	f	Swagger文档	null	f	6	29	0eb3a618-8ad3-4f11-837e-b3a990a72ed6	0	初始化数据	2025-11-29 14:16:23.939469	2025-11-29 14:16:23.939469
Redoc文档	4	2	module_common:redoc:query	el-icon-Document	Redoc	/common/redoc	module_common/redoc/index	\N	f	f	f	Redoc文档	null	f	6	30	b1cf605c-6c5f-43be-99f9-0e427093d9de	0	初始化数据	2025-11-29 14:16:23.939472	2025-11-29 14:16:23.939472
示例管理	2	1	module_example:demo:query	el-icon-ElementPlus	Demo	/example/demo	module_example/demo/index	\N	f	t	f	示例管理	null	f	7	31	54b66adb-0b2c-4664-a9d3-570203193a2e	0	示例管理	2025-11-29 14:16:23.939475	2025-11-29 14:16:23.939475
创建菜单	3	1	module_system:menu:create	\N	\N	\N	\N	\N	f	t	f	创建菜单	null	f	9	32	aa82c1c4-9231-4933-9535-904529bcda71	0	初始化数据	2025-11-29 14:16:23.942735	2025-11-29 14:16:23.942737
修改菜单	3	2	module_system:menu:update	\N	\N	\N	\N	\N	f	t	f	修改菜单	null	f	9	33	dfb453e4-822d-4bee-a01a-e360b599e8ff	0	初始化数据	2025-11-29 14:16:23.942741	2025-11-29 14:16:23.942741
删除菜单	3	3	module_system:menu:delete	\N	\N	\N	\N	\N	f	t	f	删除菜单	null	f	9	34	ca9a4272-6c29-482b-a420-4000a7042da5	0	初始化数据	2025-11-29 14:16:23.942744	2025-11-29 14:16:23.942745
批量修改菜单状态	3	4	module_system:menu:patch	\N	\N	\N	\N	\N	f	t	f	批量修改菜单状态	null	f	9	35	87a0d56f-ece4-4d50-84a2-4eb04c8cad94	0	初始化数据	2025-11-29 14:16:23.942748	2025-11-29 14:16:23.942748
创建部门	3	1	module_system:dept:create	\N	\N	\N	\N	\N	f	t	f	创建部门	null	f	10	36	43a3d9d9-f960-429b-88ed-a4fe686aaa95	0	初始化数据	2025-11-29 14:16:23.942751	2025-11-29 14:16:23.942751
修改部门	3	2	module_system:dept:update	\N	\N	\N	\N	\N	f	t	f	修改部门	null	f	10	37	3f83ecf8-bf22-4a6b-8548-1857abe64178	0	初始化数据	2025-11-29 14:16:23.942754	2025-11-29 14:16:23.942755
删除部门	3	3	module_system:dept:delete	\N	\N	\N	\N	\N	f	t	f	删除部门	null	f	10	38	c6b932ff-8ed4-4bb6-bf99-818f138295df	0	初始化数据	2025-11-29 14:16:23.942759	2025-11-29 14:16:23.942759
批量修改部门状态	3	4	module_system:dept:patch	\N	\N	\N	\N	\N	f	t	f	批量修改部门状态	null	f	10	39	1398bccd-cdd5-45a6-ac0b-e38610106b2d	0	初始化数据	2025-11-29 14:16:23.942762	2025-11-29 14:16:23.942763
创建租户	3	1	module_system:tenant:create	\N	\N	\N	\N	\N	f	t	f	创建租户	null	f	11	40	abb924a3-af4e-4a3c-aa6e-7fb25eb26d83	0	初始化数据	2025-11-29 14:16:23.942766	2025-11-29 14:16:23.942766
更新租户	3	2	module_system:tenant:update	\N	\N	\N	\N	\N	f	t	f	更新租户	null	f	11	41	519611f4-8a0a-4a5e-9cf2-e292c2179259	0	初始化数据	2025-11-29 14:16:23.942769	2025-11-29 14:16:23.942769
删除租户	3	3	module_system:tenant:delete	\N	\N	\N	\N	\N	f	t	f	删除租户	null	f	11	42	e79b41f7-70e9-4bb3-ae74-a855790d10c0	0	初始化数据	2025-11-29 14:16:23.942772	2025-11-29 14:16:23.942772
批量修改租户状态	3	4	module_system:tenant:patch	\N	\N	\N	\N	\N	f	t	f	批量修改租户状态	null	f	11	43	e1272443-8cd3-4dfa-a8bc-0c586fe86ee2	0	初始化数据	2025-11-29 14:16:23.942775	2025-11-29 14:16:23.942776
导出租户	3	5	module_system:tenant:export	\N	\N	\N	\N	\N	f	t	f	导出租户	null	f	11	44	c57524a7-c153-4f61-adc7-dd79b8914bf2	0	初始化数据	2025-11-29 14:16:23.942778	2025-11-29 14:16:23.942779
导入租户	3	6	module_system:tenant:import	\N	\N	\N	\N	\N	f	t	f	导入租户	null	f	11	45	78ac3299-4fc2-4db8-a8a5-a9f15ef37101	0	初始化数据	2025-11-29 14:16:23.942781	2025-11-29 14:16:23.942782
下载导入租户模版	3	7	module_system:tenant:download	\N	\N	\N	\N	\N	f	t	f	下载导入租户模版	null	f	11	46	7d4d961f-a5f4-49fd-92d4-09dd08e806aa	0	初始化数据	2025-11-29 14:16:23.942785	2025-11-29 14:16:23.942785
创建客户	3	1	module_system:customer:create	\N	\N	\N	\N	\N	f	t	f	创建客户	null	f	12	47	293b646f-cf8e-4eab-8894-a4b27c7a404c	0	初始化数据	2025-11-29 14:16:23.942788	2025-11-29 14:16:23.942788
更新客户	3	2	module_system:customer:update	\N	\N	\N	\N	\N	f	t	f	更新客户	null	f	12	48	082a68cc-e172-486b-8581-327aacb8d363	0	初始化数据	2025-11-29 14:16:23.942791	2025-11-29 14:16:23.942791
删除客户	3	3	module_system:customer:delete	\N	\N	\N	\N	\N	f	t	f	删除客户	null	f	12	49	f076789d-f8d0-41ec-a337-e8dd1fdaf88b	0	初始化数据	2025-11-29 14:16:23.942794	2025-11-29 14:16:23.942795
批量修改客户状态	3	4	module_system:customer:patch	\N	\N	\N	\N	\N	f	t	f	批量修改客户状态	null	f	12	50	0ebf030b-23dd-4610-812c-e90d87f624a8	0	初始化数据	2025-11-29 14:16:23.942797	2025-11-29 14:16:23.942798
导出客户	3	5	module_system:customer:export	\N	\N	\N	\N	\N	f	t	f	导出客户	null	f	12	51	48d7c0f7-afa9-4216-b40a-64944b37f60d	0	初始化数据	2025-11-29 14:16:23.942801	2025-11-29 14:16:23.942801
导入客户	3	6	module_system:customer:import	\N	\N	\N	\N	\N	f	t	f	导入客户	null	f	12	52	67e717d1-c345-4f6b-b269-82ce3fdf5e27	0	初始化数据	2025-11-29 14:16:23.942804	2025-11-29 14:16:23.942804
下载导入客户模版	3	7	module_system:customer:download	\N	\N	\N	\N	\N	f	t	f	下载导入客户模版	null	f	12	53	d84ff772-d4bc-4623-bda8-a1b4d4a101c6	0	初始化数据	2025-11-29 14:16:23.942807	2025-11-29 14:16:23.942807
创建岗位	3	1	module_system:position:create	\N	\N	\N	\N	\N	f	t	f	创建岗位	null	f	13	54	ab02ab9a-4598-4a27-b7ee-b6ed92ed4c45	0	初始化数据	2025-11-29 14:16:23.94281	2025-11-29 14:16:23.94281
修改岗位	3	2	module_system:position:update	\N	\N	\N	\N	\N	f	t	f	修改岗位	null	f	13	55	335614ea-cf42-4c69-8358-24b6105bb4de	0	初始化数据	2025-11-29 14:16:23.942813	2025-11-29 14:16:23.942813
删除岗位	3	3	module_system:position:delete	\N	\N	\N	\N	\N	f	t	f	修改岗位	null	f	13	56	34e5f7a6-a387-4053-9909-0616bc0ee86c	0	初始化数据	2025-11-29 14:16:23.942816	2025-11-29 14:16:23.942816
批量修改岗位状态	3	4	module_system:position:patch	\N	\N	\N	\N	\N	f	t	f	批量修改岗位状态	null	f	13	57	b0bcbc03-8235-4d69-8e5c-36da5082d153	0	初始化数据	2025-11-29 14:16:23.942819	2025-11-29 14:16:23.942819
岗位导出	3	5	module_system:position:export	\N	\N	\N	\N	\N	f	t	f	岗位导出	null	f	13	58	ad9b0a5f-eb3d-4358-a0c6-145aa2086f41	0	初始化数据	2025-11-29 14:16:23.942822	2025-11-29 14:16:23.942822
设置角色权限	3	8	module_system:role:permission	\N	\N	\N	\N	\N	f	t	f	设置角色权限	null	f	13	59	10a29b33-c585-41a6-93e0-cadc6dec5c85	0	初始化数据	2025-11-29 14:16:23.942825	2025-11-29 14:16:23.942826
创建角色	3	1	module_system:role:create	\N	\N	\N	\N	\N	f	t	f	创建角色	null	f	14	60	90e2d895-63d5-4da8-87d0-cef5adf69301	0	初始化数据	2025-11-29 14:16:23.942828	2025-11-29 14:16:23.942829
修改角色	3	2	module_system:role:update	\N	\N	\N	\N	\N	f	t	f	修改角色	null	f	14	61	d0696963-4ab0-45c2-8a9e-d5b84d66d4d3	0	初始化数据	2025-11-29 14:16:23.942831	2025-11-29 14:16:23.942832
删除角色	3	3	module_system:role:delete	\N	\N	\N	\N	\N	f	t	f	删除角色	null	f	14	62	c2d671b8-2570-41cb-9ad4-7c39d65fccf2	0	初始化数据	2025-11-29 14:16:23.942834	2025-11-29 14:16:23.942835
批量修改角色状态	3	4	module_system:role:patch	\N	\N	\N	\N	\N	f	t	f	批量修改角色状态	null	f	14	63	82388ca9-0e7b-4475-a2bc-155b07e18a21	0	初始化数据	2025-11-29 14:16:23.942837	2025-11-29 14:16:23.942838
角色导出	3	6	module_system:role:export	\N	\N	\N	\N	\N	f	t	f	角色导出	null	f	14	64	125a5236-3bd4-4710-aa42-fb498a104db6	0	初始化数据	2025-11-29 14:16:23.94284	2025-11-29 14:16:23.942841
创建用户	3	1	module_system:user:create	\N	\N	\N	\N	\N	f	t	f	创建用户	null	f	15	65	172d5c4d-34c4-46df-a4da-484d7f546d70	0	初始化数据	2025-11-29 14:16:23.942843	2025-11-29 14:16:23.942844
修改用户	3	2	module_system:user:update	\N	\N	\N	\N	\N	f	t	f	修改用户	null	f	15	66	74bf464a-547e-4598-be10-77f94576e26a	0	初始化数据	2025-11-29 14:16:23.942847	2025-11-29 14:16:23.942847
删除用户	3	3	module_system:user:delete	\N	\N	\N	\N	\N	f	t	f	删除用户	null	f	15	67	17cf8597-60cb-47f3-b61d-8b319d0700c4	0	初始化数据	2025-11-29 14:16:23.94285	2025-11-29 14:16:23.94285
批量修改用户状态	3	4	module_system:user:patch	\N	\N	\N	\N	\N	f	t	f	批量修改用户状态	null	f	15	68	d8f2e7d9-9af6-4a08-a242-f804dc010dcb	0	初始化数据	2025-11-29 14:16:23.942853	2025-11-29 14:16:23.942853
导出用户	3	5	module_system:user:export	\N	\N	\N	\N	\N	f	t	f	导出用户	null	f	15	69	3d84d689-bcb0-4b45-abcd-ca9d98d0c467	0	初始化数据	2025-11-29 14:16:23.942856	2025-11-29 14:16:23.942856
导入用户	3	6	module_system:user:import	\N	\N	\N	\N	\N	f	t	f	导入用户	null	f	15	70	3ad61b82-cb6f-444c-9a15-1ffb57544550	0	初始化数据	2025-11-29 14:16:23.942875	2025-11-29 14:16:23.942876
日志删除	3	1	module_system:log:delete	\N	\N	\N	\N	\N	f	t	f	日志删除	null	f	16	71	72210149-6110-49ec-a83c-c74ea12e241e	0	初始化数据	2025-11-29 14:16:23.942881	2025-11-29 14:16:23.942882
日志导出	3	2	module_system:log:export	\N	\N	\N	\N	\N	f	t	f	日志导出	null	f	16	72	4e63615f-be34-4321-b2b9-161ae418f2b8	0	初始化数据	2025-11-29 14:16:23.942885	2025-11-29 14:16:23.942885
公告创建	3	1	module_system:notice:create	\N	\N	\N	\N	\N	f	t	f	公告创建	null	f	17	73	8d1a4c22-9e25-4cf8-8cda-3adcf9eed966	0	初始化数据	2025-11-29 14:16:23.942888	2025-11-29 14:16:23.942889
公告修改	3	2	module_system:notice:update	\N	\N	\N	\N	\N	f	t	f	修改用户	null	f	17	74	3323e962-5dc1-4641-9ec5-53fd11a8ad80	0	初始化数据	2025-11-29 14:16:23.942892	2025-11-29 14:16:23.942892
公告删除	3	3	module_system:notice:delete	\N	\N	\N	\N	\N	f	t	f	公告删除	null	f	17	75	44fcc1bb-b743-4fd7-bd4d-96d7fd18b66b	0	初始化数据	2025-11-29 14:16:23.942895	2025-11-29 14:16:23.942895
公告导出	3	4	module_system:notice:export	\N	\N	\N	\N	\N	f	t	f	公告导出	null	f	17	76	a0638ae7-df7d-4d58-adf0-3094976d8eaa	0	初始化数据	2025-11-29 14:16:23.942898	2025-11-29 14:16:23.942898
公告批量修改状态	3	5	module_system:notice:patch	\N	\N	\N	\N	\N	f	t	f	公告批量修改状态	null	f	17	77	0ff55024-4c16-44f1-ac31-e8cff97bbcd1	0	初始化数据	2025-11-29 14:16:23.942901	2025-11-29 14:16:23.942902
创建参数	3	1	module_system:param:create	\N	\N	\N	\N	\N	f	t	f	创建参数	null	f	18	78	c44b1f08-ebea-421f-bb4c-1904ce2b1827	0	初始化数据	2025-11-29 14:16:23.942904	2025-11-29 14:16:23.942905
修改参数	3	2	module_system:param:update	\N	\N	\N	\N	\N	f	t	f	修改参数	null	f	18	79	43837d6d-c28e-4f7c-b901-97f0bb70b1a2	0	初始化数据	2025-11-29 14:16:23.942908	2025-11-29 14:16:23.942908
删除参数	3	3	module_system:param:delete	\N	\N	\N	\N	\N	f	t	f	删除参数	null	f	18	80	badb0c33-7591-4aff-84a7-6b9b1b4fa7a8	0	初始化数据	2025-11-29 14:16:23.942911	2025-11-29 14:16:23.942911
导出参数	3	4	module_system:param:export	\N	\N	\N	\N	\N	f	t	f	导出参数	null	f	18	81	a158f329-df49-468e-b31f-4eb2f3f68374	0	初始化数据	2025-11-29 14:16:23.942914	2025-11-29 14:16:23.942914
参数上传	3	5	module_system:param:upload	\N	\N	\N	\N	\N	f	t	f	参数上传	null	f	18	82	6377eb53-46d3-4160-b1f8-17be4c0a9dd5	0	初始化数据	2025-11-29 14:16:23.942917	2025-11-29 14:16:23.942917
创建字典类型	3	1	module_system:dict_type:create	\N	\N	\N	\N	\N	f	t	f	创建字典类型	null	f	19	83	1cd9d07d-bd1e-4061-97e0-d9a8e71af575	0	初始化数据	2025-11-29 14:16:23.94292	2025-11-29 14:16:23.94292
修改字典类型	3	2	module_system:dict_type:update	\N	\N	\N	\N	\N	f	t	f	修改字典类型	null	f	19	84	81cad0ae-435e-4fa8-b310-de047006b634	0	初始化数据	2025-11-29 14:16:23.942923	2025-11-29 14:16:23.942924
删除字典类型	3	3	module_system:dict_type:delete	\N	\N	\N	\N	\N	f	t	f	删除字典类型	null	f	19	85	83845f00-ac6e-4af9-b52a-0bffc3554edf	0	初始化数据	2025-11-29 14:16:23.942926	2025-11-29 14:16:23.942927
导出字典类型	3	4	module_system:dict_type:export	\N	\N	\N	\N	\N	f	t	f	导出字典类型	null	f	19	86	72db0ed4-95a2-416b-8305-b29eb0f7bafd	0	初始化数据	2025-11-29 14:16:23.942929	2025-11-29 14:16:23.94293
批量修改字典状态	3	5	module_system:dict_type:patch	\N	\N	\N	\N	\N	f	t	f	导出字典类型	null	f	19	87	8139361b-5062-44c6-8772-39416468b398	0	初始化数据	2025-11-29 14:16:23.942932	2025-11-29 14:16:23.942933
字典数据查询	3	6	module_system:dict_data:query	\N	\N	\N	\N	\N	f	t	f	字典数据查询	null	f	19	88	4b00c80d-2437-434e-b0f5-ce8079cf6818	0	初始化数据	2025-11-29 14:16:23.942935	2025-11-29 14:16:23.942936
创建字典数据	3	7	module_system:dict_data:create	\N	\N	\N	\N	\N	f	t	f	创建字典数据	null	f	19	89	1b927ed4-13f3-4c44-b8b1-cddb11969681	0	初始化数据	2025-11-29 14:16:23.942938	2025-11-29 14:16:23.942939
修改字典数据	3	8	module_system:dict_data:update	\N	\N	\N	\N	\N	f	t	f	修改字典数据	null	f	19	90	bca00c47-6374-4619-8849-9635dd7c9859	0	初始化数据	2025-11-29 14:16:23.942941	2025-11-29 14:16:23.942942
删除字典数据	3	9	module_system:dict_data:delete	\N	\N	\N	\N	\N	f	t	f	删除字典数据	null	f	19	91	7c331190-2661-4c8e-afe8-8548e49441d6	0	初始化数据	2025-11-29 14:16:23.942945	2025-11-29 14:16:23.942945
导出字典数据	3	10	module_system:dict_data:export	\N	\N	\N	\N	\N	f	t	f	导出字典数据	null	f	19	92	12db0f29-4fef-49db-a1ae-c73615b2fd06	0	初始化数据	2025-11-29 14:16:23.942948	2025-11-29 14:16:23.942948
批量修改字典数据状态	3	11	module_system:dict_data:patch	\N	\N	\N	\N	\N	f	t	f	批量修改字典数据状态	null	f	19	93	fbbec277-9120-4b30-821f-1b9324ecdc62	0	初始化数据	2025-11-29 14:16:23.942951	2025-11-29 14:16:23.942951
创建应用	3	1	module_application:myapp:create	\N	\N	\N	\N	\N	f	t	f	创建应用	null	f	20	94	32f2b6fa-f277-439a-8072-af8fa26b45bb	0	初始化数据	2025-11-29 14:16:23.942954	2025-11-29 14:16:23.942954
修改应用	3	2	module_application:myapp:update	\N	\N	\N	\N	\N	f	t	f	修改应用	null	f	20	95	ba0dcc56-8ac1-473c-8cdc-61208a5c1e9e	0	初始化数据	2025-11-29 14:16:23.942957	2025-11-29 14:16:23.942957
删除应用	3	3	module_application:myapp:delete	\N	\N	\N	\N	\N	f	t	f	删除应用	null	f	20	96	6081bd27-8165-417d-878c-21f3bb16d612	0	初始化数据	2025-11-29 14:16:23.94296	2025-11-29 14:16:23.94296
批量修改应用状态	3	4	module_application:myapp:patch	\N	\N	\N	\N	\N	f	t	f	批量修改应用状态	null	f	20	97	bc758628-d403-405a-9716-1624c5a805ca	0	初始化数据	2025-11-29 14:16:23.942963	2025-11-29 14:16:23.942963
创建任务	3	1	module_application:job:create	\N	\N	\N	\N	\N	f	t	f	创建任务	null	f	21	98	69d74dc0-12a8-448d-8ad0-db8686c81c00	0	初始化数据	2025-11-29 14:16:23.942966	2025-11-29 14:16:23.942966
修改和操作任务	3	2	module_application:job:update	\N	\N	\N	\N	\N	f	t	f	修改和操作任务	null	f	21	99	e8392584-ed58-45b9-88b3-476dea1ad06f	0	初始化数据	2025-11-29 14:16:23.942969	2025-11-29 14:16:23.94297
删除和清除任务	3	3	module_application:job:delete	\N	\N	\N	\N	\N	f	t	f	删除和清除任务	null	f	21	100	67a21be2-779d-4dd7-b2d3-aa51e5cfa806	0	初始化数据	2025-11-29 14:16:23.942972	2025-11-29 14:16:23.942973
导出定时任务	3	4	module_application:job:export	\N	\N	\N	\N	\N	f	t	f	导出定时任务	null	f	21	101	469cbbab-bbe3-4f0c-ba3d-50e5d00427b7	0	初始化数据	2025-11-29 14:16:23.942975	2025-11-29 14:16:23.942976
智能对话	3	1	module_application:ai:chat	\N	\N	\N	\N	\N	f	t	f	智能对话	null	f	22	102	5d6bd88d-5f27-48a6-afec-036b3d5ce807	0	智能对话	2025-11-29 14:16:23.942978	2025-11-29 14:16:23.942979
在线用户强制下线	3	1	module_monitor:online:delete	\N	\N	\N	\N	\N	f	f	f	在线用户强制下线	null	f	24	103	84c30da6-ee04-482a-af70-a10497cbd0d8	0	初始化数据	2025-11-29 14:16:23.942981	2025-11-29 14:16:23.942982
清除缓存	3	1	module_monitor:cache:delete	\N	\N	\N	\N	\N	f	f	f	清除缓存	null	f	26	104	e55975e9-ec3a-49e8-8ccd-598cae37ab86	0	初始化数据	2025-11-29 14:16:23.942985	2025-11-29 14:16:23.942985
文件上传	3	1	module_monitor:resource:upload	\N	\N	\N	\N	\N	f	t	f	文件上传	null	f	27	105	e98a6153-3597-40c2-aac8-7ebef355873d	0	初始化数据	2025-11-29 14:16:23.942988	2025-11-29 14:16:23.942988
文件下载	3	2	module_monitor:resource:download	\N	\N	\N	\N	\N	f	t	f	文件下载	null	f	27	106	edbc002e-676a-420d-8e90-703b5067d0f8	0	初始化数据	2025-11-29 14:16:23.942991	2025-11-29 14:16:23.942991
文件删除	3	3	module_monitor:resource:delete	\N	\N	\N	\N	\N	f	t	f	文件删除	null	f	27	107	27a84b07-7ca6-4b32-bead-a09a224da616	0	初始化数据	2025-11-29 14:16:23.942994	2025-11-29 14:16:23.942994
文件移动	3	4	module_monitor:resource:move	\N	\N	\N	\N	\N	f	t	f	文件移动	null	f	27	108	d6f63456-1fe0-45a6-8eab-15e4e4d3cf85	0	初始化数据	2025-11-29 14:16:23.942997	2025-11-29 14:16:23.942997
文件复制	3	5	module_monitor:resource:copy	\N	\N	\N	\N	\N	f	t	f	文件复制	null	f	27	109	edd42ca9-4ed6-4d64-a21f-b843a4840fcb	0	初始化数据	2025-11-29 14:16:23.943	2025-11-29 14:16:23.943
文件重命名	3	6	module_monitor:resource:rename	\N	\N	\N	\N	\N	f	t	f	文件重命名	null	f	27	110	a05a0a90-c988-4913-80d6-8147b1f33e39	0	初始化数据	2025-11-29 14:16:23.943003	2025-11-29 14:16:23.943003
创建目录	3	7	module_monitor:resource:create_dir	\N	\N	\N	\N	\N	f	t	f	创建目录	null	f	27	111	144384b5-eaf8-4cae-886b-8a6c34400f9e	0	初始化数据	2025-11-29 14:16:23.943006	2025-11-29 14:16:23.943006
导出文件列表	3	9	module_monitor:resource:export	\N	\N	\N	\N	\N	f	t	f	导出文件列表	null	f	27	112	640c1559-b47f-4cff-a5c1-3e162ff8bf2a	0	初始化数据	2025-11-29 14:16:23.943009	2025-11-29 14:16:23.943009
查询代码生成业务表列表	3	1	module_generator:gencode:query	\N	\N	\N	\N	\N	f	t	f	查询代码生成业务表列表	null	f	28	113	b17e0b45-2ba4-4752-aa77-45530f829df1	0	查询代码生成业务表列表	2025-11-29 14:16:23.943012	2025-11-29 14:16:23.943013
创建表结构	3	2	module_generator:gencode:create	\N	\N	\N	\N	\N	f	t	f	创建表结构	null	f	28	114	c5907914-fef0-4774-9e48-8d5fa99168fd	0	创建表结构	2025-11-29 14:16:23.943015	2025-11-29 14:16:23.943016
编辑业务表信息	3	3	module_generator:gencode:update	\N	\N	\N	\N	\N	f	t	f	编辑业务表信息	null	f	28	115	9df43176-9e80-41d8-a2ff-28756e7cef31	0	编辑业务表信息	2025-11-29 14:16:23.943018	2025-11-29 14:16:23.943019
删除业务表信息	3	4	module_generator:gencode:delete	\N	\N	\N	\N	\N	f	t	f	删除业务表信息	null	f	28	116	95fbbbf5-f952-43d9-8a08-95b9904f063c	0	删除业务表信息	2025-11-29 14:16:23.943021	2025-11-29 14:16:23.943022
导入表结构	3	5	module_generator:gencode:import	\N	\N	\N	\N	\N	f	t	f	导入表结构	null	f	28	117	e1f88642-7295-4997-9c2d-488fcbd573d3	0	导入表结构	2025-11-29 14:16:23.943024	2025-11-29 14:16:23.943025
批量生成代码	3	6	module_generator:gencode:operate	\N	\N	\N	\N	\N	f	t	f	批量生成代码	null	f	28	118	ad032fbf-6af7-4b42-9ef4-6a9483bb7860	0	批量生成代码	2025-11-29 14:16:23.943027	2025-11-29 14:16:23.943028
生成代码到指定路径	3	7	module_generator:gencode:code	\N	\N	\N	\N	\N	f	t	f	生成代码到指定路径	null	f	28	119	0ed95a33-504e-411c-bd7b-25134e77df76	0	生成代码到指定路径	2025-11-29 14:16:23.943031	2025-11-29 14:16:23.943031
查询数据库表列表	3	8	module_generator:dblist:query	\N	\N	\N	\N	\N	f	t	f	查询数据库表列表	null	f	28	120	5ea4c32c-a173-4bf0-b60b-93743b9a99f3	0	查询数据库表列表	2025-11-29 14:16:23.943034	2025-11-29 14:16:23.943034
同步数据库	3	9	module_generator:db:sync	\N	\N	\N	\N	\N	f	t	f	同步数据库	null	f	28	121	ac3247a4-caa5-48a4-a868-dee39685b56a	0	同步数据库	2025-11-29 14:16:23.943037	2025-11-29 14:16:23.943037
创建示例	3	1	module_example:demo:create	\N	\N	\N	\N	\N	f	t	f	创建示例	null	f	31	122	67759f62-1290-476f-8252-9bae8adb6a44	0	初始化数据	2025-11-29 14:16:23.94304	2025-11-29 14:16:23.94304
更新示例	3	2	module_example:demo:update	\N	\N	\N	\N	\N	f	t	f	更新示例	null	f	31	123	c0fb36ed-ba78-4b54-a26f-4f5f8022ae4e	0	初始化数据	2025-11-29 14:16:23.943043	2025-11-29 14:16:23.943043
删除示例	3	3	module_example:demo:delete	\N	\N	\N	\N	\N	f	t	f	删除示例	null	f	31	124	ecbb2f6d-d231-4e74-98b6-31c924d5bc98	0	初始化数据	2025-11-29 14:16:23.943046	2025-11-29 14:16:23.943046
批量修改示例状态	3	4	module_example:demo:patch	\N	\N	\N	\N	\N	f	t	f	批量修改示例状态	null	f	31	125	638dc6c6-8378-4720-af39-0a2e436e7a56	0	初始化数据	2025-11-29 14:16:23.943049	2025-11-29 14:16:23.943049
导出示例	3	5	module_example:demo:export	\N	\N	\N	\N	\N	f	t	f	导出示例	null	f	31	126	c0d8fca0-7de8-4017-a4c8-71bcf9dd35bb	0	初始化数据	2025-11-29 14:16:23.943052	2025-11-29 14:16:23.943052
导入示例	3	6	module_example:demo:import	\N	\N	\N	\N	\N	f	t	f	导入示例	null	f	31	127	a71c82d3-ed63-49ce-bff0-86e03326c1fd	0	初始化数据	2025-11-29 14:16:23.943055	2025-11-29 14:16:23.943055
下载导入示例模版	3	7	module_example:demo:download	\N	\N	\N	\N	\N	f	t	f	下载导入示例模版	null	f	31	128	580baeb3-1e02-4a87-b191-1e01d86ba82e	0	初始化数据	2025-11-29 14:16:23.943058	2025-11-29 14:16:23.943058
\.


--
-- Data for Name: sys_notice; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_notice (notice_title, notice_type, notice_content, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
\.


--
-- Data for Name: sys_param; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_param (config_name, config_key, config_value, config_type, id, uuid, status, description, created_time, updated_time) FROM stdin;
网站名称	sys_web_title	FastApiAdmin	t	1	cdfdad6b-ec1d-44ad-b09c-1dcebc003a96	0	初始化数据	2025-11-29 14:16:23.950135	2025-11-29 14:16:23.950136
网站描述	sys_web_description	FastApiAdmin 是完全开源的权限管理系统	t	2	b9d128e8-63ad-49a2-9c59-8f50d1548da6	0	初始化数据	2025-11-29 14:16:23.95014	2025-11-29 14:16:23.95014
网页图标	sys_web_favicon	https://service.fastapiadmin.com/api/v1/static/image/favicon.png	t	3	2645fcf9-2dbb-43aa-9f85-0643acdde4cf	0	初始化数据	2025-11-29 14:16:23.950143	2025-11-29 14:16:23.950143
网站Logo	sys_web_logo	https://service.fastapiadmin.com/api/v1/static/image/logo.png	t	4	5bedbe5e-32f5-44c9-a5ed-09091bf321f5	0	初始化数据	2025-11-29 14:16:23.950146	2025-11-29 14:16:23.950147
登录背景	sys_login_background	https://service.fastapiadmin.com/api/v1/static/image/background.svg	t	5	a062fe42-cb98-4a9f-920d-a23c7404e4ed	0	初始化数据	2025-11-29 14:16:23.950149	2025-11-29 14:16:23.95015
版权信息	sys_web_copyright	Copyright © 2025-2026 service.fastapiadmin.com 版权所有	t	6	6f78be4d-eac3-41cd-a1af-69a02a794a3a	0	初始化数据	2025-11-29 14:16:23.950153	2025-11-29 14:16:23.950153
备案信息	sys_keep_record	陕ICP备2025069493号-1	t	7	8b0486a6-187a-4657-958f-bf1853346725	0	初始化数据	2025-11-29 14:16:23.950156	2025-11-29 14:16:23.950156
帮助文档	sys_help_doc	https://service.fastapiadmin.com	t	8	80c05cef-3352-40a6-8518-8fbff71f1641	0	初始化数据	2025-11-29 14:16:23.950159	2025-11-29 14:16:23.950159
隐私政策	sys_web_privacy	https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE	t	9	fe3d3fc7-d2a3-413e-bb65-b01a7b85e0c1	0	初始化数据	2025-11-29 14:16:23.950162	2025-11-29 14:16:23.950162
用户协议	sys_web_clause	https://github.com/1014TaoTao/FastapiAdmin/blob/master/LICENSE	t	10	ecb86a40-22cd-4567-99e9-53abcb12760e	0	初始化数据	2025-11-29 14:16:23.950165	2025-11-29 14:16:23.950165
源码代码	sys_git_code	https://github.com/1014TaoTao/FastapiAdmin.git	t	11	911216d4-7cde-474a-88ae-c3f65d7bf42a	0	初始化数据	2025-11-29 14:16:23.950168	2025-11-29 14:16:23.950168
项目版本	sys_web_version	2.0.0	t	12	73ad1b65-0487-41f5-a33d-b0c9ff51f94e	0	初始化数据	2025-11-29 14:16:23.950171	2025-11-29 14:16:23.950171
演示模式启用	demo_enable	false	t	13	e86b013b-9fba-4ce8-8954-444b741579fa	0	初始化数据	2025-11-29 14:16:23.950174	2025-11-29 14:16:23.950174
演示访问IP白名单	ip_white_list	["127.0.0.1"]	t	14	98b572b6-b184-4a4c-bac7-74315e3dd5b8	0	初始化数据	2025-11-29 14:16:23.950177	2025-11-29 14:16:23.950177
接口白名单	white_api_list_path	["/api/v1/system/auth/login", "/api/v1/system/auth/token/refresh", "/api/v1/system/auth/captcha/get", "/api/v1/system/auth/logout", "/api/v1/system/config/info", "/api/v1/system/user/current/info", "/api/v1/system/notice/available"]	t	15	82aa8aec-72d1-412a-b676-e1336c3174a1	0	初始化数据	2025-11-29 14:16:23.95018	2025-11-29 14:16:23.95018
访问IP黑名单	ip_black_list	[]	t	16	72e0e2e2-3e0f-4059-b5bf-2925d543e060	0	初始化数据	2025-11-29 14:16:23.950183	2025-11-29 14:16:23.950183
\.


--
-- Data for Name: sys_position; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_position (name, "order", id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id) FROM stdin;
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_role (name, code, "order", data_scope, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id) FROM stdin;
管理员角色	ADMIN	1	4	1	4a2c80e3-8da7-4d54-8424-4758d707e1dc	0	初始化角色	2025-11-29 14:16:23.965653	2025-11-29 14:16:23.965655	1	1	1
\.


--
-- Data for Name: sys_role_depts; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_role_depts (role_id, dept_id) FROM stdin;
\.


--
-- Data for Name: sys_role_menus; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_role_menus (role_id, menu_id) FROM stdin;
\.


--
-- Data for Name: sys_tenant; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_tenant (name, code, start_time, end_time, id, uuid, status, description, created_time, updated_time) FROM stdin;
运行管理平台	SYSTEM	\N	\N	1	4ef31cc5-1af3-4ba6-919b-575277cb0ef9	0	系统内置租户，用于管理平台全局配置和所有租户	2025-11-29 14:16:23.92777	2025-11-29 14:16:23.927774
\.


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_user (username, password, name, mobile, email, gender, avatar, is_superuser, last_login, gitee_login, github_login, wx_login, qq_login, user_type, salt, dept_id, id, uuid, status, description, created_time, updated_time, created_id, updated_id, tenant_id, customer_id) FROM stdin;
admin	$2b$12$e2IJgS/cvHgJ0H3G7Xa08OXoXnk6N/NX3IZRtubBDElA0VLZhkNOa	超级管理员	\N	\N	0	https://service.fastapiadmin.com/api/v1/static/image/avatar.png	t	\N	\N	\N	\N	\N	0	123456	1	1	9886f0dc-752d-4e5f-a1cc-a3be5e1fbbea	0	超级管理员	2025-11-29 14:16:23.963215	2025-11-29 14:16:23.963216	\N	\N	1	\N
\.


--
-- Data for Name: sys_user_positions; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_user_positions (user_id, position_id) FROM stdin;
\.


--
-- Data for Name: sys_user_roles; Type: TABLE DATA; Schema: public; Owner: tao
--

COPY public.sys_user_roles (user_id, role_id) FROM stdin;
1	1
\.


--
-- Name: app_ai_mcp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.app_ai_mcp_id_seq', 1, false);


--
-- Name: app_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.app_job_id_seq', 1, false);


--
-- Name: app_job_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.app_job_log_id_seq', 1, false);


--
-- Name: app_myapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.app_myapp_id_seq', 1, false);


--
-- Name: gen_demo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.gen_demo_id_seq', 1, false);


--
-- Name: gen_table_column_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.gen_table_column_id_seq', 1, false);


--
-- Name: gen_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.gen_table_id_seq', 1, false);


--
-- Name: sys_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_customer_id_seq', 1, false);


--
-- Name: sys_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_dept_id_seq', 1, true);


--
-- Name: sys_dict_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_dict_data_id_seq', 34, true);


--
-- Name: sys_dict_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_dict_type_id_seq', 10, true);


--
-- Name: sys_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_log_id_seq', 1, false);


--
-- Name: sys_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_menu_id_seq', 128, true);


--
-- Name: sys_notice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_notice_id_seq', 1, false);


--
-- Name: sys_param_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_param_id_seq', 16, true);


--
-- Name: sys_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_position_id_seq', 1, false);


--
-- Name: sys_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_role_id_seq', 1, true);


--
-- Name: sys_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_tenant_id_seq', 1, true);


--
-- Name: sys_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tao
--

SELECT pg_catalog.setval('public.sys_user_id_seq', 1, true);


--
-- Name: app_ai_mcp app_ai_mcp_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp
    ADD CONSTRAINT app_ai_mcp_pkey PRIMARY KEY (id);


--
-- Name: app_ai_mcp app_ai_mcp_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp
    ADD CONSTRAINT app_ai_mcp_uuid_key UNIQUE (uuid);


--
-- Name: app_job_log app_job_log_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job_log
    ADD CONSTRAINT app_job_log_pkey PRIMARY KEY (id);


--
-- Name: app_job_log app_job_log_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job_log
    ADD CONSTRAINT app_job_log_uuid_key UNIQUE (uuid);


--
-- Name: app_job app_job_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job
    ADD CONSTRAINT app_job_pkey PRIMARY KEY (id);


--
-- Name: app_job app_job_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job
    ADD CONSTRAINT app_job_uuid_key UNIQUE (uuid);


--
-- Name: app_myapp app_myapp_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp
    ADD CONSTRAINT app_myapp_pkey PRIMARY KEY (id);


--
-- Name: app_myapp app_myapp_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp
    ADD CONSTRAINT app_myapp_uuid_key UNIQUE (uuid);


--
-- Name: apscheduler_jobs apscheduler_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.apscheduler_jobs
    ADD CONSTRAINT apscheduler_jobs_pkey PRIMARY KEY (id);


--
-- Name: gen_demo gen_demo_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo
    ADD CONSTRAINT gen_demo_pkey PRIMARY KEY (id);


--
-- Name: gen_demo gen_demo_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo
    ADD CONSTRAINT gen_demo_uuid_key UNIQUE (uuid);


--
-- Name: gen_table_column gen_table_column_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table_column
    ADD CONSTRAINT gen_table_column_pkey PRIMARY KEY (id);


--
-- Name: gen_table_column gen_table_column_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table_column
    ADD CONSTRAINT gen_table_column_uuid_key UNIQUE (uuid);


--
-- Name: gen_table gen_table_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table
    ADD CONSTRAINT gen_table_pkey PRIMARY KEY (id);


--
-- Name: gen_table gen_table_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table
    ADD CONSTRAINT gen_table_uuid_key UNIQUE (uuid);


--
-- Name: sys_customer sys_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_customer
    ADD CONSTRAINT sys_customer_pkey PRIMARY KEY (id);


--
-- Name: sys_customer sys_customer_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_customer
    ADD CONSTRAINT sys_customer_uuid_key UNIQUE (uuid);


--
-- Name: sys_dept sys_dept_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dept
    ADD CONSTRAINT sys_dept_pkey PRIMARY KEY (id);


--
-- Name: sys_dept sys_dept_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dept
    ADD CONSTRAINT sys_dept_uuid_key UNIQUE (uuid);


--
-- Name: sys_dict_data sys_dict_data_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_data
    ADD CONSTRAINT sys_dict_data_pkey PRIMARY KEY (id);


--
-- Name: sys_dict_data sys_dict_data_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_data
    ADD CONSTRAINT sys_dict_data_uuid_key UNIQUE (uuid);


--
-- Name: sys_dict_type sys_dict_type_dict_type_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_dict_type_key UNIQUE (dict_type);


--
-- Name: sys_dict_type sys_dict_type_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_pkey PRIMARY KEY (id);


--
-- Name: sys_dict_type sys_dict_type_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_uuid_key UNIQUE (uuid);


--
-- Name: sys_log sys_log_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log
    ADD CONSTRAINT sys_log_pkey PRIMARY KEY (id);


--
-- Name: sys_log sys_log_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log
    ADD CONSTRAINT sys_log_uuid_key UNIQUE (uuid);


--
-- Name: sys_menu sys_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_menu
    ADD CONSTRAINT sys_menu_pkey PRIMARY KEY (id);


--
-- Name: sys_menu sys_menu_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_menu
    ADD CONSTRAINT sys_menu_uuid_key UNIQUE (uuid);


--
-- Name: sys_notice sys_notice_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_pkey PRIMARY KEY (id);


--
-- Name: sys_notice sys_notice_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_uuid_key UNIQUE (uuid);


--
-- Name: sys_param sys_param_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_param
    ADD CONSTRAINT sys_param_pkey PRIMARY KEY (id);


--
-- Name: sys_param sys_param_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_param
    ADD CONSTRAINT sys_param_uuid_key UNIQUE (uuid);


--
-- Name: sys_position sys_position_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_position
    ADD CONSTRAINT sys_position_pkey PRIMARY KEY (id);


--
-- Name: sys_position sys_position_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_position
    ADD CONSTRAINT sys_position_uuid_key UNIQUE (uuid);


--
-- Name: sys_role_depts sys_role_depts_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role_depts
    ADD CONSTRAINT sys_role_depts_pkey PRIMARY KEY (role_id, dept_id);


--
-- Name: sys_role_menus sys_role_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role_menus
    ADD CONSTRAINT sys_role_menus_pkey PRIMARY KEY (role_id, menu_id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (id);


--
-- Name: sys_role sys_role_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_uuid_key UNIQUE (uuid);


--
-- Name: sys_tenant sys_tenant_code_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_tenant
    ADD CONSTRAINT sys_tenant_code_key UNIQUE (code);


--
-- Name: sys_tenant sys_tenant_name_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_tenant
    ADD CONSTRAINT sys_tenant_name_key UNIQUE (name);


--
-- Name: sys_tenant sys_tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_tenant
    ADD CONSTRAINT sys_tenant_pkey PRIMARY KEY (id);


--
-- Name: sys_tenant sys_tenant_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_tenant
    ADD CONSTRAINT sys_tenant_uuid_key UNIQUE (uuid);


--
-- Name: sys_user sys_user_email_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_email_key UNIQUE (email);


--
-- Name: sys_user sys_user_mobile_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_mobile_key UNIQUE (mobile);


--
-- Name: sys_user sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (id);


--
-- Name: sys_user_positions sys_user_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user_positions
    ADD CONSTRAINT sys_user_positions_pkey PRIMARY KEY (user_id, position_id);


--
-- Name: sys_user_roles sys_user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user_roles
    ADD CONSTRAINT sys_user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: sys_user sys_user_username_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_username_key UNIQUE (username);


--
-- Name: sys_user sys_user_uuid_key; Type: CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_uuid_key UNIQUE (uuid);


--
-- Name: ix_app_ai_mcp_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_ai_mcp_created_id ON public.app_ai_mcp USING btree (created_id);


--
-- Name: ix_app_ai_mcp_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_ai_mcp_customer_id ON public.app_ai_mcp USING btree (customer_id);


--
-- Name: ix_app_ai_mcp_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_ai_mcp_tenant_id ON public.app_ai_mcp USING btree (tenant_id);


--
-- Name: ix_app_ai_mcp_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_ai_mcp_updated_id ON public.app_ai_mcp USING btree (updated_id);


--
-- Name: ix_app_job_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_job_created_id ON public.app_job USING btree (created_id);


--
-- Name: ix_app_job_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_job_customer_id ON public.app_job USING btree (customer_id);


--
-- Name: ix_app_job_log_job_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_job_log_job_id ON public.app_job_log USING btree (job_id);


--
-- Name: ix_app_job_log_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_job_log_tenant_id ON public.app_job_log USING btree (tenant_id);


--
-- Name: ix_app_job_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_job_tenant_id ON public.app_job USING btree (tenant_id);


--
-- Name: ix_app_job_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_job_updated_id ON public.app_job USING btree (updated_id);


--
-- Name: ix_app_myapp_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_myapp_created_id ON public.app_myapp USING btree (created_id);


--
-- Name: ix_app_myapp_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_myapp_customer_id ON public.app_myapp USING btree (customer_id);


--
-- Name: ix_app_myapp_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_myapp_tenant_id ON public.app_myapp USING btree (tenant_id);


--
-- Name: ix_app_myapp_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_app_myapp_updated_id ON public.app_myapp USING btree (updated_id);


--
-- Name: ix_apscheduler_jobs_next_run_time; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_apscheduler_jobs_next_run_time ON public.apscheduler_jobs USING btree (next_run_time);


--
-- Name: ix_gen_demo_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_gen_demo_created_id ON public.gen_demo USING btree (created_id);


--
-- Name: ix_gen_demo_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_gen_demo_customer_id ON public.gen_demo USING btree (customer_id);


--
-- Name: ix_gen_demo_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_gen_demo_tenant_id ON public.gen_demo USING btree (tenant_id);


--
-- Name: ix_gen_demo_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_gen_demo_updated_id ON public.gen_demo USING btree (updated_id);


--
-- Name: ix_gen_table_column_table_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_gen_table_column_table_id ON public.gen_table_column USING btree (table_id);


--
-- Name: ix_sys_customer_code; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_customer_code ON public.sys_customer USING btree (code);


--
-- Name: ix_sys_customer_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_customer_created_id ON public.sys_customer USING btree (created_id);


--
-- Name: ix_sys_customer_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_customer_tenant_id ON public.sys_customer USING btree (tenant_id);


--
-- Name: ix_sys_customer_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_customer_updated_id ON public.sys_customer USING btree (updated_id);


--
-- Name: ix_sys_dept_code; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_dept_code ON public.sys_dept USING btree (code);


--
-- Name: ix_sys_dept_parent_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_dept_parent_id ON public.sys_dept USING btree (parent_id);


--
-- Name: ix_sys_dept_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_dept_tenant_id ON public.sys_dept USING btree (tenant_id);


--
-- Name: ix_sys_log_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_log_created_id ON public.sys_log USING btree (created_id);


--
-- Name: ix_sys_log_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_log_customer_id ON public.sys_log USING btree (customer_id);


--
-- Name: ix_sys_log_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_log_tenant_id ON public.sys_log USING btree (tenant_id);


--
-- Name: ix_sys_log_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_log_updated_id ON public.sys_log USING btree (updated_id);


--
-- Name: ix_sys_menu_parent_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_menu_parent_id ON public.sys_menu USING btree (parent_id);


--
-- Name: ix_sys_notice_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_notice_created_id ON public.sys_notice USING btree (created_id);


--
-- Name: ix_sys_notice_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_notice_customer_id ON public.sys_notice USING btree (customer_id);


--
-- Name: ix_sys_notice_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_notice_tenant_id ON public.sys_notice USING btree (tenant_id);


--
-- Name: ix_sys_notice_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_notice_updated_id ON public.sys_notice USING btree (updated_id);


--
-- Name: ix_sys_position_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_position_created_id ON public.sys_position USING btree (created_id);


--
-- Name: ix_sys_position_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_position_tenant_id ON public.sys_position USING btree (tenant_id);


--
-- Name: ix_sys_position_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_position_updated_id ON public.sys_position USING btree (updated_id);


--
-- Name: ix_sys_role_code; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_role_code ON public.sys_role USING btree (code);


--
-- Name: ix_sys_role_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_role_created_id ON public.sys_role USING btree (created_id);


--
-- Name: ix_sys_role_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_role_tenant_id ON public.sys_role USING btree (tenant_id);


--
-- Name: ix_sys_role_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_role_updated_id ON public.sys_role USING btree (updated_id);


--
-- Name: ix_sys_user_created_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_user_created_id ON public.sys_user USING btree (created_id);


--
-- Name: ix_sys_user_customer_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_user_customer_id ON public.sys_user USING btree (customer_id);


--
-- Name: ix_sys_user_dept_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_user_dept_id ON public.sys_user USING btree (dept_id);


--
-- Name: ix_sys_user_tenant_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_user_tenant_id ON public.sys_user USING btree (tenant_id);


--
-- Name: ix_sys_user_updated_id; Type: INDEX; Schema: public; Owner: tao
--

CREATE INDEX ix_sys_user_updated_id ON public.sys_user USING btree (updated_id);


--
-- Name: app_ai_mcp app_ai_mcp_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp
    ADD CONSTRAINT app_ai_mcp_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: app_ai_mcp app_ai_mcp_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp
    ADD CONSTRAINT app_ai_mcp_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_ai_mcp app_ai_mcp_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp
    ADD CONSTRAINT app_ai_mcp_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_ai_mcp app_ai_mcp_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_ai_mcp
    ADD CONSTRAINT app_ai_mcp_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: app_job app_job_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job
    ADD CONSTRAINT app_job_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: app_job app_job_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job
    ADD CONSTRAINT app_job_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_job_log app_job_log_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job_log
    ADD CONSTRAINT app_job_log_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.app_job(id) ON DELETE CASCADE;


--
-- Name: app_job_log app_job_log_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job_log
    ADD CONSTRAINT app_job_log_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_job app_job_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job
    ADD CONSTRAINT app_job_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_job app_job_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_job
    ADD CONSTRAINT app_job_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: app_myapp app_myapp_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp
    ADD CONSTRAINT app_myapp_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: app_myapp app_myapp_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp
    ADD CONSTRAINT app_myapp_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_myapp app_myapp_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp
    ADD CONSTRAINT app_myapp_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: app_myapp app_myapp_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.app_myapp
    ADD CONSTRAINT app_myapp_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: gen_demo gen_demo_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo
    ADD CONSTRAINT gen_demo_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: gen_demo gen_demo_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo
    ADD CONSTRAINT gen_demo_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gen_demo gen_demo_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo
    ADD CONSTRAINT gen_demo_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gen_demo gen_demo_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_demo
    ADD CONSTRAINT gen_demo_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: gen_table_column gen_table_column_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.gen_table_column
    ADD CONSTRAINT gen_table_column_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.gen_table(id) ON DELETE CASCADE;


--
-- Name: sys_customer sys_customer_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_customer
    ADD CONSTRAINT sys_customer_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_customer sys_customer_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_customer
    ADD CONSTRAINT sys_customer_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_customer sys_customer_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_customer
    ADD CONSTRAINT sys_customer_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_dept sys_dept_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dept
    ADD CONSTRAINT sys_dept_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.sys_dept(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_dept sys_dept_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dept
    ADD CONSTRAINT sys_dept_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_dict_data sys_dict_data_dict_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_dict_data
    ADD CONSTRAINT sys_dict_data_dict_type_id_fkey FOREIGN KEY (dict_type_id) REFERENCES public.sys_dict_type(id) ON DELETE CASCADE;


--
-- Name: sys_log sys_log_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log
    ADD CONSTRAINT sys_log_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_log sys_log_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log
    ADD CONSTRAINT sys_log_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_log sys_log_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log
    ADD CONSTRAINT sys_log_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_log sys_log_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_log
    ADD CONSTRAINT sys_log_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_menu sys_menu_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_menu
    ADD CONSTRAINT sys_menu_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.sys_menu(id) ON DELETE SET NULL;


--
-- Name: sys_notice sys_notice_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_notice sys_notice_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_notice sys_notice_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_notice sys_notice_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_position sys_position_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_position
    ADD CONSTRAINT sys_position_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_position sys_position_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_position
    ADD CONSTRAINT sys_position_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_position sys_position_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_position
    ADD CONSTRAINT sys_position_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_role sys_role_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_role_depts sys_role_depts_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role_depts
    ADD CONSTRAINT sys_role_depts_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.sys_dept(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_role_depts sys_role_depts_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role_depts
    ADD CONSTRAINT sys_role_depts_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.sys_role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_role_menus sys_role_menus_menu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role_menus
    ADD CONSTRAINT sys_role_menus_menu_id_fkey FOREIGN KEY (menu_id) REFERENCES public.sys_menu(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_role_menus sys_role_menus_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role_menus
    ADD CONSTRAINT sys_role_menus_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.sys_role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_role sys_role_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_role sys_role_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_user sys_user_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_created_id_fkey FOREIGN KEY (created_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_user sys_user_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sys_customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user sys_user_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.sys_dept(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sys_user_positions sys_user_positions_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user_positions
    ADD CONSTRAINT sys_user_positions_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.sys_position(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user_positions sys_user_positions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user_positions
    ADD CONSTRAINT sys_user_positions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user_roles sys_user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user_roles
    ADD CONSTRAINT sys_user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.sys_role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user_roles sys_user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user_roles
    ADD CONSTRAINT sys_user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user sys_user_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.sys_tenant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user sys_user_updated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tao
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_updated_id_fkey FOREIGN KEY (updated_id) REFERENCES public.sys_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

