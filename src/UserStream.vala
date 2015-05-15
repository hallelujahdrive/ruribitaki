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
            Json.Parser json_parser=new Json.Parser();
            try{
              json_parser.load_from_data(json_sb.str);
              Json.Node json_node=json_parser.get_root();
              if(json_node!=null){
                callback_json(new Status(json_node.get_object(),account.screen_name));
              }
            }catch(Error error){
            }
            //json_sbの初期化
            json_sb.erase();
          }
        }
      }
    }
    
    //シグナル
    public signal void callback_json(Status status);
    public signal void callback_error(Error e);
  }
}
