# __author__: Mai feng
# __file_name__: expert.py
# __time__: 2019:05:04:21:58


from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import User, Expert


@api.route('/expertTypes')
def get_expert_types():
    '''获取专家类型
    :param 1. page
           2. count
    '''
    # 检测参数
    page = request.args.get('page', '1')
    count = request.args.get('count', '5')
    try:
        expert_pages = 