# __author__: Mai feng
# __file_name__: essay.py
# __time__: 2019:05:10:20:14

from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import Essay


@api.route('/addEssay', methods=['POST'])
def add_essay():
    '''添加软文
    :param title: 文章标题
            abstract: 文章摘要
            # cover_img_url: 文章封面
            content: 内容
            types: 类型 （普通 or 商家优惠活动）
    '''
    data = request.json
    title = data.get('title')
    abstract = data.get('abstract')
    # cover_img_url = data.get('cover_img_url')
    content = data.get('content')
    types = data.get('types')
    # 判断是否缺少
    if not all([title, abstract, content, types]):
        return jsonify(re_code=RET.PARAMERR, msg='缺少参数')

    # 判断类型参数传递是否正确
    if types != 'common' and types != 'shop':
        return jsonify(re_code=RET.PARAMERR, msg='types参数不正确')

    # 创建实体
    essay = Essay()
    essay.title = title
    essay.abstract = abstract
    # essay.cover_img_url = cover_img_url
    essay.content = content
    essay.types = types

    try:
        db.session.add(essay)
        db.session.commit()
    except Exception as e:
        current_app.logger.debug(e)
        db.session.rollback()
        return jsonify(re_code=RET.DBERR, msg='添加软文失败')

    return jsonify(re_code=RET.OK, msg='添加成功')
    