``` 
ruby benchmark/benchmark-serializer-json.rb

Rehearsal ------------------------------------------------
fast_jsonapi   0.469146   0.003692   0.472838 (  0.482972)
==>mutils      0.343414   0.002338   0.345752 (  0.350116)
as_json        0.349795   0.002601   0.352396 (  0.355537)
grape_entity   2.123932   0.008031   2.131963 (  2.142096)
blueprinter    0.729144   0.005669   0.734813 (  0.737173)
roar           1.815007   0.015412   1.830419 (  1.831867)
panko          0.324755   0.000970   0.325725 (  0.325953)
--------------------------------------- total: 6.193906sec

                   user     system      total        real
fast_jsonapi   0.326813   0.000479   0.327292 (  0.328071)
==>mutils      0.228319   0.000145   0.228464 (  0.228649)
as_json        0.252139   0.000242   0.252381 (  0.252570)
grape_entity   1.820288   0.008052   1.828340 (  1.837977)
blueprinter    0.656481   0.001270   0.657751 (  0.659753)
roar           1.592949   0.008122   1.601071 (  1.604941)
panko          0.260401   0.000433   0.260834 (  0.261211)

Warming up --------------------------------------
        fast_jsonapi     1.000  i/100ms
           ==>mutils     1.000  i/100ms
             as_json     1.000  i/100ms
        grape_entity     1.000  i/100ms
         blueprinter     1.000  i/100ms
                roar     1.000  i/100ms
               panko     1.000  i/100ms
Calculating -------------------------------------
        fast_jsonapi      2.215  (± 5.1%) i/s -     22.000  in  10.107915s
           ==>mutils      3.136  (± 3.0%) i/s -     32.000  in  10.281530s
             as_json      3.455  (± 3.1%) i/s -     35.000  in  10.229037s
        grape_entity      0.509  (± 7.2%) i/s -      6.000  in  11.844870s
         blueprinter      1.337  (± 3.9%) i/s -     14.000  in  10.537541s
                roar      0.613  (± 2.2%) i/s -      7.000  in  11.441661s
               panko      3.527  (± 2.9%) i/s -     36.000  in  10.292679s
                   with 95.0% confidence

Comparison:
               panko:        3.5 i/s
             as_json:        3.5 i/s - same-ish: difference falls within error
           ==>mutils:        3.1 i/s - 1.13x  (± 0.05) slower
        fast_jsonapi:        2.2 i/s - 1.59x  (± 0.09) slower
         blueprinter:        1.3 i/s - 2.64x  (± 0.13) slower
                roar:        0.6 i/s - 5.76x  (± 0.21) slower
        grape_entity:        0.5 i/s - 6.93x  (± 0.53) slower
                   with 95.0% confidence

Calculating -------------------------------------
        fast_jsonapi    62.946M memsize (     0.000  retained)
                       981.039k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
           ==>mutils    65.112M memsize (     0.000  retained)
                       721.156k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
             as_json    98.148M memsize (     0.000  retained)
                         1.683M objects (     0.000  retained)
                         8.000  strings (     0.000  retained)
        grape_entity   245.776M memsize (     0.000  retained)
                         2.524M objects (     0.000  retained)
                         4.000  strings (     0.000  retained)
         blueprinter    71.856M memsize (     0.000  retained)
                       661.154k objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
                roar   221.022M memsize (     0.000  retained)
                         1.823M objects (     0.000  retained)
                         1.000  strings (     0.000  retained)
               panko    98.153M memsize (     0.000  retained)
                         1.683M objects (     0.000  retained)
                        13.000  strings (     0.000  retained)

Comparison:
        fast_jsonapi:   62945864 allocated
           =>>mutils:   65111936 allocated - 1.03x more
         blueprinter:   71856304 allocated - 1.14x more
             as_json:   98148488 allocated - 1.56x more
               panko:   98153072 allocated - 1.56x more
                roar:  221022344 allocated - 3.51x more
        grape_entity:  245775576 allocated - 3.90x morre
```