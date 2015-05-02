using Rest;

namespace Ruribitaki{
  [Compact]
  public class Account{
    //メンバ
    public int my_list_id;
    public int my_id;
    public string my_screen_name;
    public string my_profile_image_url;
    public string my_time_zone;
    public OAuthProxy api_proxy;
    public OAuthProxy stream_proxy;
    
    public Account(string consumer_key,string consumer_seclet){
      api_proxy=new OAuthProxy(consumer_key,consumer_seclet,API_URL,false);
      stream_proxy=new OAuthProxy(consumer_key,consumer_seclet,STREAM_URL,false);
    }
  }
}
