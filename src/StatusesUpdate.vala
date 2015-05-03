using Rest;

namespace Ruribitaki{
  //tweetのpost
  public async bool statuses_update(Account account,string status,string? in_reply_to_status_id_str){    
    bool result=false;
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_STATUSES_UPDATE);
    proxy_call.set_method("POST");
    proxy_call.add_param(PARAM_STATUS,status);
    //リプライならtweet_idのパラメータを設定
    if(in_reply_to_status_id_str!=null){
      proxy_call.add_param(PARAM_IN_REPLY_TO_STATUS_ID,in_reply_to_status_id_str);
    }
      
    //run
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        result=proxy_call.invoke_async.end(res);
      }catch(Error e){
        print("Error : %s\n",e.message);
      }
      statuses_update.callback();
    });
    yield;
    return result;
  }
}
