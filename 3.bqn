# Day 3
_while_ ← {𝔽⍟𝔾∘𝔽_𝕣_𝔾∘𝔽⍟𝔾𝕩}

inp ← -⟜'0'¨•FLines "3.txt"
B2D ← {𝕩+2×𝕨}˜´⌽

# Part 1: 
Mode ←{(+´𝕩)≥(≠𝕩)-+´𝕩}
•Show (⊢×○B2D¬)Mode inp

# Part 2:
Mode2 ← {(+´𝕩)≤(≠𝕩)-+´𝕩}
•Show oxy ← ⊑⊑{
  𝕊 b‿i:
  m ← i⊑Mode b
  ⟨(m=i⊑¨b)/b,i+1⟩
} _while_ {1≠≠⊑𝕩} inp‿0

•Show co2 ← ⊑⊑{
  𝕊 b‿i:
  m ← i⊑¬Mode b
  ⟨(m=i⊑¨b)/b,i+1⟩
} _while_ {1≠≠⊑𝕩} inp‿0

•Show oxy ×○B2D co2