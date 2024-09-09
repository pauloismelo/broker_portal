package com.adobe.serialization.json
{

    public class JSONDecoder extends Object
    {
        private var value:Object;
        private var tokenizer:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(param1:String)
        {
            tokenizer = new JSONTokenizer(param1);
            nextToken();
            value = parseValue();
            return;
        }// end function

        private function parseObject() : Object
        {
            var _loc_2:String;
            var _loc_1:* = new Object();
            nextToken();
            if (token.type == JSONTokenType.RIGHT_BRACE)
            {
                return _loc_1;
            }// end if
            while (true)
            {
                // label
                if (token.type == JSONTokenType.STRING)
                {
                    _loc_2 = String(token.value);
                    nextToken();
                    if (token.type == JSONTokenType.COLON)
                    {
                        nextToken();
                        _loc_1[_loc_2] = parseValue();
                        nextToken();
                        if (token.type == JSONTokenType.RIGHT_BRACE)
                        {
                            return _loc_1;
                        }// end if
                        if (token.type == JSONTokenType.COMMA)
                        {
                            nextToken();
                        }
                        else
                        {
                            tokenizer.parseError("Expecting } or , but found " + token.value);
                        }// end else if
                    }
                    else
                    {
                        tokenizer.parseError("Expecting : but found " + token.value);
                    }// end else if
                    continue;
                }// end if
                tokenizer.parseError("Expecting string but found " + token.value);
            }// end while
            return null;
        }// end function

        private function parseValue() : Object
        {
            if (token == null)
            {
                tokenizer.parseError("Unexpected end of input");
            }// end if
            switch(token.type)
            {
                case JSONTokenType.LEFT_BRACE:
                {
                    return parseObject();
                }// end case
                case JSONTokenType.LEFT_BRACKET:
                {
                    return parseArray();
                }// end case
                case JSONTokenType.STRING:
                case JSONTokenType.NUMBER:
                case JSONTokenType.TRUE:
                case JSONTokenType.FALSE:
                case JSONTokenType.NULL:
                {
                    return token.value;
                }// end case
                default:
                {
                    tokenizer.parseError("Unexpected " + token.value);
                    break;
                }// end default
            }// end switch
            return null;
        }// end function

        private function nextToken() : JSONToken
        {
            var _loc_1:* = tokenizer.getNextToken();
            token = tokenizer.getNextToken();
            return _loc_1;
        }// end function

        public function getValue()
        {
            return value;
        }// end function

        private function parseArray() : Array
        {
            var _loc_1:* = new Array();
            nextToken();
            if (token.type == JSONTokenType.RIGHT_BRACKET)
            {
                return _loc_1;
            }// end if
            while (true)
            {
                // label
                _loc_1.push(parseValue());
                nextToken();
                if (token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return _loc_1;
                }// end if
                if (token.type == JSONTokenType.COMMA)
                {
                    nextToken();
                    continue;
                }// end if
                tokenizer.parseError("Expecting ] or , but found " + token.value);
            }// end while
            return null;
        }// end function

    }
}
