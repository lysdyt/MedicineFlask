# __author__: Mai feng
# __file_name__: shop.py
# __time__: 2019:05:09:10:25



from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import MedicineShop, Video

@api.route('/shops')
def get_shops():
    '''分页获取药膳
    :param page: 页数
           count: 数量
    :reuturn: json
    ''' 
    # 检测参数
    page = request.args.get('page', '1')
    count = request.args.get('count', '5')

    try:
        shop_pages = MedicineShop.query.order_by(MedicineShop.create_time.desc()).paginate(int(page), 
                                                int(count), error_out=False)
        shops = shop_pages.items
    except Exception as e:
        current_app.logger.debug(e)
        return jsonify(re_code=RET.DBERR, msg='数据库查询错误')

    if len(shops) == 0:
        return jsonify(re_code=RET.NODATA, msg='没有数据')

    shops_list = []
    for shop in shops:
        videos_list = []
        videos = shop.get_videos()
        for video in videos:
            videos_list.append(video.to_dict())
        shop_dict = shop.to_dict()
        shop_dict['experts'] = videos_list
        shops_list.append(shop_dict)

    shops_info = {
        'data': shops_list,
        'current_items': len(shops),
        'current_page': shop_pages.page,
        'total': shop_pages.total,
        'pages': shop_pages.pages,
        'has_next': shop_pages.has_next
    }
    return jsonify(re_code=RET.OK, msg='请求成功', data=shops_info)