# __author__: Mai feng
# __file_name__: passport.py
# __time__: 2019:04:28:16:20


from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
import re
from medicine import redis_conn, db
from medicine.models import User


@api.route('/register', methods=['POST'])
def register():
    '''用户注册接口
    :param json格式
        1. phone_num
        2. phone_code
        3. password
        4. password2
    :return: json
    '''
    # 获取参数
    data = request.json
    phone = data.get('phone')
    phone_code = data.get('phone_code')
    password = data.get('password')
    password2 = data.get('password2')

    #  检查是否缺少参数
    if not all([phone, phone_code, password, password2]):
        return jsonify(re_code=RET.PARAMERR, msg='缺少参数')

    # 验证手机号码是否正确
    if not re.match('0?(13|14|15|17|18|19)[0-9]{9}', phone):
        return jsonify(re_code=RET.PARAMERR, msg='手机号码格式不正确')

    # 判断两次密码是否一致
    if password != password2:
        return jsonify(re_code=RET.DATAERR, msg='用户两次密码不一致')

    return jsonify(re_code=RET.OK, msg='注册成功')
