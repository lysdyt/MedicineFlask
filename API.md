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
	"password2":"mai"
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

