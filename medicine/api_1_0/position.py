# __author__: Mai feng
# __file_name__: expert.py
# __time__: 2019:05:04:21:58


from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import User, Expert, Position


@api.route('/positions')
def get_positions():
    '''获取专家类型
    :param 1. page
           2. count
    '''
    # 检测参数
    page = request.args.get('page', '1')
    count = request.args.get('count', '5')
    try:
        expert_pages = Position.query.order_by(Position.create_time.desc()).paginate(int(page), 
                                                int(count), error_out=False)
        positions = expert_pages.items
    except Exception as e:
        current_app.logger.debug(e)
        return jsonify(re_code=RET.DBERR, msg='数据库查询错误')

    if len(positions) == 0:
        return jsonify(re_code=RET.NODATA, msg='没有数据')

    positions_list = []
    for position in positions:
        positions_list.append(position.to_dict())
    positions_info = {
        'data': positions_list,
        'current_items': len(positions),
        'current_page': expert_pages.page,
        'total': expert_pages.total,
        'pages': expert_pages.pages,
        'has_next': expert_pages.has_next
    }
    return jsonify(re_code=RET.OK, msg='请求成功', data=positions_info)

@api.route('/addPosition', methods=['POST'])
def add_position():
    '''添加职位
    '''
    data = request.json
    nickname = data.get('nickname')
    # 检测参数
    if not nickname:
        return jsonify(re_code=RET.PARAMERR, msg='缺少参数')

    # 判断是否已经存在
    try:
        position = Position.query.filter(Position.nickname == nickname).first()
    except Exception as e:
        current_app.logger.debug(e)
        return jsonify(re_code=RET.DBERR, msg='数据库查询错误')
    
    if position:
        return jsonify(re_code=RET.PARAMERR, msg='职位已经存在')
    
    position = Position()
    position.nickname = nickname

    # 添加
    try:
        db.session.add(position)
        db.session.commit()
    except Exception as e:
        current_app.logger.debug(e)
        db.session.rollback() # 事务回滚
        return jsonify(re_code=RET.DBERR, msg='添加职位失败')

    return jsonify(re_code=RET.OK, msg='添加成功')
