# __author__: Mai feng
# __file_name__: verify.py
# __time__: 2019:04:28:21:12
import random
from medicine.api_1_0 import api
from flask import request, abort, current_app, jsonify, make_response
from medicine.utils.response_code import RET, error_map
from medicine import redis_conn
from medicine import constants
from medicine.models import User
import re
from medicine.utils.captcha.captcha import captcha
@api.route('/imageCode')
def get_image_code():
    '''获取图片验证码
    :param json method->get
        1. uuid
        2. last_uuid
        eg:http://127.0.0.1"5000/imageCode?uuid=xxxx&last_uuid=xxxx
    :return: image
    '''
    uuid = request.args.get('uuid')
    last_uuid = request.args.get('last_uuid')
    # 判断是否存在uuid
    if not uuid:
        return jsonify(re_code=RET.PARAMERR, msg='缺少uuid参数')
    
    # 生成验证码图片及信息 名字，文字信息，图片信息
    name, text, image = captcha.generate_captcha()
    current_app.logger.debug('图片验证码信息:' + text)

    # 删除上次生成的验证码
    try:
        if last_uuid:
            redis_conn.delete('ImageCode' + last_uuid)
        
        # 保存UUID对应的验证码文字信息，设置时长
        redis_conn.setex('ImageCode' + uuid, constants.IMAGE_CODE_REDIS_EXPIRES, text)
    except Exception as e:
        current_app.logger.debug(e)
        return jsonify(re_code=RET.DBERR, msg='保存图片验证码失败')

    response = make_response(image)
    response.headers['Content-Type'] = 'image/jpg'
    return response