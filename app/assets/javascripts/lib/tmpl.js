String.prototype.tmpl = function(obj){
    var str, keys, _do;

    //store string
    str = this.toString();

    //if no object just return string
    if(!obj || typeof obj !== "object"){
        return str;
    }

    //get keys in object
    keys = Object.keys(obj);

    //loop through keys and replace place holders
    _do = function(key){
        var rgx = new RegExp("#{"+key+"}", "g");
        str = str.replace(rgx, obj[key]);
    };

    keys.forEach(_do);

    return str;
}