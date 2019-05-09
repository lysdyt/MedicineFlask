# Medicine API 接口说明

### 1. Passport

#### 1.1 /register

```js
接口说明： 用户注册（包括医生）
请求方式： post
参数：
    1. phone： 用户手机号码
    2. phone_code： 短信验证码
    3. password： 用户密码
    4. password2： 再次输入密码
    5. types：病人还是专家（patient or expert）
注意：
    1. 前端页面至少有短信验证码的获取

返回：
    {
        "msg": "注册成功",
        "re_code": "0"
    }

示例：
http://127.0.0.1:5000/api/1.0/register
data = {
    "phone":"17608037***",
	"phone_code":"003533",
	"password":"mai",
    "password2":"mai",
    "types":"patient"
}

```
#### 1.2 /sessions 接口

```js
接口说明：用户登陆
请求方式：post
参数：
    1. phone：用户手机号码
    2. password：用户密码
返回：
    {
        "msg": "登陆成功",
        "re_code": "0"
    }
示例：
http://127.0.0.1:5000/api/1.0/sessions
data = {
	"phone":"176080371**",
	"password":"mai"
}

```

#### 1.3 /sessions 接口

```js
接口说明：用户注销
请求方式：delete
参数：none
返回：
    {
        "msg": "退出成功",
        "re_code": "0"
    }
示例：
http://127.0.0.1:5000/api/1.0/sessions

```


### 2. Verity

#### 2.1 /imageCode 接口

```js
接口说明： 获取验证码图片
请求方式：get
参数：
  1. uuid：用户标示码
  2. last_uuid：用户上一次验证码的标示码
注意：
    1. 如果不知道怎么生成，会将前端的uuid生成方法写进去
返回：
	image图片格式
示例：
api:http://127.0.0.1:5000/api/1.0/imageCode?uuid=123&last_uuid=""

uuid生成方法示例：js
function generateUUID() {
    var d = new Date().getTime();
    if(window.performance && typeof window.performance.now === "function"){
        d += performance.now(); //use high-precision timer if available
    }
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;
}
```

#### 2.1 /smsCode 接口

```js
接口说明： 发送手机验证码
请求方式：post
参数：
  1. phone:用户手机号码
  2. img_code_client: 用户图片验证码
  3. uuid: 用户标示码
注意：
    1. 如果不知道怎么生成，参考/imageCode接口的说明文档
    2. 前端至少有图片验证码
       
返回：
	{
        "msg": "验证码发送成功",
        "re_code": "0"
    }
示例：
api:http://127.0.0.1:5000/api/1.0/smsCode

data = {
	"phone":"176080******",
	"img_code_client":"3xfe",
	"uuid":"123"
}
注意：json格式
```


### 3. Profile

#### 3.1 /users 接口

```js
接口说明： 获取用户基本信息
请求方式：get
注意：前提已登陆
返回：
    {
        "msg": "查询成功",
        "re_code": "0",
        "user": {
            "address": null,
            "age": null,
            "avatar_url": null,
            "grade": null,
            "level": null,
            "name": "176080371**",
            "phone": "176080371**",
            "status": null,
            "user_id": 1
        }
    }
示例：
api:http://127.0.0.1:5000/api/1.0/users
```



#### 3.2 /experts 接口

```js
接口说明： 获取专家基本信息
请求方式：get
注意：前提已登陆
返回：
    {
        "msg": "查询成功",
        "re_code": "0",
        "user": {
            "address": null,
            "age": null,
            "avatar_url": null,
            "grade": null,
            "major": null,
            "name": "17608037125",
            "phone": "17608037125",
            "user_id": 1
        }
    }
示例：
api:http://127.0.0.1:5000/api/1.0/experts
```

### 4. Position

#### 4.1 positions 接口

```js
接口说明： 分页获取专家职位
请求方式：get
返回：
{
    "data": {
        "current_items": 3,
        "current_page": 1,
        "data": [
            {
                "experts": [
                    {
                        "address": null,
                        "age": null,
                        "avatar_url": null,
                        "grade": null,
                        "major": null,
                        "name": "17608037125",
                        "phone": "17608037125",
                        "position_id": 7,
                        "user_id": 1
                    }
                ],
                "nickname": "外科专家",
                "position_id": 7
            },
            {
                "experts": [],
                "nickname": "西医专家",
                "position_id": 6
            },
            {
                "experts": [],
                "nickname": "内科专家",
                "position_id": 5
            }
        ],
        "has_next": true,
        "pages": 3,
        "total": 7
    },
    "msg": "请求成功",
    "re_code": "0"
}
示例：
http://127.0.0.1:5000/api/1.0/positions?page=1&count=3
```

#### 4.2 addPosition 接口

```js
接口说明： 添加职位名称
请求方式：post
参数：
    1. nickname: 职位名称
返回：
    {
        "msg": "添加成功",
        "re_code": "0"
    }
示例：
http://127.0.0.1:5000/api/1.0/addPosition
data = {
	"nickname":"头疼专家"
}
```

#### 4.3 delPosition 接口

```js
接口说明： 删除职位名称
请求方式：post
参数：
    1. position_id: 职位id
返回：
    {
        "msg": "删除成功",
        "re_code": "0"
    }
示例：
http://127.0.0.1:5000/api/1.0/delPosition
data = {
	"position_id": 8
}
```
#### 4.4 allPositions 接口

```js
接口说明： 获取全部职位名称
请求方式：get
返回：
{
    "data": {
        "data": [
            {
                "nickname": "中医专家",
                "position_id": 1
            },
            {
                "nickname": "养生保健专家",
                "position_id": 2
            },
            {
                "nickname": "心理专家",
                "position_id": 3
            },
            {
                "nickname": "骨科专家",
                "position_id": 4
            },
            {
                "nickname": "内科专家",
                "position_id": 5
            },
            {
                "nickname": "西医专家",
                "position_id": 6
            },
            {
                "nickname": "外科专家",
                "position_id": 7
            }
        ],
        "num": 7
    },
    "msg": "返回成功",
    "re_code": "0"
}
示例：
http://127.0.0.1:5000/api/1.0/allPositions

```

### 5. Shop

#### 5.1 shops 接口



```js
接口说明： 分页获取药膳
请求方式：get
返回：
{
    "data": {
        "current_items": 3,
        "current_page": 1,
        "data": [
            {
                "activity_list": "胃口较好",
                "experts": [
                    {
                        "avatar_url": null,
                        "medicine_id": 10,
                        "video_id": 1,
                        "video_url": "https://v.qq.com/x/page/t0675upujfj.html"
                    },
                    {
                        "avatar_url": null,
                        "medicine_id": 10,
                        "video_id": 2,
                        "video_url": "https://v.qq.com/x/page/s0511q7e1zb.html"
                    }
                ],
                "name": "胃药膳",
                "shop_id": 10
            },
            {
                "activity_list": "永不发热",
                "experts": [
                    {
                        "avatar_url": null,
                        "medicine_id": 9,
                        "video_id": 3,
                        "video_url": "https://v.qq.com/x/page/w07583hab8o.html"
                    },
                    {
                        "avatar_url": null,
                        "medicine_id": 9,
                        "video_id": 4,
                        "video_url": "https://v.qq.com/x/page/q0844qbpld7.html"
                    }
                ],
                "name": "退热贴",
                "shop_id": 9
            },
            {
                "activity_list": "永不发烧",
                "experts": [],
                "name": "退烧药膳",
                "shop_id": 8
            }
        ],
        "has_next": true,
        "pages": 4,
        "total": 10
    },
    "msg": "请求成功",
    "re_code": "0"
}
示例：
http://127.0.0.1:5000/api/1.0/shops?page=1&count=3
```



























### 状态码表

```python
# update date: 2019.4.29
class RET:
    OK                  = "0"
    DBERR               = "4001"
    NODATA              = "4002"
    DATAEXIST           = "4003"
    DATAERR             = "4004"
    SESSIONERR          = "4101"
    LOGINERR            = "4102"
    PARAMERR            = "4103"
    USERERR             = "4104"
    ROLEERR             = "4105"
    PWDERR              = "4106"
    REQERR              = "4201"
    IPERR               = "4202"
    THIRDERR            = "4301"
    IOERR               = "4302"
    SERVERERR           = "4500"
    UNKOWNERR           = "4501"

error_map = {
    RET.OK                    : u"成功",
    RET.DBERR                 : u"数据库查询错误",
    RET.NODATA                : u"无数据",
    RET.DATAEXIST             : u"数据已存在",
    RET.DATAERR               : u"数据错误",
    RET.SESSIONERR            : u"用户未登录",
    RET.LOGINERR              : u"用户登录失败",
    RET.PARAMERR              : u"参数错误",
    RET.USERERR               : u"用户不存在或未激活",
    RET.ROLEERR               : u"用户身份错误",
    RET.PWDERR                : u"密码错误",
    RET.REQERR                : u"非法请求或请求次数受限",
    RET.IPERR                 : u"IP受限",
    RET.THIRDERR              : u"第三方系统错误",
    RET.IOERR                 : u"文件读写错误",
    RET.SERVERERR             : u"内部错误",
    RET.UNKOWNERR             : u"未知错误",
}
```

