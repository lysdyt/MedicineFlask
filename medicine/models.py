# __author__: Mai feng
# __file_name__: models.py
# __time__: 2019:04:23:19:54


from datetime import datetime
from . import db
from werkzeug.security import generate_password_hash,check_password_hash

class BaseModel(object):
    """模型基类"""
    create_time=db.Column(db.DateTime,default=datetime.now()) #记录模型类创建时间
    update_time=db.Column(db.DateTime,default=datetime.now,onupdate=datetime.now())#记录模型类更新时间
