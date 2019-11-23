``` 
ruby benchmark/benchmark-serializer-json.rb

Rehearsal ------------------------------------------------
as_json        0.298969   0.008275   0.307244 (  0.307616)
fast_jsonapi   0.232278   0.000439   0.232717 (  0.232886)
grape_entity   1.014712   0.001639   1.016351 (  1.017073)
blueprinter    0.342568   0.000333   0.342901 (  0.343215)
mutils         2.846847   3.318636   6.165483 (  4.499497)
roar           1.165221   0.021089   1.186310 (  1.186998)
panko          0.262190   0.005572   0.267762 (  0.267947)
--------------------------------------- total: 9.518768sec

                   user     system      total        real
as_json        0.160771   0.000220   0.160991 (  0.161083)
fast_jsonapi   0.202366   0.000215   0.202581 (  0.202866)
grape_entity   0.908631   0.005240   0.913871 (  0.914388)
blueprinter    0.270655   0.000117   0.270772 (  0.270940)
mutils         2.629444   3.284792   5.914236 (  4.256369)
roar           1.006414   0.001231   1.007645 (  1.008334)
panko          0.169449   0.000395   0.169844 (  0.170023)

Warming up --------------------------------------
             as_json     1.000  i/100ms
        fast_jsonapi     1.000  i/100ms
        grape_entity     1.000  i/100ms
         blueprinter     1.000  i/100ms
              mutils     1.000  i/100ms
                roar     1.000  i/100ms
               panko     1.000  i/100ms
Calculating -------------------------------------
             as_json      4.602  (± 3.1%) i/s -     46.000  in  10.084341s
        fast_jsonapi      3.736  (± 1.1%) i/s -     38.000  in  10.182740s
        grape_entity      0.983  (± 2.6%) i/s -     10.000  in  10.179913s
         blueprinter      3.018  (± 2.3%) i/s -     31.000  in  10.305027s
              mutils      0.224  (± 2.1%) i/s -      3.000  in  13.383544s
                roar      0.887  (± 2.1%) i/s -      9.000  in  10.166892s
               panko      4.874  (± 3.1%) i/s -     49.000  in  10.176593s
                   with 95.0% confidence

Comparison:
               panko:        4.9 i/s
             as_json:        4.6 i/s - same-ish: difference falls within error
        fast_jsonapi:        3.7 i/s - 1.30x  (± 0.04) slower
         blueprinter:        3.0 i/s - 1.61x  (± 0.06) slower
        grape_entity:        1.0 i/s - 4.95x  (± 0.20) slower
                roar:        0.9 i/s - 5.50x  (± 0.20) slower
              mutils:        0.2 i/s - 21.74x  (± 0.81) slower
                   with 95.0% confidence

Calculating -------------------------------------
             as_json    53.369M memsize (     0.000  retained)
                       841.041k objects (     0.000  retained)
                         8.000  strings (     0.000  retained)
        fast_jsonapi    33.617M memsize (     0.000  retained)
                       490.404k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
        grape_entity    83.654M memsize (     0.000  retained)
                         1.031M objects (     0.000  retained)
                         4.000  strings (     0.000  retained)
         blueprinter    31.341M memsize (     0.000  retained)
                       280.327k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
              mutils   162.079M memsize (     0.000  retained)
                         1.282M objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
                roar   123.865M memsize (     0.000  retained)
                         1.061M objects (     0.000  retained)
                         1.000  strings (     0.000  retained)
               panko    53.374M memsize (     0.000  retained)
                       841.114k objects (     0.000  retained)
                        13.000  strings (     0.000  retained)

Comparison:
         blueprinter:   31340936 allocated
        fast_jsonapi:   33617288 allocated - 1.07x more
             as_json:   53369496 allocated - 1.70x more
               panko:   53374416 allocated - 1.70x more
        grape_entity:   83653952 allocated - 2.67x more
                roar:  123864600 allocated - 3.95x more
              mutils:  162078928 allocated - 5.17x more
```