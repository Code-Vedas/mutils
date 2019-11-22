``` 
ruby benchmark/benchmark-serializer-json.rb

Rehearsal ------------------------------------------------
as_json        0.203906   0.001600   0.205506 (  0.205909)
fast_jsonapi   0.254855   0.000734   0.255589 (  0.256269)
grape_entity   1.063254   0.003285   1.066539 (  1.070634)
blueprinter    0.361891   0.002404   0.364295 (  0.365227)
mutils         2.601144   3.257604   5.858748 (  4.097969)
roar           1.154233   0.018801   1.173034 (  1.174310)
panko          0.261816   0.006418   0.268234 (  0.268633)
--------------------------------------- total: 9.191945sec

                   user     system      total        real
as_json        0.155709   0.000282   0.155991 (  0.156151)
fast_jsonapi   0.201236   0.000257   0.201493 (  0.201677)
grape_entity   0.925273   0.007193   0.932466 (  0.933399)
blueprinter    0.269445   0.000159   0.269604 (  0.269721)
mutils         2.284595   3.080149   5.364744 (  3.703868)
roar           0.998034   0.001271   0.999305 (  0.999987)
panko          0.162334   0.000032   0.162366 (  0.162354)

Warming up --------------------------------------
             as_json     1.000  i/100ms
        fast_jsonapi     1.000  i/100ms
        grape_entity     1.000  i/100ms
         blueprinter     1.000  i/100ms
              mutils     1.000  i/100ms
                roar     1.000  i/100ms
               panko     1.000  i/100ms
Calculating -------------------------------------
             as_json      4.371  (± 4.4%) i/s -     43.000  in  10.032065s
        fast_jsonapi      3.736  (± 1.3%) i/s -     38.000  in  10.189317s
        grape_entity      0.926  (± 4.1%) i/s -     10.000  in  10.819709s
         blueprinter      2.974  (± 2.8%) i/s -     30.000  in  10.132060s
              mutils      0.249  (± 3.5%) i/s -      3.000  in  12.054786s
                roar      0.901  (± 3.3%) i/s -      9.000  in  10.008720s
               panko      4.602  (± 4.0%) i/s -     46.000  in  10.202575s
                   with 95.0% confidence

Comparison:
               panko:        4.6 i/s
             as_json:        4.4 i/s - same-ish: difference falls within error
        fast_jsonapi:        3.7 i/s - 1.23x  (± 0.05) slower
         blueprinter:        3.0 i/s - 1.55x  (± 0.08) slower
        grape_entity:        0.9 i/s - 4.96x  (± 0.29) slower
                roar:        0.9 i/s - 5.11x  (± 0.27) slower
              mutils:        0.2 i/s - 18.48x  (± 0.98) slower
                   with 95.0% confidence

Calculating -------------------------------------
             as_json    53.332M memsize (     0.000  retained)
                       840.417k objects (     0.000  retained)
                         8.000  strings (     0.000  retained)
        fast_jsonapi    33.602M memsize (     0.000  retained)
                       490.209k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
        grape_entity    83.605M memsize (     0.000  retained)
                         1.030M objects (     0.000  retained)
                         4.000  strings (     0.000  retained)
         blueprinter    31.320M memsize (     0.000  retained)
                       280.132k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
              mutils   160.031M memsize (     0.000  retained)
                         1.281M objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
                roar   123.760M memsize (     0.000  retained)
                         1.061M objects (     0.000  retained)
                         1.000  strings (     0.000  retained)
               panko    53.337M memsize (     0.000  retained)
                       840.490k objects (     0.000  retained)
                        13.000  strings (     0.000  retained)

Comparison:
         blueprinter:   31320256 allocated
        fast_jsonapi:   33601520 allocated - 1.07x more
             as_json:   53331656 allocated - 1.70x more
               panko:   53336576 allocated - 1.70x more
        grape_entity:   83605416 allocated - 2.67x more
                roar:  123759552 allocated - 3.95x more
              mutils:  160030640 allocated - 5.11x more
```