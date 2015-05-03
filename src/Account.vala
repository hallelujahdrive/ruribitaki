using Rest;

namespace Ruribitaki{
  [Compact]
  public class Account{
    //メンバ
    public int id;
    public string screen_name;
    public string profile_image_url;
    public string time_zone;
    public OAuthProxy api_proxy;
    public OAuthProxy stream_proxy;
    
    public Account(string consumer_key,string consumer_seclet){
      api_proxy=new OAuthProxy(consumer_key,consumer_seclet,API_URL,false);
      stream_proxy=new OAuthProxy(consumer_key,consumer_seclet,STREAM_URL,false);
    }
  }
}
