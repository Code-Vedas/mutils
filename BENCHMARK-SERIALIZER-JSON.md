``` 
ruby benchmark/benchmark-serializer-json.rb

Rehearsal ------------------------------------------------
fast_jsonapi   0.420896   0.001788   0.422684 (  0.425161)
=> mutils      0.330089   0.000778   0.330867 (  0.331820)
as_json        0.328482   0.002571   0.331053 (  0.333599)
grape_entity   2.136319   0.012292   2.148611 (  2.160330)
blueprinter    0.809256   0.008755   0.818011 (  0.826980)
roar           1.905847   0.019966   1.925813 (  1.935937)
panko          0.323696   0.001208   0.324904 (  0.325517)
--------------------------------------- total: 6.301943sec

                   user     system      total        real
fast_jsonapi   0.329029   0.000763   0.329792 (  0.330612)
=> mutils      0.255709   0.000688   0.256397 (  0.257546)
as_json        0.259330   0.001016   0.260346 (  0.261641)
grape_entity   1.653116   0.004544   1.657660 (  1.659194)
blueprinter    0.692518   0.003879   0.696397 (  0.700324)
roar           1.578995   0.011059   1.590054 (  1.598151)
panko          0.270695   0.000999   0.271694 (  0.272918)

Warming up --------------------------------------
        fast_jsonapi     1.000  i/100ms
           => mutils     1.000  i/100ms
             as_json     1.000  i/100ms
        grape_entity     1.000  i/100ms
         blueprinter     1.000  i/100ms
                roar     1.000  i/100ms
               panko     1.000  i/100ms
Calculating -------------------------------------
        fast_jsonapi      2.502  (± 2.3%) i/s -     25.000  in  10.025595s
           => mutils      3.016  (± 3.0%) i/s -     31.000  in  10.322736s
             as_json      3.766  (± 3.2%) i/s -     38.000  in  10.197421s
        grape_entity      0.533  (± 4.8%) i/s -      6.000  in  11.273301s
         blueprinter      1.497  (± 3.8%) i/s -     15.000  in  10.095146s
                roar      0.631  (± 2.2%) i/s -      7.000  in  11.087625s
               panko      3.709  (± 3.0%) i/s -     37.000  in  10.073211s
                   with 95.0% confidence

Comparison:
             as_json:        3.8 i/s
               panko:        3.7 i/s - same-ish: difference falls within error
           => mutils:        3.0 i/s - 1.25x  (± 0.05) slower
        fast_jsonapi:        2.5 i/s - 1.51x  (± 0.06) slower
         blueprinter:        1.5 i/s - 2.52x  (± 0.13) slower
                roar:        0.6 i/s - 5.96x  (± 0.23) slower
        grape_entity:        0.5 i/s - 7.06x  (± 0.40) slower
                   with 95.0% confidence

Calculating -------------------------------------
        fast_jsonapi    62.915M memsize (     0.000  retained)
                       980.599k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
           => mutils    76.280M memsize (     0.000  retained)
                         1.001M objects (     0.000  retained)
                         6.000  strings (     0.000  retained)
             as_json    98.069M memsize (     0.000  retained)
                         1.682M objects (     0.000  retained)
                         8.000  strings (     0.000  retained)
        grape_entity   245.598M memsize (     0.000  retained)
                         2.522M objects (     0.000  retained)
                         4.000  strings (     0.000  retained)
         blueprinter    71.800M memsize (     0.000  retained)
                       660.626k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
                roar   220.796M memsize (     0.000  retained)
                         1.822M objects (     0.000  retained)
                         1.000  strings (     0.000  retained)
               panko    98.073M memsize (     0.000  retained)
                         1.682M objects (     0.000  retained)
                        13.000  strings (     0.000  retained)

Comparison:
        fast_jsonapi:   62914944 allocated
         blueprinter:   71800368 allocated - 1.14x more
           => mutils:   76279744 allocated - 1.21x more
             as_json:   98068616 allocated - 1.56x more
               panko:   98073200 allocated - 1.56x more
                roar:  220795848 allocated - 3.51x more
        grape_entity:  245598232 allocated - 3.90x more
```