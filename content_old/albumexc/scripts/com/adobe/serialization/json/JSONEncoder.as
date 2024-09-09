package com.adobe.serialization.json
{
    import flash.utils.*;

    public class JSONEncoder extends Object
    {
        private var jsonString:String;

        public function JSONEncoder(param1)
        {
            jsonString = convertToString(param1);
            return;
        }// end function

        private function escapeString(param1:String) : String
        {
            var _loc_3:String;
            var _loc_6:String;
            var _loc_7:String;
            var _loc_2:String;
            var _loc_4:* = param1.length;
            var _loc_5:int;
            while (_loc_5 < _loc_4)
            {
                // label
                _loc_3 = param1.charAt(_loc_5);
                switch(_loc_3)
                {
                    case "\"":
                    {
                        _loc_2 = _loc_2 + "\\\"";
                        break;
                    }// end case
                    case "\\":
                    {
                        _loc_2 = _loc_2 + "\\\\";
                        break;
                    }// end case
                    case "\b":
                    {
                        _loc_2 = _loc_2 + "\\b";
                        break;
                    }// end case
                    case "\f":
                    {
                        _loc_2 = _loc_2 + "\\f";
                        break;
                    }// end case
                    case "\n":
                    {
                        _loc_2 = _loc_2 + "\\n";
                        break;
                    }// end case
                    case "\r":
                    {
                        _loc_2 = _loc_2 + "\\r";
                        break;
                    }// end case
                    case "\t":
                    {
                        _loc_2 = _loc_2 + "\\t";
                        break;
                    }// end case
                    default:
                    {
                        if (_loc_3 < " ")
                        {
                            _loc_6 = _loc_3.charCodeAt(0).toString(16);
                            _loc_7 = _loc_6.length == 2 ? ("00") : ("000");
                            _loc_2 = _loc_2 + ("\\u" + _loc_7 + _loc_6);
                        }
                        else
                        {
                            _loc_2 = _loc_2 + _loc_3;
                        }// end else if
                        break;
                    }// end default
                }// end switch
                _loc_5++;
            }// end while
            return "\"" + _loc_2 + "\"";
        }// end function

        private function arrayToString(param1:Array) : String
        {
            var _loc_2:String;
            var _loc_3:int;
            while (_loc_3 < param1.length)
            {
                // label
                if (_loc_2.length > 0)
                {
                    _loc_2 = _loc_2 + ",";
                }// end if
                _loc_2 = _loc_2 + convertToString(param1[_loc_3]);
                _loc_3++;
            }// end while
            return "[" + _loc_2 + "]";
        }// end function

        public function getString() : String
        {
            return jsonString;
        }// end function

        private function objectToString(param1:Object) : String
        {
            var value:Object;
            var key:String;
            var v:XML;
            var o:* = param1;
            var s:String;
            var classInfo:* = describeType(o);
            if (classInfo.@name.toString() == "Object")
            {
                var _loc_3:int;
                var _loc_4:* = o;
                while (_loc_4 in _loc_3)
                {
                    // label
                    key = _loc_4[_loc_3];
                    value = o[key];
                    if (value is Function)
                    {
                        continue;
                    }// end if
                    if (s.length > 0)
                    {
                        s = s + ",";
                    }// end if
                    s = s + (escapeString(key) + ":" + convertToString(value));
                }// end while
            }
            else
            {
                var _loc_3:int;
                var _loc_6:int;
                var _loc_7:* = classInfo..;
                var _loc_5:* = new XMLList("");
                for each (_loc_8 in _loc_7)
                {
                    // label
                    var _loc_9:* = _loc_7[_loc_6];
                    with (_loc_7[_loc_6])
                    {
                        if (name() == "variable" || name() == "accessor")
                        {
                            _loc_5[_loc_6] = _loc_8;
                        }// end if
                    }// end with
                }// end of for each ... in
                var _loc_4:* = _loc_5;
                while (_loc_4 in _loc_3)
                {
                    // label
                    v = _loc_4[_loc_3];
                    if (s.length > 0)
                    {
                        s = s + ",";
                    }// end if
                    s = s + (escapeString(v.@name.toString()) + ":" + convertToString(o[v.@name]));
                }// end while
            }// end else if
            return "{" + s + "}";
        }// end function

        private function convertToString(param1) : String
        {
            if (param1 is String)
            {
                return escapeString(param1 as String);
            }// end if
            if (param1 is Number)
            {
                return isFinite(param1 as Number) ? (param1.toString()) : ("null");
            }
            else if (param1 is Boolean)
            {
                return param1 ? ("true") : ("false");
            }
            else
            {
                if (param1 is Array)
                {
                    return arrayToString(param1 as Array);
                }// end if
                if (param1 is Object && param1 != null)
                {
                    return objectToString(param1);
                }// end else if
            }// end else if
            return "null";
        }// end function

    }
}
