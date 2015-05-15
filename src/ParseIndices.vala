using Json;

namespace Ruribitaki{
  //indicesの解析
  private int[] parse_indices(Json.Array indices_json_array){
    int[] indices=new int[indices_json_array.get_length()];
    for(int i=0;i<indices_json_array.get_length();i++){
      indices[i]=(int)indices_json_array.get_int_element(i);
    }
    return indices;
  }
}
