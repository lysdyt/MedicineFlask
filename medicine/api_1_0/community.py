# __author__: Mai feng
# __file_name__: community.py
# __time__: 2019:05:14:19:51


from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import Question, Answer

@api.route('/questions')
def get_questions():
    '''分页获取社区内容
    '''
    page = request.args.get('page', '1')
    count = request.args.get('count', '3')

    if not all([page, count]):
        return jsonify(re_code=RET.PARAMERR, msg='缺少参数')

    try:
        question_pages = Question.query.order_by(Question.create_time.desc()).paginate(int(page), 
                                                int(count), error_out=False)
        questions = question_pages.items
    except Exception as e:
        current_app.logger.debug(e)
        return jsonify(re_code=RET.DBERR, msg='数据库查询错误')

    if len(questions) == 0:
        return jsonify(re_code=RET.NODATA, msg='没有数据')

    questions_list = []
    for question in questions:
        answers_list = []
        answers = question.get_answers()
        for answer in answers:
            answers_list.append(answer.to_dict())
        question_dict = question.to_dict()
        question_dict['answers'] = answers_list
        questions_list.append(question_dict)

    questions_info = {
        'data': questions_list,
        'current_items': len(questions_list),
        'current_page': question_pages.page,
        'total': question_pages.total,
        'pages': question_pages.pages,
        'has_next': question_pages.has_next
    }
    return jsonify(re_code=RET.OK, msg='请求成功', data=questions_info)


@api.route('/addQuestion', methods=['POST'])
def add_question():
    '''添加问题 请求方式 post
    :param 1. user_id 病人id
            2. content
    '''
    data = request.json
    user_id = data.get('user_id')
    content = data.get('content')
    if not all([user_id, content]):
        return jsonify(re_code=RET.PARAMERR, msg='缺少参数')

    question = Question()
    question.user_id = user_id
    question.content = content

    try:
        db.session.add(question)
        db.session.commit()
    except Exception as e:
        current_app.logger.debug(e)
        db.session.rollback()
        return jsonify(re_code=RET.DBERR, msg='添加错误')

    return jsonify(re_code=RET.OK, msg='添加成功')
