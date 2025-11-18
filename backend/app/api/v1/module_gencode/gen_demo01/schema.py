# -*- coding:utf-8 -*-

from typing import Optional
from pydantic import BaseModel, ConfigDict, Field

from app.core.base_schema import BaseSchema

class GenDemo01CreateSchema(BaseModel):
    """
    示例新增模型
    """

    name: Optional[str] = Field(default=None, description='名称')
    status: Optional[int] = Field(default=None, description='是否启用(True:启用 False:禁用)')
    description: Optional[str] = Field(default=None, description='备注/描述')


class GenDemo01UpdateSchema(GenDemo01CreateSchema):
    """
    示例更新模型
    """
    ...


class GenDemo01OutSchema(GenDemo01CreateSchema, BaseSchema):
    """
    示例响应模型
    """
    model_config = ConfigDict(from_attributes=True)
