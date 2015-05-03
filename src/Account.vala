using Rest;

namespace Ruribitaki{
  public class Account{
    //メンバ
    public int64 id;
    public string id_str;
    public string profile_image_url;
    public string time_zone;
    public string screen_name;
    public OAuthProxy api_proxy;
    public OAuthProxy stream_proxy;
    
    public Account(string consumer_key,string consumer_seclet){
      api_proxy=new OAuthProxy(consumer_key,consumer_seclet,API_URL,false);
      stream_proxy=new OAuthProxy(consumer_key,consumer_seclet,STREAM_URL,false);
    }
  }
}
