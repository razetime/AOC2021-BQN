#!/usr/bin/env cbqn

⟨Split, B2D, _base, Range, Pad⟩ ← •Import "lib.bqn"

inp ← ∾(¯4⊸↑2 _base)¨"0123456789ABCDEF"⊐⊑•FLines "16.txt"

# Part 1:
ptr ← 0
ReadBits ← {ptr +↩ 𝕩, inp⊏˜(ptr-𝕩)+↕𝕩}
#Adv ← {𝕊: ptr +↩ 1}
sum ← 0

GetPkt ← {
  GetPkt a‿b‿c: GetPkt @; # If given a packet value, ignore it.
  GetPkt @: # Read header and redirect to correct packet
  v‿t ← B2D¨ ⟨ReadBits 3, ReadBits 3⟩
  sum +↩ v
  GetPkt v‿t;
  GetPkt v‿4: # normal packet
  val ← B2D {𝕩/˜¬(≠𝕩)⥊0=↕5}{inp⊏˜ptr+↕5, 𝕩∾ReadBits 5} •_while_ {(0=≠𝕩)∨inp⊑˜ptr-5} ⟨⟩
  ⟨v, 4, val⟩; 
  GetPkt v‿t: # operator packet
  data ← {
    ⊑ReadBits 1 ? GetPkt ⍟ (1+↕B2D ReadBits 11) @;
	l ← ptr + B2D ReadBits 15
	res ← ⟨⟩
    {⊑res ∾↩ ⋈GetPkt 𝕩} •_while_ {𝕊:ptr<l} @
	res
  }
  ⟨v, t, data⟩
} 

expr ← GetPkt @
•Show sum

# Part 2:
•Show {
  𝕊 v‿4‿dat: dat;
  𝕊 v‿t‿dat:
  (t⊑+‿×‿⌊‿⌈‿⊢‿>‿<‿=)´𝕊¨dat
} expr
