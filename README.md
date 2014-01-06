Hy on Curry
===========

[![Build Status](https://travis-ci.org/algernon/curry.png?branch=master)](https://travis-ci.org/algernon/curry)

This library is a loose port of Clojure's [algo.monads][clj:monads] to
[Hy][hylang]. It's a work heavily in progress at the moment, and it
doesn't do very much yet.

 [clj:monads]: https://github.com/clojure/algo.monads
 [hylang]: http://hylang.org/

Example
-------

```clojure
(require curry.core)
(import [curry [monads]])

(domonad monads.identity-m [[a 1]
                            [b (inc a)]]
                           (+ a b))

;; => 3
```

More examples can be found in the [test suite][t:generic].

 [t:generic]: https://github.com/algernon/curry/blob/master/tests/

License
-------

This software is heavily based on [algo.monads][clj:monads], and as
such, is a derived work under the same
[Eclipse Public License 1.0][epl].

 [epl]: http://opensource.org/licenses/eclipse-1.0.php
