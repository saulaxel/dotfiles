" We need the conceal feature (vim ≥ 7.3)
if !has('conceal')
    finish
endif

scriptencoding=utf-8

syntax match cNiceOperator "++" conceal cchar=Δ
syntax match cNiceOperator "--" conceal cchar=∇

syntax match cNiceOperator "==" conceal cchar=≡
syntax match cNiceOperator "!=" conceal cchar=≠
syntax match cNiceOperator ">=" conceal cchar=≥
syntax match cNiceOperator "<=" conceal cchar=≤

syntax match cNiceOperator "&&" conceal cchar=∧
syntax match cNiceOperator "||" conceal cchar=∨

syntax match cNiceOperator "<<" conceal cchar=≺
syntax match cNiceOperator ">>" conceal cchar=≻

syntax match cNiceOperator "->" conceal cchar=➞

syntax keyword cType void conceal cchar=∅
syntax keyword cType unsigned conceal cchar=ℕ
syntax keyword cType int conceal cchar=ℤ
syntax keyword cType double conceal cchar=ℝ

hi link cNiceOperator Operator
hi! link Conceal Operator

set conceallevel=2

