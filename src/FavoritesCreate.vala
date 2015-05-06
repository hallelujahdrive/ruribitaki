using Rest;

namespace Ruribitaki{
  //☆
  public async bool favorites_create(Account account,string id_str)throws Error{
    bool result=false;
    Error error=null;
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_FAVORITES_CREATE);
    proxy_call.set_method("POST");
    proxy_call.add_param(PARAM_ID,id_str);
        
    //run
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        result=proxy_call.invoke_async.end(res);
      }catch(Error e){
        error=e;
      }
      favorites_create.callback();
    });
    
    yield;
    if(error!=null){
      throw error;
    }
    return result;
  }
}
