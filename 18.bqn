#!/usr/bin/env cbqn

⟨_fix⟩ ← •Import "lib.bqn"

inp ← {•BQN'⟩'¨⌾((']'=𝕩)⊸/)'⟨'¨⌾(('['=𝕩)⊸/)𝕩}¨•FLines "18.txt"

Mag ← {𝕊 f‿s: +´3‿2×𝕊¨f‿s;𝕩}
Expr ← {val 𝕊 path : val{𝕏⌾(𝕨⊸⊑)}´path}
Dig ← {0=≡𝕩 ? 0; 1+𝕨 𝕊 𝕨⊑𝕩}

PathFind ← {
  PathFind 3‿path‿arr:
  path∾⊑/2=≠¨arr;
  PathFind depth‿path‿arr:
  ⊑⟨⟨⟩⟩∾˜(×≠¨)⊸/0‿1{1<≡𝕩 ? PathFind ⟨depth+1, path∾𝕨, 𝕩⟩;⟨⟩}¨arr;
  PathFind arr:
  PathFind ⟨0, ⟨⟩, arr⟩
}

Explode ← {
  𝕊 arr:
  path ← PathFind arr
  l‿r ←  arr⊑´⌽path
  left ← /path
  right ← /¬path
  {
    ×≠left ?
    left ↩ 0∾˜path↑˜¯1⊑left
    left ∾↩ 1+/⋈ 1 Dig arr⊑´⌽left
    f ← {l⊸+} Expr left, arr F↩;
    @
  }
  {
    ×≠right ?
    right ↩ 1∾˜path↑˜¯1⊑right
    right ∾↩ /⋈0 Dig arr⊑´⌽right
    f ← {r⊸+} Expr right, arr F↩;
    @
  }
  f ← 0 Expr path
  F arr
}

Split ← {
  done ← 0
  {
    done ? 𝕩;
    0<≡𝕩 ? 𝕊¨𝕩;
    0=≡𝕩 ? 𝕩≥10 ? done ↩ 1, (⌊⋈⌈)𝕩÷2;
    𝕩
  } 𝕩
}
Exb  ← 4<≡
Spb ← ∨´9<∾⍟(-⟜1≡) 
 
Add ← {{ Split⍟((¬Exb 𝕩)⊸∧Spb) Explode⍟Exb 𝕩} •_while_ (Exb∨Spb) 𝕨⋈𝕩}
•Show Mag Add˜´⌽inp
•Show ⌈´⥊Mag∘Add⌜˜inp