;; monaxhyd -- Monads for Hy
;; Copyright (c) 2014, 2015 Gergely Nagy <algernon@madhouse-project.org>
;; Heavily based on clojure.algo.monads by Konrad Hinsen and others.
;;
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 which can be found in the file
;; EPL-1.0.txt at the root of this distribution. By using this
;; software in any fashion, you are agreeing to be bound by the terms
;; of this license. You must not remove this notice, or any other,
;; from this software.

(import [monaxhyd [monads]])

(require [monaxhyd.core [*]])
(require [hy.contrib.walk [let]])

(defn test-monad-identity []
  (assert (= (domonad monads.identity-m [[a 1]
                                         [b (inc a)]]
                      (+ a b))
             3)))

(defn test-monad-maybe []
  (let [call-state {}
        ref (fn [n &rest r]
              (setv (get call-state n) :called)
              (if r (first r) n))]
    (setv call-state {})
    (assert (= (domonad monads.maybe-m [[a (ref 1)]
                                        [b (ref 2)]
                                        [c (ref 3 None)]
                                        [d (ref 4)]]
                        (+ a b c d))
               None))
    (assert (= call-state {1 :called
                           2 :called
                           3 :called}))

    (setv call-state {})
    (assert (= (domonad monads.maybe-m [[a (ref 1)]
                                        [b (ref 2)]
                                        [c (ref 3)]
                                        [d (ref 4)]]
                        (+ a b c d))
               10))
    (assert (= call-state {1 :called
                           2 :called
                           3 :called
                           4 :called}))))

(defn test-monad-sequence []
  (assert (= (domonad monads.sequence-m
                      [[x (range 5)]
                       [y (range 3)]]
                      (+ x y))
             [0 1 2 1 2 3 2 3 4 3 4 5 4 5 6])))
