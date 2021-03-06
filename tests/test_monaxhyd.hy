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

(require [monaxhyd.core [*]])
(require [hy.contrib.walk [let]])

(defn test-monad []
  (let [test-monad (monad [m-result (fn [r])
                           m-bind (fn [mv f])])]
    (assert (not (= (get test-monad 'm-result) 'undefined)))
    (assert (not (= (get test-monad 'm-bind) 'undefined)))
    (assert (= (get test-monad 'm-zero) 'undefined))
    (assert (= (get test-monad 'm-plus) 'undefined))))

(defn test-defmonad []
  (defmonad test-monad [m-result (fn [r])
                        m-bind (fn [mv f])])
  (assert (not (= (get test-monad 'm-result) 'undefined)))
  (assert (not (= (get test-monad 'm-bind) 'undefined)))
  (assert (= (get test-monad 'm-zero) 'undefined))
  (assert (= (get test-monad 'm-plus) 'undefined)))

(defn test-with-monad []
  (let [incr-monad (monad [m-result (fn [r] (inc r))
                           m-bind (fn [mv f] (f mv))])]
    (assert (= (with-monad incr-monad
                 (m-bind 1 (fn [a]
                             (m-bind (inc a)
                                     (fn [b]
                                       (m-result (+ a b)))))))
               4))))

(defn test-domonad []
  (let [incr-monad (monad [m-result (fn [r] (inc r))
                           m-bind (fn [mv f] (f mv))])]
    (assert (= (domonad incr-monad [[a 1]
                                    [b (inc a)]]
                        (+ a b))
               4))))
