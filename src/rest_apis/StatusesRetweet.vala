using Rest;

namespace Ruribitaki{
  //retweet
  public async bool statuses_retweet(Account account,string id_str)throws Error{
    bool result=false;
    Error error=null;
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_STATUSES_RETWEET.printf(id_str));
    proxy_call.set_method(METHOD_POST);
    
    //run
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        result=proxy_call.invoke_async.end(res);
      }catch(Error e){
        error=e;
      }
      statuses_retweet.callback();
    });
    
    yield;
    if(error!=null){
      throw error;
    }
    return result;
  }
}
