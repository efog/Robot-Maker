Start
= Namespaces

Namespaces
= Namespace*

Namespace
= ns:NsType _ name:String LineTerminatorSequence { return name; }

NsType = "namespace"

String "string"
  = chars:Char*  { return chars.join(""); }
 
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

Unescaped      = [\x20-\x21\x23-\x5B\x5D-\u10FFFF]
Escape         = "\\"

/* See RFC 4234, Appendix B (http://tools.ietf.org/html/rfc4627). */
DIGIT  = [0-9]
HEXDIG = [0-9a-f]i

LineTerminatorSequence "end of line"
  = "\n"
  / "\r\n"
  / "\r"
  / "\u2028"
  / "\u2029"
  
_ "whitespace" = [ \t\n\r]*