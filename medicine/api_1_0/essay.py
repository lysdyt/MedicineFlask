# __author__: Mai feng
# __file_name__: essay.py
# __time__: 2019:05:10:20:14

from medicine.api_1_0 import api
from flask import request, jsonify, current_app, session
from medicine.utils.response_code import RET
from medicine import redis_conn, db
from medicine.utils.common import login_required
from medicine.models import Essay