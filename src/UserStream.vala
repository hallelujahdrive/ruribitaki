using Rest;

namespace Ruribitaki{
  //user_stream
  public class UserStream{
    private unowned Account account;
    
    private StringBuilder json_sb=new StringBuilder();
    
    private ProxyCall proxy_call;
    
    public UserStream(Account account){
      this.account=account;
    }
  
    public void run()throws Error{
      //proxy_callの設定
      proxy_call=account.stream_proxy.new_call();
      proxy_call.set_function(FUNCTION_USER);
      proxy_call.set_method(METHOD_GET);
      try{
        proxy_call.continuous(user_stream_cb,proxy_call);
      }catch(Error error){
        throw error;
      }
    }
  
    //user_streamのcallback
    private void user_stream_cb(ProxyCall call,string? buf,size_t len,Error? err){
      //エラー処理
      if(err!=null){
        callback_error(err);
      }
      if(buf!=null){
        string json_frg=buf.substring(0,(int)len);  
        if(json_frg!="\n"){
          json_sb.append(json_frg);
          if(json_frg.has_suffix("\r\n")||json_frg.has_suffix("\r")){
            //シグナル発行
            //debug
            //print("%s\n",json_sb.str);
            callback_json(new ParsedJsonObj.from_string(json_sb.str,account.screen_name));
            //json_sbの初期化
            json_sb.erase();
          }
        }
      }
    }
    
    //シグナル
    public signal void callback_json(ParsedJsonObj parsed_json_obj);
    public signal void callback_error(Error e);
  }
}
