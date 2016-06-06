{
  function Let(name, value, stereotype){
    var self = this;
    self.name = name;
    self.value = value;
    self.stereotype = stereotype;
  }
  function Block(name, stereotype, members){
    var self = this;
    self.name = name;
    self.stereotype = stereotype;
    self.members = members;
  }
  function Array(name, stereotype, members){
    var self = this;
    self.name = name;
    self.stereotype = stereotype;
    self.members = members;
  }
}
Start
= blocks:(_ Block _)* { return { blocks: blocks }; }

Member
= _ member:(Array / Block / Let) _ { return member; }

Array
= an:NameStereotype?
  ArrayStart
  members: ArrayItems
  ArrayEnd 
  { return new Array(an.name, an.stereotype, members); }

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
  bn:(NameStereotype)?
  BlockStart
  members:Member*
  BlockEnd 
  { return new Block(bn.name, bn.stereotype, members); }
BlockStart 
= _ "{" _ 
BlockEnd 
= _ "}" _ 

Let
= "let" _ ln:NameStereotype _ "=" _ val:Value { return new Let(ln.name, val, ln.stereotype); }

Value
= (Bool / String / Block / Array / Number)

NameStereotype
=
  name:Name
  stereotype:(":"
  stereotype:Name { return stereotype; })? { return { name: name, stereotype: stereotype }; }
  

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