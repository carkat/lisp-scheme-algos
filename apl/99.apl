⍝ Problem 1
⍝ last 1 2 3 4
⍝ return 4
last←{(-1)↑⍵}

⍝ Problem 2: get the second to last element
⍝ butlast 1 2 3 4
⍝ return 3 
butlast←{1↑(-2)↑⍵}

⍝ Problem 3: get nth element
⍝ 3 elementat 5 6 8 2 3 4
⍝ return 8
elementat←{⍺⊃⍵}

⍝ Problem 4: find the length of a list
⍝ len 1 2 3 5 6
⍝ return 5
len←{⍴⍵}

⍝ Problem 5: reverse a list
⍝ reverse 1 2 3 4
⍝ return 4 3 2 1
reverse←{⌽⍵}

⍝ Problem 6: is palindrome?
⍝ palindrom a b c d c b a
⍝ return 1
palindrome←{∧/⍵=⌽⍵}

⍝ Problem 7: flatten nested list
⍝ flatten (1 (2 (3 (4 5 6)) (7 8) 9))
⍝ return 1 2 3 4 5 6 7 8 9
flatten←{∊⍵}

⍝ Problem 8: remove consecutive duplicates 
⍝ compress 'aaaabbccccccccddddddddddeffffg'
⍝ return 'abcdefg'
compress←{(1,2≠/⍵)/⍵}

⍝ Problem 9: group consecutive duplicates
⍝ compress 'aaaabbcdddeffg'
⍝ return ('aaaa' 'bb' 'c' 'ddd' 'e' 'ff' 'g')
⍝ use the encode definition from problem 10
replicate←{(1↑⍵)/(-1)↑⍵}
group←{replicate¨encode ⍵}

⍝ Problem 10: run length encoding
⍝ compress 'aaaabbcdddeffg'
⍝ return 4a 2b 1c 3d 1e 2f 1g
⍝ count reads as follows
⍝ get the absolute value of subtracting subsequent pairs 
⍝ of the boolean filtered list of indices of length of the
⍝ right argument with the value 0 removed
count←{|2-/((1,2≠/⍵,1)×⍳1+⍴⍵)~0}
encode←{(count ⍵),¨compress ⍵}

⍝ Problem 11: modified run length encoding
⍝ single values have no integer pair
⍝ compress 'aaaabbcdddeffg'
⍝ return 4a 2b c 3d e 2f g
singlify←{1∊⍵:(-1)↑⍵⋄⍵}
encodemod←{singlify¨encode ⍵}

⍝ Problem 12: decode modified run length encoded array
⍝ decode 4a 2b c 3d e 2f g
⍝ return aaaabbcdddeffg
decode←{1=⍴⍵:⍵⋄replicate ⍵}

⍝ for testing call as follows
⍝ as encodemod builds the correct input for decode
decode ¨ encodemod 'aaaabbcdddeffg'


⍝ Problem 13: decode modified run length encoded array
⍝ already solved by problem 10?


⍝ Problem 14: duplicate
duplicate←{2/⍵}

⍝ Problem 15: replicate
replciate←{⍺/⍵}

⍝ Problem 16: drop every nth element
dropevery←{(~0=⍺|⍳⍴⍵)/⍵}

⍝ Problem 17: split on nth
split←{(⍺↑⍵) ((⍺-⍴⍵)↑⍵)}

⍝ Problem 18: splice between n1 and n2
⍝ left argument (a1 a2) right argument any list
⍝ (3 7) splice 'abcdefgh'
⍝ return 'cdef'
splice←{((⍺[2]>l)∧⍺[1]≤l←⍳⍴⍵)/⍵}
splice←{l r←⍺ ⋄ ((r>i)∧l≤i←⍳⍴⍵)/⍵}

∇ret←tuple splice string
  left right←tuple
  indices←⍳⍴string
  ret←((right>indices)∧(left≤indices))/string
∇
⍝ Problem 19: rotate n places
⍝ 2 rotate 'abcdefgh'
⍝ return 'cdefghab'
rotate←{⍺⌽⍵}

⍝ Problem 20: remove the nth item in a list
removenth←{(~⍺=⍳⍴⍵)/⍵}

⍝ Problem 21: insert element at
⍝ n value insert list
⍝ 3 'val' insert 'abcdef'
⍝ 'abcvaldef'
insert←{n v←⍺⋄l r←n split ⍵⋄ ∊l v r}


⍝ Problem 22: range between
between←{(⍺-1)+⍳(1+⍵-⍺)}

⍝ Problem 23: rand select
⍝ 3 selectrnd 'abcded'
⍝ 'edc'
selectrnd←{⍵[⍺?⍴⍵]}

⍝ Problem 24: n unique rand below m
lotto←{⍺?⍵}

⍝ Problem 25: jumble a list
jumble←{⍵[(⍴⍵)?⍴⍵]}

⍝ Problem 26: n distinct combinations

⍝ Problem 27: combinations of lists

⍝ Problem 28: sort lists by length of lists
lsort←{⍵[⍋∊(⍴¨⍵)]}


⍝ sort integers ascending 
sortup←{∨/2>/⍵:∇(b/⍵),(~b←0,2>/⍵)/⍵⋄⍵}
⍝ get list of n in range  
between←{(⍺-1)+⍳(1+⍵-⍺)}
⍝ get even numbers in range 
evenbetween←{(0=2|ns)/ns←⍺ between ⍵}
⍝ get list of factors of n 
factors←{(0=range|⍵)/range←⍳⍵}
⍝ pair an even n with its prime summation 
gbpairs←{ns,¨goldbach¨ns←⍺ evenbetween ⍵}
⍝ get the first prime pair adding to an even n
goldbach←{2↑∊(⍵=+/¨pairs)/¨pairs←ps∘.,ps←primes ⍵}
⍝ find if a number is prime 
isprime←{2=+/0=(⍳⍵)|⍵}
⍝ prime factors of n 
primefacts←{(isprime¨f)/f←factors ⍵}
⍝ primes below right arg
primes←{(isprime¨range)/range←⍳⍵}

⍝ snailsort
snailsort←{0<+/⍴⍵:⍵[1;],∇⊖⍉⍵[1↓⍳1↑⍴⍵;]⋄⍬}
