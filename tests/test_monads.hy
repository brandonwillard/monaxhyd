;; curry -- Monads for Hy
;; Copyright (c) 2014 Gergely Nagy <algernon@madhouse-project.org>
;; Heavily based on clojure.algo.monads by Konrad Hinsen and others.
;;
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 which can be found in the file
;; epl-v10.html at the root of this distribution. By using this
;; software in any fashion, you are agreeing to be bound by the terms
;; of this license. You must not remove this notice, or any other,
;; from this software.

(require curry.core)
(import [curry [monads]])

(defn test-monad-identity []
  (assert (= (domonad monads.identity-m [[a 1]
                                         [b (inc a)]]
                      (+ a b))
             3)))

(defn test-monad-maybe []
  (let [[call-state {}]
        [ref (fn [n &rest r]
               (setv (get call-state n) :called)
               (if r (first r) n))]]
    (setv call-state {})
    (assert (= (domonad monads.maybe-m [[a (ref 1)]
                                        [b (ref 2)]
                                        [c (ref 3 nil)]
                                        [d (ref 4)]]
                        (+ a b c d))
               nil))
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
