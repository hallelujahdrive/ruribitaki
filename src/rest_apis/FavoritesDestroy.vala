using Rest;

namespace Ruribitaki{
  //☆ヲ殺ス
  public async bool favorites_destroy(Account account,string id_str)throws Error{
    bool result=false;
    Error error=null;
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_FAVORITES_DESTROY);
    proxy_call.set_method(METHOD_POST);
    proxy_call.add_param(PARAM_ID,id_str);
    
    //run
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        result=proxy_call.invoke_async.end(res);
      }catch(Error e){
        error=e;
      }
      favorites_destroy.callback();
    });
    
    yield;
    if(error!=null){
      throw error;
    }
    return result;
  }
}
