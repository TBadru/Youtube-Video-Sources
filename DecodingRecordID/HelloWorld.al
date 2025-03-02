// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.DecodingRecordID;

using Microsoft.Sales.Customer;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        HexStr: Text;
    begin
        HexStr := 'BA130000027BFF4300540030003000300030003000320000000000';
        HexStr := '24000000008B01000000027BFF53002D004F005200440031003000310030003000310000000000';
        HexStr := '12000000027B053100300030003000300000000000';
        HexStr := '12000000027BFF43003000300030003100300000000000';
        //         tttttttt    LL111122223333444455556666
        //         12345678      C   0   0   0   1   0   ZZZZZZZZ

        message(' Table = %1\Customer = %2', GetIntegerFromHex(HexStr.Substring(1, 8)),
        GetCharFromHex(HexStr.Substring(15, 4)) +
        GetCharFromHex(HexStr.Substring(19, 4)) +
        GetCharFromHex(HexStr.Substring(23, 4)) +
        GetCharFromHex(HexStr.Substring(27, 4)) +
        GetCharFromHex(HexStr.Substring(31, 4)) +
        GetCharFromHex(HexStr.Substring(35, 4))
         );
    end;

    local procedure GetIntegerFromHex(HexInt: Text[8]): BigInteger
    begin
        exit(GetByteFromHexByte(HexInt.Substring(1, 2)) +
             GetByteFromHexByte(HexInt.Substring(3, 2)) * 256 +
             GetByteFromHexByte(HexInt.Substring(5, 2)) * 256 * 256 +
             GetByteFromHexByte(HexInt.Substring(7, 2)) * 256 * 256 * 256);
    end;

    local procedure GetCharFromHex(HexChar: Text[4]): Text[1]
    var
        Out: Text[1];
    begin
        Out[1] := GetByteFromHexByte(HexChar.Substring(1, 2)) +
             GetByteFromHexByte(HexChar.Substring(3, 2)) * 256;
        exit(out);
    end;

    local procedure GetByteFromHexByte(HexByte: Text[2]) b: Byte
    var
        b1: Byte;
        b2: Byte;
    begin
        b1 := GetValueFromHexChar(HexByte[1]);
        b2 := GetValueFromHexChar(HexByte[2]);
        b := (b1 * 16) + b2;
        exit(b);
    end;

    local procedure GetValueFromHexChar(HexChar: Text[1]) HexCharValue: Integer
    begin
        if not Evaluate(HexCharValue, HexChar) then begin
            case HexChar.ToLower() of
                'a':
                    HexCharValue := 10;
                'b':
                    HexCharValue := 11;
                'c':
                    HexCharValue := 12;
                'd':
                    HexCharValue := 13;
                'e':
                    HexCharValue := 14;
                'f':
                    HexCharValue := 15;
            end;
        end;
        exit(HexCharValue);
    end;
}