{
  function Var(name, value){
    var self = this;
    self.name = name;
    self.value = value;
  }
  function Block(name, type, members){
    var self = this;
    self.name = name;
    self.type = type;
    self.members = members;
  }
  function Array(name, type, members){
    var self = this;
    self.name = name;
    self.type = type;
    self.members = members;
  }
}
Start
= blocks:(_ Block _)* { return { blocks: blocks }; }

Member
= _ member:(Array / Block / Var) _ { return member; }

Array
= an:NameType?
  ArrayStart
  members: ArrayItems
  ArrayEnd 
  { return new Array(an.name, an.type, members); }

ArrayItems
= first: (Member / Value)
  next: (_ "," _ val:(Member / Value) { return val; } )*
  { return { items: [first].concat(next) }; }
ArrayStart 
= _ "[" _ 
ArrayEnd 
= _ "]" _ 
  
Block
= 
  bn:(NameType)?
  BlockStart
  members:Member*
  BlockEnd 
  { return new Block(bn.name, bn.type, members); }
BlockStart 
= _ "{" _ 
BlockEnd 
= _ "}" _ 

Var
= "var" _ name:Name _ "=" _ val:Value { return new Var(name, val); }

Value
= (Bool / String / Block / Array / Number)

NameType
=
  name:Name
  type:(":"
  type:Name { return type; })? { return { name: name, type: type }; }
  

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