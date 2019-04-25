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


class UserBaseModel(object):
    id = db.Column(db.Integer, primary_key=True) # 用户id
    name = db.Column(db.String(32)) # 用户名字
    password = db.Column(db.String(32), nullable=False) # 用户密码
    phone = db.Column(db.String(11), nullable=False) # 用户手机号码， 用手机号码注册
    age = db.Column(db.String(3), nullable=True)  # 用户年龄
    email = db.Column(db.String(32), nullable=True) # 用户邮箱
    avatar_url = db.Column(db.String(128), nullable=True) # 用户头像
    address = db.Column(db.String(128), nullable=True) # 用户地址

class Users(BaseModel, UserBaseModel, db.Model):
    '''病人模型类'''
    __tablename__ = 'mi_user_profile'


    level = db.Column(db.String(16), nullable=True) # 用户级别
    grade = db.Column(db.Enum('common', 'vip')) # 普通用户和高级用户
    status = db.Column(db.Enum('null', 'min', 'max')) # 健康， 亚健康， 不健康

class Expert(BaseModel, UserBaseModel, db.Model):
    '''专家模型类'''
    __tablename__ = 'mi_expert_profile'

    grade = db.Column(db.Enum('professor', 'assprofessor')) # 教授， 副教授
    major = db.Column(db.String(32), nullable=True) # 主治
    position_id = db.Column(db.Integer, db.ForeignKey('mi_position.id'),nullable=False) # 外键 关联position

class Position(BaseModel, db.Model):
    '''专家职位类'''
    __tablename__ = 'mi_position'
    id = db.Column(db.Integer, primary_key=True) # id
    nickname = db.Column(db.String(32), nullable=True) # 职位名称
    experts = db.relationship('Expert', backref='position') # 关系  一对多 一个职位对应多个专家 不考虑多对多

    



    
