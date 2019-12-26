import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:ifengo/utils/index.dart';

class Axios {
     //简单配置
     Dio _dio = new Dio(BaseOptions(
       baseUrl: "https://www.ifengstar.com/api/v1/",
       connectTimeout: 30000,
       receiveTimeout: 100000,
       headers: {
         'content-type':'application/x-www-form-urlencoded'
       },
       contentType: ContentType.json,
       // Transform the response data to a String encoded with UTF8.
       // The default value is [ResponseType.JSON].
       responseType: ResponseType.plain,
     ));

     Axios._internal(){
       print('Axios._internal()');
       interceptors();
     }
     //保存单例
     static Axios _auth = new Axios._internal();

     //工厂构造函数
     factory Axios()=> _auth;

     interceptors(){//请求拦截
       _dio.interceptors.add(InterceptorsWrapper(
           onRequest:(options){//请求前
             return options;

           },
           onResponse:(response){//响应拦截
             Map  result = json.decode(response.toString());
             return result;
           },
           onError:(e){//网络或接口异常
             Utils.showToast('系统异常');
             return e;
           },
       ));
     }

     get(String url,Map<String,Object> parmas) async{//get请求
         Response response;
         response = await _dio.get(url,queryParameters:parmas);
         return response;
     }

     post(String url,Map<String,Object> parmas)async{//post请求
       Response response;
       response = await _dio.post(url, data: parmas);
       return response;
     }

     from(String url,Map<String,Object> parmas) async{//formData请求
       Response response;
       FormData formData = new FormData.from(parmas);
       response = await _dio.post(url, data: formData);
       return response;
     }

}

//创建单列提供外部直接访问
Axios $axios = new Axios();

