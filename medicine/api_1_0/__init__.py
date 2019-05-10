# __author__: Mai feng
# __file_name__: __init__.py
# __time__: 2019:04:23:19:52

from flask.blueprints import Blueprint
#需求url:127.0.0.1:5000/api/1.0/index
api=Blueprint('api_1_0',__name__,url_prefix='/api/1.0')
#为了能调用到视图需要导入
from . import demo, passport, verify, profile, position, shop, essay