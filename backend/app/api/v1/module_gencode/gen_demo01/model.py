# -*- coding: utf-8 -*-

from sqlalchemy import Integer, Text, String, SmallInteger, DateTime
from typing import Optional
from sqlalchemy.orm import Mapped, mapped_column

from app.core.base_model import CreatorMixin


class GenDemo01Model(CreatorMixin):
    """
    示例表
    """
    
    __tablename__ = 'gen_demo01'
    __table_args__ = {'comment': '示例'}
    __loader_options__ = ["creator"]

    name: Mapped[Optional[str]] = mapped_column(String(64), nullable=True, comment='名称')
    status: Mapped[Optional[int]] = mapped_column(SmallInteger, nullable=True, comment='是否启用(True:启用 False:禁用)')

