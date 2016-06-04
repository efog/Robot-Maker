{
}
Start
= (_ Block _)*

Member
= _ (Array / Block / Var) _

Array
= an:NameType?
  ArrayStart
  members: ArrayMember
  ArrayEnd 
  { return { name: an.name, type: an.type, members: members  }; }

ArrayMember
= first: (Member / Value)
  next: (_ "," _ val:(Member / Value) { return val; } )*
  { return [first].concat(next); }
  
Block
= 
  bn:(NameType)?
  BlockStart
  members:Member*
  BlockEnd 
  { return { name: bn.name, type: bn.type, members: members  }; }

Var
= "var" _ name:Name _ "=" _ val:Value { return { name: name, val: val, type: "var" } }

Value
= (Bool / String / Block / Array / Number)

NameType
=
  name:Name
  type:(":"
  type:Name { return type; })? { return { name: name, type: type }; }
  
BlockStart 
= _ "{" _ 
BlockEnd 
= _ "}" _ 
ArrayStart 
= _ "[" _ 
ArrayEnd 
= _ "]" _ 

Name
= chars:[a-zA-Z\-.]* { return chars.join(""); }

Number 
= [0-9]*("."[0-9]*)? { return parseFloat(text()); }

Bool
= b:(False / True) { return b === "true"; }

True
= "true"

False
= "false"

String "string"
= "\"" _ chars:Char* _ "\""  { return chars.join(""); }
   
Char
= Unescaped
/ Escape
  sequence:(
      '"'
    / "\\"
    / "/"
    / "b" { return "\b"; }
    / "f" { return "\f"; }
    / "n" { return "\n"; }
    / "r" { return "\r"; }
    / "t" { return "\t"; }
    / "u" digits:$(HEXDIG HEXDIG HEXDIG HEXDIG) {
        return String.fromCharCode(parseInt(digits, 16));
      }
  )
  { return sequence; }
    
Unescaped      
= [\x20-\x21\x23-\x5B\x5D-\u10FFFF]

Escape         
= "\\"

/* See RFC 4234, Appendix B (http://tools.ietf.org/html/rfc4627). */
DIGIT  
= [0-9]

HEXDIG 
= [0-9a-f]i

Separator
= _";"_

LineTerminatorSequence "end of line"
  = "\n"
  / "\r\n"
  / "\r"
  / "\u2028"
  / "\u2029"  
_ "whitespace" = 
  ([ \t\n\r]* 
  / LineTerminatorSequence)