// Probably not the best way of doing this but
// It works so whatever
class Data {
  FloatDict data;
  
  Data() {
    // Data retrieved manually from
    // https://app.neilpatel.com/en/traffic_analyzer/overview?domain=reddit.com
    data = new FloatDict();
    data.set("USA", 118.6);
    data.set("UK", 19.4);
    data.set("Canada", 19.0);
    data.set("Australia", 10.3);
    data.set("Germany", 4.9);
    data.set("India", 2.9);
    data.set("France", 2.0);
    data.set("Netherlands", 1.7);
    data.set("Brazil", 1.5);
    data.set("Philippines", 1.5);
    data.set("Singapore", 1.3);
    data.set("Italy", 1.2);
    data.set("Sweden", 1);
    data.set("Spain", 1);
    data.set("Ireland", 0.907);
    data.set("Finland", 0.8);
    data.set("Poland", 0.791);
    data.set("Norway", 0.771);
    data.set("Malaysia", 0.687);
    data.set("S.-Korea", 0.623);
    data.set("New-Zealand", 0.572);
    data.set("Denmark", 0.570);
    data.set("Indonesia", 0.566);
    data.set("Belgium", 0.506);
    data.set("Portugal", 0.497);
  }
  
  float get(String country) {
    return data.get(capitalize(country));
  }
  
  int size() {
    return data.size();
  }
  
  String[] keys() {
    return data.keyArray();
  }
}
