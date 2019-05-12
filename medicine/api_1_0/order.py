# __author__: Mai feng
# __file_name__: order.py
# __time__: 2019:05:11:22:34

from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import PrivateOrder


@api.route('/privateOrders')
def get_private_orders():
    '''分页获取私人订制
    :param 1. page: 页码
            2. count: 数量
    '''
    
    page = request.args.get('page', '1')
    count = request.args.get('count', '3')

    if not all([page, count]):
        return jsonify(re_code=RET.PARAMERR, msg='缺少参数')
    
    try:
        order_pages = PrivateOrder.query.order_by(PrivateOrder.create_time.desc()).paginate(int(page), 
                                                int(count), error_out=False)
        orders = order_pages.items
    except Exception as e:
        current_app.logger.debug(e)
        return jsonify(re_code=RET.DBERR, msg='数据库查询错误')

    if len(orders) == 0:
        return jsonify(re_code=RET.NODATA, msg='没有数据')

    orders_list = []
    for order in orders:
        orders_list.append(order.to_dict())
    
    orders_info = {
        'data': orders_list,
        'current_items': len(orders_list),
        'current_page': order_pages.page,
        'total': order_pages.total,
        'pages': order_pages.pages,
        'has_next': order_pages.has_next
    }
    return jsonify(re_code=RET.OK, msg='请求成功', data=orders_info)