# __author__: Mai feng
# __file_name__: manage.py
# __time__: 2019:04:22:16:28

from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand

from medicine import get_app, db

app=get_app('develop')

#让迁移时，app和数据库建立关联
Migrate(app,db)

#创建脚本管理器
manager=Manager(app)
#增加db脚本命令
manager.add_command('db',MigrateCommand)

# db init
# python manage.py db init

# db migrate
# python manage.py db migrate

# db upgrade

# python manage.py db upgrade

if __name__ == '__main__':
    manager.run()