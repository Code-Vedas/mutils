``` 
ruby benchmark/benchmark-serializer-json.rb

Rehearsal ------------------------------------------------
fast_jsonapi   0.424546   0.001081   0.425627 (  0.426322)
mutils         0.333449   0.002400   0.335849 (  0.336298)
as_json        0.332414   0.002972   0.335386 (  0.336236)
grape_entity   1.996070   0.007464   2.003534 (  2.009630)
blueprinter    0.946221   0.007744   0.953965 (  0.966492)
roar           1.783576   0.021304   1.804880 (  1.812488)
panko          0.427139   0.011038   0.438177 (  0.438584)
--------------------------------------- total: 6.297418sec

                   user     system      total        real
fast_jsonapi   0.333992   0.000488   0.334480 (  0.335098)
mutils         0.243903   0.000213   0.244116 (  0.244320)
as_json        0.256087   0.000481   0.256568 (  0.256873)
grape_entity   1.754575   0.014044   1.768619 (  1.784909)
blueprinter    0.764821   0.007226   0.772047 (  0.783732)
roar           1.588941   0.013764   1.602705 (  1.613852)
panko          0.266022   0.000613   0.266635 (  0.267224)

Warming up --------------------------------------
        fast_jsonapi     1.000  i/100ms
              mutils     1.000  i/100ms
             as_json     1.000  i/100ms
        grape_entity     1.000  i/100ms
         blueprinter     1.000  i/100ms
                roar     1.000  i/100ms
               panko     1.000  i/100ms
Calculating -------------------------------------
        fast_jsonapi      2.359  (± 2.8%) i/s -     24.000  in  10.216600s
              mutils      3.072  (± 3.0%) i/s -     31.000  in  10.158407s
             as_json      3.389  (± 2.4%) i/s -     34.000  in  10.083233s
        grape_entity      0.522  (± 5.0%) i/s -      6.000  in  11.508761s
         blueprinter      1.282  (± 5.1%) i/s -     13.000  in  10.241835s
                roar      0.600  (± 3.6%) i/s -      7.000  in  11.678579s
               panko      3.575  (± 2.0%) i/s -     36.000  in  10.108404s
                   with 95.0% confidence

Comparison:
               panko:        3.6 i/s
             as_json:        3.4 i/s - 1.05x  (± 0.03) slower
              mutils:        3.1 i/s - 1.16x  (± 0.04) slower
        fast_jsonapi:        2.4 i/s - 1.52x  (± 0.05) slower
         blueprinter:        1.3 i/s - 2.79x  (± 0.15) slower
                roar:        0.6 i/s - 5.96x  (± 0.25) slower
        grape_entity:        0.5 i/s - 6.85x  (± 0.37) slower
                   with 95.0% confidence

Calculating -------------------------------------
        fast_jsonapi    62.874M memsize (     0.000  retained)
                       980.009k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
              mutils    65.007M memsize (     0.000  retained)
                       719.920k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             as_json    97.962M memsize (     0.000  retained)
                         1.680M objects (     0.000  retained)
                         8.000  strings (     0.000  retained)
        grape_entity   245.360M memsize (     0.000  retained)
                         2.520M objects (     0.000  retained)
                         4.000  strings (     0.000  retained)
         blueprinter    86.924M memsize (     0.000  retained)
                       959.876k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
                roar   220.492M memsize (     0.000  retained)
                         1.820M objects (     0.000  retained)
                         1.000  strings (     0.000  retained)
               panko    97.966M memsize (     0.000  retained)
                         1.680M objects (     0.000  retained)
                        13.000  strings (     0.000  retained)

Comparison:
        fast_jsonapi:   62873552 allocated
              mutils:   65007392 allocated - 1.03x more
         blueprinter:   86923712 allocated - 1.38x more
             as_json:   97961544 allocated - 1.56x more
               panko:   97966128 allocated - 1.56x more
                roar:  220492312 allocated - 3.51x more
        grape_entity:  245360488 allocated - 3.90x more

```